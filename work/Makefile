CC = gcc
firstStart: yacc y.tab.c
	${CC} -o parser y.tab.c
yacc: lex lex.yy.c
	yacc CS315f20_team5.yacc.y
lex: CS315f20_team5.lex.l
	lex CS315f20_team5.lex.l
clean:
	rm -f lex.yy.c y.tab.c parser
