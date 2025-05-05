module attributes {llvm.target_triple = "aie2"} {
  llvm.mlir.global external @_anonymous0() {addr_space = 0 : i32} : !llvm.array<2048 x i32>
  llvm.mlir.global external @of_in_FIFO_cons_buff_0() {addr_space = 0 : i32} : !llvm.array<4096 x i32>
  llvm.mlir.global external @of_in_factor_FIFO_cons_buff_0() {addr_space = 0 : i32} : !llvm.array<12 x i32>
  llvm.mlir.global external @out_buff_0() {addr_space = 0 : i32} : !llvm.array<4096 x i32>
  llvm.func @debug_i32(i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.put.ms(i32, i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.get.ss() -> !llvm.struct<(i32, i32)> attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.mcd.write.vec(vector<16xi32>, i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.scd.read.vec(i32) -> vector<16xi32> attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.acquire(i32, i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.release(i32, i32) attributes {sym_visibility = "private"}
  llvm.mlir.global external @out_cons() {addr_space = 0 : i32} : !llvm.array<4096 x i32>
  llvm.mlir.global external @out() {addr_space = 0 : i32} : !llvm.array<4096 x i32>
  llvm.mlir.global external @of_in_factor_FIFO_cons() {addr_space = 0 : i32} : !llvm.array<12 x i32>
  llvm.mlir.global external @of_in_factor_FIFO() {addr_space = 0 : i32} : !llvm.array<12 x i32>
  llvm.mlir.global external @of_in_FIFO_cons() {addr_space = 0 : i32} : !llvm.array<4096 x i32>
  llvm.mlir.global external @of_in_FIFO() {addr_space = 0 : i32} : !llvm.array<4096 x i32>
  llvm.func @NTT_stage_down(!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) attributes {sym_visibility = "private"}
  llvm.func @NTT_stage_up(!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) attributes {sym_visibility = "private"}
  llvm.func @core_0_2() {
    %0 = llvm.mlir.addressof @out_buff_0 : !llvm.ptr
    %1 = llvm.mlir.addressof @_anonymous0 : !llvm.ptr
    %2 = llvm.mlir.addressof @of_in_FIFO_cons_buff_0 : !llvm.ptr
    %3 = llvm.mlir.constant(31 : index) : i64
    %4 = llvm.mlir.addressof @of_in_factor_FIFO_cons_buff_0 : !llvm.ptr
    %5 = llvm.mlir.constant(50 : i32) : i32
    %6 = llvm.mlir.constant(48 : i32) : i32
    %7 = llvm.mlir.constant(53 : i32) : i32
    %8 = llvm.mlir.constant(52 : i32) : i32
    %9 = llvm.mlir.constant(51 : i32) : i32
    %10 = llvm.mlir.constant(49 : i32) : i32
    %11 = llvm.mlir.constant(11 : i32) : i32
    %12 = llvm.mlir.constant(10 : i32) : i32
    %13 = llvm.mlir.constant(9 : i32) : i32
    %14 = llvm.mlir.constant(8 : i32) : i32
    %15 = llvm.mlir.constant(7 : i32) : i32
    %16 = llvm.mlir.constant(6 : i32) : i32
    %17 = llvm.mlir.constant(5 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.mlir.constant(2 : i32) : i32
    %21 = llvm.mlir.constant(262140 : i32) : i32
    %22 = llvm.mlir.constant(17 : i32) : i32
    %23 = llvm.mlir.constant(65537 : i32) : i32
    %24 = llvm.mlir.constant(12 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.constant(-1 : i32) : i32
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.mlir.constant(9223372036854775807 : index) : i64
    %29 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%27 : i64)
  ^bb1(%30: i64):  // 2 preds: ^bb0, ^bb2
    %31 = llvm.icmp "slt" %30, %28 : i64
    llvm.cond_br %31, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @llvm.aie2.acquire(%10, %26) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%9, %26) : (i32, i32) -> ()
    %32 = llvm.getelementptr %4[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<12 x i32>
    %33 = llvm.ptrtoint %32 : !llvm.ptr to i64
    %34 = llvm.and %33, %3  : i64
    %35 = llvm.icmp "eq" %34, %27 : i64
    "llvm.intr.assume"(%35) : (i1) -> ()
    %36 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4096 x i32>
    %37 = llvm.ptrtoint %36 : !llvm.ptr to i64
    %38 = llvm.and %37, %3  : i64
    %39 = llvm.icmp "eq" %38, %27 : i64
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    %40 = llvm.getelementptr %1[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<2048 x i32>
    %41 = llvm.ptrtoint %40 : !llvm.ptr to i64
    %42 = llvm.and %41, %3  : i64
    %43 = llvm.icmp "eq" %42, %27 : i64
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_down(%36, %36, %40, %32, %25, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_down(%36, %36, %40, %32, %20, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_down(%36, %36, %40, %32, %19, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_down(%36, %36, %40, %32, %18, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_down(%36, %36, %40, %32, %17, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %36, %40, %32, %16, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %36, %40, %32, %15, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %36, %40, %32, %14, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %36, %40, %32, %13, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %36, %40, %32, %12, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %36, %40, %32, %11, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%8, %26) : (i32, i32) -> ()
    %44 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<4096 x i32>
    %45 = llvm.ptrtoint %44 : !llvm.ptr to i64
    %46 = llvm.and %45, %3  : i64
    %47 = llvm.icmp "eq" %46, %27 : i64
    "llvm.intr.assume"(%47) : (i1) -> ()
    "llvm.intr.assume"(%35) : (i1) -> ()
    "llvm.intr.assume"(%39) : (i1) -> ()
    "llvm.intr.assume"(%43) : (i1) -> ()
    llvm.call @NTT_stage_up(%36, %44, %40, %32, %24, %24, %24, %23, %22, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, i32) -> ()
    llvm.call @llvm.aie2.release(%7, %25) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%6, %25) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%5, %25) : (i32, i32) -> ()
    %48 = llvm.add %30, %29 : i64
    llvm.br ^bb1(%48 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}

