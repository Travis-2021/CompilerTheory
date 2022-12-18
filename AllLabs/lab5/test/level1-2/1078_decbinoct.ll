define i32 @dec2bin(i32 %a) {
B37:
  %t42 = alloca i32, align 4
  %t41 = alloca i32, align 4
  %t40 = alloca i32, align 4
  %t39 = alloca i32, align 4
  %t38 = alloca i32, align 4
  store i32 %a, i32* %t38, align 4
  store i32 0, i32* %t39, align 4
  store i32 1, i32* %t40, align 4
  %t7 = load i32, i32* %t38, align 4
  store i32 %t7, i32* %t42, align 4
  br label %B43
B43:                               	; preds = %B37, %B44
  %t8 = load i32, i32* %t42, align 4
  %t9 = icmp ne i32 %t8, 0
  br i1 %t9, label %B44, label %B48
B44:                               	; preds = %B43
  %t11 = load i32, i32* %t42, align 4
  %t12 = srem i32 %t11, 2
  store i32 %t12, i32* %t41, align 4
  %t14 = load i32, i32* %t40, align 4
  %t15 = load i32, i32* %t41, align 4
  %t16 = mul i32 %t14, %t15
  %t17 = load i32, i32* %t39, align 4
  %t18 = add i32 %t16, %t17
  store i32 %t18, i32* %t39, align 4
  %t20 = load i32, i32* %t40, align 4
  %t21 = mul i32 %t20, 10
  store i32 %t21, i32* %t40, align 4
  %t23 = load i32, i32* %t42, align 4
  %t24 = sdiv i32 %t23, 2
  store i32 %t24, i32* %t42, align 4
  br label %B43
B48:                               	; preds = %B43
  br label %B45
B45:                               	; preds = %B48
  %t25 = load i32, i32* %t39, align 4
  ret i32 %t25
}
define i32 @main() {
B49:
  %t51 = alloca i32, align 4
  %t50 = alloca i32, align 4
  store i32 400, i32* %t50, align 4
  %t30 = load i32, i32* %t50, align 4
  %t31 = call i32 @dec2bin(i32 %t30)
  store i32 %t31, i32* %t51, align 4
  %t32 = load i32, i32* %t51, align 4
  call void @putint(i32 %t32)
  store i32 10, i32* %t51, align 4
  %t35 = load i32, i32* %t51, align 4
  call void @putch(i32 %t35)
  ret i32 0
}
declare void @putint(i32)
declare void @putch(i32)
