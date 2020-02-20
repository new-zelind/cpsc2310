// Zach Lindler
// CPSC 2321, Sec 2

    .file "sum.s"
    .text
    .align  2
    .global main
    .type   main, %function

/* main() sums 10 values from stdin and prints the sum */
main:
    push {lr}    // save lr
    
    sub sp, sp, #40
	mov r4, sp
	mov r5, #1

	loop:
		 cmp r5, #10
		 bgt finishloop
		 ldr r0, =rdfmt
		 mov r1, r4
		 bl scanf
		 add r4, r4, #4
		 add r5, r5, #1
		 b loop

    finishloop:
		 mov r2, #0
		 mov r3, #0
		 mov r5, #1

    second:
		 cmp r5, #10
		 bgt done
		 ldr r1, [sp, r3]
		 add r2, r2, r1
		 add r3, r3, #4
		 add r5, r5, #1
		 b second

    done:
		 add sp, sp, #40
		 ldr r0, =prtfmt
		 mov r1, r2
		 bl printf

    pop {pc}         // put lr in pc    

.section    .rodata
    rdfmt:        .asciz "%d"
    prtfmt:       .asciz "sum is %d\n"
