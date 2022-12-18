@s = global i32 0, align 4
define i32 @get_ans_se(i32 %ans, i32 %v0, i32 %v1) {
B178:
  %t182 = alloca i32, align 4
  %t181 = alloca i32, align 4
  %t180 = alloca i32, align 4
  %t179 = alloca i32, align 4
  store i32 %ans, i32* %t179, align 4
  store i32 %v0, i32* %t180, align 4
  store i32 %v1, i32* %t181, align 4
  store i32 0, i32* %t182, align 4
  %t2 = load i32, i32* %t180, align 4
  %t3 = load i32, i32* %t181, align 4
  %t4 = icmp eq i32 %t2, %t3
  br i1 %t4, label %B183, label %B187
B183:                               	; preds = %B178
  store i32 1, i32* %t182, align 4
  br label %B184
B187:                               	; preds = %B178
  br label %B184
B184:                               	; preds = %B183, %B187
  %t7 = load i32, i32* %t179, align 4
  %t8 = mul i32 %t7, 2
  store i32 %t8, i32* %t179, align 4
  %t10 = load i32, i32* %t179, align 4
  %t11 = load i32, i32* %t182, align 4
  %t12 = add i32 %t10, %t11
  store i32 %t12, i32* %t179, align 4
  %t14 = load i32, i32* @s, align 4
  %t15 = load i32, i32* %t179, align 4
  %t16 = add i32 %t14, %t15
  store i32 %t16, i32* @s, align 4
  %t17 = load i32, i32* %t179, align 4
  ret i32 %t17
}
define i32 @get_ans(i32 %ans, i32 %v0, i32 %v1) {
B188:
  %t192 = alloca i32, align 4
  %t191 = alloca i32, align 4
  %t190 = alloca i32, align 4
  %t189 = alloca i32, align 4
  store i32 %ans, i32* %t189, align 4
  store i32 %v0, i32* %t190, align 4
  store i32 %v1, i32* %t191, align 4
  store i32 0, i32* %t192, align 4
  %t19 = load i32, i32* %t190, align 4
  %t20 = load i32, i32* %t191, align 4
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %B193, label %B197
B193:                               	; preds = %B188
  store i32 1, i32* %t192, align 4
  br label %B194
B197:                               	; preds = %B188
  br label %B194
B194:                               	; preds = %B193, %B197
  %t24 = load i32, i32* %t189, align 4
  %t25 = mul i32 %t24, 2
  store i32 %t25, i32* %t189, align 4
  %t27 = load i32, i32* %t189, align 4
  %t28 = load i32, i32* %t192, align 4
  %t29 = add i32 %t27, %t28
  store i32 %t29, i32* %t189, align 4
  %t30 = load i32, i32* %t189, align 4
  ret i32 %t30
}
define i32 @main() {
B198:
  %t207 = alloca i32, align 4
  %t206 = alloca i32, align 4
  %t205 = alloca i32, align 4
  %t204 = alloca i32, align 4
  %t203 = alloca i32, align 4
  %t202 = alloca i32, align 4
  %t201 = alloca i32, align 4
  %t200 = alloca i32, align 4
  %t199 = alloca i32, align 4
  %t31 = sub i32 0, -2147483648
  store i32 %t31, i32* %t199, align 4
  store i32 -2147483648, i32* %t200, align 4
  %t34 = add i32 -2147483648, 1
  store i32 %t34, i32* %t201, align 4
  store i32 2147483647, i32* %t202, align 4
  %t37 = sub i32 2147483647, 1
  store i32 %t37, i32* %t203, align 4
  %t44 = load i32, i32* %t199, align 4
  %t45 = load i32, i32* %t200, align 4
  %t46 = call i32 @get_ans(i32 0, i32 %t44, i32 %t45)
  store i32 %t46, i32* %t204, align 4
  %t48 = load i32, i32* %t204, align 4
  %t49 = load i32, i32* %t199, align 4
  %t50 = add i32 %t49, 1
  %t51 = load i32, i32* %t201, align 4
  %t52 = call i32 @get_ans(i32 %t48, i32 %t50, i32 %t51)
  store i32 %t52, i32* %t204, align 4
  %t54 = load i32, i32* %t204, align 4
  %t55 = load i32, i32* %t199, align 4
  %t56 = load i32, i32* %t202, align 4
  %t57 = sub i32 0, %t56
  %t58 = sub i32 %t57, 1
  %t59 = call i32 @get_ans(i32 %t54, i32 %t55, i32 %t58)
  store i32 %t59, i32* %t204, align 4
  %t61 = load i32, i32* %t204, align 4
  %t62 = load i32, i32* %t199, align 4
  %t63 = load i32, i32* %t203, align 4
  %t64 = add i32 %t63, 1
  %t65 = call i32 @get_ans(i32 %t61, i32 %t62, i32 %t64)
  store i32 %t65, i32* %t204, align 4
  %t67 = load i32, i32* %t204, align 4
  %t68 = load i32, i32* %t200, align 4
  %t69 = sdiv i32 %t68, 2
  %t70 = load i32, i32* %t201, align 4
  %t71 = sdiv i32 %t70, 2
  %t72 = call i32 @get_ans(i32 %t67, i32 %t69, i32 %t71)
  store i32 %t72, i32* %t204, align 4
  %t74 = load i32, i32* %t204, align 4
  %t75 = load i32, i32* %t200, align 4
  %t76 = load i32, i32* %t202, align 4
  %t77 = sub i32 0, %t76
  %t78 = sub i32 %t77, 1
  %t79 = call i32 @get_ans(i32 %t74, i32 %t75, i32 %t78)
  store i32 %t79, i32* %t204, align 4
  %t81 = load i32, i32* %t204, align 4
  %t82 = load i32, i32* %t200, align 4
  %t83 = load i32, i32* %t203, align 4
  %t84 = add i32 %t83, 1
  %t85 = call i32 @get_ans(i32 %t81, i32 %t82, i32 %t84)
  store i32 %t85, i32* %t204, align 4
  %t87 = load i32, i32* %t201, align 4
  %t88 = load i32, i32* %t202, align 4
  %t89 = call i32 @get_ans(i32 0, i32 %t87, i32 %t88)
  store i32 %t89, i32* %t205, align 4
  %t91 = load i32, i32* %t205, align 4
  %t92 = load i32, i32* %t201, align 4
  %t93 = load i32, i32* %t203, align 4
  %t94 = call i32 @get_ans(i32 %t91, i32 %t92, i32 %t93)
  store i32 %t94, i32* %t205, align 4
  %t96 = load i32, i32* %t205, align 4
  %t97 = load i32, i32* %t202, align 4
  %t98 = load i32, i32* %t203, align 4
  %t99 = call i32 @get_ans(i32 %t96, i32 %t97, i32 %t98)
  store i32 %t99, i32* %t205, align 4
  %t101 = load i32, i32* %t205, align 4
  %t102 = load i32, i32* %t199, align 4
  %t103 = sdiv i32 %t102, 2
  %t104 = load i32, i32* %t200, align 4
  %t105 = sdiv i32 %t104, 2
  %t106 = call i32 @get_ans(i32 %t101, i32 %t103, i32 %t105)
  store i32 %t106, i32* %t205, align 4
  %t108 = load i32, i32* %t199, align 4
  %t109 = load i32, i32* %t200, align 4
  %t110 = call i32 @get_ans_se(i32 0, i32 %t108, i32 %t109)
  store i32 %t110, i32* %t206, align 4
  %t112 = load i32, i32* %t206, align 4
  %t113 = load i32, i32* %t199, align 4
  %t114 = add i32 %t113, 1
  %t115 = load i32, i32* %t201, align 4
  %t116 = call i32 @get_ans_se(i32 %t112, i32 %t114, i32 %t115)
  store i32 %t116, i32* %t206, align 4
  %t118 = load i32, i32* %t206, align 4
  %t119 = load i32, i32* %t199, align 4
  %t120 = load i32, i32* %t202, align 4
  %t121 = sub i32 0, %t120
  %t122 = sub i32 %t121, 1
  %t123 = call i32 @get_ans_se(i32 %t118, i32 %t119, i32 %t122)
  store i32 %t123, i32* %t206, align 4
  %t125 = load i32, i32* %t206, align 4
  %t126 = load i32, i32* %t199, align 4
  %t127 = load i32, i32* %t203, align 4
  %t128 = add i32 %t127, 1
  %t129 = call i32 @get_ans_se(i32 %t125, i32 %t126, i32 %t128)
  store i32 %t129, i32* %t206, align 4
  %t131 = load i32, i32* %t206, align 4
  %t132 = load i32, i32* %t200, align 4
  %t133 = sdiv i32 %t132, 2
  %t134 = load i32, i32* %t201, align 4
  %t135 = sdiv i32 %t134, 2
  %t136 = call i32 @get_ans_se(i32 %t131, i32 %t133, i32 %t135)
  store i32 %t136, i32* %t206, align 4
  %t138 = load i32, i32* %t206, align 4
  %t139 = load i32, i32* %t200, align 4
  %t140 = load i32, i32* %t202, align 4
  %t141 = sub i32 0, %t140
  %t142 = sub i32 %t141, 1
  %t143 = call i32 @get_ans_se(i32 %t138, i32 %t139, i32 %t142)
  store i32 %t143, i32* %t206, align 4
  %t145 = load i32, i32* %t206, align 4
  %t146 = load i32, i32* %t200, align 4
  %t147 = load i32, i32* %t203, align 4
  %t148 = add i32 %t147, 1
  %t149 = call i32 @get_ans_se(i32 %t145, i32 %t146, i32 %t148)
  store i32 %t149, i32* %t206, align 4
  %t151 = load i32, i32* %t201, align 4
  %t152 = load i32, i32* %t202, align 4
  %t153 = call i32 @get_ans_se(i32 0, i32 %t151, i32 %t152)
  store i32 %t153, i32* %t207, align 4
  %t155 = load i32, i32* %t207, align 4
  %t156 = load i32, i32* %t201, align 4
  %t157 = load i32, i32* %t203, align 4
  %t158 = call i32 @get_ans_se(i32 %t155, i32 %t156, i32 %t157)
  store i32 %t158, i32* %t207, align 4
  %t160 = load i32, i32* %t207, align 4
  %t161 = load i32, i32* %t202, align 4
  %t162 = load i32, i32* %t203, align 4
  %t163 = call i32 @get_ans_se(i32 %t160, i32 %t161, i32 %t162)
  store i32 %t163, i32* %t207, align 4
  %t165 = load i32, i32* %t207, align 4
  %t166 = load i32, i32* %t199, align 4
  %t167 = sdiv i32 %t166, 2
  %t168 = load i32, i32* %t200, align 4
  %t169 = sdiv i32 %t168, 2
  %t170 = call i32 @get_ans_se(i32 %t165, i32 %t167, i32 %t169)
  store i32 %t170, i32* %t207, align 4
  %t171 = load i32, i32* %t204, align 4
  %t172 = load i32, i32* %t205, align 4
  %t173 = add i32 %t171, %t172
  %t174 = load i32, i32* %t206, align 4
  %t175 = add i32 %t173, %t174
  %t176 = load i32, i32* %t207, al