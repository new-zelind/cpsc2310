bipush(-40)
istore_1
bipush(-40)
istore_2

label(loop)

iconst_1
invokevirtual(1)
iconst_2
invokevirtual(2)

iload_1
bipush(10)
iadd
istore_1

iload_2
bipush(9)
imul
bipush(5)
idiv
bipush(32)
iadd
istore_2

iload_1
bipush(120)
isub

ifle(loop)

return
