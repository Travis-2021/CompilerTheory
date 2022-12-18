define i32 @fsqrt(i32 %a) {
B32:
  %t35 = alloca i32, align 4
  %t34 = alloca i32, align 4
  %t33 = alloca i32, align 4
  store i32 %a, i32* %t33, align 4
  store i32 0, i32* %t34, align 4
  %t3 = load i32, i32* %t33, align 4
  %t4 = sdiv i32 %t3, 2
  store i32 %t4, i32* %t35, align 4
  br label %B36
B36:                               	; preds = %B32, %B37
  %t5 = load i32, i32* %t34, align 4
  %t6 = load i32, i32* %t35, align 4
  %t7 = sub i32 %t5, %t6
  %t8 = icmp ne i32 %t7, 0
  br i1 %t8, label %B37, label %B41
B37:                               	; preds = %B36
  %t10 = load i32, i32* %t35, align 4
  store i32 %t10, i32* %t34, align 4
  %t12 = load i32, i32* %t34, align 4
  %t13 = load i32, i32* %t33, align 4
  %t14 = load i32, i32* %t34, align 4
  %t15 = sdiv i32 %t13, %t14
  %t16 = add i32 %t12, %t15
  store i32 %t16, i32* %t35, align 4
  %t18 = load i32, i32* %t35, align 4
  %t19 = sdiv i32 %t18, 2
  store i32 %t19, i32* %t35, align 4
  br label %B36
B41:                               	; preds = %B36
  br label %B38
B38:                               	; preds = %B41
  %t20 = load i32, i32* %t35, align 4
  ret i32 %t20
}
define i32 @main() {
B42:
  %t44 = alloca i32, align 4
  %t43 = alloca i32, align 4
  store i32 400, i32* %t43, align 4
  %t25 = load i32, i32* %t43, align 4
  %t26 = call i32 @fsqrt(i32 %t25)
  store i32 %t26, i32* %t44, align 4
  %t27 = load i32, i32* %t44, align 4
  call void @putint(i32 %t27)
  store i32 10, i32* %t44, align 4
  %t30 = load i32, i32* %t44, align 4
  call void @putch(i32 %t30)
  ret i32 0
}
declare void @putint(i32)
declare void @putch(i32)
