	  comment(' set aside memory and initialize variables ')
   word(sum, 0)
   word(i, 0)
   word(zero, 0)
   word(one, 1)
   word(ten, 10)

label(start)
   
   load(zero)
   store(sum)

   load(one)
   store(i)

label(loop)

   load(sum)
   add(i)
   store(sum)

   load(i)
   add(one)
   store(i)

   sub(ten)
   ble0(loop)

label(done)

   print(sum)
   halt

   start
