define i32 @main() {
B31:
  %t33 = alloca i32, align 4
  %t32 = alloca i32, align 4
  store i32 56, i32* %t32, align 4
  store i32 4, i32* %t33, align 4
  %t5 = load i32, i32* %t32, align 4
  %t6 = sub i32 0, 4
  %t7 = sub i32 %t5, %t6
  %t8 = load i32, i32* %t33, align 4
  %t10 = add i32 %t7, %t8
  store i32 %t10, i32* %t32, align 4
  %t11 = load i32, i32* %t32, align 4
  %t27 = icmp ne i32 %t11, 0
  %t12 = xor i1 %t27, 1
  %t13 = xor i1 %t12, 1
  %t28 = icmp ne i1 %t13, 0
  %t14 = xor i1 %t28, 1
  %t29 = zext i1 %t14 to i32
  %t15 = sub i32 0, %t29
  %t30 = icmp ne i32 %t15, 0
  br i1 %t30, label %B34, label %B39
B34:                               	; preds = %B31
  %t18 = sub i32 0, 1
  %t19 = sub i32 0, %t18
  %t20 = sub i32 0, %t19
  store i32 %t20, i32* %t32, align 4
  br label %B36
B39:                               	; preds = %B31
  br label %B35
B36:                               	; preds = %B34, %B35
  %t25 = load i32, i32* %t32, align 4
  call void @putint(i32 %t25)
  ret i32 0
B35:                               	; preds = %B39
  %t22 = load i32, i32* %t33, align 4
  %t24 = add i32 0, %t22
  store i32 %t24, i32* %t32, align 4
  br label %B36
}
declare void @putint(i32)
