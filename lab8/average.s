//Zach Lindler
// CPSC 2311, Sec 2

   .file "average.s"
   .text
   .align 2
   .global	main
   .type	main, %function

main:
   push {lr}

   sub sp, sp, #64
   mov r4, sp
   mov r5, #1

   loop:
	  cmp r5, #16
	  bgt loopend
	  ldr r0, =rdfmt
	  mov r1, r4
	  bl scanf
	  add r4, r4, #4
	  add r5, r5, #1
	  b loop

   loopend:
	  mov r2, #0
	  mov r3, #0
	  mov r5, #1

   loop2:
	  cmp r5, #16
	  bgt done
	  ldr r1, [sp, r3]
	  add r2, r2, r1
	  add r3, r3, #4
	  add r5, r5, #1
	  b loop2

   done:
	  //PRINT
	  add sp, sp, #64
	  ldr r0, =prtfmt
	  mov r1, r2, lsr #4
	  bl printf

   pop {pc}

.section	.rodata
   rdfmt:		  .asciz "%d"
   prtfmt:		  .asciz "average is %d\n"
