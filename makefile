all: 
	 flex -i calculadora_flex.l
	 gcc lex.yy.c -o prog
	 ./prog
	 