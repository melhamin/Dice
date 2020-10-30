CC = gcc
firstStart: yacc y.tab.c
	${CC} -o parser y.tab.c
yacc: lex lex.yy.c
	yacc dice.y
lex: lexer.l
	lex lexer.l
clean:
	rm -f lex.yy.c y.tab.c parser
