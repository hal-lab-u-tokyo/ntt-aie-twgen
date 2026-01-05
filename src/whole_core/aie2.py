# section-4/section-4a/aie2.py -*- Python -*-
#
# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# (c) Copyright 2024 Advanced Micro Devices, Inc. or its affiliates


import argparse

import aie.utils.trace as trace_utils
import numpy as np
import sys

from aie.dialects.aie import *
from aie.dialects.aiex import *
from aie.helpers.dialects.ext.scf import _for as range_
from aie.extras.context import mlir_mod_ctx
def my_vector_scalar(opts):

    # enableTrace = opts.trace_size > 0
    enableTrace = False
    trace_size = opts.trace_size

    # ===================================
    # Change here for different configurations
    all_size_log = 16
    modulo_q = 65537
    n_stage_for_debug = 13
    # ===================================
    

    col_num_log = 2
    raw_num_log = 2
    size_per_vec_log = 4

    cores_num_log = col_num_log+raw_num_log
    size_per_core_log = all_size_log - cores_num_log

    col_num = 1<<col_num_log
    raw_num = 1<<raw_num_log
    all_size = 1<<all_size_log
    factor_buff_size = 1<<size_per_vec_log
    factor_FIFO_size = all_size_log
    cores_num = 1<<cores_num_log
    cores_size = 1<<size_per_core_log
    barret_w = 17
    barret_u = (1<<(2 * barret_w)) // modulo_q
    

    @device(AIEDevice.npu1)
    def device_body():
        all_ty = np.ndarray[(all_size,), np.dtype[np.int32]]
        cores_ty = np.ndarray[(cores_size,), np.dtype[np.int32]]
        factor_buff_ty = np.ndarray[(factor_buff_size,), np.dtype[np.int32]]
        mem_ty = np.ndarray[(1<<(all_size_log-col_num_log),), np.dtype[np.int32]]
        factor_FIFO_ty = np.ndarray[(factor_FIFO_size,), np.dtype[np.int32]]
        factor_mem_FIFO_ty = np.ndarray[(factor_FIFO_size,), np.dtype[np.int32]]
        factor_all_ty = np.ndarray[(factor_FIFO_size*col_num,), np.dtype[np.int32]]
        flag_ty = np.ndarray[(1,), np.dtype[np.int32]]

        
        # ===================
        # External Function
        # ===================
        NTT_stage_down = external_func(
            "NTT_stage_down",
            inputs = [cores_ty,cores_ty,factor_buff_ty,factor_FIFO_ty,np.int32,  np.int32,np.int32, np.int32, np.int32,np.int32],
        )
        NTT_stage_up = external_func(
            "NTT_stage_up",
            inputs = [cores_ty,cores_ty,factor_buff_ty,factor_FIFO_ty,np.int32, np.int32, np.int32,np.int32, np.int32, np.int32],
        )

        vector_copy = external_func(
            "vector_copy",
            inputs = [cores_ty, cores_ty,np.int32],
            )
        NTT_stage_next_up_down = external_func(
            "NTT_stage_next_up_down",
            inputs = [cores_ty,cores_ty,cores_ty,cores_ty,factor_buff_ty,factor_FIFO_ty,np.int32,np.int32,np.int32, np.int32,np.int32,np.int32, np.int32,np.int32,np.int32],
        )
        swap = external_func(
            "vector_swap",
            inputs = [cores_ty,cores_ty,np.int32,np.int32],
        )
        


        # ===================
        # Define Tiles
        # ===================
        CT_tile_ls = []
        Mem_tile_ls = []
        Shim_tile_ls = []
        for col in range(col_num):
            Shim_tile_ls.append(tile(col,0))
            Mem_tile_ls.append(tile(col,1))
            CT_tile_ls.append([])
            for raw in range(raw_num):
                CT_tile_ls[col].append(tile(col,raw+2))

        
        # ===================
        # Define FIFOs
        # ===================
        Mem_CT_FIFO_ls = []
        Mem_CT_factor_FIFO_ls = []
        CT_Mem_FIFO_ls = []
        for col in range(col_num):
            Mem_CT_FIFO_ls.append([])
            CT_Mem_FIFO_ls.append([])
            Mem_CT_factor_FIFO_ls.append(object_fifo(f"of_Mem_{col}_CT_factor_FIFO", Mem_tile_ls[col], [CT_tile_ls[col][raw] for raw in range(raw_num)] , 1, factor_FIFO_ty))

            for raw in range(raw_num):
                Mem_CT_FIFO_ls[col].append(object_fifo(f"of_Mem_CT_FIFO_{col}_{raw}", Mem_tile_ls[col], CT_tile_ls[col][raw], 1, cores_ty))
                CT_Mem_FIFO_ls[col].append(object_fifo(f"of_CT_Mem_FIFO_{col}_{raw}", CT_tile_ls[col][raw], Mem_tile_ls[col], 1, cores_ty))
        
        Shim_Mem_FIFO_ls = []
        Shim_Mem_factor_FIFO_ls = []
        Mem_Shim_FIFO_ls = []
        for col in range(col_num):
            Shim_Mem_FIFO_ls.append(object_fifo(f"of_Shim_Mem_FIFO_{col}",  Shim_tile_ls[col],Mem_tile_ls[col], 1, mem_ty))
            Shim_Mem_factor_FIFO_ls.append(object_fifo(f"of_Shim_Mem_factor_FIFO_{col}",  Shim_tile_ls[col],Mem_tile_ls[col], 1, factor_mem_FIFO_ty))
            Mem_Shim_FIFO_ls.append(object_fifo(f"of_Mem_Shim_{col}_FIFO", Mem_tile_ls[col], Shim_tile_ls[col], 1, mem_ty))
        
        
        # ===================
        # Define Buffers and FIFOs for core communication
        # ===================
        if (raw > 0):
            up_down_flag_fifo_ls = []
            for col in range(col_num):
                up_down_flag_fifo_ls.append([])
                for raw in range(raw_num):
                    if raw % 2 == 0:
                        temp = 1
                    else:
                        temp = -1
                    up_down_flag_fifo_ls[col].append(object_fifo(f"of_up_down_flag_FIFO_{col}_{raw}", CT_tile_ls[col][raw], CT_tile_ls[col][raw+temp], 1, flag_ty))
        
        if col > 0:
            right_left_flag_fifo_ls = []
            for col in range(col_num):
                right_left_flag_fifo_ls.append([])
                for raw in range(col_num):
                    if col % 2 == 0:
                        temp = 1
                    else:
                        temp = -1
                    right_left_flag_fifo_ls[col].append(object_fifo(f"of_right_left_flag_FIFO_{col}_{raw}", CT_tile_ls[col][raw], CT_tile_ls[col+temp][raw], 1, flag_ty))
        

        if raw > 2:
            swap_fifo_flag_ls = []
            swap_destination = [[0,2,1,3],
                                [4,6,5,7],
                                [8,10,9,11],
                                [12,14,13,15],
                                ]
            for col in range(col_num):
                swap_fifo_flag_ls.append([])
                for raw in range(raw_num):
                    destination = swap_destination[col][raw]
                    destination_x_y = [destination//raw_num,destination%raw_num]
                    if col*raw_num+raw == destination:
                        swap_fifo_flag_ls[col].append(0)
                    else:
                        swap_fifo_flag_ls[col].append(object_fifo(f"of_swap_FIFO_{col}_{raw}", CT_tile_ls[col][raw], CT_tile_ls[destination_x_y[0]][destination_x_y[1]], 1, flag_ty))
        

        if col > 2:
            swap_2_fifo_flag_ls = []
            swap_2_destination = [[0,1,2,3],
                                [8,9,10,11],
                                [4,5,6,7],
                                [12,13,14,15],
                                ]
            for col in range(col_num):
                swap_2_fifo_flag_ls.append([])
                for raw in range(raw_num):
                    destination = swap_2_destination[col][raw]
                    destination_x_y = [destination//raw_num,destination%raw_num]
                    if col*raw_num+raw == destination:
                        swap_2_fifo_flag_ls[col].append(0)
                    else:
                        swap_2_fifo_flag_ls[col].append(object_fifo(f"of_swap_2_FIFO_{col}_{raw}", CT_tile_ls[col][raw], CT_tile_ls[destination_x_y[0]][destination_x_y[1]], 1, flag_ty))
        

        factor_buff_ls = []
        for col in range(col_num):
            factor_buff_ls.append([])
            for raw in range(raw_num):
                factor_buff_ls[col].append( buffer(tile=CT_tile_ls[col][raw], datatype= factor_buff_ty))
        
        buff_ls = []
        for col in range(col_num):
            buff_ls.append([])
            for raw in range(raw_num):
                buff_ls[col].append( buffer(tile=CT_tile_ls[col][raw], datatype= cores_ty))
        
        # ===================
        # Link FIFOs
        # ===================
        for col in range(col_num):
            object_fifo_link(Shim_Mem_FIFO_ls[col], [Mem_CT_FIFO_ls[col][raw] for raw in range(raw_num)],[],[raw*cores_size for raw in range(raw_num)])
            object_fifo_link( [CT_Mem_FIFO_ls[col][raw] for raw in range(raw_num)], Mem_Shim_FIFO_ls[col],[raw * cores_size for raw in range(raw_num)],[])
            object_fifo_link(Shim_Mem_factor_FIFO_ls[col], Mem_CT_factor_FIFO_ls[col],[],[raw * factor_FIFO_size for raw in range(raw_num)])



        # ===================
        # Core Body
        # ===================
        for col in range(col_num):
            for raw in range(raw_num):
                @core(CT_tile_ls[col][raw], "func.o")
                def core_body():
                    for _ in range_(sys.maxsize):
                        core_index = col * raw_num + raw



                        
                        # =====================================
                        # Copy input to local memory of ComputeTile
                        # =====================================
                        in_vec = Mem_CT_FIFO_ls[col][raw].acquire(ObjectFifoPort.Consume, 1)
                        buff = buff_ls[col][raw]
                        times = 1 << (size_per_core_log - size_per_vec_log)
                        vector_copy(in_vec,buff,times)
                        Mem_CT_FIFO_ls[col][raw].release(ObjectFifoPort.Consume, 1)

                        factor_FIFO_buff = Mem_CT_factor_FIFO_ls[col].acquire(ObjectFifoPort.Consume, 1)
                        factor_buff = factor_buff_ls[col][raw]

                        # =====================================
                        # Start NTT
                        # =====================================
                        
                        # =====================================
                        # Inter-Tile NTT
                        # Stage 1 to Stage (n-4)
                        # =====================================

                        up_down_flag_fifo_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                        
                        stage_compute_in_tile = all_size_log - 4
                        for stage in range(1,6):
                            NTT_stage_down(buff,buff,factor_buff,factor_FIFO_buff,stage,all_size_log,size_per_core_log,modulo_q,barret_w,barret_u)

                        for stage in range(6, stage_compute_in_tile + 1):
                            NTT_stage_up(buff,buff,factor_buff,factor_FIFO_buff,stage,all_size_log,size_per_core_log,modulo_q,barret_w,barret_u)

                        up_down_flag_fifo_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        
                        # =====================================
                        #  NTT Stage (n-3)
                        #  3  7 11 15
                        #  |  |  |  |
                        #  2  6 10 14
                        #  1  5  9 13
                        #  |  |  |  |
                        #  0  4  8 12
                        # =====================================
                        
                        
                        #======
                        # For next swap
                        destination = swap_destination[col][raw]
                        temp = col * raw_num + raw
                        if temp != destination:
                            swap_fifo_flag_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        #====

                        reached_tile = 0                        
                        if raw % 2 == 0:
                            reached_tile = 1
                        else:
                            reached_tile = -1
                        up_down_flag_fifo_ls[col][raw+reached_tile].acquire(ObjectFifoPort.Consume, 1)

                        stage = size_per_core_log+1
                        if raw % 2 == 0:
                            half_bool = 0
                            # reached_tile = 1
                            factor_scalar = 1
                            NTT_stage_next_up_down(buff_ls[col][raw],buff_ls[col][raw+reached_tile],buff_ls[col][raw],buff_ls[col][raw+reached_tile],factor_buff,factor_FIFO_buff, factor_scalar,half_bool,stage, all_size_log,size_per_core_log,(1<< (size_per_core_log-5)),modulo_q, barret_w, barret_u)
                         
                        else:            
                            half_bool = 1
                            # reached_tile = -1
                            factor_scalar = factor_FIFO_buff[all_size_log-stage+size_per_core_log-1]
                            NTT_stage_next_up_down(buff_ls[col][raw+reached_tile],buff_ls[col][raw],buff_ls[col][raw+reached_tile],buff_ls[col][raw],factor_buff,factor_FIFO_buff, factor_scalar,half_bool,stage, all_size_log,size_per_core_log,(1<< (size_per_core_log-5)),modulo_q, barret_w, barret_u)                            

                        up_down_flag_fifo_ls[col][raw+reached_tile].release(ObjectFifoPort.Consume, 1)

                        

                        # =====================================
                        # cleanup
                        # =====================================
                        # TODO: This is dummy output
                        out_vec = CT_Mem_FIFO_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                        for i in range_(cores_size):
                            out_vec[i] = buff[i]
                        CT_Mem_FIFO_ls[col][raw].release(ObjectFifoPort.Produce, 1)

                        # Cleanup
                        Mem_CT_factor_FIFO_ls[col].release(ObjectFifoPort.Consume, 1)
                        

                        """
                        
                        # =====================================
                        # SWAP 1
                        # Before swap:
                        #  3  7 11 15
                        #  2  6 10 14
                        #  1  5  9 13
                        #  0  4  8 12
                        #
                        # After swap:
                        #  3  7 11 15
                        #  1  5  9 13
                        #  2  6 10 14
                        #  0  4  8 12
                        # =====================================
                        
                        destination = swap_destination[col][raw]

                        if core_index != destination:
                            swap_fifo_flag_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                            swap_fifo_flag_ls[destination // raw_num][destination % raw_num].acquire(ObjectFifoPort.Consume, 1)
                            if core_index > destination:
                                swap(buff_ls[col][raw],buff_ls[destination // raw_num][destination % raw_num],0 , 1<<(size_per_core_log-5))
                            if core_index < destination:
                                swap(buff_ls[col][raw],buff_ls[destination // raw_num][destination % raw_num],1<<(size_per_core_log-1), 1<<(size_per_core_log-5))

                            swap_fifo_flag_ls[destination // raw_num][destination % raw_num].acquire(ObjectFifoPort.Consume, 1)
                            swap_fifo_flag_ls[destination // raw_num][destination % raw_num].release(ObjectFifoPort.Consume, 1)

                        # =====================================
                        # 隣接タイルBF 1
                        # =====================================
                        #  3  7 11 15
                        #  |  |  |  |
                        #  1  5  9 13
                        #  2  6 10 14
                        #  |  |  |  |
                        #  0  4  8 12 
                        # =====================================
                        
                        up_down_flag_fifo_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)

                        #======
                        # 次のswapよう
                        destination = swap_destination[col][raw]
                        temp = col * raw_num + raw
                        if temp != destination:
                            swap_fifo_flag_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        #====
                        
                        stage = size_per_core_log+2
                        
                        factor_scalar = 1
                        for _ in range(core_index % (1 << (stage-size_per_core_log))):
                            factor_scalar = factor_scalar*factor_FIFO_buff[all_size_log-stage+size_per_core_log-1] % modulo_q

                        if raw % 2 == 0:
                            half_bool = 0
                            reached_tile = 1
                            NTT_stage_next_up_down(buff_ls[col][raw],buff_ls[col][raw+reached_tile],buff_ls[col][raw],buff_ls[col][raw+reached_tile],factor_buff,factor_FIFO_buff, factor_scalar,half_bool,stage, all_size_log,size_per_core_log,(1<< (size_per_core_log-5)),modulo_q, barret_w, barret_u)
                            
                        else:
                            half_bool = 1
                            reached_tile = -1
                            NTT_stage_next_up_down(buff_ls[col][raw+reached_tile],buff_ls[col][raw],buff_ls[col][raw+reached_tile],buff_ls[col][raw],factor_buff,factor_FIFO_buff, factor_scalar,half_bool,stage, all_size_log,size_per_core_log,(1<< (size_per_core_log-5)),modulo_q, barret_w, barret_u)

                        up_down_flag_fifo_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        up_down_flag_fifo_ls[col][raw+reached_tile].acquire(ObjectFifoPort.Consume, 1)
                        up_down_flag_fifo_ls[col][raw+reached_tile].release(ObjectFifoPort.Consume, 1)

                        
                        # =====================================
                        # SWAP 1-2

                        なぜ必要？
                        # =====================================

                        # 次のため
                        right_left_flag_fifo_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                        
                        
                        destination = swap_destination[col][raw]

                        if core_index != destination:
                            swap_fifo_flag_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                            swap_fifo_flag_ls[destination // raw_num][destination % raw_num].acquire(ObjectFifoPort.Consume, 1)
                            if core_index > destination:
                                swap(buff_ls[col][raw],buff_ls[destination // raw_num][destination % raw_num],0 , 1<<(size_per_core_log-5))
                            if core_index < destination:
                                swap(buff_ls[col][raw],buff_ls[destination // raw_num][destination % raw_num],1<<(size_per_core_log-1), 1<<(size_per_core_log-5))

                            swap_fifo_flag_ls[destination // raw_num][destination % raw_num].acquire(ObjectFifoPort.Consume, 1)
                            swap_fifo_flag_ls[destination // raw_num][destination % raw_num].release(ObjectFifoPort.Consume, 1)
                
                        # =====================================
                        # 横の計算
                        #  3 - 7 11 - 15
                        #  1 - 5  9 - 13
                        #  2 - 6 10 - 14
                        #  0 - 4  8 - 12 
                        # =====================================


                        #======
                        # 次のswapよう
                        destination = swap_2_destination[col][raw]
                        if core_index != destination:
                            swap_2_fifo_flag_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                        #====
                        
                        stage = size_per_core_log+3
                        reached_tile = 1
                        if col % 2 == 1:
                            factor_scaler_index = raw
                            half_bool = 0
                            
                            factor_scalar = 1
                            reached_tile = -1

                            for _ in range(factor_scaler_index):
                                factor_scalar = factor_scalar*factor_FIFO_buff[all_size_log-stage+size_per_core_log] % modulo_q

                            NTT_stage_next_up_down(buff_ls[col-1][raw],buff_ls[col][raw],buff_ls[col-1][raw],buff_ls[col][raw],factor_buff,factor_FIFO_buff, factor_scalar,half_bool,stage, all_size_log,size_per_core_log,(1<< (size_per_core_log-4)),modulo_q, barret_w, barret_u)                            

                        right_left_flag_fifo_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        right_left_flag_fifo_ls[col+reached_tile][raw].acquire(ObjectFifoPort.Consume, 1)
                        right_left_flag_fifo_ls[col+reached_tile][raw].release(ObjectFifoPort.Consume, 1)


                        # =====================================
                        # SWAP 2-1
                        # Before swap:
                        #  3  7 11 15
                        #  1  5  9 13
                        #  2  6 10 14
                        #  0  4  8 12
                        
                        # After swap:
                        #  3  11 7 15
                        #  1  9  5 13
                        #  2 10  6 14
                        #  0  8  4 12
                        # =====================================

                        # 次のため
                        right_left_flag_fifo_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                        
                        
                        destination = swap_2_destination[col][raw]

                        if core_index != destination:
                            swap_2_fifo_flag_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                            swap_2_fifo_flag_ls[destination // raw_num][destination % raw_num].acquire(ObjectFifoPort.Consume, 1)
                            if core_index > destination:
                                swap(buff_ls[col][raw],buff_ls[destination // raw_num][destination % raw_num],0 , 1<<(size_per_core_log-4))
                            # if core_index < destination:
                            #     swap(buff_ls[col][raw],buff_ls[destination // raw_num][destination % raw_num],1<<(size_per_core_log-1), 1<<(size_per_core_log-4))

                            # swap_2_fifo_flag_ls[destination // raw_num][destination % raw_num].acquire(ObjectFifoPort.Consume, 1)
                            swap_2_fifo_flag_ls[destination // raw_num][destination % raw_num].release(ObjectFifoPort.Consume, 1)
                        
                            swap_2_fifo_flag_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                            swap_2_fifo_flag_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        

                        
                        # =====================================
                        # 横の計算 2
                        #  3 -  11 7 - 15
                        #  1 -  9  5 - 13
                        #  2 - 10  6 - 14
                        #  0 -  8  4 - 12
                        # =====================================

                        stage = size_per_core_log+4
                        reached_tile = 1
                        if col % 2 == 1:
                            temp_index = 0
                            if col == 3:
                                temp_index = 4


                            factor_scaler_index = raw + temp_index
                            half_bool = 0
                            
                            factor_scalar = 1
                            reached_tile = -1

                            for _ in range(factor_scaler_index):
                                factor_scalar = factor_scalar*factor_FIFO_buff[all_size_log-stage+size_per_core_log] % modulo_q

                            NTT_stage_next_up_down(buff_ls[col-1][raw],buff_ls[col][raw],buff_ls[col-1][raw],buff_ls[col][raw],factor_buff,factor_FIFO_buff, factor_scalar,half_bool,stage, all_size_log,size_per_core_log,(1<< (size_per_core_log-4)),modulo_q, barret_w, barret_u)                            

                        right_left_flag_fifo_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        right_left_flag_fifo_ls[col+reached_tile][raw].acquire(ObjectFifoPort.Consume, 1)
                        right_left_flag_fifo_ls[col+reached_tile][raw].release(ObjectFifoPort.Consume, 1)


                        # =====================================
                        # ComputeTile → ShimTile
                        # =====================================
                    
                        out_put_vec = CT_Mem_FIFO_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)
                        times = 1<<(size_per_core_log-size_per_vec_log)

                        vector_copy(buff,out_put_vec,times)
                        CT_Mem_FIFO_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        """
                        






        # ===================
        # Runtime Sequence
        # ===================
        @runtime_sequence(all_ty,factor_all_ty,all_ty)
        def sequence(in_put,in_put_factor,out_put):
            if enableTrace:
                trace_utils.configure_simple_tracing_aie2(
                    CT_tile_ls[0][0],
                    Shim_tile_ls[0],
                    ddr_id=2,
                    size=trace_size,
                    offset=all_size * 4,  # offset in bytes
                )
            for col in range(col_num):
                npu_dma_memcpy_nd(metadata = Shim_Mem_FIFO_ls[col], bd_id=col, mem=in_put ,
                                   sizes=[1, 1, 1, 1<<(all_size_log-col_num_log)], offsets = [0,0,0,(1<<(all_size_log-col_num_log))*col],
                                   issue_token=True)
                
                npu_dma_memcpy_nd(metadata = Shim_Mem_factor_FIFO_ls[col], bd_id= col + col_num, mem=in_put_factor ,
                                   sizes=[1, 1, 1, factor_FIFO_size], offsets = [0,0,0,factor_FIFO_size*col],
                                   issue_token=True)
                
                npu_dma_memcpy_nd(metadata = Mem_Shim_FIFO_ls[col], bd_id=2*col_num+col, mem=out_put ,
                                   sizes=[1, 1, 1, 1<<(all_size_log-col_num_log)], offsets = [0,0,0,(1<<(all_size_log-col_num_log))*col]
                                   )
            
            # npu_sync(column=0, row=0, direction=0, channel=0)
            dma_wait(*Mem_Shim_FIFO_ls)



if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument(
        "-t",
        "--trace_sz",
        dest="trace_size",
        default=0,
        type=int,
        help="trace size in bytes",
    )
    opts = p.parse_args(sys.argv[1:])
    with mlir_mod_ctx() as ctx:
        my_vector_scalar(opts)
        res = ctx.module.operation.verify()
        if res == True:
            print(ctx.module)
        else:
            print(res)





