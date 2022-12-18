@a = global i32 0, align 4
define i32 @func(i32 %p) {
B11:
  %t12 = alloca i32, align 4
  store i32 %p, i32* %t12, align 4
  %t2 = load i32, i32* %t12, align 4
  %t3 = sub i32 %t2, 1
  store i32 %t3, i32* %t12, align 4
  %t4 = load i32, i32* %t12, align 4
  ret i32 %t4
}
define i32 @main() {
B13:
  %t14 = alloca i32, align 4
  store i32 10, i32* @a, align 4
  %t8 = load i32, i32* @a, align 4
  %t9 = call i32 @func(i32 %t8)
  store i32 %t9, i32* %t14, align 4
  %t10 = load i32, i32* %t14, align 4
  ret i32 %t10
}
