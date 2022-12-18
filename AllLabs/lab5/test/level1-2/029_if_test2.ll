define i32 @ifElseIf() {
B32:
  %t34 = alloca i32, align 4
  %t33 = alloca i32, align 4
  store i32 5, i32* %t33, align 4
  store i32 10, i32* %t34, align 4
  %t4 = load i32, i32* %t33, align 4
  %t5 = icmp eq i32 %t4, 6
  br i1 %t5, label %B35, label %B41
B35:                               	; preds = %B32, %B38
  %t9 = load i32, i32* %t33, align 4
  ret i32 %t9
B41:                               	; preds = %B32
  br label %B38
B37:                               	; preds = %B35, %B47
  %t29 = load i32, i32* %t33, align 4
  ret i32 %t29
B38:                               	; preds = %B41
  %t6 = load i32, i32* %t34, align 4
  %t7 = icmp eq i32 %t6, 11
  br i1 %t7, label %B35, label %B44
B44:                               	; preds = %B38
  br label %B36
B36:                               	; preds = %B44
  %t10 = load i32, i32* %t34, align 4
  %t11 = icmp eq i32 %t10, 10
  br i1 %t11, label %B48, label %B51
B48:                               	; preds = %B36
  %t12 = load i32, i32* %t33, align 4
  %t13 = icmp eq i32 %t12, 1
  br i1 %t13, label %B45, label %B54
B51:                               	; preds = %B36
  br label %B46
B45:                               	; preds = %B48
  store i32 25, i32* %t33, align 4
  br label %B47
B54:                               	; preds = %B48
  br label %B46
B46:                               	; preds = %B51, %B54
  %t16 = load i32, i32* %t34, align 4
  %t17 = icmp eq i32 %t16, 10
  br i1 %t17, label %B58, label %B61
B47:                               	; preds = %B45, %B57
  br label %B37
B58:                               	; preds = %B46
  %t18 = load i32, i32* %t33, align 4
  %t19 = sub i32 0, 5
  %t20 = icmp eq i32 %t18, %t19
  br i1 %t20, label %B55, label %B64
B61:                               	; preds = %B46
  br label %B56
B55:                               	; preds = %B58
  %t23 = load i32, i32* %t33, align 4
  %t24 = add i32 %t23, 15
  store i32 %t24, i32* %t33, align 4
  br label %B57
B64:                               	; preds = %B58
  br label %B56
B56:                               	; preds = %B61, %B64
  %t26 = load i32, i32* %t33, align 4
  %t28 = sub i32 0, %t26
  store i32 %t28, i32* %t33, align 4
  br label %B57
B57:                               	; preds = %B55, %B56
  br label %B47
}
define i32 @main() {
B65:
  %t30 = call i32 @ifElseIf()
  call void @putint(i32 %t30)
  ret i32 0
}
declare void @putint(i32)
