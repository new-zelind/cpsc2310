@ Zach Lindler (zelindl)
@ CPSC 2310, Section 2
@ Programming Assignment 4
@ Due December 6

@ FUNCTION: encode

@ Description: This is the encode function specified in the main.c file.
@     It's purpose is to encode or decode a supplied string of characters
@     with a second parameter string.

@ Input parameters:
@    r0 - address of input string
@    r1 - address of output string
@    r2 - address of key string
@    r3 - encode/decode swtich
@        r3 == 0 means encode
@        r3 == 1 means decode

@ Return Value: void

@ Other output parameters: a string is passed in that will serve as the
@     encoded / decoded string.

@ Effect/Output: This function will result in an encoded or decoded string.

@ Method/Effect: Suppose the letters a-z are represented by integer numbers
@    1-26. This function adds the integer representations of the letters
@    and converts them back to letters based on the resulting integer. These
@    make the encoded string. For decoding, does the same as the encoding
@    function, but backwards.

@ Typical Calling Sequence:
@    put address of the input string in r0
@    put address of the output string in r1
@    put address of the key string in r2
@    put the encode/decode switch in r3

@ Register usage:
@    r0 = pointer to input string
@    r1 = pointer to output string
@    r2 = pointer to key string
@    r3 = switch integer
@    r4 = character iterator for input string
@    r5 = character iterator for key string
@    r6 = current input letter
@    r7 = current key letter

.text
   .global encode

encode:
   
   @ at the beginning, load registers 4 - 7.
   @ Then, initialize the string iterators in 4 and 5.
   @ Check to see if r3 is 0 or 1; on a 0, continue with the encode sequence.
   @ On a 1, branch to the decode sequence.
   push	 {r4 - r7, lr}

   mov	 r4, #0	  
   mov	 r5, #0

   cmp	 r3, #0
   bgt	 decode

   @  The general encoding loop. To start off with, check and see if we're at
   @  The /0 terminating character. If so, we're done. Otherwise, check to
   @  see if the current character in the input is a space. do the same for the
   @  key string.
   loop:

	  ldrb	r6, [r0, r4]
	  cmp	r6, #0
	  beq	done
	  
	  cmp	r6, #96
	  ble	encodeSpec

	  cmp	r6, #123
	  bge	encodeSpec

	  ldrb	r7, [r2, r5]
	  cmp	r7, #0
	  beq	reset

	  cmp	r7, #96
	  ble	keySpec

	  cmp	r7, #123
	  bge	keySpec

   @  The normal encoding sequence - subtract 96 from the two character values
   @  To get the letter's 1-26 value. Add the two together. If the resulting
   @  value is less than 26, branch to the store command. Otherwise, subtract
   @  26.
   encodeNormal:
	  
	  sub	r6, r6, #96
	  sub	r7, r7, #96

	  add	r6, r6, r7
	  cmp	r6, #26
	  ble	eStore

	  sub	r6, r6, #26

   @  Store the resulting value in the array at location [r4], and increase
   @  each iterator by 1. Begin the loop again.
   eStore:

	  add	r6, r6, #96
	  strb	r6, [r1, r4]

	  add	r4, r4, #1
	  add	r5, r5, #1

	  bal	loop

   @  In the event of a space, store the space in the output string and
   @  increment the iterators. Begin the loop again.
   encodeSpec:

	  strb	r6, [r1, r4]
	  add	r4, r4, #1
	  add	r5, r5, #1

	  bal	loop

   @  If we encounter a /0 character in the key string, reset the key iterator
   @  to 0 and start the loop again.
   reset:
	  
	  mov	r5, #0
	  bal	loop

   @  If we encounter a space in the key, store the input string's character
   @  in the output string. Increment the iterators. Begin the loop again.
   keySpec:

	  strb	r6, [r1, r4]
	  add	r4, r4, #1
	  add	r5, r5, #1
	  bal	loop

@  Decode Branch
decode:

   @  General Decoder Loop - check to see if the current character in the
   @  string is the null character. If so, we're done. Otherwise, see if it's
   @  a space. Branch to the appropriate section of code, and repeat for the
   @  key string.
   dLoop:

	  ldrb	r6, [r0, r4]
	  cmp	r6, #0
	  beq	done
	  
	  cmp	r6, #96
	  ble	decodeSpec

	  cmp	r6, #123
	  bge	decodeSpec

	  ldrb	r7, [r2, r5]
	  cmp	r7, #0
	  beq	dReset

	  cmp	r7, #96
	  ble	decodeKeySpec

	  cmp	r7, #123
	  bge	decodeKeySpec

   @  Decoder for a normal character (not space / null terminator). Subtract
   @  96 from the input string and key string character, then subtract the two
   @  values. If that value is less than 0, add 26. Otherwise, complete the
   @  regular decoding process.
   decodeChar:
	  
	  sub	r6, r6, #96
	  sub	r7, r7, #96

	  sub	r6, r6, r7
	  cmp	r6, #0
	  bge	regDecode

	  add	r6, r6, #26

   @  Stores the decoded character in the output string. Increment r4 and r5.
   regDecode:

	  add	r6, r6, #96
	  strb	r6, [r1, r4]

	  add	r4, r4, #1
	  add	r5, r5, #1

	  bal	dLoop

   @  For a space, store the original character in r6 in the output string.
   @  Increment r4 and r5.
   decodeSpec:

	  strb	r6, [r1, r4]
	  add	r4, r4, #1
	  add	r5, r5, #1

	  bal	dLoop

   @  Resets the key string as described in the `encode` section.
   dReset:
	  
	  mov	r5, #0
	  bal	dLoop

   @  Decoding a space in the key functions the same as above.
   decodeKeySpec:

	  strb	r6, [r1, r4]
	  add	r4, r4, #1
	  add	r5, r5, #1
	  bal	dLoop
   
done:

   @  Store the Null terminating character in the output string, and return.`
   mov	 r6, #0
   strb	 r6, [r1, r4]
   pop	 {r4 - r7, pc}
