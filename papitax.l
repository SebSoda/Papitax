/*  Especificación del Lexer para el lenguaje Papitax */

%{
#include <stdio.h>
%}

%option noyywrap

%%
"player"        { printf("TOKEN: KEYWORD_PLAYER, Lexema: '%s'\n", yytext); }
"stats"         { printf("TOKEN: KEYWORD_STATS, Lexema: '%s'\n", yytext); }
"action"        { printf("TOKEN: KEYWORD_ACTION, Lexema: '%s'\n", yytext); }
"use"           { printf("TOKEN: KEYWORD_USE, Lexema: '%s'\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("TOKEN: IDENTIFIER, Lexema: '%s'\n", yytext); }
[0-9]+          { printf("TOKEN: NUMBER, Lexema: '%s'\n", yytext); }
\"[^\"]*\"      { printf("TOKEN: STRING, Lexema: '%s'\n", yytext); }

"{"             { printf("TOKEN: LBRACE, Lexema: '%s'\n", yytext); }
"}"             { printf("TOKEN: RBRACE, Lexema: '%s'\n", yytext); }
"="             { printf("TOKEN: ASSIGN, Lexema: '%s'\n", yytext); }
";"             { printf("TOKEN: SEMICOLON, Lexema: '%s'\n", yytext); }

"//"[^\n]*      { /* Ignorar comentarios de una línea */ }
[ \t\n]+        { /* Ignorar espacios en blanco */ }

.               { printf("ERROR LÉXICO: Carácter desconocido '%s'\n", yytext); }

%%
/* -- Sección de Código de Usuario -- */

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error al abrir el archivo");
            return 1;
        }
        yyin = file;
    }

    yylex();

    printf("\n--- Fin del Análisis Léxico ---\n");
    return 0;
}