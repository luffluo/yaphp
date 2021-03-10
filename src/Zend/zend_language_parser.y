%{
#include <stdio.h>
#include <string.h>

extern int yylex(void);
extern int yyparse(void);
extern FILE *yyin;
extern int yylineno;

int yywrap()
{
    return 1;
}

void yyerror(const char *s)
{
    printf("[error] %s, in line %d\n", s, yylineno);
}

int main(int argc, char const *argv[])
{
    const char *file = argv[1];
    FILE *fp = fopen(file, "r");

    if (fp == NULL) {
        printf("cannot open %s\n", file);
        return -1;
    }

    yyin = fp;
    yyparse();

    return 0;
}
%}

%token T_ECHO T_LNUMBER

%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

statement: %empty
|   T_ECHO expr   { printf("%d\n", $2); }
;

expr: %empty
|   expr '+' expr                 {$$ = $1 + $3;}
|   expr '-' expr                 {$$ = $1 - $3;}
|   expr '*' expr                 {$$ = $1 * $3;}
|   expr '/' expr                 {$$ = $1 / $3;}
|   '(' expr ')'                  {$$ = $2;}
|   T_LNUMBER                     {$$ = $1;}
;

%%