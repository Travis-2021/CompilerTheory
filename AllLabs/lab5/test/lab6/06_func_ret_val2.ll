define i32 @func(i32 %a, i32 %b) {
B5:
  %t8 = alloca i32, align 4
  %t7 = alloca i32, align 4
  %t6 = alloca i32, align 4
  store i32 %a, i32* %t6, align 4
  store i32 %b, i32* %t7, align 4
  %t0 = load i32, i32* %t6, align 4
  %t1 = load i32, i32* %t7, align 4
  %t2 = add i32 %t0, %t1
  store i32 %t2, i32* %t8, align 4
}
define i32 @main() {
B9:
  %t4 = call i32 @func(i32 1, i32 2)
  ret i32 0
}
