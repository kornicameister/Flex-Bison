%{
  #include <stdio.h>
  #include "global.h"

  int tokenval = NONE;
  int lineno = 1;

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
        tokenval = atoi(yytext);
        return NUM;
  		}

{ID} {
      //printf("ID: %s\n", yytext);
      int p = lookup (yytext);
      if (p == 0) {
        p = insert (yytext, ID);
      }
      tokenval = p;
      return symtable[p].token;
		}

"+"|"-"|"*"|"/" {
  // printf("OP: %s\n", yytext);
  return yytext[0];
}

{NEWLINE}	 { lineno++; }

{IGNORE}*   { /*ignore*/ }

.            {
    tokenval = NONE;
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
