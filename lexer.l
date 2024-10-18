%{
#include "parser.tab.h"
void yyerror(const char *s);
%}

%%

"M"   { return M; }
"D"   { return D; }
"C"   { return C; }
"L"   { return L; }
"X"   { return X; }
"V"   { return V; }
"I"   { return I; }
[ \t\n]+    { } // skip spaces
.     { yyerror("Invalid character"); }

%%

int yywrap() { return 1; }
