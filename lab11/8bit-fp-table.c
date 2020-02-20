//Zach Lindler
//CPSC 2310 Lab
//lab11, 8bit-fp-table.c

// gcc <x>.c -lm
// ./a.out > result.txt
// diff result.txt output

#include <stdio.h>
#include <math.h>
  
int main()
{
   int sign, exp, fraction, significand;
   int i, j, k;
   float f;
   float prev = 0;

   int x, fff;

   for (i = 0; i < 256; i++)
   {
	  /* begin your code */
	  
	  //bitwise field extraction
	  sign = (i >> 7) & 1;
	  fraction = (i & 7);
	  exp = (i >> 3) & 15;

	  //if the exponent is 0, treat it like a 1.
	  //otherwise, don't do anything to it.
	  //why, I have no idea - the TA explained it this way.
	  if(exp == 0){
		 exp -= 7;
		 x = 1;
	  }
	  else{
		 exp -= 8;
		 x = 0;
	  }

	  //if the sign bit is 0, the number is positive.
	  //otherwise, the number is negative.
	  //if(sign == 0){s = 1;}
	  //else{s = -1;}

	  //calculate the significand and change the exponent based on that
	  fff = fraction;
	  significand = (!x << 3) | fff;
	  exp -= 3;
	  f = significand;

	  //if the exponent is positive, calculate the square as many times as
	  //needed. Otherwise, half it as many times as needed.
	  //f *= pow(2, exp);
	  
	  if(exp > 0){
		 for(j = 0; j < exp; j++){
			f *= 2;
		 }
	  }
	  else{
		 for(k = 0; k > exp; k--){
			f /= 2;
		 }
	  }

	  //sign the number
	  if(sign == 1) f = -f;

	  /* end your code */

	  printf ("%02x => %08x = %+11.6f (spacing = %+11.6f)\n",
		 i, *(int*) &f, f, prev-f);
	  prev = f;
   }

   return 0;
}
