	.text
	.align	1
	.global	arrMax
	.type	arrMax, %function
arrMax:

	push	{r7}		@ 保存r7
	@ 扩展栈
	sub	sp, sp, #20		
	add	r7, sp, #0		@ sp => r7
	@ 从sp开始存数，依次是arr,max,i
	str	r0, [r7, #4]	@ r0 => [r7+4]		r0存储arr地址
	ldr	r3, [r7, #4]	@ [r7+4] => r3
	ldr	r3, [r3]		@ [r3]=>r3			(max=arr[0])
	str	r3, [r7, #8]	@ r3 => [r7+8]
	movs	r3, #0		@ r3 = 0
	str	r3, [r7, #12]	@ r3 => [r7+12]		(i=0)
	b	.L2	
.L4:	@ while循环体内
	@ 执行if(arr[i]>max)
	ldr	r3, [r7, #12]	@ i => r3
	lsls	r3, r3, #2	@ i = i*4  
	ldr	r2, [r7, #4]	@ arr => r2
	add	r3, r3, r2		@ arr+i =>r3
	ldr	r3, [r3]		@ arr[i] =>r3
	ldr	r2, [r7, #8]	@ max => r2
	cmp	r2, r3			@ max,arr[i]比较
	bge	.L3				@ max>=arr[i]就 跳.L3 (跳过if语句)
	@ 条件成立；执行max = arr[i];
	ldr	r3, [r7, #12]	@ i => r3
	lsls	r3, r3, #2	@ i = i*4
	ldr	r2, [r7, #4]	@ arr => r2
	add	r3, r3, r2		@ arr+i =>r3
	ldr	r3, [r3]		@ arr[i] =>r3 
	str	r3, [r7, #8]	@ r3 => max
.L3:	
	@ 条件不成立；执行i++
	ldr	r3, [r7, #12]	@ i => r3
	adds	r3, r3, #1	@ i++;
	str	r3, [r7, #12]	@ 存入i
.L2:
	@ 执行判断i<5?
	ldr	r3, [r7, #12]	@ i => r3
	cmp	r3, #4			@ i与4比较
	@ 条件成立，跳到.L4
	ble	.L4	
	@ 不成立，继续
	ldr	r3, [r7, #8]	@ max => r3
	mov	r0, r3			@ r3 => r0
	@ 恢复栈
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4	@ 将r7值恢复
	bx	lr
	.size	arrMax, .-arrMax
	.section	.rodata
	.align	2
.LC1:
	.ascii	"\346\225\260\347\273\204\344\270\255\346\234\200\345"
	.ascii	"\244\247\345\200\274\344\270\272:%d\012\000"
	.align	2
.LC0:
	.word	2
	.word	1
	.word	4
	.word	5
	.word	3
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	push	{r4, r5, r7, lr}
	@ 扩展栈
	sub	sp, sp, #32		
	add	r7, sp, #0
	ldr	r2, .L9			@ r2 = GOT-(LPIC2+4)
.LPIC2:
	add	r2, pc			@ r2 = GOT
	ldr	r3, .L9+4		@ r3 = __stack_chk_guard(GOT)
	ldr	r3, [r2, r3]	@ [r2+r3] => r3
	ldr	r3, [r3]		@ [r3] => r3
	str	r3, [r7, #28]	@ 将[r3] => [r7+28]
	mov	r3, #0
	ldr	r3, .L9+8		@ r3 = .LC0-(.LPIC0+4)
.LPIC0:
	add	r3, pc			@ r3 = .LC0
	add	r4, r7, #8		@ r7+8 => r4
	mov	r5, r3			@ r3 => r5
	@ .LC0对应arr[0-4]放入栈
	ldmia	r5!, {r0, r1, r2, r3}	
	stmia	r4!, {r0, r1, r2, r3}	
	ldr	r3, [r5]
	str	r3, [r4]

	add	r3, r7, #8
	mov	r0, r3
	bl	arrMax(PLT)		@ PLT???
	str	r0, [r7, #4]
	ldr	r1, [r7, #4]
	ldr	r3, .L9+12		@ r3 = .LC1-(.LPIC1+4)
.LPIC1:
	add	r3, pc			@ r3 = .LC1
	mov	r0, r3			@ r0 = r3
	bl	printf(PLT)
	movs	r3, #0
	ldr	r1, .L9+16		@ r1 = _GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
.LPIC3:
	add	r1, pc			@ r1 = GOT
	ldr	r2, .L9+4		@ r2 = __stack_chk_guard(GOT)
	ldr	r2, [r1, r2]	@ [r1+r2] => r2
	ldr	r1, [r2]		@ [r2] => r1
	ldr	r2, [r7, #28]	@ [r7+28] => r2
	eors	r1, r2, r1	@ ???
	mov	r2, #0
	beq	.L8
	bl	__stack_chk_fail(PLT)
.L8:
	@ 恢复栈结构
	mov	r0, r3
	adds	r7, r7, #32
	mov	sp, r7
	@ sp needed
	pop	{r4, r5, r7, pc}
.L10:
	.align	2
.L9:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC2+4)
	.word	__stack_chk_guard(GOT)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)


