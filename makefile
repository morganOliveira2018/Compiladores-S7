all: 
	 flex -i exemplo_flex.l
	 gcc lex.yy.c -o prog
	 ./prog
	 