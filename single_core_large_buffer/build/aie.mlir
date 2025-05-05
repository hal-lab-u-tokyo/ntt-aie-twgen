module {
  aie.device(npu1_1col) {
    func.func private @NTT_stage_down(memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32)
    func.func private @NTT_stage_up(memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32)
    %tile_0_0 = aie.tile(0, 0)
    %tile_0_2 = aie.tile(0, 2)
    aie.objectfifo @of_in_FIFO(%tile_0_0, {%tile_0_2}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_in_factor_FIFO(%tile_0_0, {%tile_0_2}, 1 : i32) : !aie.objectfifo<memref<12xi32>>
    aie.objectfifo @out(%tile_0_2, {%tile_0_0}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    %buffer_0_2 = aie.buffer(%tile_0_2) : memref<2048xi32> 
    %core_0_2 = aie.core(%tile_0_2) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_in_FIFO(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_in_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<12xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<12xi32>> -> memref<12xi32>
        %c1_i32 = arith.constant 1 : i32
        %c12_i32 = arith.constant 12 : i32
        %c12_i32_0 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%1, %1, %buffer_0_2, %3, %c1_i32, %c12_i32, %c12_i32_0, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c12_i32_1 = arith.constant 12 : i32
        %c12_i32_2 = arith.constant 12 : i32
        %c65537_i32_3 = arith.constant 65537 : i32
        %c17_i32_4 = arith.constant 17 : i32
        %c262140_i32_5 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%1, %1, %buffer_0_2, %3, %c2_i32, %c12_i32_1, %c12_i32_2, %c65537_i32_3, %c17_i32_4, %c262140_i32_5) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c12_i32_6 = arith.constant 12 : i32
        %c12_i32_7 = arith.constant 12 : i32
        %c65537_i32_8 = arith.constant 65537 : i32
        %c17_i32_9 = arith.constant 17 : i32
        %c262140_i32_10 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%1, %1, %buffer_0_2, %3, %c3_i32, %c12_i32_6, %c12_i32_7, %c65537_i32_8, %c17_i32_9, %c262140_i32_10) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c12_i32_11 = arith.constant 12 : i32
        %c12_i32_12 = arith.constant 12 : i32
        %c65537_i32_13 = arith.constant 65537 : i32
        %c17_i32_14 = arith.constant 17 : i32
        %c262140_i32_15 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%1, %1, %buffer_0_2, %3, %c4_i32, %c12_i32_11, %c12_i32_12, %c65537_i32_13, %c17_i32_14, %c262140_i32_15) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c12_i32_16 = arith.constant 12 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%1, %1, %buffer_0_2, %3, %c5_i32, %c12_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c12_i32_21 = arith.constant 12 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %1, %buffer_0_2, %3, %c6_i32, %c12_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c12_i32_26 = arith.constant 12 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %1, %buffer_0_2, %3, %c7_i32, %c12_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c12_i32_31 = arith.constant 12 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %1, %buffer_0_2, %3, %c8_i32, %c12_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c12_i32_36 = arith.constant 12 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %1, %buffer_0_2, %3, %c9_i32, %c12_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c12_i32_41 = arith.constant 12 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %1, %buffer_0_2, %3, %c10_i32, %c12_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c12_i32_46 = arith.constant 12 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %1, %buffer_0_2, %3, %c11_i32, %c12_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @out(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c12_i32_51 = arith.constant 12 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c12_i32_53 = arith.constant 12 : i32
        %c65537_i32_54 = arith.constant 65537 : i32
        %c17_i32_55 = arith.constant 17 : i32
        %c262140_i32_56 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%1, %5, %buffer_0_2, %3, %c12_i32_51, %c12_i32_52, %c12_i32_53, %c65537_i32_54, %c17_i32_55, %c262140_i32_56) : (memref<4096xi32>, memref<4096xi32>, memref<2048xi32>, memref<12xi32>, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @out(Produce, 1)
        aie.objectfifo.release @of_in_FIFO(Consume, 1)
        aie.objectfifo.release @of_in_factor_FIFO(Consume, 1)
      }
      aie.end
    } {link_with = "func.o"}
    aiex.runtime_sequence(%arg0: memref<4096xi32>, %arg1: memref<12xi32>, %arg2: memref<4096xi32>) {
      aiex.npu.dma_memcpy_nd(0, 0, %arg0[0, 0, 0, 0][1, 1, 1, 4096][0, 0, 0, 1]) {id = 1 : i64, issue_token = true, metadata = @of_in_FIFO} : memref<4096xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg1[0, 0, 0, 0][1, 1, 1, 12][0, 0, 0, 1]) {id = 2 : i64, issue_token = true, metadata = @of_in_factor_FIFO} : memref<12xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg2[0, 0, 0, 0][1, 1, 1, 4096][0, 0, 0, 1]) {id = 0 : i64, metadata = @out} : memref<4096xi32>
      aiex.npu.dma_wait {symbol = @out}
    }
  }
}

