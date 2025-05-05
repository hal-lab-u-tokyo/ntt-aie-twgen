module {
  aie.device(npu1_4col) {
    func.func private @NTT_stage_down(memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32)
    func.func private @NTT_stage_up(memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32)
    func.func private @store_func(memref<4096xi32>, memref<4096xi32>, i32)
    func.func private @NTT_stage_next_up_down(memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32)
    func.func private @swap(memref<4096xi32>, memref<4096xi32>, i32, i32)
    %tile_0_0 = aie.tile(0, 0)
    %tile_0_1 = aie.tile(0, 1)
    %tile_0_2 = aie.tile(0, 2)
    %tile_0_3 = aie.tile(0, 3)
    %tile_0_4 = aie.tile(0, 4)
    %tile_0_5 = aie.tile(0, 5)
    %tile_1_0 = aie.tile(1, 0)
    %tile_1_1 = aie.tile(1, 1)
    %tile_1_2 = aie.tile(1, 2)
    %tile_1_3 = aie.tile(1, 3)
    %tile_1_4 = aie.tile(1, 4)
    %tile_1_5 = aie.tile(1, 5)
    %tile_2_0 = aie.tile(2, 0)
    %tile_2_1 = aie.tile(2, 1)
    %tile_2_2 = aie.tile(2, 2)
    %tile_2_3 = aie.tile(2, 3)
    %tile_2_4 = aie.tile(2, 4)
    %tile_2_5 = aie.tile(2, 5)
    %tile_3_0 = aie.tile(3, 0)
    %tile_3_1 = aie.tile(3, 1)
    %tile_3_2 = aie.tile(3, 2)
    %tile_3_3 = aie.tile(3, 3)
    %tile_3_4 = aie.tile(3, 4)
    %tile_3_5 = aie.tile(3, 5)
    aie.objectfifo @of_Mem_0_CT_factor_FIFO(%tile_0_1, {%tile_0_2, %tile_0_3, %tile_0_4, %tile_0_5}, 1 : i32) : !aie.objectfifo<memref<2048xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_0_0(%tile_0_1, {%tile_0_2}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_0_0(%tile_0_2, {%tile_0_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_0_1(%tile_0_1, {%tile_0_3}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_0_1(%tile_0_3, {%tile_0_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_0_2(%tile_0_1, {%tile_0_4}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_0_2(%tile_0_4, {%tile_0_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_0_3(%tile_0_1, {%tile_0_5}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_0_3(%tile_0_5, {%tile_0_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_1_CT_factor_FIFO(%tile_1_1, {%tile_1_2, %tile_1_3, %tile_1_4, %tile_1_5}, 1 : i32) : !aie.objectfifo<memref<2048xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_1_0(%tile_1_1, {%tile_1_2}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_1_0(%tile_1_2, {%tile_1_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_1_1(%tile_1_1, {%tile_1_3}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_1_1(%tile_1_3, {%tile_1_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_1_2(%tile_1_1, {%tile_1_4}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_1_2(%tile_1_4, {%tile_1_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_1_3(%tile_1_1, {%tile_1_5}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_1_3(%tile_1_5, {%tile_1_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_2_CT_factor_FIFO(%tile_2_1, {%tile_2_2, %tile_2_3, %tile_2_4, %tile_2_5}, 1 : i32) : !aie.objectfifo<memref<2048xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_2_0(%tile_2_1, {%tile_2_2}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_2_0(%tile_2_2, {%tile_2_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_2_1(%tile_2_1, {%tile_2_3}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_2_1(%tile_2_3, {%tile_2_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_2_2(%tile_2_1, {%tile_2_4}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_2_2(%tile_2_4, {%tile_2_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_2_3(%tile_2_1, {%tile_2_5}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_2_3(%tile_2_5, {%tile_2_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_3_CT_factor_FIFO(%tile_3_1, {%tile_3_2, %tile_3_3, %tile_3_4, %tile_3_5}, 1 : i32) : !aie.objectfifo<memref<2048xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_3_0(%tile_3_1, {%tile_3_2}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_3_0(%tile_3_2, {%tile_3_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_3_1(%tile_3_1, {%tile_3_3}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_3_1(%tile_3_3, {%tile_3_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_3_2(%tile_3_1, {%tile_3_4}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_3_2(%tile_3_4, {%tile_3_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Mem_CT_FIFO_3_3(%tile_3_1, {%tile_3_5}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_CT_Mem_FIFO_3_3(%tile_3_5, {%tile_3_1}, 1 : i32) : !aie.objectfifo<memref<4096xi32>>
    aie.objectfifo @of_Shim_Mem_FIFO_0(%tile_0_0, {%tile_0_1}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_factor_FIFO_0(%tile_0_0, {%tile_0_1}, 1 : i32) : !aie.objectfifo<memref<8192xi32>>
    aie.objectfifo @of_Mem_Shim_0_FIFO(%tile_0_1, {%tile_0_0}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_FIFO_1(%tile_1_0, {%tile_1_1}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_factor_FIFO_1(%tile_1_0, {%tile_1_1}, 1 : i32) : !aie.objectfifo<memref<8192xi32>>
    aie.objectfifo @of_Mem_Shim_1_FIFO(%tile_1_1, {%tile_1_0}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_FIFO_2(%tile_2_0, {%tile_2_1}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_factor_FIFO_2(%tile_2_0, {%tile_2_1}, 1 : i32) : !aie.objectfifo<memref<8192xi32>>
    aie.objectfifo @of_Mem_Shim_2_FIFO(%tile_2_1, {%tile_2_0}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_FIFO_3(%tile_3_0, {%tile_3_1}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_Shim_Mem_factor_FIFO_3(%tile_3_0, {%tile_3_1}, 1 : i32) : !aie.objectfifo<memref<8192xi32>>
    aie.objectfifo @of_Mem_Shim_3_FIFO(%tile_3_1, {%tile_3_0}, 1 : i32) : !aie.objectfifo<memref<16384xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_0_0(%tile_0_2, {%tile_0_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_0_1(%tile_0_3, {%tile_0_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_0_2(%tile_0_4, {%tile_0_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_0_3(%tile_0_5, {%tile_0_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_1_0(%tile_1_2, {%tile_1_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_1_1(%tile_1_3, {%tile_1_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_1_2(%tile_1_4, {%tile_1_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_1_3(%tile_1_5, {%tile_1_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_2_0(%tile_2_2, {%tile_2_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_2_1(%tile_2_3, {%tile_2_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_2_2(%tile_2_4, {%tile_2_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_2_3(%tile_2_5, {%tile_2_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_3_0(%tile_3_2, {%tile_3_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_3_1(%tile_3_3, {%tile_3_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_3_2(%tile_3_4, {%tile_3_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_up_down_flag_FIFO_3_3(%tile_3_5, {%tile_3_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_0_0(%tile_0_2, {%tile_1_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_0_1(%tile_0_3, {%tile_1_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_0_2(%tile_0_4, {%tile_1_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_0_3(%tile_0_5, {%tile_1_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_1_0(%tile_1_2, {%tile_0_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_1_1(%tile_1_3, {%tile_0_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_1_2(%tile_1_4, {%tile_0_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_1_3(%tile_1_5, {%tile_0_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_2_0(%tile_2_2, {%tile_3_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_2_1(%tile_2_3, {%tile_3_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_2_2(%tile_2_4, {%tile_3_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_2_3(%tile_2_5, {%tile_3_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_3_0(%tile_3_2, {%tile_2_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_3_1(%tile_3_3, {%tile_2_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_3_2(%tile_3_4, {%tile_2_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_right_left_flag_FIFO_3_3(%tile_3_5, {%tile_2_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_0_1(%tile_0_3, {%tile_0_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_0_2(%tile_0_4, {%tile_0_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_1_1(%tile_1_3, {%tile_1_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_1_2(%tile_1_4, {%tile_1_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_2_1(%tile_2_3, {%tile_2_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_2_2(%tile_2_4, {%tile_2_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_3_1(%tile_3_3, {%tile_3_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_FIFO_3_2(%tile_3_4, {%tile_3_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_1_0(%tile_1_2, {%tile_2_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_1_1(%tile_1_3, {%tile_2_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_1_2(%tile_1_4, {%tile_2_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_1_3(%tile_1_5, {%tile_2_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_2_0(%tile_2_2, {%tile_1_2}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_2_1(%tile_2_3, {%tile_1_3}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_2_2(%tile_2_4, {%tile_1_4}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    aie.objectfifo @of_swap_2_FIFO_2_3(%tile_2_5, {%tile_1_5}, 1 : i32) : !aie.objectfifo<memref<1xi32>>
    %buffer_0_2 = aie.buffer(%tile_0_2) : memref<16xi32> 
    %buffer_0_3 = aie.buffer(%tile_0_3) : memref<16xi32> 
    %buffer_0_4 = aie.buffer(%tile_0_4) : memref<16xi32> 
    %buffer_0_5 = aie.buffer(%tile_0_5) : memref<16xi32> 
    %buffer_1_2 = aie.buffer(%tile_1_2) : memref<16xi32> 
    %buffer_1_3 = aie.buffer(%tile_1_3) : memref<16xi32> 
    %buffer_1_4 = aie.buffer(%tile_1_4) : memref<16xi32> 
    %buffer_1_5 = aie.buffer(%tile_1_5) : memref<16xi32> 
    %buffer_2_2 = aie.buffer(%tile_2_2) : memref<16xi32> 
    %buffer_2_3 = aie.buffer(%tile_2_3) : memref<16xi32> 
    %buffer_2_4 = aie.buffer(%tile_2_4) : memref<16xi32> 
    %buffer_2_5 = aie.buffer(%tile_2_5) : memref<16xi32> 
    %buffer_3_2 = aie.buffer(%tile_3_2) : memref<16xi32> 
    %buffer_3_3 = aie.buffer(%tile_3_3) : memref<16xi32> 
    %buffer_3_4 = aie.buffer(%tile_3_4) : memref<16xi32> 
    %buffer_3_5 = aie.buffer(%tile_3_5) : memref<16xi32> 
    %buffer_0_2_0 = aie.buffer(%tile_0_2) : memref<4096xi32> 
    %buffer_0_3_1 = aie.buffer(%tile_0_3) : memref<4096xi32> 
    %buffer_0_4_2 = aie.buffer(%tile_0_4) : memref<4096xi32> 
    %buffer_0_5_3 = aie.buffer(%tile_0_5) : memref<4096xi32> 
    %buffer_1_2_4 = aie.buffer(%tile_1_2) : memref<4096xi32> 
    %buffer_1_3_5 = aie.buffer(%tile_1_3) : memref<4096xi32> 
    %buffer_1_4_6 = aie.buffer(%tile_1_4) : memref<4096xi32> 
    %buffer_1_5_7 = aie.buffer(%tile_1_5) : memref<4096xi32> 
    %buffer_2_2_8 = aie.buffer(%tile_2_2) : memref<4096xi32> 
    %buffer_2_3_9 = aie.buffer(%tile_2_3) : memref<4096xi32> 
    %buffer_2_4_10 = aie.buffer(%tile_2_4) : memref<4096xi32> 
    %buffer_2_5_11 = aie.buffer(%tile_2_5) : memref<4096xi32> 
    %buffer_3_2_12 = aie.buffer(%tile_3_2) : memref<4096xi32> 
    %buffer_3_3_13 = aie.buffer(%tile_3_3) : memref<4096xi32> 
    %buffer_3_4_14 = aie.buffer(%tile_3_4) : memref<4096xi32> 
    %buffer_3_5_15 = aie.buffer(%tile_3_5) : memref<4096xi32> 
    aie.objectfifo.link [@of_Shim_Mem_FIFO_0] -> [@of_Mem_CT_FIFO_0_0, @of_Mem_CT_FIFO_0_1, @of_Mem_CT_FIFO_0_2, @of_Mem_CT_FIFO_0_3]([] [0, 4096, 8192, 12288])
    aie.objectfifo.link [@of_CT_Mem_FIFO_0_0, @of_CT_Mem_FIFO_0_1, @of_CT_Mem_FIFO_0_2, @of_CT_Mem_FIFO_0_3] -> [@of_Mem_Shim_0_FIFO]([0, 4096, 8192, 12288] [])
    aie.objectfifo.link [@of_Shim_Mem_factor_FIFO_0] -> [@of_Mem_0_CT_factor_FIFO]([] [0, 2048, 4096, 6144])
    aie.objectfifo.link [@of_Shim_Mem_FIFO_1] -> [@of_Mem_CT_FIFO_1_0, @of_Mem_CT_FIFO_1_1, @of_Mem_CT_FIFO_1_2, @of_Mem_CT_FIFO_1_3]([] [0, 4096, 8192, 12288])
    aie.objectfifo.link [@of_CT_Mem_FIFO_1_0, @of_CT_Mem_FIFO_1_1, @of_CT_Mem_FIFO_1_2, @of_CT_Mem_FIFO_1_3] -> [@of_Mem_Shim_1_FIFO]([0, 4096, 8192, 12288] [])
    aie.objectfifo.link [@of_Shim_Mem_factor_FIFO_1] -> [@of_Mem_1_CT_factor_FIFO]([] [0, 2048, 4096, 6144])
    aie.objectfifo.link [@of_Shim_Mem_FIFO_2] -> [@of_Mem_CT_FIFO_2_0, @of_Mem_CT_FIFO_2_1, @of_Mem_CT_FIFO_2_2, @of_Mem_CT_FIFO_2_3]([] [0, 4096, 8192, 12288])
    aie.objectfifo.link [@of_CT_Mem_FIFO_2_0, @of_CT_Mem_FIFO_2_1, @of_CT_Mem_FIFO_2_2, @of_CT_Mem_FIFO_2_3] -> [@of_Mem_Shim_2_FIFO]([0, 4096, 8192, 12288] [])
    aie.objectfifo.link [@of_Shim_Mem_factor_FIFO_2] -> [@of_Mem_2_CT_factor_FIFO]([] [0, 2048, 4096, 6144])
    aie.objectfifo.link [@of_Shim_Mem_FIFO_3] -> [@of_Mem_CT_FIFO_3_0, @of_Mem_CT_FIFO_3_1, @of_Mem_CT_FIFO_3_2, @of_Mem_CT_FIFO_3_3]([] [0, 4096, 8192, 12288])
    aie.objectfifo.link [@of_CT_Mem_FIFO_3_0, @of_CT_Mem_FIFO_3_1, @of_CT_Mem_FIFO_3_2, @of_CT_Mem_FIFO_3_3] -> [@of_Mem_Shim_3_FIFO]([0, 4096, 8192, 12288] [])
    aie.objectfifo.link [@of_Shim_Mem_factor_FIFO_3] -> [@of_Mem_3_CT_factor_FIFO]([] [0, 2048, 4096, 6144])
    %core_0_2 = aie.core(%tile_0_2) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_0_0(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_0_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_0_2_0, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_0_0(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_2_0, %buffer_0_2_0, %buffer_0_2, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_2_0, %buffer_0_3_1, %buffer_0_2_0, %buffer_0_3_1, %buffer_0_2, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_0(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_1(Consume, 1)
        %8 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %c0_i32_79 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_80 = arith.constant 16 : i32
        %c12_i32_81 = arith.constant 12 : i32
        %c128_i32_82 = arith.constant 128 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %c17_i32_84 = arith.constant 17 : i32
        %c262140_i32_85 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_2_0, %buffer_0_3_1, %buffer_0_2_0, %buffer_0_3_1, %buffer_0_2, %3, %c1_i32_78, %c0_i32_79, %c14_i32, %c16_i32_80, %c12_i32_81, %c128_i32_82, %c65537_i32_83, %c17_i32_84, %c262140_i32_85) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_0(Produce, 1)
        %10 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_0(Produce, 1)
        %14 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %15 = aie.objectfifo.subview.access %14[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_0(Consume, 1)
        %16 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %17 = aie.objectfifo.subview.access %16[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_0(Produce, 1)
        %18 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_0(Consume, 1)
        %20 = aie.objectfifo.acquire @of_CT_Mem_FIFO_0_0(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_86 = arith.constant 256 : i32
        func.call @store_func(%buffer_0_2_0, %21, %c256_i32_86) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_0_0(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_0_3 = aie.core(%tile_0_3) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_0_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_0_3_1, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_0_1(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_3_1, %buffer_0_3_1, %buffer_0_3, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_1(Produce, 1)
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_2_0, %buffer_0_3_1, %buffer_0_2_0, %buffer_0_3_1, %buffer_0_3, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_1(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_0(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_0_1(Produce, 1)
        %9 = aie.objectfifo.acquire @of_swap_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32 = arith.constant 2048 : i32
        %c128_i32_78 = arith.constant 128 : i32
        func.call @swap(%buffer_0_3_1, %buffer_0_4_2, %c2048_i32, %c128_i32_78) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %11 = aie.objectfifo.acquire @of_swap_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %12 = aie.objectfifo.subview.access %11[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_2(Consume, 1)
        %13 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %14 = aie.objectfifo.subview.access %13[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_1(Produce, 1)
        %c13 = arith.constant 13 : index
        %15 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_79 = arith.constant 1 : i32
        %16 = arith.muli %15, %c1_i32_79 : i32
        %c65537_i32_80 = arith.constant 65537 : i32
        %17 = arith.remsi %16, %c65537_i32_80 : i32
        %c1_i32_81 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_82 = arith.constant 16 : i32
        %c12_i32_83 = arith.constant 12 : i32
        %c128_i32_84 = arith.constant 128 : i32
        %c65537_i32_85 = arith.constant 65537 : i32
        %c17_i32_86 = arith.constant 17 : i32
        %c262140_i32_87 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_2_0, %buffer_0_3_1, %buffer_0_2_0, %buffer_0_3_1, %buffer_0_3, %3, %17, %c1_i32_81, %c14_i32, %c16_i32_82, %c12_i32_83, %c128_i32_84, %c65537_i32_85, %c17_i32_86, %c262140_i32_87) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_1(Produce, 1)
        %18 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_0(Consume, 1)
        %20 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_1(Produce, 1)
        %22 = aie.objectfifo.acquire @of_swap_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32_88 = arith.constant 2048 : i32
        %c128_i32_89 = arith.constant 128 : i32
        func.call @swap(%buffer_0_3_1, %buffer_0_4_2, %c2048_i32_88, %c128_i32_89) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %24 = aie.objectfifo.acquire @of_swap_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_2(Consume, 1)
        aie.objectfifo.release @of_right_left_flag_FIFO_0_1(Produce, 1)
        %26 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_1(Consume, 1)
        %28 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_1(Produce, 1)
        %30 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_1(Consume, 1)
        %32 = aie.objectfifo.acquire @of_CT_Mem_FIFO_0_1(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %33 = aie.objectfifo.subview.access %32[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_90 = arith.constant 256 : i32
        func.call @store_func(%buffer_0_3_1, %33, %c256_i32_90) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_0_1(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_0_4 = aie.core(%tile_0_4) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_0_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_0_4_2, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_0_2(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_4_2, %buffer_0_4_2, %buffer_0_4, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_2(Produce, 1)
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_4_2, %buffer_0_5_3, %buffer_0_4_2, %buffer_0_5_3, %buffer_0_4, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_2(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_3(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_0_2(Produce, 1)
        %8 = aie.objectfifo.acquire @of_swap_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_78 = arith.constant 0 : i32
        %c128_i32_79 = arith.constant 128 : i32
        func.call @swap(%buffer_0_4_2, %buffer_0_3_1, %c0_i32_78, %c128_i32_79) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %10 = aie.objectfifo.acquire @of_swap_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_2(Produce, 1)
        %c13 = arith.constant 13 : index
        %14 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_80 = arith.constant 1 : i32
        %15 = arith.muli %14, %c1_i32_80 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c0_i32_84 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_4_2, %buffer_0_5_3, %buffer_0_4_2, %buffer_0_5_3, %buffer_0_4, %3, %19, %c0_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_2(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_3(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_2(Produce, 1)
        %24 = aie.objectfifo.acquire @of_swap_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_91 = arith.constant 0 : i32
        %c128_i32_92 = arith.constant 128 : i32
        func.call @swap(%buffer_0_4_2, %buffer_0_3_1, %c0_i32_91, %c128_i32_92) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %26 = aie.objectfifo.acquire @of_swap_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_0_1(Consume, 1)
        aie.objectfifo.release @of_right_left_flag_FIFO_0_2(Produce, 1)
        %28 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_2(Consume, 1)
        %30 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_2(Produce, 1)
        %32 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %33 = aie.objectfifo.subview.access %32[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_2(Consume, 1)
        %34 = aie.objectfifo.acquire @of_CT_Mem_FIFO_0_2(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %35 = aie.objectfifo.subview.access %34[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_93 = arith.constant 256 : i32
        func.call @store_func(%buffer_0_4_2, %35, %c256_i32_93) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_0_2(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_0_5 = aie.core(%tile_0_5) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_0_3(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_0_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_0_5_3, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_0_3(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_0_5_3, %buffer_0_5_3, %buffer_0_5, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_4_2, %buffer_0_5_3, %buffer_0_4_2, %buffer_0_5_3, %buffer_0_5, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_3(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_2(Consume, 1)
        %9 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13 = arith.constant 13 : index
        %11 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %12 = arith.muli %11, %c1_i32_78 : i32
        %c65537_i32_79 = arith.constant 65537 : i32
        %13 = arith.remsi %12, %c65537_i32_79 : i32
        %c13_80 = arith.constant 13 : index
        %14 = memref.load %3[%c13_80] : memref<2048xi32>
        %15 = arith.muli %13, %14 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c1_i32_84 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_4_2, %buffer_0_5_3, %buffer_0_4_2, %buffer_0_5_3, %buffer_0_5, %3, %19, %c1_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_0_3(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_0_2(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_3(Produce, 1)
        %24 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_3(Consume, 1)
        %26 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_3(Produce, 1)
        %28 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_1_3(Consume, 1)
        %30 = aie.objectfifo.acquire @of_CT_Mem_FIFO_0_3(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_91 = arith.constant 256 : i32
        func.call @store_func(%buffer_0_5_3, %31, %c256_i32_91) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_0_3(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_1_2 = aie.core(%tile_1_2) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_1_0(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_1_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_1_2_4, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_1_0(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_2_4, %buffer_1_2_4, %buffer_1_2, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_2_4, %buffer_1_3_5, %buffer_1_2_4, %buffer_1_3_5, %buffer_1_2, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_0(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_1(Consume, 1)
        %8 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %c0_i32_79 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_80 = arith.constant 16 : i32
        %c12_i32_81 = arith.constant 12 : i32
        %c128_i32_82 = arith.constant 128 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %c17_i32_84 = arith.constant 17 : i32
        %c262140_i32_85 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_2_4, %buffer_1_3_5, %buffer_1_2_4, %buffer_1_3_5, %buffer_1_2, %3, %c1_i32_78, %c0_i32_79, %c14_i32, %c16_i32_80, %c12_i32_81, %c128_i32_82, %c65537_i32_83, %c17_i32_84, %c262140_i32_85) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_0(Produce, 1)
        %10 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %14 = aie.objectfifo.acquire @of_swap_2_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %15 = aie.objectfifo.subview.access %14[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_86 = arith.constant 1 : i32
        %c0_i32_87 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_88 = arith.constant 16 : i32
        %c12_i32_89 = arith.constant 12 : i32
        %c256_i32_90 = arith.constant 256 : i32
        %c65537_i32_91 = arith.constant 65537 : i32
        %c17_i32_92 = arith.constant 17 : i32
        %c262140_i32_93 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_2_0, %buffer_1_2_4, %buffer_0_2_0, %buffer_1_2_4, %buffer_1_2, %3, %c1_i32_86, %c0_i32_87, %c15_i32, %c16_i32_88, %c12_i32_89, %c256_i32_90, %c65537_i32_91, %c17_i32_92, %c262140_i32_93) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_0(Produce, 1)
        %16 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %17 = aie.objectfifo.subview.access %16[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_0(Consume, 1)
        %18 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_0(Produce, 1)
        %20 = aie.objectfifo.acquire @of_swap_2_FIFO_2_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_0(Consume, 1)
        %22 = aie.objectfifo.acquire @of_swap_2_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_0(Produce, 1)
        %c1_i32_94 = arith.constant 1 : i32
        %c0_i32_95 = arith.constant 0 : i32
        %c16_i32_96 = arith.constant 16 : i32
        %c16_i32_97 = arith.constant 16 : i32
        %c12_i32_98 = arith.constant 12 : i32
        %c256_i32_99 = arith.constant 256 : i32
        %c65537_i32_100 = arith.constant 65537 : i32
        %c17_i32_101 = arith.constant 17 : i32
        %c262140_i32_102 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_2_0, %buffer_1_2_4, %buffer_0_2_0, %buffer_1_2_4, %buffer_1_2, %3, %c1_i32_94, %c0_i32_95, %c16_i32_96, %c16_i32_97, %c12_i32_98, %c256_i32_99, %c65537_i32_100, %c17_i32_101, %c262140_i32_102) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_0(Produce, 1)
        %24 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_0(Consume, 1)
        %26 = aie.objectfifo.acquire @of_CT_Mem_FIFO_1_0(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_103 = arith.constant 256 : i32
        func.call @store_func(%buffer_1_2_4, %27, %c256_i32_103) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_1_0(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_1_3 = aie.core(%tile_1_3) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_1_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_1_3_5, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_1_1(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_3_5, %buffer_1_3_5, %buffer_1_3, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_1(Produce, 1)
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_2_4, %buffer_1_3_5, %buffer_1_2_4, %buffer_1_3_5, %buffer_1_3, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_1(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_0(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_1_1(Produce, 1)
        %9 = aie.objectfifo.acquire @of_swap_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32 = arith.constant 2048 : i32
        %c128_i32_78 = arith.constant 128 : i32
        func.call @swap(%buffer_1_3_5, %buffer_1_4_6, %c2048_i32, %c128_i32_78) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %11 = aie.objectfifo.acquire @of_swap_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %12 = aie.objectfifo.subview.access %11[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_2(Consume, 1)
        %13 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %14 = aie.objectfifo.subview.access %13[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_1(Produce, 1)
        %c13 = arith.constant 13 : index
        %15 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_79 = arith.constant 1 : i32
        %16 = arith.muli %15, %c1_i32_79 : i32
        %c65537_i32_80 = arith.constant 65537 : i32
        %17 = arith.remsi %16, %c65537_i32_80 : i32
        %c1_i32_81 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_82 = arith.constant 16 : i32
        %c12_i32_83 = arith.constant 12 : i32
        %c128_i32_84 = arith.constant 128 : i32
        %c65537_i32_85 = arith.constant 65537 : i32
        %c17_i32_86 = arith.constant 17 : i32
        %c262140_i32_87 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_2_4, %buffer_1_3_5, %buffer_1_2_4, %buffer_1_3_5, %buffer_1_3, %3, %17, %c1_i32_81, %c14_i32, %c16_i32_82, %c12_i32_83, %c128_i32_84, %c65537_i32_85, %c17_i32_86, %c262140_i32_87) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_1(Produce, 1)
        %18 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_0(Consume, 1)
        %20 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_1(Produce, 1)
        %22 = aie.objectfifo.acquire @of_swap_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32_88 = arith.constant 2048 : i32
        %c128_i32_89 = arith.constant 128 : i32
        func.call @swap(%buffer_1_3_5, %buffer_1_4_6, %c2048_i32_88, %c128_i32_89) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %24 = aie.objectfifo.acquire @of_swap_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_2(Consume, 1)
        %26 = aie.objectfifo.acquire @of_swap_2_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13_90 = arith.constant 13 : index
        %28 = memref.load %3[%c13_90] : memref<2048xi32>
        %c1_i32_91 = arith.constant 1 : i32
        %29 = arith.muli %28, %c1_i32_91 : i32
        %c65537_i32_92 = arith.constant 65537 : i32
        %30 = arith.remsi %29, %c65537_i32_92 : i32
        %c0_i32 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_93 = arith.constant 16 : i32
        %c12_i32_94 = arith.constant 12 : i32
        %c256_i32_95 = arith.constant 256 : i32
        %c65537_i32_96 = arith.constant 65537 : i32
        %c17_i32_97 = arith.constant 17 : i32
        %c262140_i32_98 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_3_1, %buffer_1_3_5, %buffer_0_3_1, %buffer_1_3_5, %buffer_1_3, %3, %30, %c0_i32, %c15_i32, %c16_i32_93, %c12_i32_94, %c256_i32_95, %c65537_i32_96, %c17_i32_97, %c262140_i32_98) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_1(Produce, 1)
        %31 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %32 = aie.objectfifo.subview.access %31[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_1(Consume, 1)
        %33 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %34 = aie.objectfifo.subview.access %33[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_1(Produce, 1)
        %35 = aie.objectfifo.acquire @of_swap_2_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %36 = aie.objectfifo.subview.access %35[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_1(Consume, 1)
        %37 = aie.objectfifo.acquire @of_swap_2_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %38 = aie.objectfifo.subview.access %37[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_1(Produce, 1)
        %c12 = arith.constant 12 : index
        %39 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_99 = arith.constant 1 : i32
        %40 = arith.muli %39, %c1_i32_99 : i32
        %c65537_i32_100 = arith.constant 65537 : i32
        %41 = arith.remsi %40, %c65537_i32_100 : i32
        %c0_i32_101 = arith.constant 0 : i32
        %c16_i32_102 = arith.constant 16 : i32
        %c16_i32_103 = arith.constant 16 : i32
        %c12_i32_104 = arith.constant 12 : i32
        %c256_i32_105 = arith.constant 256 : i32
        %c65537_i32_106 = arith.constant 65537 : i32
        %c17_i32_107 = arith.constant 17 : i32
        %c262140_i32_108 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_3_1, %buffer_1_3_5, %buffer_0_3_1, %buffer_1_3_5, %buffer_1_3, %3, %41, %c0_i32_101, %c16_i32_102, %c16_i32_103, %c12_i32_104, %c256_i32_105, %c65537_i32_106, %c17_i32_107, %c262140_i32_108) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_1(Produce, 1)
        %42 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %43 = aie.objectfifo.subview.access %42[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_1(Consume, 1)
        %44 = aie.objectfifo.acquire @of_CT_Mem_FIFO_1_1(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %45 = aie.objectfifo.subview.access %44[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_109 = arith.constant 256 : i32
        func.call @store_func(%buffer_1_3_5, %45, %c256_i32_109) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_1_1(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_1_4 = aie.core(%tile_1_4) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_1_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_1_4_6, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_1_2(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_4_6, %buffer_1_4_6, %buffer_1_4, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_2(Produce, 1)
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_4_6, %buffer_1_5_7, %buffer_1_4_6, %buffer_1_5_7, %buffer_1_4, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_2(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_3(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_1_2(Produce, 1)
        %8 = aie.objectfifo.acquire @of_swap_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_78 = arith.constant 0 : i32
        %c128_i32_79 = arith.constant 128 : i32
        func.call @swap(%buffer_1_4_6, %buffer_1_3_5, %c0_i32_78, %c128_i32_79) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %10 = aie.objectfifo.acquire @of_swap_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_2(Produce, 1)
        %c13 = arith.constant 13 : index
        %14 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_80 = arith.constant 1 : i32
        %15 = arith.muli %14, %c1_i32_80 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c0_i32_84 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_4_6, %buffer_1_5_7, %buffer_1_4_6, %buffer_1_5_7, %buffer_1_4, %3, %19, %c0_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_2(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_3(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_2(Produce, 1)
        %24 = aie.objectfifo.acquire @of_swap_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_91 = arith.constant 0 : i32
        %c128_i32_92 = arith.constant 128 : i32
        func.call @swap(%buffer_1_4_6, %buffer_1_3_5, %c0_i32_91, %c128_i32_92) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %26 = aie.objectfifo.acquire @of_swap_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_1_1(Consume, 1)
        %28 = aie.objectfifo.acquire @of_swap_2_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13_93 = arith.constant 13 : index
        %30 = memref.load %3[%c13_93] : memref<2048xi32>
        %c1_i32_94 = arith.constant 1 : i32
        %31 = arith.muli %30, %c1_i32_94 : i32
        %c65537_i32_95 = arith.constant 65537 : i32
        %32 = arith.remsi %31, %c65537_i32_95 : i32
        %c13_96 = arith.constant 13 : index
        %33 = memref.load %3[%c13_96] : memref<2048xi32>
        %34 = arith.muli %32, %33 : i32
        %c65537_i32_97 = arith.constant 65537 : i32
        %35 = arith.remsi %34, %c65537_i32_97 : i32
        %c0_i32_98 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_99 = arith.constant 16 : i32
        %c12_i32_100 = arith.constant 12 : i32
        %c256_i32_101 = arith.constant 256 : i32
        %c65537_i32_102 = arith.constant 65537 : i32
        %c17_i32_103 = arith.constant 17 : i32
        %c262140_i32_104 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_4_2, %buffer_1_4_6, %buffer_0_4_2, %buffer_1_4_6, %buffer_1_4, %3, %35, %c0_i32_98, %c15_i32, %c16_i32_99, %c12_i32_100, %c256_i32_101, %c65537_i32_102, %c17_i32_103, %c262140_i32_104) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_2(Produce, 1)
        %36 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %37 = aie.objectfifo.subview.access %36[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_2(Consume, 1)
        %38 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %39 = aie.objectfifo.subview.access %38[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_2(Produce, 1)
        %40 = aie.objectfifo.acquire @of_swap_2_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %41 = aie.objectfifo.subview.access %40[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_2(Consume, 1)
        %42 = aie.objectfifo.acquire @of_swap_2_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %43 = aie.objectfifo.subview.access %42[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_2(Produce, 1)
        %c12 = arith.constant 12 : index
        %44 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_105 = arith.constant 1 : i32
        %45 = arith.muli %44, %c1_i32_105 : i32
        %c65537_i32_106 = arith.constant 65537 : i32
        %46 = arith.remsi %45, %c65537_i32_106 : i32
        %c12_107 = arith.constant 12 : index
        %47 = memref.load %3[%c12_107] : memref<2048xi32>
        %48 = arith.muli %46, %47 : i32
        %c65537_i32_108 = arith.constant 65537 : i32
        %49 = arith.remsi %48, %c65537_i32_108 : i32
        %c0_i32_109 = arith.constant 0 : i32
        %c16_i32_110 = arith.constant 16 : i32
        %c16_i32_111 = arith.constant 16 : i32
        %c12_i32_112 = arith.constant 12 : i32
        %c256_i32_113 = arith.constant 256 : i32
        %c65537_i32_114 = arith.constant 65537 : i32
        %c17_i32_115 = arith.constant 17 : i32
        %c262140_i32_116 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_4_2, %buffer_1_4_6, %buffer_0_4_2, %buffer_1_4_6, %buffer_1_4, %3, %49, %c0_i32_109, %c16_i32_110, %c16_i32_111, %c12_i32_112, %c256_i32_113, %c65537_i32_114, %c17_i32_115, %c262140_i32_116) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_2(Produce, 1)
        %50 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %51 = aie.objectfifo.subview.access %50[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_2(Consume, 1)
        %52 = aie.objectfifo.acquire @of_CT_Mem_FIFO_1_2(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %53 = aie.objectfifo.subview.access %52[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_117 = arith.constant 256 : i32
        func.call @store_func(%buffer_1_4_6, %53, %c256_i32_117) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_1_2(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_1_5 = aie.core(%tile_1_5) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_1_3(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_1_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_1_5_7, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_1_3(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_1_5_7, %buffer_1_5_7, %buffer_1_5, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_4_6, %buffer_1_5_7, %buffer_1_4_6, %buffer_1_5_7, %buffer_1_5, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_3(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_2(Consume, 1)
        %9 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13 = arith.constant 13 : index
        %11 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %12 = arith.muli %11, %c1_i32_78 : i32
        %c65537_i32_79 = arith.constant 65537 : i32
        %13 = arith.remsi %12, %c65537_i32_79 : i32
        %c13_80 = arith.constant 13 : index
        %14 = memref.load %3[%c13_80] : memref<2048xi32>
        %15 = arith.muli %13, %14 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c1_i32_84 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_1_4_6, %buffer_1_5_7, %buffer_1_4_6, %buffer_1_5_7, %buffer_1_5, %3, %19, %c1_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_1_3(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_1_2(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %24 = aie.objectfifo.acquire @of_swap_2_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13_91 = arith.constant 13 : index
        %26 = memref.load %3[%c13_91] : memref<2048xi32>
        %c1_i32_92 = arith.constant 1 : i32
        %27 = arith.muli %26, %c1_i32_92 : i32
        %c65537_i32_93 = arith.constant 65537 : i32
        %28 = arith.remsi %27, %c65537_i32_93 : i32
        %c13_94 = arith.constant 13 : index
        %29 = memref.load %3[%c13_94] : memref<2048xi32>
        %30 = arith.muli %28, %29 : i32
        %c65537_i32_95 = arith.constant 65537 : i32
        %31 = arith.remsi %30, %c65537_i32_95 : i32
        %c13_96 = arith.constant 13 : index
        %32 = memref.load %3[%c13_96] : memref<2048xi32>
        %33 = arith.muli %31, %32 : i32
        %c65537_i32_97 = arith.constant 65537 : i32
        %34 = arith.remsi %33, %c65537_i32_97 : i32
        %c0_i32 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_98 = arith.constant 16 : i32
        %c12_i32_99 = arith.constant 12 : i32
        %c256_i32_100 = arith.constant 256 : i32
        %c65537_i32_101 = arith.constant 65537 : i32
        %c17_i32_102 = arith.constant 17 : i32
        %c262140_i32_103 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_5_3, %buffer_1_5_7, %buffer_0_5_3, %buffer_1_5_7, %buffer_1_5, %3, %34, %c0_i32, %c15_i32, %c16_i32_98, %c12_i32_99, %c256_i32_100, %c65537_i32_101, %c17_i32_102, %c262140_i32_103) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_3(Produce, 1)
        %35 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %36 = aie.objectfifo.subview.access %35[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_3(Consume, 1)
        %37 = aie.objectfifo.acquire @of_right_left_flag_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %38 = aie.objectfifo.subview.access %37[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_3(Produce, 1)
        %39 = aie.objectfifo.acquire @of_swap_2_FIFO_2_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %40 = aie.objectfifo.subview.access %39[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_3(Consume, 1)
        %41 = aie.objectfifo.acquire @of_swap_2_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %42 = aie.objectfifo.subview.access %41[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_1_3(Produce, 1)
        %c12 = arith.constant 12 : index
        %43 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_104 = arith.constant 1 : i32
        %44 = arith.muli %43, %c1_i32_104 : i32
        %c65537_i32_105 = arith.constant 65537 : i32
        %45 = arith.remsi %44, %c65537_i32_105 : i32
        %c12_106 = arith.constant 12 : index
        %46 = memref.load %3[%c12_106] : memref<2048xi32>
        %47 = arith.muli %45, %46 : i32
        %c65537_i32_107 = arith.constant 65537 : i32
        %48 = arith.remsi %47, %c65537_i32_107 : i32
        %c12_108 = arith.constant 12 : index
        %49 = memref.load %3[%c12_108] : memref<2048xi32>
        %50 = arith.muli %48, %49 : i32
        %c65537_i32_109 = arith.constant 65537 : i32
        %51 = arith.remsi %50, %c65537_i32_109 : i32
        %c0_i32_110 = arith.constant 0 : i32
        %c16_i32_111 = arith.constant 16 : i32
        %c16_i32_112 = arith.constant 16 : i32
        %c12_i32_113 = arith.constant 12 : i32
        %c256_i32_114 = arith.constant 256 : i32
        %c65537_i32_115 = arith.constant 65537 : i32
        %c17_i32_116 = arith.constant 17 : i32
        %c262140_i32_117 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_0_5_3, %buffer_1_5_7, %buffer_0_5_3, %buffer_1_5_7, %buffer_1_5, %3, %51, %c0_i32_110, %c16_i32_111, %c16_i32_112, %c12_i32_113, %c256_i32_114, %c65537_i32_115, %c17_i32_116, %c262140_i32_117) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_1_3(Produce, 1)
        %52 = aie.objectfifo.acquire @of_right_left_flag_FIFO_0_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %53 = aie.objectfifo.subview.access %52[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_0_3(Consume, 1)
        %54 = aie.objectfifo.acquire @of_CT_Mem_FIFO_1_3(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %55 = aie.objectfifo.subview.access %54[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_118 = arith.constant 256 : i32
        func.call @store_func(%buffer_1_5_7, %55, %c256_i32_118) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_1_3(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_2_2 = aie.core(%tile_2_2) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_2_0(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_2_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_2_2_8, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_2_0(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_2_8, %buffer_2_2_8, %buffer_2_2, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_2_8, %buffer_2_3_9, %buffer_2_2_8, %buffer_2_3_9, %buffer_2_2, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_0(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_1(Consume, 1)
        %8 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %c0_i32_79 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_80 = arith.constant 16 : i32
        %c12_i32_81 = arith.constant 12 : i32
        %c128_i32_82 = arith.constant 128 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %c17_i32_84 = arith.constant 17 : i32
        %c262140_i32_85 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_2_8, %buffer_2_3_9, %buffer_2_2_8, %buffer_2_3_9, %buffer_2_2, %3, %c1_i32_78, %c0_i32_79, %c14_i32, %c16_i32_80, %c12_i32_81, %c128_i32_82, %c65537_i32_83, %c17_i32_84, %c262140_i32_85) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_0(Produce, 1)
        %10 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %14 = aie.objectfifo.acquire @of_swap_2_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %15 = aie.objectfifo.subview.access %14[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_0(Produce, 1)
        %16 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %17 = aie.objectfifo.subview.access %16[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_0(Consume, 1)
        %18 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_0(Produce, 1)
        %20 = aie.objectfifo.acquire @of_swap_2_FIFO_1_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_86 = arith.constant 0 : i32
        %c256_i32_87 = arith.constant 256 : i32
        func.call @swap(%buffer_2_2_8, %buffer_1_2_4, %c0_i32_86, %c256_i32_87) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        aie.objectfifo.release @of_swap_2_FIFO_1_0(Consume, 1)
        %22 = aie.objectfifo.acquire @of_swap_2_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_0(Produce, 1)
        aie.objectfifo.release @of_right_left_flag_FIFO_2_0(Produce, 1)
        %24 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_0(Consume, 1)
        %26 = aie.objectfifo.acquire @of_CT_Mem_FIFO_2_0(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_88 = arith.constant 256 : i32
        func.call @store_func(%buffer_2_2_8, %27, %c256_i32_88) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_2_0(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_2_3 = aie.core(%tile_2_3) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_2_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_2_3_9, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_2_1(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_3_9, %buffer_2_3_9, %buffer_2_3, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_1(Produce, 1)
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_2_8, %buffer_2_3_9, %buffer_2_2_8, %buffer_2_3_9, %buffer_2_3, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_1(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_0(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_2_1(Produce, 1)
        %9 = aie.objectfifo.acquire @of_swap_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32 = arith.constant 2048 : i32
        %c128_i32_78 = arith.constant 128 : i32
        func.call @swap(%buffer_2_3_9, %buffer_2_4_10, %c2048_i32, %c128_i32_78) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %11 = aie.objectfifo.acquire @of_swap_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %12 = aie.objectfifo.subview.access %11[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_2(Consume, 1)
        %13 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %14 = aie.objectfifo.subview.access %13[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_1(Produce, 1)
        %c13 = arith.constant 13 : index
        %15 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_79 = arith.constant 1 : i32
        %16 = arith.muli %15, %c1_i32_79 : i32
        %c65537_i32_80 = arith.constant 65537 : i32
        %17 = arith.remsi %16, %c65537_i32_80 : i32
        %c1_i32_81 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_82 = arith.constant 16 : i32
        %c12_i32_83 = arith.constant 12 : i32
        %c128_i32_84 = arith.constant 128 : i32
        %c65537_i32_85 = arith.constant 65537 : i32
        %c17_i32_86 = arith.constant 17 : i32
        %c262140_i32_87 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_2_8, %buffer_2_3_9, %buffer_2_2_8, %buffer_2_3_9, %buffer_2_3, %3, %17, %c1_i32_81, %c14_i32, %c16_i32_82, %c12_i32_83, %c128_i32_84, %c65537_i32_85, %c17_i32_86, %c262140_i32_87) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_1(Produce, 1)
        %18 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_0(Consume, 1)
        %20 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_1(Produce, 1)
        %22 = aie.objectfifo.acquire @of_swap_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32_88 = arith.constant 2048 : i32
        %c128_i32_89 = arith.constant 128 : i32
        func.call @swap(%buffer_2_3_9, %buffer_2_4_10, %c2048_i32_88, %c128_i32_89) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %24 = aie.objectfifo.acquire @of_swap_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_2(Consume, 1)
        %26 = aie.objectfifo.acquire @of_swap_2_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_1(Produce, 1)
        %28 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_1(Consume, 1)
        %30 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_1(Produce, 1)
        %32 = aie.objectfifo.acquire @of_swap_2_FIFO_1_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %33 = aie.objectfifo.subview.access %32[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32 = arith.constant 0 : i32
        %c256_i32_90 = arith.constant 256 : i32
        func.call @swap(%buffer_2_3_9, %buffer_1_3_5, %c0_i32, %c256_i32_90) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        aie.objectfifo.release @of_swap_2_FIFO_1_1(Consume, 1)
        %34 = aie.objectfifo.acquire @of_swap_2_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %35 = aie.objectfifo.subview.access %34[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_1(Produce, 1)
        aie.objectfifo.release @of_right_left_flag_FIFO_2_1(Produce, 1)
        %36 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %37 = aie.objectfifo.subview.access %36[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_1(Consume, 1)
        %38 = aie.objectfifo.acquire @of_CT_Mem_FIFO_2_1(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %39 = aie.objectfifo.subview.access %38[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_91 = arith.constant 256 : i32
        func.call @store_func(%buffer_2_3_9, %39, %c256_i32_91) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_2_1(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_2_4 = aie.core(%tile_2_4) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_2_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_2_4_10, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_2_2(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_4_10, %buffer_2_4_10, %buffer_2_4, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_2(Produce, 1)
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_4_10, %buffer_2_5_11, %buffer_2_4_10, %buffer_2_5_11, %buffer_2_4, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_2(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_3(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_2_2(Produce, 1)
        %8 = aie.objectfifo.acquire @of_swap_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_78 = arith.constant 0 : i32
        %c128_i32_79 = arith.constant 128 : i32
        func.call @swap(%buffer_2_4_10, %buffer_2_3_9, %c0_i32_78, %c128_i32_79) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %10 = aie.objectfifo.acquire @of_swap_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_2(Produce, 1)
        %c13 = arith.constant 13 : index
        %14 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_80 = arith.constant 1 : i32
        %15 = arith.muli %14, %c1_i32_80 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c0_i32_84 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_4_10, %buffer_2_5_11, %buffer_2_4_10, %buffer_2_5_11, %buffer_2_4, %3, %19, %c0_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_2(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_3(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_2(Produce, 1)
        %24 = aie.objectfifo.acquire @of_swap_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_91 = arith.constant 0 : i32
        %c128_i32_92 = arith.constant 128 : i32
        func.call @swap(%buffer_2_4_10, %buffer_2_3_9, %c0_i32_91, %c128_i32_92) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %26 = aie.objectfifo.acquire @of_swap_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_2_1(Consume, 1)
        %28 = aie.objectfifo.acquire @of_swap_2_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_2(Produce, 1)
        %30 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_2(Consume, 1)
        %32 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %33 = aie.objectfifo.subview.access %32[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_2(Produce, 1)
        %34 = aie.objectfifo.acquire @of_swap_2_FIFO_1_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %35 = aie.objectfifo.subview.access %34[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_93 = arith.constant 0 : i32
        %c256_i32_94 = arith.constant 256 : i32
        func.call @swap(%buffer_2_4_10, %buffer_1_4_6, %c0_i32_93, %c256_i32_94) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        aie.objectfifo.release @of_swap_2_FIFO_1_2(Consume, 1)
        %36 = aie.objectfifo.acquire @of_swap_2_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %37 = aie.objectfifo.subview.access %36[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_2(Produce, 1)
        aie.objectfifo.release @of_right_left_flag_FIFO_2_2(Produce, 1)
        %38 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %39 = aie.objectfifo.subview.access %38[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_2(Consume, 1)
        %40 = aie.objectfifo.acquire @of_CT_Mem_FIFO_2_2(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %41 = aie.objectfifo.subview.access %40[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_95 = arith.constant 256 : i32
        func.call @store_func(%buffer_2_4_10, %41, %c256_i32_95) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_2_2(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_2_5 = aie.core(%tile_2_5) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_2_3(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_2_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_2_5_11, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_2_3(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_2_5_11, %buffer_2_5_11, %buffer_2_5, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_4_10, %buffer_2_5_11, %buffer_2_4_10, %buffer_2_5_11, %buffer_2_5, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_3(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_2(Consume, 1)
        %9 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13 = arith.constant 13 : index
        %11 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %12 = arith.muli %11, %c1_i32_78 : i32
        %c65537_i32_79 = arith.constant 65537 : i32
        %13 = arith.remsi %12, %c65537_i32_79 : i32
        %c13_80 = arith.constant 13 : index
        %14 = memref.load %3[%c13_80] : memref<2048xi32>
        %15 = arith.muli %13, %14 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c1_i32_84 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_4_10, %buffer_2_5_11, %buffer_2_4_10, %buffer_2_5_11, %buffer_2_5, %3, %19, %c1_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_2_3(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_2_2(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %24 = aie.objectfifo.acquire @of_swap_2_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_3(Produce, 1)
        %26 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_3(Consume, 1)
        %28 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %29 = aie.objectfifo.subview.access %28[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_3(Produce, 1)
        %30 = aie.objectfifo.acquire @of_swap_2_FIFO_1_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32 = arith.constant 0 : i32
        %c256_i32_91 = arith.constant 256 : i32
        func.call @swap(%buffer_2_5_11, %buffer_1_5_7, %c0_i32, %c256_i32_91) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        aie.objectfifo.release @of_swap_2_FIFO_1_3(Consume, 1)
        %32 = aie.objectfifo.acquire @of_swap_2_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %33 = aie.objectfifo.subview.access %32[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_2_FIFO_2_3(Produce, 1)
        aie.objectfifo.release @of_right_left_flag_FIFO_2_3(Produce, 1)
        %34 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %35 = aie.objectfifo.subview.access %34[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_3_3(Consume, 1)
        %36 = aie.objectfifo.acquire @of_CT_Mem_FIFO_2_3(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %37 = aie.objectfifo.subview.access %36[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_92 = arith.constant 256 : i32
        func.call @store_func(%buffer_2_5_11, %37, %c256_i32_92) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_2_3(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_3_2 = aie.core(%tile_3_2) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_3_0(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_3_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_3_2_12, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_3_0(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_2_12, %buffer_3_2_12, %buffer_3_2, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_2_12, %buffer_3_3_13, %buffer_3_2_12, %buffer_3_3_13, %buffer_3_2, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_0(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_1(Consume, 1)
        %8 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %c0_i32_79 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_80 = arith.constant 16 : i32
        %c12_i32_81 = arith.constant 12 : i32
        %c128_i32_82 = arith.constant 128 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %c17_i32_84 = arith.constant 17 : i32
        %c262140_i32_85 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_2_12, %buffer_3_3_13, %buffer_3_2_12, %buffer_3_3_13, %buffer_3_2, %3, %c1_i32_78, %c0_i32_79, %c14_i32, %c16_i32_80, %c12_i32_81, %c128_i32_82, %c65537_i32_83, %c17_i32_84, %c262140_i32_85) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_0(Produce, 1)
        %10 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c1_i32_86 = arith.constant 1 : i32
        %c0_i32_87 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_88 = arith.constant 16 : i32
        %c12_i32_89 = arith.constant 12 : i32
        %c256_i32_90 = arith.constant 256 : i32
        %c65537_i32_91 = arith.constant 65537 : i32
        %c17_i32_92 = arith.constant 17 : i32
        %c262140_i32_93 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_2_8, %buffer_3_2_12, %buffer_2_2_8, %buffer_3_2_12, %buffer_3_2, %3, %c1_i32_86, %c0_i32_87, %c15_i32, %c16_i32_88, %c12_i32_89, %c256_i32_90, %c65537_i32_91, %c17_i32_92, %c262140_i32_93) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_0(Produce, 1)
        %14 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %15 = aie.objectfifo.subview.access %14[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_0(Consume, 1)
        %16 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_0(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %17 = aie.objectfifo.subview.access %16[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c12 = arith.constant 12 : index
        %18 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_94 = arith.constant 1 : i32
        %19 = arith.muli %18, %c1_i32_94 : i32
        %c65537_i32_95 = arith.constant 65537 : i32
        %20 = arith.remsi %19, %c65537_i32_95 : i32
        %c12_96 = arith.constant 12 : index
        %21 = memref.load %3[%c12_96] : memref<2048xi32>
        %22 = arith.muli %20, %21 : i32
        %c65537_i32_97 = arith.constant 65537 : i32
        %23 = arith.remsi %22, %c65537_i32_97 : i32
        %c12_98 = arith.constant 12 : index
        %24 = memref.load %3[%c12_98] : memref<2048xi32>
        %25 = arith.muli %23, %24 : i32
        %c65537_i32_99 = arith.constant 65537 : i32
        %26 = arith.remsi %25, %c65537_i32_99 : i32
        %c12_100 = arith.constant 12 : index
        %27 = memref.load %3[%c12_100] : memref<2048xi32>
        %28 = arith.muli %26, %27 : i32
        %c65537_i32_101 = arith.constant 65537 : i32
        %29 = arith.remsi %28, %c65537_i32_101 : i32
        %c0_i32_102 = arith.constant 0 : i32
        %c16_i32_103 = arith.constant 16 : i32
        %c16_i32_104 = arith.constant 16 : i32
        %c12_i32_105 = arith.constant 12 : i32
        %c256_i32_106 = arith.constant 256 : i32
        %c65537_i32_107 = arith.constant 65537 : i32
        %c17_i32_108 = arith.constant 17 : i32
        %c262140_i32_109 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_2_8, %buffer_3_2_12, %buffer_2_2_8, %buffer_3_2_12, %buffer_3_2, %3, %29, %c0_i32_102, %c16_i32_103, %c16_i32_104, %c12_i32_105, %c256_i32_106, %c65537_i32_107, %c17_i32_108, %c262140_i32_109) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_0(Produce, 1)
        %30 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %31 = aie.objectfifo.subview.access %30[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_0(Consume, 1)
        %32 = aie.objectfifo.acquire @of_CT_Mem_FIFO_3_0(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %33 = aie.objectfifo.subview.access %32[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_110 = arith.constant 256 : i32
        func.call @store_func(%buffer_3_2_12, %33, %c256_i32_110) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_3_0(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_3_3 = aie.core(%tile_3_3) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_3_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_3_3_13, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_3_1(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_3_13, %buffer_3_3_13, %buffer_3_3, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_1(Produce, 1)
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_2_12, %buffer_3_3_13, %buffer_3_2_12, %buffer_3_3_13, %buffer_3_3, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_1(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_0(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_3_1(Produce, 1)
        %9 = aie.objectfifo.acquire @of_swap_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32 = arith.constant 2048 : i32
        %c128_i32_78 = arith.constant 128 : i32
        func.call @swap(%buffer_3_3_13, %buffer_3_4_14, %c2048_i32, %c128_i32_78) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %11 = aie.objectfifo.acquire @of_swap_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %12 = aie.objectfifo.subview.access %11[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_2(Consume, 1)
        %13 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %14 = aie.objectfifo.subview.access %13[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_1(Produce, 1)
        %c13 = arith.constant 13 : index
        %15 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_79 = arith.constant 1 : i32
        %16 = arith.muli %15, %c1_i32_79 : i32
        %c65537_i32_80 = arith.constant 65537 : i32
        %17 = arith.remsi %16, %c65537_i32_80 : i32
        %c1_i32_81 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_82 = arith.constant 16 : i32
        %c12_i32_83 = arith.constant 12 : i32
        %c128_i32_84 = arith.constant 128 : i32
        %c65537_i32_85 = arith.constant 65537 : i32
        %c17_i32_86 = arith.constant 17 : i32
        %c262140_i32_87 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_2_12, %buffer_3_3_13, %buffer_3_2_12, %buffer_3_3_13, %buffer_3_3, %3, %17, %c1_i32_81, %c14_i32, %c16_i32_82, %c12_i32_83, %c128_i32_84, %c65537_i32_85, %c17_i32_86, %c262140_i32_87) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_1(Produce, 1)
        %18 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_0(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %19 = aie.objectfifo.subview.access %18[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_0(Consume, 1)
        %20 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_1(Produce, 1)
        %22 = aie.objectfifo.acquire @of_swap_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c2048_i32_88 = arith.constant 2048 : i32
        %c128_i32_89 = arith.constant 128 : i32
        func.call @swap(%buffer_3_3_13, %buffer_3_4_14, %c2048_i32_88, %c128_i32_89) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %24 = aie.objectfifo.acquire @of_swap_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_2(Consume, 1)
        %c13_90 = arith.constant 13 : index
        %26 = memref.load %3[%c13_90] : memref<2048xi32>
        %c1_i32_91 = arith.constant 1 : i32
        %27 = arith.muli %26, %c1_i32_91 : i32
        %c65537_i32_92 = arith.constant 65537 : i32
        %28 = arith.remsi %27, %c65537_i32_92 : i32
        %c0_i32 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_93 = arith.constant 16 : i32
        %c12_i32_94 = arith.constant 12 : i32
        %c256_i32_95 = arith.constant 256 : i32
        %c65537_i32_96 = arith.constant 65537 : i32
        %c17_i32_97 = arith.constant 17 : i32
        %c262140_i32_98 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_3_9, %buffer_3_3_13, %buffer_2_3_9, %buffer_3_3_13, %buffer_3_3, %3, %28, %c0_i32, %c15_i32, %c16_i32_93, %c12_i32_94, %c256_i32_95, %c65537_i32_96, %c17_i32_97, %c262140_i32_98) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_1(Produce, 1)
        %29 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %30 = aie.objectfifo.subview.access %29[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_1(Consume, 1)
        %31 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_1(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %32 = aie.objectfifo.subview.access %31[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c12 = arith.constant 12 : index
        %33 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_99 = arith.constant 1 : i32
        %34 = arith.muli %33, %c1_i32_99 : i32
        %c65537_i32_100 = arith.constant 65537 : i32
        %35 = arith.remsi %34, %c65537_i32_100 : i32
        %c12_101 = arith.constant 12 : index
        %36 = memref.load %3[%c12_101] : memref<2048xi32>
        %37 = arith.muli %35, %36 : i32
        %c65537_i32_102 = arith.constant 65537 : i32
        %38 = arith.remsi %37, %c65537_i32_102 : i32
        %c12_103 = arith.constant 12 : index
        %39 = memref.load %3[%c12_103] : memref<2048xi32>
        %40 = arith.muli %38, %39 : i32
        %c65537_i32_104 = arith.constant 65537 : i32
        %41 = arith.remsi %40, %c65537_i32_104 : i32
        %c12_105 = arith.constant 12 : index
        %42 = memref.load %3[%c12_105] : memref<2048xi32>
        %43 = arith.muli %41, %42 : i32
        %c65537_i32_106 = arith.constant 65537 : i32
        %44 = arith.remsi %43, %c65537_i32_106 : i32
        %c12_107 = arith.constant 12 : index
        %45 = memref.load %3[%c12_107] : memref<2048xi32>
        %46 = arith.muli %44, %45 : i32
        %c65537_i32_108 = arith.constant 65537 : i32
        %47 = arith.remsi %46, %c65537_i32_108 : i32
        %c0_i32_109 = arith.constant 0 : i32
        %c16_i32_110 = arith.constant 16 : i32
        %c16_i32_111 = arith.constant 16 : i32
        %c12_i32_112 = arith.constant 12 : i32
        %c256_i32_113 = arith.constant 256 : i32
        %c65537_i32_114 = arith.constant 65537 : i32
        %c17_i32_115 = arith.constant 17 : i32
        %c262140_i32_116 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_3_9, %buffer_3_3_13, %buffer_2_3_9, %buffer_3_3_13, %buffer_3_3, %3, %47, %c0_i32_109, %c16_i32_110, %c16_i32_111, %c12_i32_112, %c256_i32_113, %c65537_i32_114, %c17_i32_115, %c262140_i32_116) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_1(Produce, 1)
        %48 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %49 = aie.objectfifo.subview.access %48[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_1(Consume, 1)
        %50 = aie.objectfifo.acquire @of_CT_Mem_FIFO_3_1(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %51 = aie.objectfifo.subview.access %50[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_117 = arith.constant 256 : i32
        func.call @store_func(%buffer_3_3_13, %51, %c256_i32_117) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_3_1(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_3_4 = aie.core(%tile_3_4) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_3_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_3_4_14, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_3_2(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_4_14, %buffer_3_4_14, %buffer_3_4, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_2(Produce, 1)
        %c1_i32_72 = arith.constant 1 : i32
        %c0_i32 = arith.constant 0 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_4_14, %buffer_3_5_15, %buffer_3_4_14, %buffer_3_5_15, %buffer_3_4, %3, %c1_i32_72, %c0_i32, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_2(Produce, 1)
        %6 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %7 = aie.objectfifo.subview.access %6[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_3(Consume, 1)
        aie.objectfifo.release @of_swap_FIFO_3_2(Produce, 1)
        %8 = aie.objectfifo.acquire @of_swap_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %9 = aie.objectfifo.subview.access %8[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_78 = arith.constant 0 : i32
        %c128_i32_79 = arith.constant 128 : i32
        func.call @swap(%buffer_3_4_14, %buffer_3_3_13, %c0_i32_78, %c128_i32_79) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %10 = aie.objectfifo.acquire @of_swap_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %11 = aie.objectfifo.subview.access %10[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_1(Consume, 1)
        %12 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %13 = aie.objectfifo.subview.access %12[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_2(Produce, 1)
        %c13 = arith.constant 13 : index
        %14 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_80 = arith.constant 1 : i32
        %15 = arith.muli %14, %c1_i32_80 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c0_i32_84 = arith.constant 0 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_4_14, %buffer_3_5_15, %buffer_3_4_14, %buffer_3_5_15, %buffer_3_4, %3, %19, %c0_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_2(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_3(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_2(Produce, 1)
        %24 = aie.objectfifo.acquire @of_swap_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %25 = aie.objectfifo.subview.access %24[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c0_i32_91 = arith.constant 0 : i32
        %c128_i32_92 = arith.constant 128 : i32
        func.call @swap(%buffer_3_4_14, %buffer_3_3_13, %c0_i32_91, %c128_i32_92) : (memref<4096xi32>, memref<4096xi32>, i32, i32) -> ()
        %26 = aie.objectfifo.acquire @of_swap_FIFO_3_1(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %27 = aie.objectfifo.subview.access %26[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_swap_FIFO_3_1(Consume, 1)
        %c13_93 = arith.constant 13 : index
        %28 = memref.load %3[%c13_93] : memref<2048xi32>
        %c1_i32_94 = arith.constant 1 : i32
        %29 = arith.muli %28, %c1_i32_94 : i32
        %c65537_i32_95 = arith.constant 65537 : i32
        %30 = arith.remsi %29, %c65537_i32_95 : i32
        %c13_96 = arith.constant 13 : index
        %31 = memref.load %3[%c13_96] : memref<2048xi32>
        %32 = arith.muli %30, %31 : i32
        %c65537_i32_97 = arith.constant 65537 : i32
        %33 = arith.remsi %32, %c65537_i32_97 : i32
        %c0_i32_98 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_99 = arith.constant 16 : i32
        %c12_i32_100 = arith.constant 12 : i32
        %c256_i32_101 = arith.constant 256 : i32
        %c65537_i32_102 = arith.constant 65537 : i32
        %c17_i32_103 = arith.constant 17 : i32
        %c262140_i32_104 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_4_10, %buffer_3_4_14, %buffer_2_4_10, %buffer_3_4_14, %buffer_3_4, %3, %33, %c0_i32_98, %c15_i32, %c16_i32_99, %c12_i32_100, %c256_i32_101, %c65537_i32_102, %c17_i32_103, %c262140_i32_104) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_2(Produce, 1)
        %34 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %35 = aie.objectfifo.subview.access %34[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_2(Consume, 1)
        %36 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_2(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %37 = aie.objectfifo.subview.access %36[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c12 = arith.constant 12 : index
        %38 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_105 = arith.constant 1 : i32
        %39 = arith.muli %38, %c1_i32_105 : i32
        %c65537_i32_106 = arith.constant 65537 : i32
        %40 = arith.remsi %39, %c65537_i32_106 : i32
        %c12_107 = arith.constant 12 : index
        %41 = memref.load %3[%c12_107] : memref<2048xi32>
        %42 = arith.muli %40, %41 : i32
        %c65537_i32_108 = arith.constant 65537 : i32
        %43 = arith.remsi %42, %c65537_i32_108 : i32
        %c12_109 = arith.constant 12 : index
        %44 = memref.load %3[%c12_109] : memref<2048xi32>
        %45 = arith.muli %43, %44 : i32
        %c65537_i32_110 = arith.constant 65537 : i32
        %46 = arith.remsi %45, %c65537_i32_110 : i32
        %c12_111 = arith.constant 12 : index
        %47 = memref.load %3[%c12_111] : memref<2048xi32>
        %48 = arith.muli %46, %47 : i32
        %c65537_i32_112 = arith.constant 65537 : i32
        %49 = arith.remsi %48, %c65537_i32_112 : i32
        %c12_113 = arith.constant 12 : index
        %50 = memref.load %3[%c12_113] : memref<2048xi32>
        %51 = arith.muli %49, %50 : i32
        %c65537_i32_114 = arith.constant 65537 : i32
        %52 = arith.remsi %51, %c65537_i32_114 : i32
        %c12_115 = arith.constant 12 : index
        %53 = memref.load %3[%c12_115] : memref<2048xi32>
        %54 = arith.muli %52, %53 : i32
        %c65537_i32_116 = arith.constant 65537 : i32
        %55 = arith.remsi %54, %c65537_i32_116 : i32
        %c0_i32_117 = arith.constant 0 : i32
        %c16_i32_118 = arith.constant 16 : i32
        %c16_i32_119 = arith.constant 16 : i32
        %c12_i32_120 = arith.constant 12 : i32
        %c256_i32_121 = arith.constant 256 : i32
        %c65537_i32_122 = arith.constant 65537 : i32
        %c17_i32_123 = arith.constant 17 : i32
        %c262140_i32_124 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_4_10, %buffer_3_4_14, %buffer_2_4_10, %buffer_3_4_14, %buffer_3_4, %3, %55, %c0_i32_117, %c16_i32_118, %c16_i32_119, %c12_i32_120, %c256_i32_121, %c65537_i32_122, %c17_i32_123, %c262140_i32_124) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_2(Produce, 1)
        %56 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %57 = aie.objectfifo.subview.access %56[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_2(Consume, 1)
        %58 = aie.objectfifo.acquire @of_CT_Mem_FIFO_3_2(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %59 = aie.objectfifo.subview.access %58[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_125 = arith.constant 256 : i32
        func.call @store_func(%buffer_3_4_14, %59, %c256_i32_125) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_3_2(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    %core_3_5 = aie.core(%tile_3_5) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @of_Mem_CT_FIFO_3_3(Consume, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %2 = aie.objectfifo.acquire @of_Mem_3_CT_factor_FIFO(Consume, 1) : !aie.objectfifosubview<memref<2048xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<2048xi32>> -> memref<2048xi32>
        %c256_i32 = arith.constant 256 : i32
        func.call @store_func(%1, %buffer_3_5_15, %c256_i32) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_Mem_CT_FIFO_3_3(Consume, 1)
        %c1_i32 = arith.constant 1 : i32
        %c16_i32 = arith.constant 16 : i32
        %c12_i32 = arith.constant 12 : i32
        %c65537_i32 = arith.constant 65537 : i32
        %c17_i32 = arith.constant 17 : i32
        %c262140_i32 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c1_i32, %c16_i32, %c12_i32, %c65537_i32, %c17_i32, %c262140_i32) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c2_i32 = arith.constant 2 : i32
        %c16_i32_16 = arith.constant 16 : i32
        %c12_i32_17 = arith.constant 12 : i32
        %c65537_i32_18 = arith.constant 65537 : i32
        %c17_i32_19 = arith.constant 17 : i32
        %c262140_i32_20 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c2_i32, %c16_i32_16, %c12_i32_17, %c65537_i32_18, %c17_i32_19, %c262140_i32_20) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c3_i32 = arith.constant 3 : i32
        %c16_i32_21 = arith.constant 16 : i32
        %c12_i32_22 = arith.constant 12 : i32
        %c65537_i32_23 = arith.constant 65537 : i32
        %c17_i32_24 = arith.constant 17 : i32
        %c262140_i32_25 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c3_i32, %c16_i32_21, %c12_i32_22, %c65537_i32_23, %c17_i32_24, %c262140_i32_25) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c4_i32 = arith.constant 4 : i32
        %c16_i32_26 = arith.constant 16 : i32
        %c12_i32_27 = arith.constant 12 : i32
        %c65537_i32_28 = arith.constant 65537 : i32
        %c17_i32_29 = arith.constant 17 : i32
        %c262140_i32_30 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c4_i32, %c16_i32_26, %c12_i32_27, %c65537_i32_28, %c17_i32_29, %c262140_i32_30) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c5_i32 = arith.constant 5 : i32
        %c16_i32_31 = arith.constant 16 : i32
        %c12_i32_32 = arith.constant 12 : i32
        %c65537_i32_33 = arith.constant 65537 : i32
        %c17_i32_34 = arith.constant 17 : i32
        %c262140_i32_35 = arith.constant 262140 : i32
        func.call @NTT_stage_down(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c5_i32, %c16_i32_31, %c12_i32_32, %c65537_i32_33, %c17_i32_34, %c262140_i32_35) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c6_i32 = arith.constant 6 : i32
        %c16_i32_36 = arith.constant 16 : i32
        %c12_i32_37 = arith.constant 12 : i32
        %c65537_i32_38 = arith.constant 65537 : i32
        %c17_i32_39 = arith.constant 17 : i32
        %c262140_i32_40 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c6_i32, %c16_i32_36, %c12_i32_37, %c65537_i32_38, %c17_i32_39, %c262140_i32_40) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c7_i32 = arith.constant 7 : i32
        %c16_i32_41 = arith.constant 16 : i32
        %c12_i32_42 = arith.constant 12 : i32
        %c65537_i32_43 = arith.constant 65537 : i32
        %c17_i32_44 = arith.constant 17 : i32
        %c262140_i32_45 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c7_i32, %c16_i32_41, %c12_i32_42, %c65537_i32_43, %c17_i32_44, %c262140_i32_45) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c8_i32 = arith.constant 8 : i32
        %c16_i32_46 = arith.constant 16 : i32
        %c12_i32_47 = arith.constant 12 : i32
        %c65537_i32_48 = arith.constant 65537 : i32
        %c17_i32_49 = arith.constant 17 : i32
        %c262140_i32_50 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c8_i32, %c16_i32_46, %c12_i32_47, %c65537_i32_48, %c17_i32_49, %c262140_i32_50) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c9_i32 = arith.constant 9 : i32
        %c16_i32_51 = arith.constant 16 : i32
        %c12_i32_52 = arith.constant 12 : i32
        %c65537_i32_53 = arith.constant 65537 : i32
        %c17_i32_54 = arith.constant 17 : i32
        %c262140_i32_55 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c9_i32, %c16_i32_51, %c12_i32_52, %c65537_i32_53, %c17_i32_54, %c262140_i32_55) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c10_i32 = arith.constant 10 : i32
        %c16_i32_56 = arith.constant 16 : i32
        %c12_i32_57 = arith.constant 12 : i32
        %c65537_i32_58 = arith.constant 65537 : i32
        %c17_i32_59 = arith.constant 17 : i32
        %c262140_i32_60 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c10_i32, %c16_i32_56, %c12_i32_57, %c65537_i32_58, %c17_i32_59, %c262140_i32_60) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c11_i32 = arith.constant 11 : i32
        %c16_i32_61 = arith.constant 16 : i32
        %c12_i32_62 = arith.constant 12 : i32
        %c65537_i32_63 = arith.constant 65537 : i32
        %c17_i32_64 = arith.constant 17 : i32
        %c262140_i32_65 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c11_i32, %c16_i32_61, %c12_i32_62, %c65537_i32_63, %c17_i32_64, %c262140_i32_65) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %c12_i32_66 = arith.constant 12 : i32
        %c16_i32_67 = arith.constant 16 : i32
        %c12_i32_68 = arith.constant 12 : i32
        %c65537_i32_69 = arith.constant 65537 : i32
        %c17_i32_70 = arith.constant 17 : i32
        %c262140_i32_71 = arith.constant 262140 : i32
        func.call @NTT_stage_up(%buffer_3_5_15, %buffer_3_5_15, %buffer_3_5, %3, %c12_i32_66, %c16_i32_67, %c12_i32_68, %c65537_i32_69, %c17_i32_70, %c262140_i32_71) : (memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32) -> ()
        %4 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c14 = arith.constant 14 : index
        %6 = memref.load %3[%c14] : memref<2048xi32>
        %c1_i32_72 = arith.constant 1 : i32
        %c13_i32 = arith.constant 13 : i32
        %c16_i32_73 = arith.constant 16 : i32
        %c12_i32_74 = arith.constant 12 : i32
        %c128_i32 = arith.constant 128 : i32
        %c65537_i32_75 = arith.constant 65537 : i32
        %c17_i32_76 = arith.constant 17 : i32
        %c262140_i32_77 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_4_14, %buffer_3_5_15, %buffer_3_4_14, %buffer_3_5_15, %buffer_3_5, %3, %6, %c1_i32_72, %c13_i32, %c16_i32_73, %c12_i32_74, %c128_i32, %c65537_i32_75, %c17_i32_76, %c262140_i32_77) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_3(Produce, 1)
        %7 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %8 = aie.objectfifo.subview.access %7[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_2(Consume, 1)
        %9 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %10 = aie.objectfifo.subview.access %9[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13 = arith.constant 13 : index
        %11 = memref.load %3[%c13] : memref<2048xi32>
        %c1_i32_78 = arith.constant 1 : i32
        %12 = arith.muli %11, %c1_i32_78 : i32
        %c65537_i32_79 = arith.constant 65537 : i32
        %13 = arith.remsi %12, %c65537_i32_79 : i32
        %c13_80 = arith.constant 13 : index
        %14 = memref.load %3[%c13_80] : memref<2048xi32>
        %15 = arith.muli %13, %14 : i32
        %c65537_i32_81 = arith.constant 65537 : i32
        %16 = arith.remsi %15, %c65537_i32_81 : i32
        %c13_82 = arith.constant 13 : index
        %17 = memref.load %3[%c13_82] : memref<2048xi32>
        %18 = arith.muli %16, %17 : i32
        %c65537_i32_83 = arith.constant 65537 : i32
        %19 = arith.remsi %18, %c65537_i32_83 : i32
        %c1_i32_84 = arith.constant 1 : i32
        %c14_i32 = arith.constant 14 : i32
        %c16_i32_85 = arith.constant 16 : i32
        %c12_i32_86 = arith.constant 12 : i32
        %c128_i32_87 = arith.constant 128 : i32
        %c65537_i32_88 = arith.constant 65537 : i32
        %c17_i32_89 = arith.constant 17 : i32
        %c262140_i32_90 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_3_4_14, %buffer_3_5_15, %buffer_3_4_14, %buffer_3_5_15, %buffer_3_5, %3, %19, %c1_i32_84, %c14_i32, %c16_i32_85, %c12_i32_86, %c128_i32_87, %c65537_i32_88, %c17_i32_89, %c262140_i32_90) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_up_down_flag_FIFO_3_3(Produce, 1)
        %20 = aie.objectfifo.acquire @of_up_down_flag_FIFO_3_2(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %21 = aie.objectfifo.subview.access %20[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_up_down_flag_FIFO_3_2(Consume, 1)
        %22 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %23 = aie.objectfifo.subview.access %22[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c13_91 = arith.constant 13 : index
        %24 = memref.load %3[%c13_91] : memref<2048xi32>
        %c1_i32_92 = arith.constant 1 : i32
        %25 = arith.muli %24, %c1_i32_92 : i32
        %c65537_i32_93 = arith.constant 65537 : i32
        %26 = arith.remsi %25, %c65537_i32_93 : i32
        %c13_94 = arith.constant 13 : index
        %27 = memref.load %3[%c13_94] : memref<2048xi32>
        %28 = arith.muli %26, %27 : i32
        %c65537_i32_95 = arith.constant 65537 : i32
        %29 = arith.remsi %28, %c65537_i32_95 : i32
        %c13_96 = arith.constant 13 : index
        %30 = memref.load %3[%c13_96] : memref<2048xi32>
        %31 = arith.muli %29, %30 : i32
        %c65537_i32_97 = arith.constant 65537 : i32
        %32 = arith.remsi %31, %c65537_i32_97 : i32
        %c0_i32 = arith.constant 0 : i32
        %c15_i32 = arith.constant 15 : i32
        %c16_i32_98 = arith.constant 16 : i32
        %c12_i32_99 = arith.constant 12 : i32
        %c256_i32_100 = arith.constant 256 : i32
        %c65537_i32_101 = arith.constant 65537 : i32
        %c17_i32_102 = arith.constant 17 : i32
        %c262140_i32_103 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_5_11, %buffer_3_5_15, %buffer_2_5_11, %buffer_3_5_15, %buffer_3_5, %3, %32, %c0_i32, %c15_i32, %c16_i32_98, %c12_i32_99, %c256_i32_100, %c65537_i32_101, %c17_i32_102, %c262140_i32_103) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_3(Produce, 1)
        %33 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %34 = aie.objectfifo.subview.access %33[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_3(Consume, 1)
        %35 = aie.objectfifo.acquire @of_right_left_flag_FIFO_3_3(Produce, 1) : !aie.objectfifosubview<memref<1xi32>>
        %36 = aie.objectfifo.subview.access %35[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        %c12 = arith.constant 12 : index
        %37 = memref.load %3[%c12] : memref<2048xi32>
        %c1_i32_104 = arith.constant 1 : i32
        %38 = arith.muli %37, %c1_i32_104 : i32
        %c65537_i32_105 = arith.constant 65537 : i32
        %39 = arith.remsi %38, %c65537_i32_105 : i32
        %c12_106 = arith.constant 12 : index
        %40 = memref.load %3[%c12_106] : memref<2048xi32>
        %41 = arith.muli %39, %40 : i32
        %c65537_i32_107 = arith.constant 65537 : i32
        %42 = arith.remsi %41, %c65537_i32_107 : i32
        %c12_108 = arith.constant 12 : index
        %43 = memref.load %3[%c12_108] : memref<2048xi32>
        %44 = arith.muli %42, %43 : i32
        %c65537_i32_109 = arith.constant 65537 : i32
        %45 = arith.remsi %44, %c65537_i32_109 : i32
        %c12_110 = arith.constant 12 : index
        %46 = memref.load %3[%c12_110] : memref<2048xi32>
        %47 = arith.muli %45, %46 : i32
        %c65537_i32_111 = arith.constant 65537 : i32
        %48 = arith.remsi %47, %c65537_i32_111 : i32
        %c12_112 = arith.constant 12 : index
        %49 = memref.load %3[%c12_112] : memref<2048xi32>
        %50 = arith.muli %48, %49 : i32
        %c65537_i32_113 = arith.constant 65537 : i32
        %51 = arith.remsi %50, %c65537_i32_113 : i32
        %c12_114 = arith.constant 12 : index
        %52 = memref.load %3[%c12_114] : memref<2048xi32>
        %53 = arith.muli %51, %52 : i32
        %c65537_i32_115 = arith.constant 65537 : i32
        %54 = arith.remsi %53, %c65537_i32_115 : i32
        %c12_116 = arith.constant 12 : index
        %55 = memref.load %3[%c12_116] : memref<2048xi32>
        %56 = arith.muli %54, %55 : i32
        %c65537_i32_117 = arith.constant 65537 : i32
        %57 = arith.remsi %56, %c65537_i32_117 : i32
        %c0_i32_118 = arith.constant 0 : i32
        %c16_i32_119 = arith.constant 16 : i32
        %c16_i32_120 = arith.constant 16 : i32
        %c12_i32_121 = arith.constant 12 : i32
        %c256_i32_122 = arith.constant 256 : i32
        %c65537_i32_123 = arith.constant 65537 : i32
        %c17_i32_124 = arith.constant 17 : i32
        %c262140_i32_125 = arith.constant 262140 : i32
        func.call @NTT_stage_next_up_down(%buffer_2_5_11, %buffer_3_5_15, %buffer_2_5_11, %buffer_3_5_15, %buffer_3_5, %3, %57, %c0_i32_118, %c16_i32_119, %c16_i32_120, %c12_i32_121, %c256_i32_122, %c65537_i32_123, %c17_i32_124, %c262140_i32_125) : (memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<4096xi32>, memref<16xi32>, memref<2048xi32>, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> ()
        aie.objectfifo.release @of_right_left_flag_FIFO_3_3(Produce, 1)
        %58 = aie.objectfifo.acquire @of_right_left_flag_FIFO_2_3(Consume, 1) : !aie.objectfifosubview<memref<1xi32>>
        %59 = aie.objectfifo.subview.access %58[0] : !aie.objectfifosubview<memref<1xi32>> -> memref<1xi32>
        aie.objectfifo.release @of_right_left_flag_FIFO_2_3(Consume, 1)
        %60 = aie.objectfifo.acquire @of_CT_Mem_FIFO_3_3(Produce, 1) : !aie.objectfifosubview<memref<4096xi32>>
        %61 = aie.objectfifo.subview.access %60[0] : !aie.objectfifosubview<memref<4096xi32>> -> memref<4096xi32>
        %c256_i32_126 = arith.constant 256 : i32
        func.call @store_func(%buffer_3_5_15, %61, %c256_i32_126) : (memref<4096xi32>, memref<4096xi32>, i32) -> ()
        aie.objectfifo.release @of_CT_Mem_FIFO_3_3(Produce, 1)
      }
      aie.end
    } {link_with = "func.o"}
    aiex.runtime_sequence(%arg0: memref<65536xi32>, %arg1: memref<32768xi32>, %arg2: memref<65536xi32>) {
      aiex.npu.dma_memcpy_nd(0, 0, %arg0[0, 0, 0, 0][1, 1, 1, 16384][0, 0, 0, 1]) {id = 0 : i64, issue_token = true, metadata = @of_Shim_Mem_FIFO_0} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg1[0, 0, 0, 0][1, 1, 1, 8192][0, 0, 0, 1]) {id = 4 : i64, issue_token = true, metadata = @of_Shim_Mem_factor_FIFO_0} : memref<32768xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg2[0, 0, 0, 0][1, 1, 1, 16384][0, 0, 0, 1]) {id = 8 : i64, metadata = @of_Mem_Shim_0_FIFO} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg0[0, 0, 0, 16384][1, 1, 1, 16384][0, 0, 0, 1]) {id = 1 : i64, issue_token = true, metadata = @of_Shim_Mem_FIFO_1} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg1[0, 0, 0, 8192][1, 1, 1, 8192][0, 0, 0, 1]) {id = 5 : i64, issue_token = true, metadata = @of_Shim_Mem_factor_FIFO_1} : memref<32768xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg2[0, 0, 0, 16384][1, 1, 1, 16384][0, 0, 0, 1]) {id = 9 : i64, metadata = @of_Mem_Shim_1_FIFO} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg0[0, 0, 0, 32768][1, 1, 1, 16384][0, 0, 0, 1]) {id = 2 : i64, issue_token = true, metadata = @of_Shim_Mem_FIFO_2} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg1[0, 0, 0, 16384][1, 1, 1, 8192][0, 0, 0, 1]) {id = 6 : i64, issue_token = true, metadata = @of_Shim_Mem_factor_FIFO_2} : memref<32768xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg2[0, 0, 0, 32768][1, 1, 1, 16384][0, 0, 0, 1]) {id = 10 : i64, metadata = @of_Mem_Shim_2_FIFO} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg0[0, 0, 0, 49152][1, 1, 1, 16384][0, 0, 0, 1]) {id = 3 : i64, issue_token = true, metadata = @of_Shim_Mem_FIFO_3} : memref<65536xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg1[0, 0, 0, 24576][1, 1, 1, 8192][0, 0, 0, 1]) {id = 7 : i64, issue_token = true, metadata = @of_Shim_Mem_factor_FIFO_3} : memref<32768xi32>
      aiex.npu.dma_memcpy_nd(0, 0, %arg2[0, 0, 0, 49152][1, 1, 1, 16384][0, 0, 0, 1]) {id = 11 : i64, metadata = @of_Mem_Shim_3_FIFO} : memref<65536xi32>
      aiex.npu.dma_wait {symbol = @of_Mem_Shim_0_FIFO}
      aiex.npu.dma_wait {symbol = @of_Mem_Shim_1_FIFO}
      aiex.npu.dma_wait {symbol = @of_Mem_Shim_2_FIFO}
      aiex.npu.dma_wait {symbol = @of_Mem_Shim_3_FIFO}
    }
  }
}

