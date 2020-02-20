COMP= gcc
FLAGS= -Wall -g -lm -o
PROG= 8bit-fp-table.c
OUT= result.txt
TARGET= exe

clean:
	  rm -f $(TARGET) $(OUT)

run:
	  $(COMP) $(PROG) $(FLAGS) $(TARGET)
	  ./$(TARGET) > $(OUT)
	  diff $(OUT) output
