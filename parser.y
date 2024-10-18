%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
typedef struct yy_buffer_state *YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char *str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int result;
%}

%token M D C L X V I

%%

calculation:
    roman               { result = $1; }
    ;

roman
    : thousand hundred ten digit
        { $$ = $1 + $2 + $3 + $4; }
    ;

thousand
    : M              { $$ = 1000; }
    | M M            { $$ = 2000; }
    | M M M          { $$ = 3000; }
    |                { $$ = 0; }
    ;

hundred
    : iHundred           { $$ = $1; }
    | C D                { $$ = 400; }
    | D iHundred         { $$ = 500 + $2; }
    | C M                { $$ = 900; }
    ;

iHundred
    : C                  { $$ = 100; }
    | C C                { $$ = 200; }
    | C C C              { $$ = 300; }
    |                    { $$ = 0; }
    ;

ten
    : iTen               { $$ = $1; }
    | X L                { $$ = 40; }
    | L iTen             { $$ = 50 + $2; }
    | X C                { $$ = 90; }
    ;

iTen
    : X                  { $$ = 10; }
    | X X                { $$ = 20; }
    | X X X              { $$ = 30; }
    |                    { $$ = 0; }
    ;

digit
    : iDigit             { $$ = $1; }
    | I V                { $$ = 4; }
    | V iDigit           { $$ = 5 + $2; }
    | I X                { $$ = 9; }
    ;

iDigit
    : I                  { $$ = 1; }
    | I I                { $$ = 2; }
    | I I I              { $$ = 3; }
    |                    { $$ = 0; }
    ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s NUMERAL\n", argv[0]);
        return 1;
    }

    YY_BUFFER_STATE buffer = yy_scan_string(argv[1]);

    if (yyparse() != 0)
    {

        fprintf(stderr, "Error: Invalid Roman numeral\n");
        exit(1);
    }

    printf("%d\n", result);
    yy_delete_buffer(buffer);

    return 0;
}
