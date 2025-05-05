; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target triple = "aie2"

%struct.ipd.custom_type.uint2_t.uint2_t = type { i2 }

@_anonymous0 = external global [2048 x i32]
@of_in_FIFO_cons_buff_0 = external global [4096 x i32]
@of_in_factor_FIFO_cons_buff_0 = external global [12 x i32]
@out_buff_0 = external global [4096 x i32]

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

declare void @llvm.aie2.acquire(i32, i32)

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #0

declare void @NTT_stage_down(ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32)

declare void @NTT_stage_up(ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32)

declare void @llvm.aie2.release(i32, i32)

; Function Attrs: mustprogress nounwind
define dso_local void @llvm___aie2___acquire(i32 noundef %0, i32 noundef %1) local_unnamed_addr addrspace(1) #1 {
  tail call addrspace(1) void @llvm.chess_memory_fence()
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_acquire_guarded___uint___uint(i32 zeroext %0, i32 zeroext %1) #5
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call addrspace(1) void @llvm.chess_memory_fence()
  ret void
}

; Function Attrs: nounwind willreturn
declare void @llvm.chess_memory_fence() addrspace(1) #2

; Function Attrs: inaccessiblememonly nounwind
declare dso_local void @_Z25chess_separator_schedulerv() local_unnamed_addr addrspace(1) #3

; Function Attrs: inaccessiblememonly nounwind
declare dso_local x86_regcallcc void @__regcall3__chessintr_void_acquire_guarded___uint___uint(i32 zeroext, i32 zeroext) local_unnamed_addr addrspace(1) #3

; Function Attrs: mustprogress nounwind
define dso_local void @llvm___aie2___release(i32 noundef %0, i32 noundef %1) local_unnamed_addr addrspace(1) #1 {
  tail call addrspace(1) void @llvm.chess_memory_fence()
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_release_guarded___uint___sint(i32 zeroext %0, i32 signext %1) #5
  tail call addrspace(1) void @_Z25chess_separator_schedulerv() #5
  tail call addrspace(1) void @llvm.chess_memory_fence()
  ret void
}

; Function Attrs: inaccessiblememonly nounwind
declare dso_local x86_regcallcc void @__regcall3__chessintr_void_release_guarded___uint___sint(i32 zeroext, i32 signext) local_unnamed_addr addrspace(1) #3

; Function Attrs: nounwind
define dso_local void @llvm___aie___event0() local_unnamed_addr addrspace(1) #4 {
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_event_uint2_t(%struct.ipd.custom_type.uint2_t.uint2_t zeroinitializer) #5
  ret void
}

; Function Attrs: inaccessiblememonly nounwind
declare dso_local x86_regcallcc void @__regcall3__chessintr_void_event_uint2_t(%struct.ipd.custom_type.uint2_t.uint2_t) local_unnamed_addr addrspace(1) #3

; Function Attrs: nounwind
define dso_local void @llvm___aie___event1() local_unnamed_addr addrspace(1) #4 {
  tail call x86_regcallcc addrspace(1) void @__regcall3__chessintr_void_event_uint2_t(%struct.ipd.custom_type.uint2_t.uint2_t { i2 1 }) #5
  ret void
}

attributes #0 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
attributes #1 = { mustprogress nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { nounwind willreturn }
attributes #3 = { inaccessiblememonly nounwind "frame-pointer"="all" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #4 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtin-memcpy" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { inaccessiblememonly nounwind "no-builtin-memcpy" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.linker.options = !{}
!llvm.ident = !{!3}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 15.0.5 (/u/sgasip/ipd/repositories/llvm_ipd 3a25925e0239306412dac02da5e4c8c51ae722e8)"}
