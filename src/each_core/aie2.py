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
import aie.extras.dialects.ext.arith as arith
from aie.helpers.util import np_dtype_to_mlir_type
from aie.extras import types as T

# ===================================
# Change here for different configurations
all_size_log = 17
# ===================================

DEBUG_ON = 1
DEBUG_OFF = 0
STORE_FACTOR = 1
NO_STORE_FACTOR = 0    

def divided_ntt_internal(opts):

    # enableTrace = opts.trace_size > 0
    enableTrace = False
    trace_size = opts.trace_size

    col_num_log = 2
    raw_num_log = 2
    
    cores_num_log = col_num_log+raw_num_log
    size_per_core_log = 10 # FIXED.
    
    block_per_core_log = size_per_core_log
    block_per_core = 1 << block_per_core_log
    block_per_col = 1 << (block_per_core_log + raw_num_log)
    loops = 1 << (all_size_log - block_per_core_log - col_num_log - raw_num_log)

    col_num = 1<<col_num_log
    raw_num = 1<<raw_num_log
    all_size = 1<<all_size_log
    factor_buff_size = 16 * 3
    factor_FIFO_size = all_size_log + 8  # +4 for barrett_w, barrett_u, and logn
    cores_num = 1<<cores_num_log
    cores_size = 1<<size_per_core_log
    

    @device(AIEDevice.npu1)
    def device_body():
        all_ty = np.ndarray[(all_size,), np.dtype[np.int32]]
        cores_ty = np.ndarray[(block_per_core,), np.dtype[np.int32]]
        factor_buff_ty = np.ndarray[(factor_buff_size,), np.dtype[np.int32]]
        mem_ty = np.ndarray[(block_per_col,), np.dtype[np.int32]]
        factor_FIFO_ty = np.ndarray[(factor_FIFO_size,), np.dtype[np.int32]]
        factor_mem_FIFO_ty = np.ndarray[(factor_FIFO_size,), np.dtype[np.int32]]
        factor_all_ty = np.ndarray[(factor_FIFO_size*col_num,), np.dtype[np.int32]]
        flag_ty = np.ndarray[(1,), np.dtype[np.int32]]
        int_ty = np.int32

        
        # ===================
        # External Function
        # ===================
        multi_NTT_in_a_tile = external_func(
            "multi_NTT_in_a_tile",
            inputs = [cores_ty,cores_ty,factor_buff_ty,factor_FIFO_ty,np.int32,np.int32,np.int32,np.int32,np.int32,np.int32,np.int32,np.int32],
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
        # Link FIFOs
        # ===================
        for col in range(col_num):
            object_fifo_link(Shim_Mem_FIFO_ls[col], [Mem_CT_FIFO_ls[col][raw] for raw in range(raw_num)],[],[raw*cores_size for raw in range(raw_num)])
            object_fifo_link( [CT_Mem_FIFO_ls[col][raw] for raw in range(raw_num)], Mem_Shim_FIFO_ls[col],[raw * cores_size for raw in range(raw_num)],[])
            object_fifo_link(Shim_Mem_factor_FIFO_ls[col], Mem_CT_factor_FIFO_ls[col],[],[raw * factor_FIFO_size for raw in range(raw_num)])


        # ===================
        # Buffers
        # ===================
        buff_ls = []
        for col in range(col_num):
            buff_ls.append([])
            for raw in range(raw_num):
                buff_ls[col].append( buffer(tile=CT_tile_ls[col][raw], datatype= cores_ty))
        

        factor_buff_ls = []
        for col in range(col_num):
            factor_buff_ls.append([])
            for raw in range(raw_num):
                factor_buff_ls[col].append( buffer(tile=CT_tile_ls[col][raw], datatype= factor_buff_ty))

        # ===================
        # Core Body
        # ===================
        for col in range(col_num):
            for raw in range(raw_num):
                @core(CT_tile_ls[col][raw], "aie-kernel.o")
                def core_body():
                    for _ in range_(sys.maxsize):
                        core_index = col * raw_num + raw
                                                
                        factor_FIFO_buff = Mem_CT_factor_FIFO_ls[col].acquire(ObjectFifoPort.Consume, 1)
                        factor_buff = factor_buff_ls[col][raw]
                        buff = buff_ls[col][raw]
                        
                        for loop in range_(loops):
                            # =====================================
                            # Copy input to local memory of ComputeTile
                            # =====================================
                            in_vec = Mem_CT_FIFO_ls[col][raw].acquire(ObjectFifoPort.Consume, 1)
                            out_vec = CT_Mem_FIFO_ls[col][raw].acquire(ObjectFifoPort.Produce, 1)

                            for i in range_(block_per_core):
                                buff[i] = in_vec[i]

                            # =====================================
                            # Prepare parameters
                            # =====================================
                            modulo_q = factor_FIFO_buff[all_size_log]
                            barret_w = factor_FIFO_buff[all_size_log + 1]
                            barret_u = factor_FIFO_buff[all_size_log + 2]
                            logn_for_current_ntt = factor_FIFO_buff[all_size_log + 3]
                            n_for_current_ntt = factor_FIFO_buff[all_size_log + 4]
                            if_phase2 = factor_FIFO_buff[all_size_log + 5]

                            
                            number_of_ntt_per_core = block_per_core // n_for_current_ntt
                            w_offset_pow = loop * (number_of_ntt_per_core * cores_num) + core_index * number_of_ntt_per_core
                            w_offset_pow_i32 = arith.index_cast(w_offset_pow, to=np_dtype_to_mlir_type(np.int32))
                            multi_NTT_in_a_tile(buff, buff, factor_buff, factor_FIFO_buff, all_size_log, 
                                                block_per_core_log, logn_for_current_ntt, modulo_q, barret_w, barret_u, w_offset_pow_i32, if_phase2)

                            
                            # =====================================
                            # cleanup
                            # =====================================
                            for i in range_(block_per_core):
                                out_vec[i] = buff[i]
                            
                            Mem_CT_FIFO_ls[col][raw].release(ObjectFifoPort.Consume, 1)
                            CT_Mem_FIFO_ls[col][raw].release(ObjectFifoPort.Produce, 1)
                        Mem_CT_factor_FIFO_ls[col].release(ObjectFifoPort.Consume, 1)                        
                        
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
            inner_max = 256
            inner_rep = block_per_col // inner_max
            for col in range(col_num):
                npu_dma_memcpy_nd(metadata = Shim_Mem_FIFO_ls[col], bd_id=col, mem=in_put ,
                                   sizes=[1, loops, inner_rep, inner_max], 
                                   offsets = [0,0,0,block_per_col*col],
                                   strides=[0, block_per_col*col_num, inner_max, 1],
                                   issue_token=True)
                
                npu_dma_memcpy_nd(metadata = Shim_Mem_factor_FIFO_ls[col], bd_id= col + col_num, mem=in_put_factor ,
                                   sizes=[1, 1, 1, factor_FIFO_size], offsets = [0,0,0,factor_FIFO_size*col],
                                   issue_token=True)
                
                npu_dma_memcpy_nd(metadata = Mem_Shim_FIFO_ls[col], bd_id=2*col_num+col, mem=out_put,
                                   sizes=[1, loops, inner_rep, inner_max], 
                                   offsets = [0,0,0,block_per_col*col],
                                   strides=[0, block_per_col*col_num, inner_max, 1],
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
        divided_ntt_internal(opts)
        res = ctx.module.operation.verify()
        if res == True:
            print(ctx.module)
        else:
            print(res)





