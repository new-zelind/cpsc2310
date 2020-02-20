@ Zach Lindler (zelindl)
@ CPSC 2310 - 002
@ Homework 4
@ Due Dec 6, 2019
@ This program is the ARM assembly implementation of the encrypt
@    and decrypt functions in main.c

.global hw4
.global encrypt
.global decrypt

encrypt:
   push	 {r4, r5, lr}
   mov	 r3, #0

   encryptLoop:
	  
	  ldrb	r4, [r0, r3]
	  cmp	r4, #0
	  beq	done

	  cmp	r4, #97
	  blt	specialChar

	  sub	r4, r4, #97
	  ldr	r5, [r1, r4]
	  strb	r5, [r2, r3]
	  add	r3, r3, #1
	  bal	encryptLoop

   eSpecialChar:
	  strb	r4, [r2, r3]
	  add	r3, r3, #1
	  bal	encryptLoop

   eDone:
	  mov	r5, #0
	  strb	r5, [r2, r3]
	  
	  pop	{r4, r5, pc}

decrypt:
   push	 {r4 - r8, lr}
   mov	 r3, #0

   decryptLoop:
	  ldrb	r4, [r0, r3]
	  cmp	r4, #0
	  beq	dDone

	  cmp	r4, #97
	  blt	dSpecialChar

	  cmp	r4, #122
	  bgt	dSpecialChar

	  mov	r7, #0

	  keyLoop:
		 ldrb  r8, [r1, r7]
		 cmp   r4, r8
		 beq   storeIt

		 add   r7, r7, #1
		 bal   keyLoop

		 storeIt:
			add	  r7, r7, #97
			strb  r7, [r2, r3]
			add	  r3, r3, #1

   bal	 decryptLoop

   dSpecialChar:
	  strb	r4, [r2, r3]
	  add	r3, r3, #1
	  bal	decryptLoop

   dDone:
	  mov	r5, #0
	  strb	r5, [r2, r3]

	  pop	{r4 - r8, pc}
