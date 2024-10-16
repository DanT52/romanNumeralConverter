%{
#include <stdio.h>
#include <stdlib.h>

int yylex();


void yyerror(const char *s);
%}

%token NUMBER
%token PLUS MULT

%%
calculation:
    expression               { printf("Result = %d\n", $1); }
    ;

expression:
    expression PLUS term      { $$ = $1 + $3; }
    | term                    { $$ = $1; }
    ;

term:
    term MULT factor          { $$ = $1 * $3; }
    | factor                  { $$ = $1; }
    ;

factor:
    NUMBER                    { $$ = $1; }
    ;
%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
