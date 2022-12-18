@n = global i32 0, align 4
define i32 @gcd(i32 %m, i32 %n) {
B46:
  %t52 = alloca i32, align 4
  %t51 = alloca i32, align 4
  %t50 = alloca i32, align 4
  %t49 = alloca i32, align 4
  %t48 = alloca i32, align 4
  %t47 = alloca i32, align 4
  store i32 %m, i32* %t47, align 4
  store i32 %n, i32* %t48, align 4
  %t4 = load i32, i32* %t47, align 4
  store i32 %t4, i32* %t49, align 4
  %t6 = load i32, i32* %t48, align 4
  store i32 %t6, i32* %t50, align 4
  %t9 = load i32, i32* %t47, align 4
  %t10 = load i32, i32* %t48, align 4
  %t11 = icmp slt i32 %t9, %t10
  br i1 %t11, label %B53, label %B57
B53:                               	; preds = %B46
  %t13 = load i32, i32* %t47, align 4
  store i32 %t13, i32* %t51, align 4
  %t15 = load i32, i32* %t48, align 4
  store i32 %t15, i32* %t47, align 4
  %t17 = load i32, i32* %t51, align 4
  store i32 %t17, i32* %t48, align 4
  br label %B54
B57:                               	; preds = %B46
  br label %B54
B54:                               	; preds = %B53, %B57
  %t19 = load i32, i32* %t47, align 4
  %t20 = load i32, i32* %t48, align 4
  %t21 = srem i32 %t19, %t20
  store i32 %t21, i32* %t52, align 4
  br label %B58
B58:                               	; preds = %B54, %B59
  %t22 = load i32, i32* %t52, align 4
  %t23 = icmp ne i32 %t22, 0
  br i1 %t23, label %B59, label %B63
B59:                               	; preds = %B58
  %t25 = load i32, i32* %t48, align 4
  store i32 %t25, i32* %t47, align 4
  %t27 = load i32, i32* %t52, align 4
  store i32 %t27, i32* %t48, align 4
  %t29 = load i32, i32* %t47, align 4
  %t30 = load i32, i32* %t48, align 4
  %t31 = srem i32 %t29, %t30
  store i32 %t31, i32* %t52, align 4
  br label %B58
B63:                               	; preds = %B58
  br label %B60
B60:                               	; preds = %B63
  %t32 = load i32, i32* %t49, align 4
  %t33 = load i32, i32* %t50, align 4
  %t34 = mul i32 %t32, %t33
  %t35 = load i32, i32* %t48, align 4
  %t36 = sdiv i32 %t34, %t35
  ret i32 %t36
}
define i32 @main() {
B64:
  %t66 = alloca i32, align 4
  %t65 = alloca i32, align 4
  %t40 = call i32 @getint()
  store i32 %t40, i32* %t65, align 4
  %t42 = call i32 @getint()
  store i32 %t42, i32* %t66, align 4
  %t43 = load i32, i32* %t65, align 4
  %t44 = load i32, i32* %t66, align 4
  %t45 = call i32 @gcd(i32 %t43, i32 %t44)
  ret i32 %t45
}
declare i32 @getint()
