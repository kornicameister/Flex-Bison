%{
	#define YYDEBUG 1
	void yyerror(const char *str);
	int yywrap();
%}

%code requires {
	#include "global.h"
}

%token NUMBER
%token MODTOKEN
%token DIVTOKEN
%token ID
%token DONE

%%

Input: /* empty */
	|Line
;

Line:/* empty */
	|Exp ';' Line
;

Exp: 	 Exp '+' term { emit('+', NONE); }
		| Exp '-' term { emit('-', NONE); }
		| term
;

term: term '*' factor { emit('*', NONE);}
	|term '/' factor { emit('/', NONE);}
	|term MODTOKEN factor {emit(MODTOKEN, NONE);}
	|term DIVTOKEN factor {emit(DIVTOKEN, NONE);}
	|factor
;

factor:/* empty */
	|'(' Exp ')'
	|ID { emit(ID, $1); }
	|NUMBER {  emit (NUMBER, $1); }
;

%%

void yyerror(const char *str) {
        fprintf(stderr,"error: %s\n",str);
}

int yywrap() {
        return 1;
}

void parse() {
	extern int yydebug;
	yydebug = 0;
	yyparse();
}
