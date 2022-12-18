define i32 @deepWhileBr(i32 %a, i32 %b) {
B31:
  %t52 = alloca i32, align 4
  %t41 = alloca i32, align 4
  %t34 = alloca i32, align 4
  %t33 = alloca i32, align 4
  %t32 = alloca i32, align 4
  store i32 %a, i32* %t32, align 4
  store i32 %b, i32* %t33, align 4
  %t2 = load i32, i32* %t32, align 4
  %t3 = load i32, i32* %t33, align 4
  %t4 = add i32 %t2, %t3
  store i32 %t4, i32* %t34, align 4
  br label %B35
B35:                               	; preds = %B31, %B43
  %t5 = load i32, i32* %t34, align 4
  %t6 = icmp slt i32 %t5, 75
  br i1 %t6, label %B36, label %B40
B36:                               	; preds = %B35
  store i32 42, i32* %t41, align 4
  %t9 = load i32, i32* %t34, align 4
  %t10 = icmp slt i32 %t9, 100
  br i1 %t10, label %B42, label %B46
B40:                               	; preds = %B35
  br label %B37
B42:                               	; preds = %B36
  %t12 = load i32, i32* %t34, align 4
  %t13 = load i32, i32* %t41, align 4
  %t14 = add i32 %t12, %t13
  store i32 %t14, i32* %t34, align 4
  %t15 = load i32, i32* %t34, align 4
  %t16 = icmp sgt i32 %t15, 99
  br i1 %t16, label %B47, label %B51
B46:                               	; preds = %B36
  br label %B43
B37:                               	; preds = %B40
  %t25 = load i32, i32* %t34, align 4
  ret i32 %t25
B47:                               	; preds = %B42
  %t19 = load i32, i32* %t41, align 4
  %t20 = mul i32 %t19, 2
  store i32 %t20, i32* %t52, align 4
  %t21 = icmp eq i32 1, 1
  br i1 %t21, label %B53, label %B57
B51:                               	; preds = %B42
  br label %B48
B43:                               	; preds = %B46, %B48
  br label %B35
B53:                               	; preds = %B47
  %t23 = load i32, i32* %t52, align 4
  %t24 = mul i32 %t23, 2
  store i32 %t24, i32* %t34, align 4
  br label %B54
B57:                               	; preds = %B47
  br label %B54
B48:                               	; preds = %B51, %B54
  br label %B43
B54:                               	; preds = %B53, %B57
  br label %B48
}
define i32 @main() {
B58:
  %t59 = alloca i32, align 4
  store i32 2, i32* %t59, align 4
  %t28 = load i32, i32* %t59, align 4
  %t29 = load i32, i32* %t59, align 4
  %t30 = call i32 @deepWhileBr(i32 %t28, i32 %t29)
  ret i32 %t30
}
