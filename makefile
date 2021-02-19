all: 
	 flex -i exemplo_tentativa.l
	 gcc lex.yy.c -o test
	 ./test 
	 