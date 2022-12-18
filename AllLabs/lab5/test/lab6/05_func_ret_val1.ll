define void @func(i32 %a) {
B5:
  %t6 = alloca i32, align 4
  store i32 %a, i32* %t6, align 4
  %t1 = load i32, i32* %t6, align 4
  %t2 = add i32 %t1, 1
  store i32 %t2, i32* %t6, align 4
  %t3 = load i32, i32* %t6, align 4
  ret i32 %t3
}
define i32 @main() {
B7:
  call void @func(i32 1)
  ret i32 0
}
