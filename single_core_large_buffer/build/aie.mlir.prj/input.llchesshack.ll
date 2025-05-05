; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "aie2"

@_anonymous0 = external global [2048 x i32]
@of_in_FIFO_cons_buff_0 = external global [4096 x i32]
@of_in_factor_FIFO_cons_buff_0 = external global [12 x i32]
@out_buff_0 = external global [4096 x i32]
@out_cons = external global [4096 x i32]
@out = external global [4096 x i32]
@of_in_factor_FIFO_cons = external global [12 x i32]
@of_in_factor_FIFO = external global [12 x i32]
@of_in_FIFO_cons = external global [4096 x i32]
@of_in_FIFO = external global [4096 x i32]

declare void @debug_i32(i32)

declare void @llvm.aie2.put.ms(i32, i32)

declare { i32, i32 } @llvm.aie2.get.ss()

declare void @llvm.aie2.mcd.write.vec(<16 x i32>, i32)

declare <16 x i32> @llvm.aie2.scd.read.vec(i32)

declare void @llvm.aie2.acquire(i32, i32)

declare void @llvm.aie2.release(i32, i32)

declare void @NTT_stage_down(ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32)

declare void @NTT_stage_up(ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32)

define void @core_0_2() {
  br label %1

1:                                                ; preds = %4, %0
  %2 = phi i64 [ %13, %4 ], [ 0, %0 ]
  %3 = icmp slt i64 %2, 9223372036854775807
  br i1 %3, label %4, label %14

4:                                                ; preds = %1
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  call void @llvm.aie2.acquire(i32 51, i32 -1)
  %5 = and i64 ptrtoint (ptr @of_in_factor_FIFO_cons_buff_0 to i64), 31
  %6 = icmp eq i64 %5, 0
  call void @llvm.assume(i1 %6)
  %7 = and i64 ptrtoint (ptr @of_in_FIFO_cons_buff_0 to i64), 31
  %8 = icmp eq i64 %7, 0
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  %9 = and i64 ptrtoint (ptr @_anonymous0 to i64), 31
  %10 = icmp eq i64 %9, 0
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_down(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 1, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_down(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 2, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_down(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 3, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_down(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 4, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_down(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 5, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 6, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 7, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 8, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 9, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 10, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @of_in_FIFO_cons_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 11, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.aie2.acquire(i32 52, i32 -1)
  %11 = and i64 ptrtoint (ptr @out_buff_0 to i64), 31
  %12 = icmp eq i64 %11, 0
  call void @llvm.assume(i1 %12)
  call void @llvm.assume(i1 %6)
  call void @llvm.assume(i1 %8)
  call void @llvm.assume(i1 %10)
  call void @NTT_stage_up(ptr @of_in_FIFO_cons_buff_0, ptr @out_buff_0, ptr @_anonymous0, ptr @of_in_factor_FIFO_cons_buff_0, i32 12, i32 12, i32 12, i32 65537, i32 17, i32 262140)
  call void @llvm.aie2.release(i32 53, i32 1)
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 50, i32 1)
  %13 = add i64 %2, 1
  br label %1

14:                                               ; preds = %1
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn inaccessiblememonly writeonly
declare void @llvm.assume(i1 noundef) #0

attributes #0 = { nocallback nofree nosync nounwind willreturn inaccessiblememonly writeonly }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
