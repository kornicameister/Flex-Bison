%{
  #include <stdio.h>
  #include "parser.h"

  int tokenval = NONE;
  int lineno = 1;

  extern YYSTYPE yylval;

%}
%option noyywrap

IGNORE 		[\s\t]
NEWLINE   [\r\n]
DIGIT     [0-9]
ALPHA     [a-zA-Z]
ALNUM     [a-zA-Z0-9]
ID        {ALPHA}{ALNUM}*

%%

{DIGIT}+	           {
        // printf("DIGIT: %d\n", yytext);
        yylval = atoi(yytext);
        return NUMBER;
  		}

{ID} {
      //printf("ID: %s\n", yytext);
      int p = lookup (yytext);
      if (p == 0) {
        p = insert (yytext, ID);
      }
      yylval = p;
      return symtable[p].token;
		}

"+"|"-"|"*"|"/" {
  // printf("OP: %s\n", yytext);
  return yytext[0];
}

{NEWLINE}	 { lineno++; }

{IGNORE}*   { /*ignore*/ }

.            {
    yylval = NONE;
    return yytext[0];
}

<<EOF>>		   {
      printf("Done\n");
      return DONE;
}

%%

lexan (){
  yylex();
}
