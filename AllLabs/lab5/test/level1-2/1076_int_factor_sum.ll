@N = global i32 0, align 4
@newline = global i32 0, align 4
define i32 @factor(i32 %n) {
B30:
  %t33 = alloca i32, align 4
  %t32 = alloca i32, align 4
  %t31 = alloca i32, align 4
  store i32 %n, i32* %t31, align 4
  store i32 0, i32* %t33, align 4
  store i32 1, i32* %t32, align 4
  br label %B34
B34:                               	; preds = %B30, %B41
  %t6 = load i32, i32* %t32, align 4
  %t7 = load i32, i32* %t31, align 4
  %t8 = add i32 %t7, 1
  %t9 = icmp slt i32 %t6, %t8
  br i1 %t9, label %B35, label %B39
B35:                               	; preds = %B34
  %t10 = load i32, i32* %t31, align 4
  %t11 = load i32, i32* %t32, align 4
  %t12 = srem i32 %t10, %t11
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %B40, label %B44
B39:                               	; preds = %B34
  br label %B36
B40:                               	; preds = %B35
  %t15 = load i32, i32* %t33, align 4
  %t16 = load i32, i32* %t32, align 4
  %t17 = add i32 %t15, %t16
  store i32 %t17, i32* %t33, align 4
  br label %B41
B44:                               	; preds = %B35
  br label %B41
B36:                               	; preds = %B39
  %t21 = load i32, i32* %t33, align 4
  ret i32 %t21
B41:                               	; preds = %B40, %B44
  %t19 = load i32, i32* %t32, align 4
  %t20 = add i32 %t19, 1
  store i32 %t20, i32* %t32, align 4
  br label %B34
}
define i32 @main() {
B45:
  %t48 = alloca i32, align 4
  %t47 = alloca i32, align 4
  %t46 = alloca i32, align 4
  store i32 4, i32* @N, align 4
  store i32 10, i32* @newline, align 4
  store i32 1478, i32* %t47, align 4
  %t28 = load i32, i32* %t47, align 4
  %t29 = call i32 @factor(i32 %t28)
  ret i32 %t29
}
