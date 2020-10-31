CC = gcc
firstStart: yacc y.tab.c
	${CC} -o parser y.tab.c
yacc: lex lex.yy.c
	yacc CS315f20_teamXX.yacc.y
lex: CS315f20_teamXX.lex.l
	lex CS315f20_teamXX.lex.l
clean:
	rm -f lex.yy.c y.tab.c parser
