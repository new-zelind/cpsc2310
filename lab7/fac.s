	.global	fact
fact:
    push  {r1, lr}        

    cmp   r0, #1          
    beq   done            

    mov  r1, r0           
    sub  r0, r0, #1       
    bl   fact             

    mul  r0, r1, r0       

done:
    pop  {r1, pc}         
    .size    fact, .-fact

    .align   2
    .section .rodata
fmt_str:
    .ascii   "The factorial of %d is %d\012\000"

    .text
    .align   2
    .global  main
main:
   push {lr}			   @ save the link register so we can jump back to 
	
   mov r0, #10			   @ this is the actual number we're taking the
						   @ factorial of
   mov r3, r0
   bl fact				   @ move to the 'fact' branch to execute the
						   @ factorial function
   mov r2, r0
   mov r1, r3			   
   ldr r0, =fmt_str		   @ put the address of the print string into r0
   bl printf			   @ branch to printf function
   mov r0, #0			   @ return 0;
   

    pop  {pc}             @ pop the top of the stack

	.size    main, .-main
	.ident   "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section .note.GNU-stack,"",%progbits
