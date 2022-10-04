; ModuleID = 'game_of_life.c'
source_filename = "game_of_life.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.polygon = type { i8*, i64, i64 }

@.str = private unnamed_addr constant [5 x i8] c"buff\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"game_of_life.c\00", align 1
@__PRETTY_FUNCTION__.init_poly = private unnamed_addr constant [53 x i8] c"struct polygon init_poly(unsigned int, unsigned int)\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.polygon, align 8
  %3 = alloca %struct.polygon, align 8
  store i32 0, i32* %1, align 4
  call void @init_poly(%struct.polygon* sret %2, i32 800, i32 600)
  call void @init_poly(%struct.polygon* sret %3, i32 800, i32 600)
  call void @graph_init(i64 800, i64 600)
  call void @create_chaos(%struct.polygon* byval(%struct.polygon) align 8 %2)
  br label %4

4:                                                ; preds = %6, %0
  %5 = call zeroext i1 (...) @graph_is_running()
  br i1 %5, label %6, label %7

6:                                                ; preds = %4
  call void (...) @graph_is_closed()
  call void (...) @graph_clear()
  call void @evolution(%struct.polygon* byval(%struct.polygon) align 8 %2, %struct.polygon* byval(%struct.polygon) align 8 %3)
  call void @swap_poly(%struct.polygon* %2, %struct.polygon* %3)
  call void @draw(%struct.polygon* byval(%struct.polygon) align 8 %2)
  br label %4

7:                                                ; preds = %4
  call void @finalizing(%struct.polygon* byval(%struct.polygon) align 8 %2, %struct.polygon* byval(%struct.polygon) align 8 %3)
  %8 = load i32, i32* %1, align 4
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init_poly(%struct.polygon* noalias sret %0, i32 %1, i32 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  store i32 %1, i32* %4, align 4
  store i32 %2, i32* %5, align 4
  %7 = load i32, i32* %4, align 4
  %8 = load i32, i32* %5, align 4
  %9 = mul i32 %7, %8
  %10 = zext i32 %9 to i64
  %11 = call noalias i8* @calloc(i64 %10, i64 1) #5
  store i8* %11, i8** %6, align 8
  %12 = load i8*, i8** %6, align 8
  %13 = icmp ne i8* %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %16

15:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1, i64 0, i64 0), i32 63, i8* getelementptr inbounds ([53 x i8], [53 x i8]* @__PRETTY_FUNCTION__.init_poly, i64 0, i64 0)) #6
  unreachable

16:                                               ; preds = %14
  %17 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 0
  %18 = load i8*, i8** %6, align 8
  store i8* %18, i8** %17, align 8
  %19 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 1
  %20 = load i32, i32* %4, align 4
  %21 = zext i32 %20 to i64
  store i64 %21, i64* %19, align 8
  %22 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %23 = load i32, i32* %5, align 4
  %24 = zext i32 %23 to i64
  store i64 %24, i64* %22, align 8
  ret void
}

declare dso_local void @graph_init(i64, i64) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @create_chaos(%struct.polygon* byval(%struct.polygon) align 8 %0) #0 {
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = call i64 @time(i64* null) #5
  %5 = trunc i64 %4 to i32
  call void @srand(i32 %5) #5
  store i64 0, i64* %2, align 8
  br label %6

6:                                                ; preds = %29, %1
  %7 = load i64, i64* %2, align 8
  %8 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 1
  %9 = load i64, i64* %8, align 8
  %10 = icmp ult i64 %7, %9
  br i1 %10, label %11, label %32

11:                                               ; preds = %6
  store i64 0, i64* %3, align 8
  br label %12

12:                                               ; preds = %25, %11
  %13 = load i64, i64* %3, align 8
  %14 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %15 = load i64, i64* %14, align 8
  %16 = icmp ult i64 %13, %15
  br i1 %16, label %17, label %28

17:                                               ; preds = %12
  %18 = load i64, i64* %2, align 8
  %19 = trunc i64 %18 to i32
  %20 = load i64, i64* %3, align 8
  %21 = trunc i64 %20 to i32
  %22 = call i32 @rand() #5
  %23 = srem i32 %22, 2
  %24 = icmp ne i32 %23, 0
  call void @set_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %19, i32 %21, i1 zeroext %24)
  br label %25

25:                                               ; preds = %17
  %26 = load i64, i64* %3, align 8
  %27 = add i64 %26, 1
  store i64 %27, i64* %3, align 8
  br label %12

28:                                               ; preds = %12
  br label %29

29:                                               ; preds = %28
  %30 = load i64, i64* %2, align 8
  %31 = add i64 %30, 1
  store i64 %31, i64* %2, align 8
  br label %6

32:                                               ; preds = %6
  ret void
}

declare dso_local zeroext i1 @graph_is_running(...) #1

declare dso_local void @graph_is_closed(...) #1

declare dso_local void @graph_clear(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @evolution(%struct.polygon* byval(%struct.polygon) align 8 %0, %struct.polygon* byval(%struct.polygon) align 8 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i8, align 1
  store i64 0, i64* %3, align 8
  br label %6

6:                                                ; preds = %34, %2
  %7 = load i64, i64* %3, align 8
  %8 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 1
  %9 = load i64, i64* %8, align 8
  %10 = icmp ult i64 %7, %9
  br i1 %10, label %11, label %37

11:                                               ; preds = %6
  store i64 0, i64* %4, align 8
  br label %12

12:                                               ; preds = %30, %11
  %13 = load i64, i64* %4, align 8
  %14 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %15 = load i64, i64* %14, align 8
  %16 = icmp ult i64 %13, %15
  br i1 %16, label %17, label %33

17:                                               ; preds = %12
  %18 = load i64, i64* %3, align 8
  %19 = trunc i64 %18 to i32
  %20 = load i64, i64* %4, align 8
  %21 = trunc i64 %20 to i32
  %22 = call zeroext i1 @determine_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %19, i32 %21)
  %23 = zext i1 %22 to i8
  store i8 %23, i8* %5, align 1
  %24 = load i64, i64* %3, align 8
  %25 = trunc i64 %24 to i32
  %26 = load i64, i64* %4, align 8
  %27 = trunc i64 %26 to i32
  %28 = load i8, i8* %5, align 1
  %29 = trunc i8 %28 to i1
  call void @set_state(%struct.polygon* byval(%struct.polygon) align 8 %1, i32 %25, i32 %27, i1 zeroext %29)
  br label %30

30:                                               ; preds = %17
  %31 = load i64, i64* %4, align 8
  %32 = add i64 %31, 1
  store i64 %32, i64* %4, align 8
  br label %12

33:                                               ; preds = %12
  br label %34

34:                                               ; preds = %33
  %35 = load i64, i64* %3, align 8
  %36 = add i64 %35, 1
  store i64 %36, i64* %3, align 8
  br label %6

37:                                               ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @swap_poly(%struct.polygon* %0, %struct.polygon* %1) #0 {
  %3 = alloca %struct.polygon*, align 8
  %4 = alloca %struct.polygon*, align 8
  %5 = alloca %struct.polygon, align 8
  store %struct.polygon* %0, %struct.polygon** %3, align 8
  store %struct.polygon* %1, %struct.polygon** %4, align 8
  %6 = load %struct.polygon*, %struct.polygon** %3, align 8
  %7 = bitcast %struct.polygon* %5 to i8*
  %8 = bitcast %struct.polygon* %6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %7, i8* align 8 %8, i64 24, i1 false)
  %9 = load %struct.polygon*, %struct.polygon** %3, align 8
  %10 = load %struct.polygon*, %struct.polygon** %4, align 8
  %11 = bitcast %struct.polygon* %9 to i8*
  %12 = bitcast %struct.polygon* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %11, i8* align 8 %12, i64 24, i1 false)
  %13 = load %struct.polygon*, %struct.polygon** %4, align 8
  %14 = bitcast %struct.polygon* %13 to i8*
  %15 = bitcast %struct.polygon* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %14, i8* align 8 %15, i64 24, i1 false)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @draw(%struct.polygon* byval(%struct.polygon) align 8 %0) #0 {
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  store i64 0, i64* %2, align 8
  br label %4

4:                                                ; preds = %29, %1
  %5 = load i64, i64* %2, align 8
  %6 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 1
  %7 = load i64, i64* %6, align 8
  %8 = icmp ult i64 %5, %7
  br i1 %8, label %9, label %32

9:                                                ; preds = %4
  store i64 0, i64* %3, align 8
  br label %10

10:                                               ; preds = %25, %9
  %11 = load i64, i64* %3, align 8
  %12 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %13 = load i64, i64* %12, align 8
  %14 = icmp ult i64 %11, %13
  br i1 %14, label %15, label %28

15:                                               ; preds = %10
  %16 = load i64, i64* %2, align 8
  %17 = trunc i64 %16 to i32
  %18 = load i64, i64* %3, align 8
  %19 = trunc i64 %18 to i32
  %20 = load i64, i64* %2, align 8
  %21 = trunc i64 %20 to i32
  %22 = load i64, i64* %3, align 8
  %23 = trunc i64 %22 to i32
  %24 = call zeroext i1 @get_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %21, i32 %23)
  call void @graph_put_pixel(i32 %17, i32 %19, i1 zeroext %24)
  br label %25

25:                                               ; preds = %15
  %26 = load i64, i64* %3, align 8
  %27 = add i64 %26, 1
  store i64 %27, i64* %3, align 8
  br label %10

28:                                               ; preds = %10
  br label %29

29:                                               ; preds = %28
  %30 = load i64, i64* %2, align 8
  %31 = add i64 %30, 1
  store i64 %31, i64* %2, align 8
  br label %4

32:                                               ; preds = %4
  call void (...) @graph_flush()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @finalizing(%struct.polygon* byval(%struct.polygon) align 8 %0, %struct.polygon* byval(%struct.polygon) align 8 %1) #0 {
  call void @delete_poly(%struct.polygon* byval(%struct.polygon) align 8 %0)
  call void @delete_poly(%struct.polygon* byval(%struct.polygon) align 8 %1)
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @calloc(i64, i64) #2

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @get_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %1, i32 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %1, i32* %4, align 4
  store i32 %2, i32* %5, align 4
  %6 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 0
  %7 = load i8*, i8** %6, align 8
  %8 = load i32, i32* %5, align 4
  %9 = sext i32 %8 to i64
  %10 = load i32, i32* %4, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %13 = load i64, i64* %12, align 8
  %14 = mul i64 %11, %13
  %15 = add i64 %9, %14
  %16 = getelementptr inbounds i8, i8* %7, i64 %15
  %17 = load i8, i8* %16, align 1
  %18 = trunc i8 %17 to i1
  ret i1 %18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @set_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %1, i32 %2, i1 zeroext %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = zext i1 %3 to i8
  store i8 %8, i8* %7, align 1
  %9 = load i8, i8* %7, align 1
  %10 = trunc i8 %9 to i1
  %11 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 0
  %12 = load i8*, i8** %11, align 8
  %13 = load i32, i32* %6, align 4
  %14 = sext i32 %13 to i64
  %15 = load i32, i32* %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %18 = load i64, i64* %17, align 8
  %19 = mul i64 %16, %18
  %20 = add i64 %14, %19
  %21 = getelementptr inbounds i8, i8* %12, i64 %20
  %22 = zext i1 %10 to i8
  store i8 %22, i8* %21, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @delete_poly(%struct.polygon* byval(%struct.polygon) align 8 %0) #0 {
  %2 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 0
  %3 = load i8*, i8** %2, align 8
  call void @free(i8* %3) #5
  ret void
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: nounwind
declare dso_local void @srand(i32) #2

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) #2

; Function Attrs: nounwind
declare dso_local i32 @rand() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @count_neighb(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %1, i32 %2, i1 zeroext %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %11 = zext i1 %3 to i8
  store i8 %11, i8* %7, align 1
  store i64 0, i64* %8, align 8
  %12 = load i32, i32* %5, align 4
  %13 = sub nsw i32 %12, 1
  store i32 %13, i32* %9, align 4
  br label %14

14:                                               ; preds = %72, %4
  %15 = load i32, i32* %9, align 4
  %16 = load i32, i32* %5, align 4
  %17 = add nsw i32 %16, 1
  %18 = icmp sle i32 %15, %17
  br i1 %18, label %19, label %75

19:                                               ; preds = %14
  %20 = load i32, i32* %6, align 4
  %21 = sub nsw i32 %20, 1
  store i32 %21, i32* %10, align 4
  br label %22

22:                                               ; preds = %68, %19
  %23 = load i32, i32* %10, align 4
  %24 = load i32, i32* %6, align 4
  %25 = add nsw i32 %24, 1
  %26 = icmp sle i32 %23, %25
  br i1 %26, label %27, label %71

27:                                               ; preds = %22
  %28 = load i32, i32* %9, align 4
  %29 = load i32, i32* %5, align 4
  %30 = icmp eq i32 %28, %29
  br i1 %30, label %31, label %36

31:                                               ; preds = %27
  %32 = load i32, i32* %10, align 4
  %33 = load i32, i32* %6, align 4
  %34 = icmp eq i32 %32, %33
  br i1 %34, label %35, label %36

35:                                               ; preds = %31
  br label %68

36:                                               ; preds = %31, %27
  %37 = load i32, i32* %9, align 4
  %38 = icmp slt i32 %37, 0
  br i1 %38, label %54, label %39

39:                                               ; preds = %36
  %40 = load i32, i32* %9, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 1
  %43 = load i64, i64* %42, align 8
  %44 = icmp uge i64 %41, %43
  br i1 %44, label %54, label %45

45:                                               ; preds = %39
  %46 = load i32, i32* %10, align 4
  %47 = icmp slt i32 %46, 0
  br i1 %47, label %54, label %48

48:                                               ; preds = %45
  %49 = load i32, i32* %10, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds %struct.polygon, %struct.polygon* %0, i32 0, i32 2
  %52 = load i64, i64* %51, align 8
  %53 = icmp uge i64 %50, %52
  br i1 %53, label %54, label %55

54:                                               ; preds = %48, %45, %39, %36
  br label %68

55:                                               ; preds = %48
  %56 = load i8, i8* %7, align 1
  %57 = trunc i8 %56 to i1
  %58 = zext i1 %57 to i32
  %59 = load i32, i32* %9, align 4
  %60 = load i32, i32* %10, align 4
  %61 = call zeroext i1 @get_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %59, i32 %60)
  %62 = zext i1 %61 to i32
  %63 = icmp eq i32 %58, %62
  br i1 %63, label %64, label %67

64:                                               ; preds = %55
  %65 = load i64, i64* %8, align 8
  %66 = add i64 %65, 1
  store i64 %66, i64* %8, align 8
  br label %67

67:                                               ; preds = %64, %55
  br label %68

68:                                               ; preds = %67, %54, %35
  %69 = load i32, i32* %10, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, i32* %10, align 4
  br label %22

71:                                               ; preds = %22
  br label %72

72:                                               ; preds = %71
  %73 = load i32, i32* %9, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %9, align 4
  br label %14

75:                                               ; preds = %14
  %76 = load i64, i64* %8, align 8
  ret i64 %76
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @determine_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %1, i32 %2) #0 {
  %4 = alloca i1, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %5, align 4
  %9 = load i32, i32* %6, align 4
  %10 = call i64 @count_neighb(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %8, i32 %9, i1 zeroext true)
  store i64 %10, i64* %7, align 8
  %11 = load i32, i32* %5, align 4
  %12 = load i32, i32* %6, align 4
  %13 = call zeroext i1 @get_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %11, i32 %12)
  %14 = zext i1 %13 to i32
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %21

16:                                               ; preds = %3
  %17 = load i64, i64* %7, align 8
  %18 = icmp eq i64 %17, 3
  br i1 %18, label %19, label %20

19:                                               ; preds = %16
  store i1 true, i1* %4, align 1
  br label %39

20:                                               ; preds = %16
  br label %21

21:                                               ; preds = %20, %3
  %22 = load i32, i32* %5, align 4
  %23 = load i32, i32* %6, align 4
  %24 = call zeroext i1 @get_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %22, i32 %23)
  %25 = zext i1 %24 to i32
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %35

27:                                               ; preds = %21
  %28 = load i64, i64* %7, align 8
  %29 = icmp ugt i64 %28, 3
  br i1 %29, label %33, label %30

30:                                               ; preds = %27
  %31 = load i64, i64* %7, align 8
  %32 = icmp ult i64 %31, 2
  br i1 %32, label %33, label %34

33:                                               ; preds = %30, %27
  store i1 false, i1* %4, align 1
  br label %39

34:                                               ; preds = %30
  store i1 true, i1* %4, align 1
  br label %39

35:                                               ; preds = %21
  %36 = load i32, i32* %5, align 4
  %37 = load i32, i32* %6, align 4
  %38 = call zeroext i1 @get_state(%struct.polygon* byval(%struct.polygon) align 8 %0, i32 %36, i32 %37)
  store i1 %38, i1* %4, align 1
  br label %39

39:                                               ; preds = %35, %34, %33, %19
  %40 = load i1, i1* %4, align 1
  ret i1 %40
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

declare dso_local void @graph_put_pixel(i32, i32, i1 zeroext) #1

declare dso_local void @graph_flush(...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
