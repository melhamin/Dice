%{
#include <stdio.h>
int yylex();
int yyerror();
int lineno;
%}
%token NUMBER VARIABLE IF LP RP LB RB SEMICLN LINE_COMMENT MULTILINE_COMMENT 
%token ASGNMNT_OP DOT STRING_IDNT CHAR_IDNT OR_OP AND_OP NOT_OP EQUAL_OP NOT_EQUAL_OP
%token LESS_T_OP GREATER_T_OP LT_OR_EQUAL_OP GT_OR_EQUAL_OP MUL_OP DIV_OP
%token ADD_OP SUB_OP MOD_OP COMMA INPUT_CALL OUTPUT_CALL WHILE_LOOP FOR_LOOP
%token FUNCTION IDENTIFIER ELSE IN_OP OUT_OP
%token CONNECT TAKEOFF LAND FLIP_LEFT FLIP_RIGHT FLIP_FRONT FLIP_BACK GO GO_UP GO_FORWARD
%token GO_DOWN GO_BACKWARD GO_LEFT GO_RIGHT ROTATE_C ROTATE_CC VIDEO_ON VIDEO_OFF
%token TAKE_PIC EMERGENCY_STOP SET_SPEED SET_WIFI HOVER GET_SPEED GET_ALTITUDE 
%token GET_TEMPERATURE GET_ACCELERATION GET_INCLINATION GET_TIME GET_BATTERY


%start program

%right EQUALS  // TODO  

%left GT_CMP LT_CMP NEQ_CMP LTEQ_CMP GTEQ_CMP   // TODO

%left PLUS MINUS   // TODO

%left MUL DIV    // TODO

%nonassoc IF     // TODO

%nonassoc ELSE   // TODO

%%
program: statement_list
;
statement_list:
statement SEMICLN
| statement SEMICLN statement_list 
| line_comment statement_list
| block_comment statement_list
;
statement: declaration_statement
| assignment_statement
| conditional_statement
| loop_statement
| function_definition
| input_statement
| output_statement
| expression
;
declaration_statement: VARIABLE IDENTIFIER
| VARIABLE IDENTIFIER ASGNMNT_OP expression
;
assignment_statement: IDENTIFIER ASGNMNT_OP expression
;
conditional_statement: IF LP expression RP block
| IF LP expression RP block ELSE block
;
expression: arithmetic 
| relational 
| not_expression 
;
arithmetic: arithmetic ADD_OP mult_div   
| arithmetic SUB_OP mult_div
| mult_div
;
mult_div: mult_div MUL_OP in_paranthesis
| mult_div DIV_OP in_paranthesis
| mult_div MOD_OP in_paranthesis
| in_paranthesis
;
in_paranthesis: LP arithmetic RP
| NUMBER
| IDENTIFIER
| function_call
;
relational: in_paranthesis relational_operator in_paranthesis
;
relational_operator: LESS_T_OP
| LT_OR_EQUAL_OP
| GREATER_T_OP
| GT_OR_EQUAL_OP
| AND_OP
| OR_OP
| EQUAL_OP
| NOT_EQUAL_OP                                             
;
not_expression: NOT_OP in_paranthesis
| NOT_OP LP relational RP
;
function_definition: function_header function_body
;
function_header: FUNCTION function_signature
;
function_signature: IDENTIFIER LP parameter_list RP    
| IDENTIFIER LP RP
;
parameter_list: parameter_list COMMA IDENTIFIER 
| IDENTIFIER     
;
function_body: block | SEMICLN
;
block: LB statement_list RB
| LB RB
;
function_call: function_name LP argument_list RP
| function_name LP RP    
;
function_name: IDENTIFIER 
| builtin_function_id
;       
builtin_function_id: CONNECT
|TAKEOFF
|LAND
|FLIP_LEFT
|FLIP_RIGHT
|FLIP_FRONT
|FLIP_BACK
|GO
|GO_UP
|GO_FORWARD
|GO_DOWN
|GO_BACKWARD
|GO_LEFT
|GO_RIGHT
|ROTATE_C
|ROTATE_CC
|VIDEO_ON
|VIDEO_OFF
|TAKE_PIC
|EMERGENCY_STOP
|SET_SPEED
|SET_WIFI
|HOVER
|GET_SPEED
|GET_ALTITUDE
|GET_TEMPERATURE
|GET_ACCELERATION
|GET_INCLINATION
|GET_TIME
|GET_BATTERY
;
argument_list: expression
| expression COMMA argument_list
;         
input_statement: INPUT_CALL IN_OP expression
;
output_statement: OUTPUT_CALL OUT_OP expression
;
loop_statement: while
| for
;
while: WHILE_LOOP LP expression RP block
;
for: FOR_LOOP LP declaration_statement SEMICLN expression SEMICLN assignment_statement RP block
;
line_comment: LINE_COMMENT
;
block_comment: MULTILINE_COMMENT  
;
%%
#include "lex.yy.c"
int yyerror( char *s ) { 
    printf("\nError on line: %d\n Invalid Program! \n", lineno); 
    return -1;
}
int main() {
    return yyparse();   
}
