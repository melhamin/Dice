%{
#include <stdio.h>
int lineno;
%}


%token INTEGER FLOAT FOR IF WHILE ELSE CONNECT
%token SEND INT_TYPE BOOL_TYPE STR_TYPE WHEN SEMICOLON
%token CONST PRINT RETURN FLT_TYPE AND OR RECEIVE TIMESTAMP END_OF_FILE
%token STRING COMMENT SWITCH BUILTIN_FUNC PLUS MINUS
%token DIV MUL EQUALS IDENTIFIER LB RB LP RP EQ_CMP BOOLEAN
%token GTEQ_CMP NEQ_CMP LTEQ_CMP LT_CMP GT_CMP URL NL COMMA SRB SLB VOID


%start program

%right EQUALS

%left GT_CMP LT_CMP NEQ_CMP LTEQ_CMP GTEQ_CMP

%left PLUS MINUS
%left MUL DIV
%nonassoc IF
%nonassoc ELSE
%%
program: stmt_list eof
;
stmt_list:
/* empty */
| stmt_list stmt
;
stmt: NL
| expr
| func_call NL
| if_stmt NL
| loop_stmt NL
| print NL
| cmnt NL
| func_declr NL
| return NL
| switch NL
| url NL
;
eof: END_OF_FILE
{printf("Valid Program! End of File! Exiting...\n"); return 0;}
;
expr:
 declr NL
| asnmt NL
;
declr:
 INT_TYPE IDENTIFIER
| FLT_TYPE IDENTIFIER
| BOOL_TYPE IDENTIFIER
| STR_TYPE IDENTIFIER
| INT_TYPE IDENTIFIER EQUALS integer
| INT_TYPE IDENTIFIER EQUALS BUILTIN_FUNC
| FLT_TYPE IDENTIFIER EQUALS float
| BOOL_TYPE IDENTIFIER EQUALS BOOLEAN
| STR_TYPE IDENTIFIER EQUALS STRING
| CONST INT_TYPE IDENTIFIER EQUALS INTEGER
| CONST FLT_TYPE IDENTIFIER EQUALS FLOAT
| CONST BOOL_TYPE IDENTIFIER EQUALS BOOLEAN
| CONST STR_TYPE IDENTIFIER EQUALS STRING
;
integer:INTEGER
| MINUS INTEGER
;
float: FLOAT
| MINUS FLOAT
;
asnmt:
  IDENTIFIER EQUALS operate
| IDENTIFIER EQUALS func_call
| IDENTIFIER EQUALS real WHEN timestamp
| IDENTIFIER EQUALS BUILTIN_FUNC
| IDENTIFIER EQUALS BOOLEAN
| IDENTIFIER EQUALS STRING
| IDENTIFIER EQUALS URL
;
operate:
 operate plus_minus mul_div
| mul_div
;
func_call:
IDENTIFIER LP common_list RP
;
common_list:
/*empty*/
| commons
| common_list COMMA commons
;
commons:
IDENTIFIER
| INTEGER
| FLOAT
| STRING
| BOOLEAN
;
real: INTEGER
| FLOAT
;
timestamp:
  real 
| TIMESTAMP
;
plus_minus:
  PLUS
| MINUS
;
mul_div:
 expression
| mul_div MUL expression
| mul_div DIV expression
;
expression:
 INTEGER
| IDENTIFIER
| FLOAT
;
if_stmt:
	IF LP condition RP LB NL stmt_list RB else
  |  IF LP condition RP LB NL stmt_list RB 
;
else:
 ELSE LB NL stmt_list RB
;
condition:
 condition AND comp rel_op comp
| condition OR comp rel_op comp
| comp rel_op comp
;
comp:
 operate
| BUILTIN_FUNC
;
rel_op: EQ_CMP
| GTEQ_CMP
| NEQ_CMP
| LTEQ_CMP
| LT_CMP
| GT_CMP
;
loop_stmt:
 while_loop
| for_loop
;
while_loop:
WHILE LP condition RP LB NL stmt_list RB
;
for_loop:
  FOR LP INT_TYPE IDENTIFIER EQUALS INTEGER SEMICOLON condition SEMICOLON for_asnmt RP LB NL stmt_list RB
  | FOR LP INT_TYPE IDENTIFIER EQUALS IDENTIFIER SEMICOLON condition SEMICOLON for_asnmt RP LB NL stmt_list RB
;
for_asnmt:
 IDENTIFIER EQUALS operate
;
print:
 PRINT LP commons RP
;
param_list:
param
| param_list COMMA param
;
param:
|type IDENTIFIER
;
switch: SWITCH SRB BOOLEAN SLB
;
return: RETURN | RETURN commons
;
url:
 CONNECT URL
| CONNECT IDENTIFIER
| commons SEND URL
| commons SEND IDENTIFIER
| IDENTIFIER RECEIVE URL
| IDENTIFIER RECEIVE IDENTIFIER
;
type: INT_TYPE | FLT_TYPE | STR_TYPE | BOOL_TYPE ;
cmnt:
 COMMENT
 ;
func_declr: INT_TYPE IDENTIFIER LP param_list RP LB NL stmt_list RB
| BOOL_TYPE IDENTIFIER LP param_list RP LB stmt_list RB
| FLT_TYPE IDENTIFIER LP param_list RP LB stmt_list RB
| STR_TYPE IDENTIFIER LP param_list RP LB stmt_list RB
| VOID IDENTIFIER LP param_list RP LB stmt_list RB
;
%%
#include "lex.yy.c"
int main() {
return yyparse();
}int yyerror( char *s ) { printf("Error on line: %d\n Invalid Program! \n", 1 + lineno); }
