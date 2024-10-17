%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token I V X L C D M

%%
calculation:
    romanNum               { printf("Result = %d\n", $1); }
    ;

romanNum:
    thousand hundred ten digit { $$ = $1 + $2 + $3 + $4; }
    ;

thousand:
    M M M                  { $$ = 3000; }
    | M M                  { $$ = 2000; }
    | M                    { $$ = 1000; }
    |                      { $$ = 0; }
    ;

hundred:
    smallHundred           { $$ = $1; }
    | C D                  { $$ = 400; }
    | D smallHundred       { $$ = 500 + $2; }
    | C M                  { $$ = 900; }
    ;

smallHundred:
    C C C                  { $$ = 300; }
    | C C                  { $$ = 200; }
    | C                    { $$ = 100; }
    |                      { $$ = 0; }
    ;

ten:
    smallTen               { $$ = $1; }
    | X L                  { $$ = 40; }
    | L smallTen           { $$ = 50 + $2; }
    | X C                  { $$ = 90; }
    ;

smallTen:
    X X X                  { $$ = 30; }
    | X X                  { $$ = 20; }
    | X                    { $$ = 10; }
    |                      { $$ = 0; }
    ;

digit:
    smallDigit             { $$ = $1; }
    | I V                  { $$ = 4; }
    | V smallDigit         { $$ = 5 + $2; }
    | I X                  { $$ = 9; }
    ;

smallDigit:
    I I I                  { $$ = 3; }
    | I I                  { $$ = 2; }
    | I                    { $$ = 1; }
    |                      { $$ = 0; }
    ;
%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}