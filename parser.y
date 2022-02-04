%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	extern int yylineno; // track the line number


%}
/* declare tokens */
%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_NUM T_ID T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN

/* specify start symbol */
%start START

%%
START : PROG { printf("Valid syntax\n"); YYACCEPT; }	/* If program fits the grammar, syntax is valid */
        ;						/* Anything within {} is C code, it is the action corresponding to the 							production rule */


	  
PROG :  T_INCLUDE '<' T_HEADER '>' PROG	/* include header */
	|MAIN PROG				/* main function  */
	|DECLR ';' PROG 			/* declarations   */	
	| ASSGN ';' PROG 			/* assigments     */
	| 					/* end of program */
	;
	 

/* Grammar for variable declaration */
DECLR : TYPE LISTVAR
	;	/* always terminate with a ; */


LISTVAR : LISTVAR ',' T_ID 
	  | T_ID 
	  ;
	
TYPE : T_INT
       | T_FLOAT
       | T_DOUBLE
       | T_CHAR
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID '=' EXPR 
	;

EXPR : EXPR REL_OP E
       | E
       ;

/* Expression Grammar */	   
E : E '+' T
    | E '-' T
    | T
    ;
	
	
T : T '*' F
    | T '/' F
    | F
    ;

F : '(' EXPR ')'
    | T_ID
    | T_NUM
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	

	
/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' STMT '}';


/* argument list can be empty, or have a list of variables */
EMPTY_LISTVAR : LISTVAR
		|	/* similar to lambda */
		;

/* statements can be standalone, or parts of blocks */
STMT : STMT_NO_BLOCK STMT
       | BLOCK STMT
       |
       ;

STMT_NO_BLOCK : DECLR ';'
       | ASSGN ';' 
       ;

BLOCK : '{' STMT '}';
       



%%

void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}

int main(int argc, char* argv[])
{
	yyparse();
	return 0;

}
