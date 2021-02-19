%option noyywrap
    // int yywrap(){ return 1;}

%{

// código C, bibliotecas, funcoes
#include <string.h>
#include <stdio.h>
#include <locale.h> // biblioteca para reconhecer caracteres especiais
// flex -i exemplo_flex.l
// gcc lex.yy.c -o prog
// ./prog
// makefile - todos os comandos em sequencia

%}

    // definicoes regulares

INICIO "Inicio"
FIM "Fim do programa"

INTEIRO "int"
REAL "real"
BOOLEANO "bool"
TEXTO "string"

NUMERO [0-9]+
LETRA [a-zA-Z]+
FLOAT {NUMERO}+("."){NUMERO}+
STRING \".*\" 

ARITMETICO "+"|"-"|"*"|"/"|"raiz"
LOGICO "&&"|"or"|"true"|"false"
RELACIONAIS ">"|">="|"<"|"<="|"=="|"!="

COND1 "IF"
COND2 "ELSE"
COND3 "ELSE IF"

COMENTARIO "@@".*
CONDICIONAL ({COND1}|{COND2}|{COND3})*

VARIAVEL {LETRA}({LETRA}|{NUMERO}|"-"|"_")*
LER "leia"(" ")*">>"(" ")*{VARIAVEL}
ESCREVER "escreva"(" ")*"<<"(" ")*({VARIAVEL}|\".*\")*
REPETICAO "REPETE"(" ")?"(".+")"
INVALIDO .

%%

    // tokens ou regras
{INICIO} { 
    printf("Identificador de início do programa: %s\n", yytext); 
}
{FIM} { 
    printf("Identificador de fim do programa: %s\n", yytext); 
}

"\n"|" "|"\t"|","|"<<"|"("|")" { /* ignore */ }

{CONDICIONAL} { 
    printf("Estrutura condicional: %s\n", yytext); 
}
{REPETICAO} { 
    printf("Estrutura de repeticao: %s\n", yytext); 
}

{INTEIRO} { 
    printf("Tipo inteiro: %s\n", yytext); 
}
{REAL} { 
    printf("Tipo real: %s\n", yytext); 
}
{BOOLEANO} {
    printf("Tipo booleano: %s\n", yytext); 
}
{FLOAT} {
    printf("Tipo real: %s\n", yytext);
}
{TEXTO} { 
    printf("Tipo texto: %s\n", yytext); 
}
{VARIAVEL} { 
    printf("Variável: %s\n", yytext); 
}
{COMENTARIO} { 
    printf("Comentário: %s\n", yytext); 
}
{LER} { 
    printf("Operação de leitura: %s\n", yytext); 
}
{ESCREVER} { 
    printf("Operação de escrita: %s\n", yytext); 
}
{NUMERO} { 
    printf("Número: %s\n", yytext); 
}
{STRING} { 
    printf("String: %s\n", yytext); 
}

{ARITMETICO} { 
    printf("Operador aritmético: %s\n", yytext); 
}
{RELACIONAIS} {
    printf("Operador relacional: %s\n", yytext);
}
{LOGICO} { 
    printf("Operador lógico: %s\n", yytext); 
}
{INVALIDO} { 
    printf("Caractere inválido: %s\n", yytext); 
}

%%


// código fonte em C
int main(){
    yyin = fopen("in.morgana", "r");
    yylex();  
    fclose (yyin);

    return 0;
}