#include "parser.h"

struct entry keywords[] = {
  {"div", DIVTOKEN},
  {"mod", MODTOKEN},
  {0, 0}
};

void init () {
  struct entry *p;
  for (p = keywords; p->token; p++)
    insert (p->lexptr, p->token);
}
