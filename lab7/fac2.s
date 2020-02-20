	.global	fact
fact:
	mov   r1, #1        

here:
	cmp   r0, #1        
	beq   there         

	mul   r1, r0, r1    
	sub   r0, r0, #1    
	b     here          

there:
	mov   r0, r1        

	bx    lr

	.size	fact, .-fact

	.align   2
	.section .rodata
fmt_str:
	.ascii  "The factorial of %d is %d\012\000"

	.text
	.align  2
	.global main
main:
	push  {lr}

	mov r0, #10			@ store the initial value in r0.
	bl fact				@ call the factorial function, move to that branch
	mov r2, r0
	mov r1, #10			
	ldr r0, =fmt_str	@ store the address of the print string into r0
	bl printf			@ call the print function, move to that branch
	mov r0, #0			@ return 0;

	pop  {pc}

	.size    main, .-main
	.ident   "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section .note.GNU-stack,"",%progbits
