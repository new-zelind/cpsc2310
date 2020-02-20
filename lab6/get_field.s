// Zach Lindler
// CPSC 2310
// Dr. Widman
// Lab 6 - get_field.s

   .global main

main:
	push {r7, lr}
	sub sp, sp, #16
	add r7, sp, #0

	ldr r0, =0x12345678       /* put the source value in r0 */
	ldr r2, =0x7              /* put the location of the field's lsb in r2 */
	ldr r3, =0x8              /* put the size of field in r3 */
	
/* Beginning of your code */
   mov r4, #1				  // put the number 1 in register 4
   lsl r4, r4, r3			  // shift the 1 in register 4 by the size of the field
							  // in r3
   sub r4, r4, #1			  // then, create an "array" of 1's that is the same
							  // length as the field.
   lsl r4, r4, r2			  // shift the bit mask by 'lsb' bits
   and r1, r4, r0			  // perform 'and' comparison for masking

   lsr r1, r1, r2			  // shift the resulting number right so that the
							  // lsb is at position 0
/* End of your code */

/* show output on screen */
    ldr r0, =prt_line	
	bl printf
	add r7, r7, #16
	mov sp, r7
	pop {r7, pc}

	.size main, .-main
	.section .rodata

prt_line: .asciz "0x%X\n"
