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
    %out_cons_prod_lock = aie.lock(%tile_0_0, 4) {init = 1 : i32, sym_name = "out_cons_prod_lock"}
    %out_cons_cons_lock = aie.lock(%tile_0_0, 5) {init = 0 : i32, sym_name = "out_cons_cons_lock"}
    %out_buff_0 = aie.buffer(%tile_0_2) {address = 16384 : i32, mem_bank = 1 : i32, sym_name = "out_buff_0"} : memref<4096xi32> 
    %out_prod_lock = aie.lock(%tile_0_2, 4) {init = 1 : i32, sym_name = "out_prod_lock"}
    %out_cons_lock = aie.lock(%tile_0_2, 5) {init = 0 : i32, sym_name = "out_cons_lock"}
    %of_in_factor_FIFO_cons_buff_0 = aie.buffer(%tile_0_2) {address = 1024 : i32, mem_bank = 0 : i32, sym_name = "of_in_factor_FIFO_cons_buff_0"} : memref<12xi32> 
    %of_in_factor_FIFO_cons_prod_lock = aie.lock(%tile_0_2, 2) {init = 1 : i32, sym_name = "of_in_factor_FIFO_cons_prod_lock"}
    %of_in_factor_FIFO_cons_cons_lock = aie.lock(%tile_0_2, 3) {init = 0 : i32, sym_name = "of_in_factor_FIFO_cons_cons_lock"}
    %of_in_factor_FIFO_prod_lock = aie.lock(%tile_0_0, 2) {init = 1 : i32, sym_name = "of_in_factor_FIFO_prod_lock"}
    %of_in_factor_FIFO_cons_lock = aie.lock(%tile_0_0, 3) {init = 0 : i32, sym_name = "of_in_factor_FIFO_cons_lock"}
    %of_in_FIFO_cons_buff_0 = aie.buffer(%tile_0_2) {address = 32768 : i32, mem_bank = 2 : i32, sym_name = "of_in_FIFO_cons_buff_0"} : memref<4096xi32> 
    %of_in_FIFO_cons_prod_lock = aie.lock(%tile_0_2, 0) {init = 1 : i32, sym_name = "of_in_FIFO_cons_prod_lock"}
    %of_in_FIFO_cons_cons_lock = aie.lock(%tile_0_2, 1) {init = 0 : i32, sym_name = "of_in_FIFO_cons_cons_lock"}
    %of_in_FIFO_prod_lock = aie.lock(%tile_0_0, 0) {init = 1 : i32, sym_name = "of_in_FIFO_prod_lock"}
    %of_in_FIFO_cons_lock = aie.lock(%tile_0_0, 1) {init = 0 : i32, sym_name = "of_in_FIFO_cons_lock"}
    %switchbox_0_0 = aie.switchbox(%tile_0_0) {
      aie.connect<South : 3, North : 1>
      aie.connect<South : 7, North : 0>
      aie.connect<North : 0, South : 2>
      %0 = aie.amsel<5> (3)
      %1 = aie.masterset(South : 0, %0) {keep_pkt_header = true}
      aie.packet_rules(Ctrl : 0) {
        aie.rule(31, 15, %0)
      }
    }
    %shim_mux_0_0 = aie.shim_mux(%tile_0_0) {
      aie.connect<DMA : 0, North : 3>
      aie.connect<DMA : 1, North : 7>
      aie.connect<North : 2, DMA : 0>
    }
    %tile_0_1 = aie.tile(0, 1)
    %switchbox_0_1 = aie.switchbox(%tile_0_1) {
      aie.connect<South : 1, North : 1>
      aie.connect<South : 0, North : 0>
      aie.connect<North : 0, South : 0>
    }
    %switchbox_0_2 = aie.switchbox(%tile_0_2) {
      aie.connect<South : 1, DMA : 0>
      aie.connect<South : 0, DMA : 1>
      aie.connect<DMA : 0, South : 0>
    }
    %_anonymous0 = aie.buffer(%tile_0_2) {address = 49152 : i32, mem_bank = 3 : i32, sym_name = "_anonymous0"} : memref<2048xi32> 
    %core_0_2 = aie.core(%tile_0_2) {
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
      %c1_i32 = arith.constant 1 : i32
      %c12_i32 = arith.constant 12 : i32
      %c12_i32_0 = arith.constant 12 : i32
      %c65537_i32 = arith.constant 65537 : i32
      %c17_i32 = arith.constant 17 : i32
      %c262140_i32 = arith.constant 262140 : i32
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c1_i32, %c12_i32, %c12_i32_0, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c2_i32 = arith.constant 2 : i32
      %c12_i32_1 = arith.constant 12 : i32
      %c12_i32_2 = arith.constant 12 : i32
      %c65537_i32_3 = arith.constant 65537 : i32
      %c17_i32_4 = arith.constant 17 : i32
      %c262140_i32_5 = arith.constant 262140 : i32
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c2_i32, %c12_i32_1, %c12_i32_2, %c65537_i32_3, %c17_i32_4, %c262140_i32_5) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c3_i32 = arith.constant 3 : i32
      %c12_i32_6 = arith.constant 12 : i32
      %c12_i32_7 = arith.constant 12 : i32
      %c65537_i32_8 = arith.constant 65537 : i32
      %c17_i32_9 = arith.constant 17 : i32
      %c262140_i32_10 = arith.constant 262140 : i32
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c3_i32, %c12_i32_6, %c12_i32_7, %c65537_i32_8, %c17_i32_9, %c262140_i32_10) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c4_i32 = arith.constant 4 : i32
      %c12_i32_11 = arith.constant 12 : i32
      %c12_i32_12 = arith.constant 12 : i32
      %c65537_i32_13 = arith.constant 65537 : i32
      %c17_i32_14 = arith.constant 17 : i32
      %c262140_i32_15 = arith.constant 262140 : i32
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c4_i32, %c12_i32_11, %c12_i32_12, %c65537_i32_13, %c17_i32_14, %c262140_i32_15) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c5_i32 = arith.constant 5 : i32
      %c12_i32_16 = arith.constant 12 : i32
      %c12_i32_17 = arith.constant 12 : i32
      %c65537_i32_18 = arith.constant 65537 : i32
      %c17_i32_19 = arith.constant 17 : i32
      %c262140_i32_20 = arith.constant 262140 : i32
      func.call @NTT_stage_down(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c5_i32, %c12_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c6_i32 = arith.constant 6 : i32
      %c12_i32_21 = arith.constant 12 : i32
      %c12_i32_22 = arith.constant 12 : i32
      %c65537_i32_23 = arith.constant 65537 : i32
      %c17_i32_24 = arith.constant 17 : i32
      %c262140_i32_25 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c6_i32, %c12_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c7_i32 = arith.constant 7 : i32
      %c12_i32_26 = arith.constant 12 : i32
      %c12_i32_27 = arith.constant 12 : i32
      %c65537_i32_28 = arith.constant 65537 : i32
      %c17_i32_29 = arith.constant 17 : i32
      %c262140_i32_30 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c7_i32, %c12_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c8_i32 = arith.constant 8 : i32
      %c12_i32_31 = arith.constant 12 : i32
      %c12_i32_32 = arith.constant 12 : i32
      %c65537_i32_33 = arith.constant 65537 : i32
      %c17_i32_34 = arith.constant 17 : i32
      %c262140_i32_35 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c8_i32, %c12_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c9_i32 = arith.constant 9 : i32
      %c12_i32_36 = arith.constant 12 : i32
      %c12_i32_37 = arith.constant 12 : i32
      %c65537_i32_38 = arith.constant 65537 : i32
      %c17_i32_39 = arith.constant 17 : i32
      %c262140_i32_40 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c9_i32, %c12_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c10_i32 = arith.constant 10 : i32
      %c12_i32_41 = arith.constant 12 : i32
      %c12_i32_42 = arith.constant 12 : i32
      %c65537_i32_43 = arith.constant 65537 : i32
      %c17_i32_44 = arith.constant 17 : i32
      %c262140_i32_45 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c10_i32, %c12_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      %c11_i32 = arith.constant 11 : i32
      %c12_i32_46 = arith.constant 12 : i32
      %c12_i32_47 = arith.constant 12 : i32
      %c65537_i32_48 = arith.constant 65537 : i32
      %c17_i32_49 = arith.constant 17 : i32
      %c262140_i32_50 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %of_in_FIFO_cons_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c11_i32, %c12_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      aie.use_lock(%out_prod_lock, AcquireGreaterEqual, 1)
      %c12_i32_51 = arith.constant 12 : i32
      %c12_i32_52 = arith.constant 12 : i32
      %c12_i32_53 = arith.constant 12 : i32
      %c65537_i32_54 = arith.constant 65537 : i32
      %c17_i32_55 = arith.constant 17 : i32
      %c262140_i32_56 = arith.constant 262140 : i32
      func.call @NTT_stage_up(%of_in_FIFO_cons_buff_0, %out_buff_0, %_anonymous0, %of_in_factor_FIFO_cons_buff_0, %c12_i32_51, %c12_i32_52, %c12_i32_53, %c65537_i32_54, %c17_i32_55, %c262140_i32_56) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
      aie.use_lock(%out_cons_lock, Release, 1)
      aie.use_lock(%of_in_FIFO_cons_prod_lock, Release, 1)
      aie.use_lock(%of_in_factor_FIFO_cons_prod_lock, Release, 1)
      %2 = arith.addi %0, %c1 : index
      cf.br ^bb1(%2 : index)
    ^bb3:  // pred: ^bb1
      aie.end
    } {link_with = "func.o"}
    aie.shim_dma_allocation @of_in_FIFO(MM2S, 0, 0)
    aiex.runtime_sequence(%arg0: memref<4096xi32>, %arg1: memref<12xi32>, %arg2: memref<4096xi32>) {
      aiex.npu.dma_memcpy_nd(0, 0, %arg0[0, 0, 0, 0][1, 1, 1, 4096][0, 0, 0, 1]) {id = 1 : i64, issue_token = true, metadata = @of_in_FIFO} : memref<4096xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg1[0, 0, 0, 0][1, 1, 1, 12][0, 0, 0, 1]) {id = 2 : i64, issue_token = true, metadata = @of_in_factor_FIFO} : memref<12xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg2[0, 0, 0, 0][1, 1, 1, 4096][0, 0, 0, 1]) {id = 0 : i64, metadata = @out} : memref<4096xi32>
      aiex.npu.dma_wait {symbol = @out}
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
    aie.wire(%shim_mux_0_0 : North, %switchbox_0_0 : South)
    aie.wire(%tile_0_0 : DMA, %shim_mux_0_0 : DMA)
    aie.wire(%tile_0_1 : Core, %switchbox_0_1 : Core)
    aie.wire(%tile_0_1 : DMA, %switchbox_0_1 : DMA)
    aie.wire(%switchbox_0_0 : North, %switchbox_0_1 : South)
    aie.wire(%tile_0_2 : Core, %switchbox_0_2 : Core)
    aie.wire(%tile_0_2 : DMA, %switchbox_0_2 : DMA)
    aie.wire(%switchbox_0_1 : North, %switchbox_0_2 : South)
  }
}

