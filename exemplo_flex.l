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
STRING \".*\"
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
    return INICIO;       
}

{FIM} {    
    return FIM;          
}

{ATRIBUICAO} {
    return ATRIBUICAO;
}

{INTEIRO} {
    return INTEIRO;
}

{REAL} {
    return REAL;
}

{VARIAVEL} {
    strcpy (yylval.texto, yytext);
    return VARIAVEL;
}

{TEXTO} {
    return TEXTO;
}

{RAIZ} {
    return RAIZ;
}

{LER} {
    return LER;
}

{ESCREVER} {
    return ESCREVER;
}

{COMENTARIO}..*|"/**"(..*|{IGNORE})*"*/" {;}

{NUMERO_REAL} {
    yylval.real = atof(yytext);
    return NUM_REAL;
}

{STRING} {
    strcpy(yylval.texto, yytext);
}

{LOGICO} {
    printf(" Apenas léxico. Operador lógico: %s\n", yytext);
}

{CONDICIONAL} {   
    printf("Apenas léxico. Estrutura condicional: %s\n", yytext);
}

{REPETICAO} {
    printf ("Apenas léxico. Estrutura de repeticao:" %s\n" yytext);
}

{INVALIDO} {;}

%%

int yywrap(){ return 1;}
// código C
int main(){
    
    yyin = fopen("in.morgana", "r");
    yylex();
    fclose (yyin);

    return 0;
}