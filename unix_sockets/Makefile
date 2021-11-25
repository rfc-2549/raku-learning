
CC = cc
SHARED_OUTPUT = librakunix.so
OBJ_OUTPUT    = librakunix.o

rakunix: rakunix.c
	gcc -c rakunix.c -fpic -o $(OBJ_OUTPUT)
	gcc -shared $(OBJ_OUTPUT) -o $(SHARED_OUTPUT) 

clean:
	rm $(SHARED_OUTPUT) $(OBJ_OUTPUT)
