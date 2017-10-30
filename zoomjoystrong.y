%{
/*
 * Project 2 - 343
 * ZoomJoyStrong
 * @Author - Phil Garza
 * Bison File
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "zoomjoystrong.h"
void mySetColor(int p1, int p2, int p3);
void myEnd();
%}

%start input

%union { int i;
          float f;
 }

%token END        
%token END_STATEMENT
%token POINT      
%token LINE       
%token CIRCLE    
%token RECTANGLE  
%token SET_COLOR  
%token<i> FLOAT
%token<f> INT

%%
input: exp 
      | exp  input
      | error
      | error input

;
exp: point        
    | line        
    | cirlce      
    | rectangle   
    | setcolor
    | end  
;
point:    POINT      INT INT END_STATEMENT             { point($2,$3);}
;
line:     LINE       INT INT INT INT END_STATEMENT     { line($2,$3,$4,$5); }
;
cirlce:   CIRCLE     INT INT INT END_STATEMENT         { circle($2,$3,$4); }
;
rectangle:RECTANGLE  INT INT INT INT  END_STATEMENT    { rectangle($2,$3,$4,$5); }
;
setcolor: SET_COLOR  INT INT INT END_STATEMENT         { mySetColor($2,$4,$4);}
;
end:      END        END_STATEMENT                     { myEnd(); }
;
%%
/**********************************************************************
* Main Method
* Starts The whole Shabang
***********************************************************************/ 
int main()
{
  setup();
  yyparse();
}
/***********************************************************************
* mySetColor
* @Param: p1 - red, p2 - green, p3 - blue
* Accepts RGB input and checks the integer is less than 255
***********************************************************************/
void mySetColor(int p1, int p2, int p3){
  if(p1 > 255 || p2 > 255 || p3 > 255 ){
    printf("Invalid Paramter\n");
    return;
  }
  set_color(p1,p2,p3);
}

/***********************************************************************
* yyerror
* Displays the error message given from the parser
* @Param: s - accepts the error from the parser
* @return: returns 0 or 1 to the parser
***********************************************************************/
int yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
  return(1);
}

/***********************************************************************
* yywrap
* Does stuff. didn't want to remove it. 
***********************************************************************/
int yywrap()
{
  return(1);
}

/***********************************************************************
* myEnd
* Says goodbye and calls the zoomjoystrong finish method
* also exits the program
***********************************************************************/
void myEnd(){
  printf("Goodbye");
  finish();
  exit(1);
}
