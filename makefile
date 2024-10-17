calc: calc.tab.c lex.yy.c
	bison -d calc.y
	flex calc.l
	gcc calc.tab.c lex.yy.c -o calc -lm

calc.tab.c: calc.y
	bison -d calc.y

lex.yy.c: calc.l
	flex calc.l

clean:
	rm -f calc calc.tab.c calc.tab.h lex.yy.c