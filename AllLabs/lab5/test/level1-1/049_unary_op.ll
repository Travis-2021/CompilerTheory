define i32 @main() {
B18:
  %t19 = alloca i32, align 4
  store i32 10, i32* %t19, align 4
  %t2 = load i32, i32* %t19, align 4
  %t14 = icmp ne i32 %t2, 0
  %t3 = xor i1 %t14, 1
  %t4 = xor i1 %t3, 1
  %t15 = icmp ne i1 %t4, 0
  %t5 = xor i1 %t15, 1
  %t16 = zext i1 %t5 to i32
  %t6 = sub i32 0, %t16
  %t17 = icmp ne i32 %t6, 0
  br i1 %t17, label %B20, label %B25
B20:                               	; preds = %B18
  %t9 = sub i32 0, 1
  %t10 = sub i32 0, %t9
  %t11 = sub i32 0, %t10
  store i32 %t11, i32* %t19, align 4
  br label %B22
B25:                               	; preds = %B18
  br label %B21
B22:                               	; preds = %B20, %B21
  %t13 = load i32, i32* %t19, align 4
  ret i32 %t13
B21:                               	; preds = %B25
  store i32 0, i32* %t19, align 4
  br label %B22
}
