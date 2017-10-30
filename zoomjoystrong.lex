%{
/*
 * Sample Lex/Flex file.
 * from a wonderful tutorial from
 * IBM's Knowledge Center
 * https://www.ibm.com/support/knowledgecenter/en/ssw_aix_61/com.ibm.aix.genprogc/ie_prog_4lex_yacc.htm
 * @Author: Phil Garza
 */

#include <stdio.h>
#include <stdlib.h> 
#include "zoomjoystrong.tab.h"

#define YY_DECL int yylex()
int myInt;
float myFloat;
%}
%%
\n|\t   ;
[ \t]+    ;
"end"         { return(END);          }
";"           { return(END_STATEMENT);}
"point"       { return(POINT);        }
"line"        { return(LINE);         }
"circle"      { return(CIRCLE);       }
"rectangle"   { return(RECTANGLE);    }
"set_color"   { return(SET_COLOR);    }
[0-9]+\.[0-9]+ { myFloat = atof(yytext);
                yylval.i = myFloat;
                return(FLOAT);
              }
[0-9]+    { myInt = atoi(yytext);
                yylval.f = myInt;
                return(INT);
              }
.          { printf("Bad Token \n");  }
%%
