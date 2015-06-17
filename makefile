objects = main.o emitter.o lexer.o symbol.o error.o init.o parser.o
header = global.h
name = LOL

CC=cc
FLEX=flex

edit: $(objects)
	$(CC) -o ${name} $(objects)

clean:
	rm -f *.o
	rm -f lexer.c
	rm -f ${name}

main.o: main.c $(header)
	$(CC) -c $< -o $@

init.o: init.c $(header)
	$(CC) -c $< -o $@

emitter.o: emitter.c $(header)
	$(CC) -c $< -o $@

lexer.c: lexer.l $(header)
	$(FLEX) -o lexer.c lexer.l

lexer.o: lexer.c $(header)
	$(CC) -c $< -o $@

symbol.o: symbol.c $(header)
	$(CC) -c $< -o $@

error.o: error.c $(header)
	$(CC) -c $< -o $@

parser.o: parser.c $(header)
	$(CC) -c $< -o $@
