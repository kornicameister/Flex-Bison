#include "parser.h"

void emit (int t, int tval) {
  switch (t) {
    case '+':
    case '-':
    case '*':
    case '/':
      printf ("%c\n", t);
      break;
    case DIVTOKEN:
      printf ("DIV\n");
      break;
    case MODTOKEN:
      printf ("MOD\n");
      break;
    case NUMBER:
      printf ("%d\n", tval);
      break;
    case ID:
      printf ("%s\n", symtable[tval].lexptr);
      break;
    default:
      printf ("token %d , tokenval %d\n", t, tval);
    }
}
