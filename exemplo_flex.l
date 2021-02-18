%{

// código C
#include <string.h>
#include <stdio.h>
// flex -i exemplo_flex.l
// gcc analisador.c -o prog
// ./prog

%}



INTEIRO "inteiro"
REAL "real"
TEXTO "texto"

LETRA [a-zA-Z]+
NUMERO_REAL [0-9]+\.?[0-9]*
RAIZ "raiz"


VARIAVEL {LETRA}({LETRA} | {NUMERO} | "," | "-" | "_")*
ATRIBUICAO "<<"

LER "leia"
ESCREVER "escreva"

INICIO "inicio"
FIM "fim"

LOGICO "<" | "<=" | ">" | ">=""
CONDICIONAL "SENAO SE" | "SE" | "SENAO"
REPETICAO "REPETE"

COMENTARIO "!".*
IGNORE [\s\t\n" "]

%% 

{INICIO} { 
    printf("Inicio: %s\n", yytext);
}

{FIM} {    
    printf("Fim do programa %s\n", yytext);
}

{ATRIBUICAO} {
    printf("Atribuicao: %s\n", yytext);
}

{INTEIRO} {
    printf("Int: %s\n", yytext);
}

{REAL} {
    printf("Numero real: %s\n", yytext);
}

{VARIAVEL} {
    printf("Variavel: %s\n", yytext);
}

{TEXTO} {
    printf("Apenas léxico. Texto: %s\n", yytext);
}

{CONDICIONAL} {   
    printf("Apenas léxico. Estrutura condicional: %s\n", yytext);
}

{REPETICAO} {
    printf ("Apenas léxico. Estrutura de repeticao: %s\n" yytext);
}

{LER} {
    printf("Apenas léxico. Estrutura de leitura: %s\n", yytext);
}

{ESCREVER} {
    printf('%s\n', yytext);
}

{COMENTARIO}..*|"/**"(..*|{IGNORE})*"*/" {;}

{NUMERO_REAL} {
    printf('%s\n', yytext);
}

{LOGICO} {
    printf("Apenas léxico. Operador lógico: %s\n", yytext);
}

{RAIZ} {
    printf('%s\n', yytext);
}

. {
    printf("Caractere invalido: %s\n", yytext);
}

%%

int yywrap(){ return 1;}
// código C
int main(){
    
    yyin = fopen("in.morgana", "r");
    yylex();
    fclose (yyin);

    return 0;
}