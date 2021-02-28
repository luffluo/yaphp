%option noyywrap
%option nounput
%option noinput
%{
#include "zend_language_parser.h"
%}

%%
echo {
    return T_ECHO;
}

[;(),+*/-] return *yytext;

[0-9]+ {
    yylval = atoi(yytext);
    return T_NUMBER;
}

[\t\n ]+  /* ignore \t, \n, whitespace */

%%