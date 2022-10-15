@a = dso_local global [5 x [5 x float]] [[5 x float] [float 0x3FF3333340000000, float 0x4003333340000000, float 0x400CCCCCC0000000, float 0x4013333340000000, float 5.000000e+00], [5 x float] zeroinitializer, [5 x float] zeroinitializer, [5 x float] zeroinitializer, [5 x float] zeroinitializer], align 16
@max = common dso_local global float 0.000000e+00, align 4
@.str = private unnamed_addr constant [23 x i8] c"\E5\85\83\E7\B4\A0\E4\B9\8B\E5\92\8C\E4\B8\BA\EF\BC\9A%f \0A\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"\E5\85\83\E7\B4\A0\E6\9C\80\E5\A4\A7\E5\80\BC\E4\B8\BA\EF\BC\9A%f \0A\00", align 1



;sumfunc()函数
define dso_local float @sumfunc([5 x float]* %0) #0 {
    ;声明变量a、i、j、sum
    %a = alloca [5 x float]*, align 8                    ;局部变量a
    %i = alloca i32, align 4                            ;int i
    %j = alloca i32, align 4                            ;int j
    %sum = alloca float, align 4                        ;float sum

    ;初始化a、i、sum
    store [5 x float]* %0, [5 x float]** %a, align 8     ;a=函数传入的参数
    store i32 0, i32* %i, align 4                       ;i=0
    store float 0.000000e+00, float* %sum, align 4      ;sum=0.0

    br label %while1.cond

while1.cond:                                        ;preds = %while1.body2, %1
    %2 = load i32, i32* %i, align 4
    %cmpi = icmp slt i32 %2, 5                                                  ;while(i<5)
    br i1 %cmpi, label %while1.body1, label %return 

while1.body1:                                       ;preds = %while1.cond
    store i32 0, i32* %j, align 4                                               ;j=0
    br label %while2.cond

while2.cond:                                        ;preds = %while1.body1, %while2.body
    %3 = load i32, i32* %j, align 4
    %cmpj = icmp slt i32 %3, 5                                                  ;while(j<5)
    br i1 %cmpj, label %while2.body, label %while1.body2

while2.body:                                        ;preds = %while2.cond
    %4 = load float, float* %sum, align 4                                           ;sum
    %5 = load i32, i32* %i, align 4                                                 ;i
    %6 = load i32, i32* %j, align 4                                                 ;j
    %7 = load [5 x float]*, [5 x float]** %a, align 8                               ;a

    %8 = sext i32 %5 to i64
    %9 = getelementptr inbounds [5 x float], [5 x float]* %7, i64 %8
    %10 = sext i32 %6 to i64
    %11 = getelementptr inbounds [5 x float], [5 x float]* %9, i64 0, i64 %10
    %12 = load float, float* %11, align 4                                            ;a[i][j]

    %add = fadd float %4, %12                                                       ;sum+a[i][j]
    store float %add, float* %sum, align 4                                          ;sum=sum+a[i][j]

    %incj = add nsw i32 %6, 1
    store i32 %incj, i32* %j, align 4                                                ;j=j+1
    br label %while2.cond

while1.body2:                                       ;preds = %while2.cond
    %13 = load i32, i32* %i, align 4
    %inci = add nsw i32 %13, 1
    store i32 %inci, i32* %i, align 4                                               ;i=i+1
    br label %while1.cond

return:                                             ;preds = %while1.cond
    %14 = load float, float* %sum, align 4
    ret float %14
}


;maxfunc()函数
define dso_local void @maxfunc([5 x float]* %0) #0 {
    ;声明变量a、i、j
    %a = alloca [5 x float]*, align 8                           ;局部变量a
    %i = alloca i32, align 4                                    ;i
    %j = alloca i32, align 4                                    ;j

    ;初始化a、i
    store [5 x float]* %0, [5 x float]** %a, align 8            ;a=函数传入的参数
    store i32 0, i32* %i, align 4                               ;i=0

    ;初始化max
    %2 = load [5 x float]*, [5 x float]** %a, align 8
    %3 = getelementptr inbounds [5 x float], [5 x float]* %2, i64 0
    %4 = getelementptr inbounds [5 x float], [5 x float]* %3, i64 0, i64 0
    %5 = load float, float* %4, align 4                             ;a[0][0]
    store float %5, float* @max, align 4                            ;max=a[0][0]
    br label %while1.cond

while1.cond:                                        ;preds = %while1.body2, %1
    %6 = load i32, i32* %i, align 4
    %cmpi = icmp slt i32 %6, 5                                                  ;while(i<5)
    br i1 %cmpi, label %while1.body1, label %return 

while1.body1:                                       ;preds = %while1.cond
    store i32 0, i32* %j, align 4                                               ;j=0
    br label %while2.cond

while2.cond:                                        ;preds = %while1.body1, %while2.body2
    %7 = load i32, i32* %j, align 4
    %cmpj = icmp slt i32 %7, 5                                                  ;while(j<5)
    br i1 %cmpj, label %while2.body1, label %while1.body2

while2.body1:                                       ;preds = %while2.cond
    br label %if.cond

if.cond:                                            ;preds = %while2.body1
    %8 = load float, float* @max, align 4                           ;max
    %9 = load [5 x float]*, [5 x float]** %a, align 8               ;a
    %10 = load i32, i32* %i, align 4
    %11 = sext i32 %10 to i64                                      ;i
    %12 = load i32, i32* %j, align 4
    %13 = sext i32 %12 to i64                                      ;j

    %14 = getelementptr inbounds [5 x float], [5 x float]* %9, i64 %11
    %15 = getelementptr inbounds [5 x float], [5 x float]* %14, i64 0, i64 %13
    %16 = load float, float* %15, align 4                            ;a[i][j]

    %cmpmax = fcmp olt float %8, %16
    br i1 %cmpmax, label %if.body, label %while2.body2

if.body:                                            ;preds = %if.cond
    ;%17 = load float, float* @max, align 4                           ;max
    %17 = load [5 x float]*, [5 x float]** %a, align 8               ;a
    %18 = load i32, i32* %i, align 4
    %19 = sext i32 %18 to i64                                      ;i
    %20 = load i32, i32* %j, align 4
    %21 = sext i32 %20 to i64                                      ;j

    %22 = getelementptr inbounds [5 x float], [5 x float]* %17, i64 %19
    %23 = getelementptr inbounds [5 x float], [5 x float]* %22, i64 0, i64 %21
    %24 = load float, float* %23, align 4                            ;a[i][j]

    store float %24, float* @max, align 4                               ;max=a[i][j]
    br label %while2.body2

while2.body2:                                       ;preds = %if.cond, %if.body
    %25 = load i32, i32* %j, align 4
    %incj = add nsw i32 %25, 1
    store i32 %incj, i32* %j, align 4                                   ;j=j+1
    br label %while2.cond

while1.body2:                                       ;preds = %while2.cond
    %26 = load i32, i32* %i, align 4
    %inci = add nsw i32 %26, 1
    store i32 %inci, i32* %i, align 4                                   ;j=j+1
    br label %while1.cond

return:                                             ;preds = %while1.cond
    ret void
}



;main函数
define dso_local i32 @main() #0 {

    ;返回变量retval=0
    %retval = alloca i32, align 4
    store i32 0, i32* %retval, align 4

    ;调用函数sumfunc()
    %1 = call float @sumfunc([5 x float]* getelementptr inbounds ([5 x [5 x float]], [5 x [5 x float]]* @a, i64 0, i64 0))
    ;把sumfunc()返回值改成double型
    %2 = fpext float %1 to double

    ;调用函数printf()，输出sumfunc()返回值
    %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), double %2)
    
    ;调用函数maxfunc()
    call void @maxfunc([5 x float]* getelementptr inbounds ([5 x [5 x float]], [5 x [5 x float]]* @a, i64 0, i64 0))
    
    ;调用函数printf()，输出max
    %4 = load float, float* @max, align 4
    %5 = fpext float %4 to double
    %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i64 0, i64 0), double %5)

    ;return 0
    %7 = load i32, i32* %retval, align 4
    ret i32 %7
}

    declare dso_local i32 @printf(i8*, ...) #1

    attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
    attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
