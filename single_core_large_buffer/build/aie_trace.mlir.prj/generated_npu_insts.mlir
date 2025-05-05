module {
  aie.device(npu1_1col) {
    memref.global "public" @out_cons : memref<4096xi32>
    memref.global "public" @out : memref<4096xi32>
    memref.global "public" @of_in_factor_FIFO_cons : memref<12xi32>
    memref.global "public" @of_in_factor_FIFO : memref<12xi32>
    memref.global "public" @of_in_FIFO_cons : memref<4096xi32>
    memref.global "public" @of_in_FIFO : memref<4096xi32>
    func.func private @NTT_stage_down(memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32)
    func.func private @NTT_stage_up(memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32)
    %tile_0_0 = aie.tile(0, 0) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 15>}
    %tile_0_2 = aie.tile(0, 2) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 27>}
    %out_buff_0 = aie.buffer(%tile_0_2) {address = 16384 : i32, mem_bank = 1 : i32, sym_name = "out_buff_0"} : memref<4096xi32> 
    %out_prod_lock = aie.lock(%tile_0_2, 4) {init = 1 : i32, sym_name = "out_prod_lock"}
    %out_cons_lock = aie.lock(%tile_0_2, 5) {init = 0 : i32, sym_name = "out_cons_lock"}
    %of_in_factor_FIFO_cons_buff_0 = aie.buffer(%tile_0_2) {address = 1024 : i32, mem_bank = 0 : i32, sym_name = "of_in_factor_FIFO_cons_buff_0"} : memref<12xi32> 
    %of_in_factor_FIFO_cons_prod_lock = aie.lock(%tile_0_2, 2) {init = 1 : i32, sym_name = "of_in_factor_FIFO_cons_prod_lock"}
    %of_in_factor_FIFO_cons_cons_lock = aie.lock(%tile_0_2, 3) {init = 0 : i32, sym_name = "of_in_factor_FIFO_cons_cons_lock"}
    %of_in_FIFO_cons_buff_0 = aie.buffer(%tile_0_2) {address = 32768 : i32, mem_bank = 2 : i32, sym_name = "of_in_FIFO_cons_buff_0"} : memref<4096xi32> 
    %of_in_FIFO_cons_prod_lock = aie.lock(%tile_0_2, 0) {init = 1 : i32, sym_name = "of_in_FIFO_cons_prod_lock"}
    %of_in_FIFO_cons_cons_lock = aie.lock(%tile_0_2, 1) {init = 0 : i32, sym_name = "of_in_FIFO_cons_cons_lock"}
    aie.flow(%tile_0_0, DMA : 0, %tile_0_2, DMA : 0)
    aie.flow(%tile_0_0, DMA : 1, %tile_0_2, DMA : 1)
    aie.flow(%tile_0_2, DMA : 0, %tile_0_0, DMA : 0)
    %_anonymous0 = aie.buffer(%tile_0_2) {address = 49152 : i32, mem_bank = 3 : i32, sym_name = "_anonymous0"} : memref<2048xi32> 
    %core_0_2 = aie.core(%tile_0_2) {
      %c11_i32 = arith.constant 11 : i32
      %c10_i32 = arith.constant 10 : i32
      %c9_i32 = arith.constant 9 : i32
      %c8_i32 = arith.constant 8 : i32
      %c7_i32 = arith.constant 7 : i32
      %c6_i32 = arith.constant 6 : i32
      %c5_i32 = arith.constant 5 : i32
      %c4_i32 = arith.constant 4 : i32
      %c3_i32 = arith.constant 3 : i32
      %c2_i32 = arith.constant 2 : i32
      %c262140_i32 = arith.constant 262140 : i32
      %c17_i32 = arith.constant 17 : i32
      %c65537_i32 = arith.constant 65537 : i32
      %c12_i32 = arith.constant 12 : i32
      %c1_i32 = arith.constant 1 : i32
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
      %1 = arith.cmpi slt, %0, %c9223372036854775807 : index
      cf.cond_br %1, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      aie.use_lock(%of_in_FIFO_cons_cons_lock, AcquireGreaterEqual, 1)
      aie.use_lock(%of_in_factor_FIFO_cons_cons_lock, AcquireGreaterEqual, 1)
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c1_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c2_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c3_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c4_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c5_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c6_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c7_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c8_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c9_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c10_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c11_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      aie.use_lock(%out_prod_lock, AcquireGreaterEqual, 1)
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %out_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c12_i32, %c12_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      aie.use_lock(%out_cons_lock, Release, 1)
      aie.use_lock(%of_in_FIFO_cons_prod_lock, Release, 1)
      aie.use_lock(%of_in_factor_FIFO_cons_prod_lock, Release, 1)
      %2 = arith.addi %0, %c1 : index
      cf.br ^bb1(%2 : index)
    ^bb3:  // pred: ^bb1
      aie.end
    } {link_with = "func.o"}
    aie.flow(%tile_0_2, Trace : 0, %tile_0_0, DMA : 1)
    aie.shim_dma_allocation @of_in_FIFO(MM2S, 0, 0)
    memref.global "private" constant @blockwrite_data_0 : memref<8xi32> = dense<[32768, 16384, 0, 0, -2147483648, 0, 0, 33554432]>
    memref.global "private" constant @blockwrite_data_1 : memref<8xi32> = dense<[4096, 0, 0, 0, -2147483648, 0, 0, 33554432]>
    memref.global "private" constant @blockwrite_data_2 : memref<8xi32> = dense<[12, 0, 0, 0, -2147483648, 0, 0, 33554432]>
    memref.global "private" constant @blockwrite_data_3 : memref<8xi32> = dense<[4096, 0, 0, 0, -2147483648, 0, 0, 33554432]>
    aiex.runtime_sequence(%arg0: memref<4096xi32>, %arg1: memref<12xi32>, %arg2: memref<4096xi32>) {
      aiex.npu.write32 {address = 213200 : ui32, column = 0 : i32, row = 2 : i32, value = 65536 : ui32}
      aiex.npu.write32 {address = 213204 : ui32, column = 0 : i32, row = 2 : i32, value = 0 : ui32}
      aiex.npu.write32 {address = 213216 : ui32, column = 0 : i32, row = 2 : i32, value = 1260724769 : ui32}
      aiex.npu.write32 {address = 213220 : ui32, column = 0 : i32, row = 2 : i32, value = 439168079 : ui32}
      aiex.npu.write32 {address = 261888 : ui32, column = 0 : i32, row = 2 : i32, value = 289 : ui32}
      aiex.npu.write32 {address = 261892 : ui32, column = 0 : i32, row = 2 : i32, value = 0 : ui32}
      %0 = memref.get_global @blockwrite_data_0 : memref<8xi32>
      aiex.npu.blockwrite(%0) {address = 119200 : ui32} : memref<8xi32>
      aiex.npu.address_patch {addr = 119204 : ui32, arg_idx = 2 : i32, arg_plus = 16384 : i32}
      aiex.npu.write32 {address = 119308 : ui32, column = 0 : i32, row = 0 : i32, value = 13 : ui32}
      %1 = memref.get_global @blockwrite_data_1 : memref<8xi32>
      aiex.npu.blockwrite(%1) {address = 118816 : ui32} : memref<8xi32>
      aiex.npu.address_patch {addr = 118820 : ui32, arg_idx = 0 : i32, arg_plus = 0 : i32}
      aiex.npu.maskwrite32 {address = 119312 : ui32, column = 0 : i32, mask = 3840 : ui32, row = 0 : i32, value = 3840 : ui32}
      aiex.npu.write32 {address = 119316 : ui32, column = 0 : i32, row = 0 : i32, value = 2147483649 : ui32}
      %2 = memref.get_global @blockwrite_data_2 : memref<8xi32>
      aiex.npu.blockwrite(%2) {address = 118848 : ui32} : memref<8xi32>
      aiex.npu.address_patch {addr = 118852 : ui32, arg_idx = 1 : i32, arg_plus = 0 : i32}
      aiex.npu.maskwrite32 {address = 119320 : ui32, column = 0 : i32, mask = 3840 : ui32, row = 0 : i32, value = 3840 : ui32}
      aiex.npu.write32 {address = 119324 : ui32, column = 0 : i32, row = 0 : i32, value = 2147483650 : ui32}
      %3 = memref.get_global @blockwrite_data_3 : memref<8xi32>
      aiex.npu.blockwrite(%3) {address = 118784 : ui32} : memref<8xi32>
      aiex.npu.address_patch {addr = 118788 : ui32, arg_idx = 2 : i32, arg_plus = 0 : i32}
      aiex.npu.maskwrite32 {address = 119296 : ui32, column = 0 : i32, mask = 3840 : ui32, row = 0 : i32, value = 3840 : ui32}
      aiex.npu.write32 {address = 119300 : ui32, column = 0 : i32, row = 0 : i32, value = 2147483648 : ui32}
      aiex.npu.sync {channel = 0 : i32, column = 0 : i32, column_num = 1 : i32, direction = 0 : i32, row = 0 : i32, row_num = 1 : i32}
    }
    aie.shim_dma_allocation @of_in_factor_FIFO(MM2S, 1, 0)
    aie.shim_dma_allocation @out(S2MM, 0, 0)
    %mem_0_2 = aie.mem(%tile_0_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb2)
    ^bb1:  // 2 preds: ^bb0, ^bb1
      aie.use_lock(%of_in_FIFO_cons_prod_lock, AcquireGreaterEqual, 1)
      aie.dma_bd(%of_in_FIFO_cons_buff_0 : memref<4096xi32>, 0, 4096) {bd_id = 0 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%of_in_FIFO_cons_cons_lock, Release, 1)
      aie.next_bd ^bb1
    ^bb2:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb3, ^bb4)
    ^bb3:  // 2 preds: ^bb2, ^bb3
      aie.use_lock(%of_in_factor_FIFO_cons_prod_lock, AcquireGreaterEqual, 1)
      aie.dma_bd(%of_in_factor_FIFO_cons_buff_0 : memref<12xi32>, 0, 12) {bd_id = 1 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%of_in_factor_FIFO_cons_cons_lock, Release, 1)
      aie.next_bd ^bb3
    ^bb4:  // pred: ^bb2
      %2 = aie.dma_start(MM2S, 0, ^bb5, ^bb6)
    ^bb5:  // 2 preds: ^bb4, ^bb5
      aie.use_lock(%out_cons_lock, AcquireGreaterEqual, 1)
      aie.dma_bd(%out_buff_0 : memref<4096xi32>, 0, 4096) {bd_id = 2 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%out_prod_lock, Release, 1)
      aie.next_bd ^bb5
    ^bb6:  // pred: ^bb4
      aie.end
    }
    aie.packet_flow(15) {
      aie.packet_source<%tile_0_0, Ctrl : 0>
      aie.packet_dest<%tile_0_0, South : 0>
    } {keep_pkt_header = true, priority_route = true}
  }
}

