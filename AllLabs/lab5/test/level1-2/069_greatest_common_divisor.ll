define i32 @fun(i32 %m, i32 %n) {
B25:
  %t28 = alloca i32, align 4
  %t27 = alloca i32, align 4
  %t26 = alloca i32, align 4
  store i32 %m, i32* %t26, align 4
  store i32 %n, i32* %t27, align 4
  br label %B29
B29:                               	; preds = %B25, %B30
  %t1 = load i32, i32* %t27, align 4
  %t2 = icmp sgt i32 %t1, 0
  br i1 %t2, label %B30, label %B34
B30:                               	; preds = %B29
  %t4 = load i32, i32* %t26, align 4
  %t5 = load i32, i32* %t27, align 4
  %t6 = srem i32 %t4, %t5
  store i32 %t6, i32* %t28, align 4
  %t8 = load i32, i32* %t27, align 4
  store i32 %t8, i32* %t26, align 4
  %t10 = load i32, i32* %t28, align 4
  store i32 %t10, i32* %t27, align 4
  br label %B29
B34:                               	; preds = %B29
  br label %B31
B31:                               	; preds = %B34
  %t11 = load i32, i32* %t26, align 4
  ret i32 %t11
}
define i32 @main() {
B35:
  %t38 = alloca i32, align 4
  %t37 = alloca i32, align 4
  %t36 = alloca i32, align 4
  %t16 = call i32 @getint()
  store i32 %t16, i32* %t37, align 4
  %t18 = call i32 @getint()
  store i32 %t18, i32* %t36, align 4
  %t20 = load i32, i32* %t37, align 4
  %t21 = load i32, i32* %t36, align 4
  %t22 = call i32 @fun(i32 %t20, i32 %t21)
  store i32 %t22, i32* %t38, align 4
  %t23 = load i32, i32* %t38, align 4
  call void @putint(i32 %t23)
  ret i32 0
}
declare void @putint(i32)
declare i32 @getint()
