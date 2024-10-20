%{
#include <stdio.h>
#include <stdlib.h>
#include "expr.h"

int yylex();
void yyerror(const char *s);

typedef struct yy_buffer_state *YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char *str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

#define YYSTYPE struct ast *
struct ast * parser_result = 0;

%}

%token M D C L X V I

%%

calculation:
    roman               { parser_result = $1; }
    ;

roman
    : thousand hundred ten digit
        { $$ = create(
                create($1, $2),
                create($3, $4)); }
    ;

thousand
    : M              { $$ = value( 1000 ); }
    | M M            { $$ = value( 2000 ); }
    | M M M          { $$ = value( 3000 ); }
    |                { $$ = value( 0 ); }
    ;

hundred
    : iHundred           { $$ = $1; }
    | C D                { $$ = value( 400 ); }
    | D iHundred         { $$ = create(value( 500 ), $2); }
    | C M                { $$ = value( 900 ); }
    ;

iHundred
    : C                  { $$ = value( 100 ); }
    | C C                { $$ = value( 200 ); }
    | C C C              { $$ = value( 300 ); }
    |                    { $$ = value( 0 ); }
    ;

ten
    : iTen               { $$ = $1; }
    | X L                { $$ = value( 40 ); }
    | L iTen             { $$ = create(value( 50 ), $2); }
    | X C                { $$ = value( 90 ); }
    ;

iTen
    : X                  { $$ = value( 10 ); }
    | X X                { $$ = value( 20 ); }
    | X X X              { $$ = value( 30 ); }
    |                    { $$ = value( 0 ); }
    ;

digit
    : iDigit             { $$ = $1; }
    | I V                { $$ = value( 4 ); }
    | V iDigit           { $$ = create(value( 5 ), $2); }
    | I X                { $$ = value( 9 ); }
    ;

iDigit
    : I                  { $$ = value( 1 ); }
    | I I                { $$ = value( 2 ); }
    | I I I              { $$ = value( 3 ); }
    |                    { $$ = value( 0 ); }
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

    int result = evaluate(parser_result);
    printf("%d\n", result);

    free_ast(parser_result);
    yy_delete_buffer(buffer);

    return 0;
}
