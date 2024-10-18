# makefile
# -lfl flag links the Flex library

all: roman

roman:
	flex lexer.l
	bison -d parser.y
	gcc -o roman lex.yy.c parser.tab.c -lfl

clean:
	rm -f roman parser.tab.* lex.yy.c
