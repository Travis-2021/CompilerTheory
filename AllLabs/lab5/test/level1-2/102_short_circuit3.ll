@a = global i32 0, align 4
@b = global i32 0, align 4
@d = global i32 0, align 4
define i32 @set_a(i32 %val) {
B150:
  %t151 = alloca i32, align 4
  store i32 %val, i32* %t151, align 4
  %t4 = load i32, i32* %t151, align 4
  store i32 %t4, i32* @a, align 4
  %t5 = load i32, i32* @a, align 4
  ret i32 %t5
}
define i32 @set_b(i32 %val) {
B152:
  %t153 = alloca i32, align 4
  store i32 %val, i32* %t153, align 4
  %t7 = load i32, i32* %t153, align 4
  store i32 %t7, i32* @b, align 4
  %t8 = load i32, i32* @b, align 4
  ret i32 %t8
}
define i32 @set_d(i32 %val) {
B154:
  %t155 = alloca i32, align 4
  store i32 %val, i32* %t155, align 4
  %t10 = load i32, i32* %t155, align 4
  store i32 %t10, i32* @d, align 4
  %t11 = load i32, i32* @d, align 4
  ret i32 %t11
}
define i32 @main() {
B156:
  %t228 = alloca i32, align 4
  %t227 = alloca i32, align 4
  %t226 = alloca i32, align 4
  %t225 = alloca i32, align 4
  %t224 = alloca i32, align 4
  %t175 = alloca i32, align 4
  store i32 2, i32* @a, align 4
  store i32 3, i32* @b, align 4
  %t14 = call i32 @set_a(i32 0)
  %t131 = icmp ne i32 %t14, 0
  br i1 %t131, label %B159, label %B162
B159:                               	; preds = %B156
  %t15 = call i32 @set_b(i32 1)
  %t132 = icmp ne i32 %t15, 0
  br i1 %t132, label %B157, label %B165
B162:                               	; preds = %B156
  br label %B158
B157:                               	; preds = %B159
  br label %B158
B165:                               	; preds = %B159
  br label %B158
B158:                               	; preds = %B157, %B162, %B165
  %t17 = load i32, i32* @a, align 4
  call void @putint(i32 %t17)
  call void @putch(i32 32)
  %t20 = load i32, i32* @b, align 4
  call void @putint(i32 %t20)
  call void @putch(i32 32)
  store i32 2, i32* @a, align 4
  store i32 3, i32* @b, align 4
  %t25 = call i32 @set_a(i32 0)
  %t133 = icmp ne i32 %t25, 0
  br i1 %t133, label %B168, label %B171
B168:                               	; preds = %B158
  %t26 = call i32 @set_b(i32 1)
  %t134 = icmp ne i32 %t26, 0
  br i1 %t134, label %B166, label %B174
B171:                               	; preds = %B158
  br label %B167
B166:                               	; preds = %B168
  br label %B167
B174:                               	; preds = %B168
  br label %B167
B167:                               	; preds = %B166, %B171, %B174
  %t28 = load i32, i32* @a, align 4
  call void @putint(i32 %t28)
  call void @putch(i32 32)
  %t31 = load i32, i32* @b, align 4
  call void @putint(i32 %t31)
  call void @putch(i32 10)
  store i32 1, i32* %t175, align 4
  store i32 2, i32* @d, align 4
  %t36 = load i32, i32* %t175, align 4
  %t37 = icmp sge i32 %t36, 1
  br i1 %t37, label %B178, label %B181
B178:                               	; preds = %B167
  %t38 = call i32 @set_d(i32 3)
  %t135 = icmp ne i32 %t38, 0
  br i1 %t135, label %B176, label %B184
B181:                               	; preds = %B167
  br label %B177
B176:                               	; preds = %B178
  br label %B177
B184:                               	; preds = %B178
  br label %B177
B177:                               	; preds = %B176, %B181, %B184
  %t40 = load i32, i32* @d, align 4
  call void @putint(i32 %t40)
  call void @putch(i32 32)
  %t43 = load i32, i32* %t175, align 4
  %t44 = icmp sle i32 %t43, 1
  br i1 %t44, label %B185, label %B190
B185:                               	; preds = %B177, %B187
  br label %B186
B190:                               	; preds = %B177
  br label %B187
B186:                               	; preds = %B185, %B193
  %t47 = load i32, i32* @d, align 4
  call void @putint(i32 %t47)
  call void @putch(i32 10)
  %t50 = add i32 2, 1
  %t51 = sub i32 3, %t50
  %t52 = icmp sge i32 16, %t51
  br i1 %t52, label %B194, label %B198
B187:                               	; preds = %B190
  %t45 = call i32 @set_d(i32 4)
  %t136 = icmp ne i32 %t45, 0
  br i1 %t136, label %B185, label %B193
B194:                               	; preds = %B186
  call void @putch(i32 65)
  br label %B195
B198:                               	; preds = %B186
  br label %B195
B193:                               	; preds = %B187
  br label %B186
B195:                               	; preds = %B194, %B198
  %t54 = sub i32 25, 7
  %t55 = mul i32 6, 3
  %t56 = sub i32 36, %t55
  %t57 = icmp ne i32 %t54, %t56
  br i1 %t57, label %B199, label %B203
B199:                               	; preds = %B195
  call void @putch(i32 66)
  br label %B200
B203:                               	; preds = %B195
  br label %B200
B200:                               	; preds = %B199, %B203
  %t59 = icmp slt i32 1, 8
  %t137 = zext i1 %t59 to i32
  %t60 = srem i32 7, 2
  %t61 = icmp ne i32 %t137, %t60
  br i1 %t61, label %B204, label %B208
B204:                               	; preds = %B200
  call void @putch(i32 67)
  br label %B205
B208:                               	; preds = %B200
  br label %B205
B205:                               	; preds = %B204, %B208
  %t63 = icmp sgt i32 3, 4
  %t138 = zext i1 %t63 to i32
  %t64 = icmp eq i32 %t138, 0
  br i1 %t64, label %B209, label %B213
B209:                               	; preds = %B205
  call void @putch(i32 68)
  br label %B210
B213:                               	; preds = %B205
  br label %B210
B210:                               	; preds = %B209, %B213
  %t66 = icmp sle i32 102, 63
  %t139 = zext i1 %t66 to i32
  %t67 = icmp eq i32 1, %t139
  br i1 %t67, label %B214, label %B218
B214:                               	; preds = %B210
  call void @putch(i32 69)
  br label %B215
B218:                               	; preds = %B210
  br label %B215
B215:                               	; preds = %B214, %B218
  %t69 = sub i32 5, 6
  %t140 = icmp ne i32 0, 0
  %t70 = xor i1 %t140, 1
  %t141 = zext i1 %t70 to i32
  %t71 = sub i32 0, %t141
  %t72 = icmp eq i32 %t69, %t71
  br i1 %t72, label %B219, label %B223
B219:                               	; preds = %B215
  call void @putch(i32 70)
  br label %B220
B223:                               	; preds = %B215
  br label %B220
B220:                               	; preds = %B219, %B223
  call void @putch(i32 10)
  store i32 0, i32* %t224, align 4
  store i32 1, i32* %t225, align 4
  store i32 2, i32* %t226, align 4
  store i32 3, i32* %t227, align 4
  store i32 4, i32* %t228, align 4
  br label %B229
B229:                               	; preds = %B220, %B230
  %t80 = load i32, i32* %t224, align 4
  %t142 = icmp ne i32 %t80, 0
  br i1 %t142, label %B232, label %B235
B232:                               	; preds = %B229
  %t81 = load i32, i32* %t225, align 4
  %t143 = icmp ne i32 %t81, 0
  br i1 %t143, label %B230, label %B238
B235:                               	; preds = %B229
  br label %B231
B230:                               	; preds = %B232
  call void @putch(i32 32)
  br label %B229
B238:                               	; preds = %B232
  br label %B231
B231:                               	; preds = %B235, %B238
  %t84 = load i32, i32* %t224, align 4
  %t144 = icmp ne i32 %t84, 0
  br i1 %t144, label %B239, label %B244
B239:                               	; preds = %B231, %B241
  call void @putch(i32 67)
  br label %B240
B244:                               	; preds = %B231
  br label %B241
B240:                               	; preds = %B239, %B247
  %t88 = load i32, i32* %t224, align 4
  %t89 = load i32, i32* %t225, align 4
  %t90 = icmp sge i32 %t88, %t89
  br i1 %t90, label %B248, label %B253
B241:                               	; preds = %B244
  %t85 = load i32, i32* %t225, align 4
  %t145 = icmp ne i32 %t85, 0
  br i1 %t145, label %B239, label %B247
B248:                               	; preds = %B240, %B250
  call void @putch(i32 72)
  br label %B249
B253:                               	; preds = %B240
  br label %B250
B247:                               	; preds = %B241
  br label %B240
B249:                               	; preds = %B248, %B256
  %t96 = load i32, i32* %t226, align 4
  %t97 = load i32, i32* %t225, align 4
  %t98 = icmp sge i32 %t96, %t97
  br i1 %t98, label %B259, label %B262
B250:                               	; preds = %B253
  %t91 = load i32, i32* %t225, align 4
  %t92 = load i32, i32* %t224, align 4
  