%{
#include <stdlib.h>
#include "token_header.h"
#include "y.tab.h"
void yyerror(char *);
%}

%%

"=="            return EQ;
"while"         return WHILE;
"if"            return IF;
"return"         return RETURN;

[a-zA-Z]+ { yylval.sIndex = *yytext - 'a'; return VARIABLE;}

[0-9]+ { yylval.number = atoi(yytext); return INTEGER; }

[<=+*;\[\]] { return *yytext; }

[ \t]+        ;       /* ignore whitespace */

"\n" 	yylineno++;

.               yyerror("Unknown character");
%%
int yywrap(void) {
    return 1;
}
