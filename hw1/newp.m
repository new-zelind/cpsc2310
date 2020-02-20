   word(N, 111)		comment(`N = the binary number to be converted')
   word(ten, 10)		comment(`a constant for 10')
   word(two, 2)			comment(`a constant for 2')
   word(power, 1)		comment(`an integer that represents which power of 2')
						comment(`the loop is working with (i.e. 1, 2, 4, 8, etc)')
   word(result, 0)		comment(`result holds the integer that N is to be compared')
						comment(`to in the remainder calculation')
   word(remainder, 0)	comment(`holds the remainder after the mod calculation')
   word(decimal, 0)		comment(`an integer that holds the decimal number')

label(loop)
   load(N)
   ble0(done)			comment(`while(N > 0)')
   
   div(ten)				comment(`result = N % 10')
   mul(ten)
   store(result)		comment(`result = (N / 10) * 10')

   load(N)
   sub(result)
   store(remainder)		comment(`remainder = N - result')

   load(N)
   div(ten)
   store(N)				comment(`N /= 10')

   load(remainder)
   mul(power)
   add(decimal)
   store(decimal)		comment(`decimal += remainder * power')

   load(power)
   mul(two)
   store(power)			comment(`power *= 2')

   ba(loop)				comment(`back to beginning of while loop')

label(done)

   print(decimal)
   halt
   end(loop)
