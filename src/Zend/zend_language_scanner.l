%option noyywrap
%option nounput
%option noinput
%{
#include <iostream>
#include "zend_language_parser.h"
%}

%%
echo {
    return T_ECHO;
}

[;(),+*/-] {
    return *yytext;
}

[0-9]+ {
    yylval = atoi(yytext);
    return T_LNUMBER;
}

[#].* /* ignore comment */

[\t\n ]+  /* ignore \t, \n, whitespace */

. {
    std::cerr << "Lexical error. Unrecognized character: '" << *yytext << "'" << std::endl;
    exit(EXIT_FAILURE);
}
%%