%{
#include <stdlib.h>
#include <string.h>
#include "token_header.h"
#include "y.tab.h"
int hash(char *);
void yyerror(char *);
%}

%%

"=="            return EQ;
"while"         return WHILE;
"if"            return IF;
"return"         return RETURN;

[a-zA-Z]+ { yylval.sIndex = hash(yytext); return VARIABLE;}

[0-9]+ { yylval.number = atoi(yytext); return INTEGER; }

[<=+*;\[\]] { return *yytext; }

[ \t]+        ;       /* ignore whitespace */

"\n" 	yylineno++;

.               yyerror("Unknown character");
%%
int yywrap(void) {
    return 1;
}


int hash(char * token)
{
	int ch = 0;
	int val = 0;
	int len = strlen(token);
	
	for(int i = 0; i < len ; i++)
	{
		ch = *(token + i);
		val += ch*(i+1);
	}

	val = val%26;

	return val;
}
