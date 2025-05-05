# section-4/section-4b/aie2.py -*- Python -*-
#
# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# (c) Copyright 2024 Advanced Micro Devices, Inc. or its affiliates


"""


# トレース撮りたい


"""


import argparse
import numpy as np
import sys

from aie.dialects.aie import *
from aie.dialects.aiex import *
from aie.helpers.dialects.ext.scf import _for as range_
from aie.extras.context import mlir_mod_ctx

import aie.utils.trace as trace_utils


def my_vector_scalar(opts):

    enableTrace = opts.trace_size > 0
    trace_size = opts.trace_size

    all_size_log = 12
    all_size = 2**all_size_log
    core_size_log = all_size_log
    core_size = 1<<core_size_log
    factor_FIFO_size = all_size_log
    factor_buff_size_log = core_size_log-1
    factor_buff_size = 1<<(factor_buff_size_log)
    last_FIFO_size_log = all_size_log
    last_FIFO_size = 1 << last_FIFO_size_log
    calc_size_log = 4
    calc_size = 1<<calc_size_log

    # modulo_q = 12289
    modulo_q = 65537
    barret_w = 17
    barret_u = 2**(2 * barret_w) // modulo_q


    @device(AIEDevice.npu1_1col)
    def device_body():
        all_ty = np.ndarray[(all_size,), np.dtype[np.int32]]
        cores_ty = np.ndarray[(core_size,), np.dtype[np.int32]]
        factor_FIFO_ty = np.ndarray[(factor_FIFO_size,), np.dtype[np.int32]]
        factor_buff_ty = np.ndarray[(factor_buff_size,), np.dtype[np.int32]]




        NTT_stage_down = external_func(
            "NTT_stage_down",
            inputs = [cores_ty,cores_ty,factor_buff_ty,factor_FIFO_ty,np.int32,  np.int32,np.int32, np.int32, np.int32,np.int32],
        )
        NTT_stage_up = external_func(
            "NTT_stage_up",
            inputs = [cores_ty,cores_ty,factor_buff_ty,factor_FIFO_ty,np.int32, np.int32, np.int32,np.int32, np.int32, np.int32],
        )


        # Tile declarations
        ShimTile = tile(0, 0)
        ComputeTile2 = tile(0, 2)

        # AIE-array data movement with object fifos
        of_in_FIFO = object_fifo("of_in_FIFO", ShimTile, ComputeTile2, 1, cores_ty)
        of_in_factor_FIFO = object_fifo("of_in_factor_FIFO", ShimTile, ComputeTile2, 1, factor_FIFO_ty)
        of_out_FIFO = object_fifo("out", ComputeTile2, ShimTile, 1, cores_ty)



        factor_buff = buffer(tile=ComputeTile2, datatype= factor_buff_ty)




# ======================================================================================================
# 内部計算
# ======================================================================================================
        # Set up compute tiles
        # Compute tile 2
        @core(ComputeTile2, "func.o")
        def core_body():
            # Effective while(1)
            for _ in range_(sys.maxsize):
                get_vec = of_in_FIFO.acquire(ObjectFifoPort.Consume, 1)
                get_in_factor_vec = of_in_factor_FIFO.acquire(ObjectFifoPort.Consume, 1)
                for stage in range(1,6):
                    NTT_stage_down(get_vec,get_vec,factor_buff,get_in_factor_vec,stage,all_size_log,core_size_log,modulo_q,barret_w,barret_u)
                
                for stage in range(6,core_size_log):
                    NTT_stage_up(get_vec,get_vec,factor_buff,get_in_factor_vec,stage,all_size_log,core_size_log,modulo_q,barret_w,barret_u)
                

                put_vec = of_out_FIFO.acquire(ObjectFifoPort.Produce, 1)
                NTT_stage_up(get_vec,put_vec,factor_buff,get_in_factor_vec,core_size_log,all_size_log,core_size_log,modulo_q,barret_w,barret_u)
                
                of_out_FIFO.release(ObjectFifoPort.Produce, 1)
                of_in_FIFO.release(ObjectFifoPort.Consume, 1)
                of_in_factor_FIFO.release(ObjectFifoPort.Consume, 1)






# =========================================================================
# 最終設定
# =========================================================================
        # Set up a circuit-switched flow from core to shim for tracing information
        if enableTrace:
            flow(ComputeTile2, WireBundle.Trace, 0, ShimTile, WireBundle.DMA, 1)

        # To/from AIE-array data movement
        @runtime_sequence(all_ty, factor_FIFO_ty, all_ty)
        def sequence(A, F, C):
            if enableTrace:
                trace_utils.configure_simple_tracing_aie2(
                    ComputeTile2,
                    ShimTile,
                    ddr_id=2,
                    size=trace_size,
                    offset=all_size * 4,  # offset in bytes
                )

            npu_dma_memcpy_nd(
                metadata=of_in_FIFO, bd_id=1, mem=A, sizes=[1, 1, 1, all_size], issue_token=True
            )
            npu_dma_memcpy_nd(
                metadata=of_in_factor_FIFO,
                bd_id=2,
                mem=F,
                sizes=[1, 1, 1, factor_FIFO_size],
                issue_token=True,
            )
            npu_dma_memcpy_nd(metadata=of_out_FIFO, bd_id=0, mem=C, sizes=[1, 1, 1, all_size])
            dma_wait(of_out_FIFO)


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
