%{
#include <stdio.h>
int lineno;
%}


%token NUMBER VARIABLE IF LP RP LB RB SEMICLN SINGLE_LINE_COMMENT MULTILINE_COMMENT 
%token ASGNMNT_OP DOT STRING_IDNT CHAR_IDNT OR_OP AND_OP NOT_OP EQUAL_OP NOT_EQUAL_OP
%token LESS_T_OP GREATER_T_OP LT_OR_EQUAL_OP GT_OR_EQUAL_OP MUL_OP DIV_OP
%token ADD_OP SUB_OP MOD_OP COMMA INPUT_CALL OUTPUT_CALL WHILE_LOOP FOR_LOOP
%token FUNCTION IDENTIFIER ELSE IN_OP OUT_OP

%start program

%right EQUALS  // TODO  

%left GT_CMP LT_CMP NEQ_CMP LTEQ_CMP GTEQ_CMP   // TODO

%left PLUS MINUS   // TODO

%left MUL DIV    // TODO

%nonassoc IF     // TODO

%nonassoc ELSE   // TODO

%%
program: statement_List
;
statement_List:
statement
| statement_List SEMICLN statement
;
statement: declaration_statement
| assignment_statement
| function_call
| conditional_statement
| loop_statement
| builtin_functions
;
declaration_statement: VARIABLE IDENTIFIER
| VARIABLE IDENTIFIER ASGNMNT_OP IDENTIFIER
| VARIABLE IDENTIFIER ASGNMNT_OP expression
;
assignment_statement: IDENTIFIER ASGNMNT_OP IDENTIFIER
| IDENTIFIER ASGNMNT_OP expression
| IDENTIFIER ASGNMNT_OP function_call
;
conditional_statement : IF LP expression RP LB statement_List RB
| IF LP expression RP LB statement_list LCB ELSE LB statement_list RB
;
expression  : arithmetic 
| relational 
| not_expression 
;
arithmetic : arithmetic ADD_OP mult_div   
| arithmetic SUB_OP mult_div
| mult_div
;
mult_div : mult_div MUL_OP in_paranthesis
| mult_div DIV_OP in_paranthesis
| mult_div MOD_OP in_paranthesis
| in_paranthesis
;
in_paranthesis : LP arithmetic RP
| NUMBER
| IDENTIFIER
| function_call
;
relational : in_paranthesis relational_operator in_paranthesis
;
relational_operator : LESS_T_OP
| LT_OR_EQUAL_OP
| GREATER_T_OP
| GT_OR_EQUAL_OP
| AND_OP
| OR_OP
| EQUAL_OP
| NOT_EQUAL_OP                                             
;
not_expression : NOT_OP in_paranthesis
| NOT_OP LP relational RP
| NOT_OP function_call
;
function_definition : function_header function_body
;
function_header     : FUNCTION function_signature
;
function_signature  : function_name LP parameter_list RP    
| function_name LP RP
;
parameter_list      : parameter_list comma IDENTIFIER 
| IDENTIFIER     
;
function_body       : block | SEMICLN
;
block               : LB statement_List RB
| LB RB
;
function_call       : function_name LP argument_list RP
| function_name LP RP    
;
function_name       : IDENTIFIER 
| builtin_function_id
;                   
input_statement : INPUT_CALL IN_OP IDENTIFIER
;
output_statement : OUTPUT_CALL OUT_OP expression
;
loop_statement : while
| for
;
while : WHILE_LOOP LP expression RP LB statement_List RB
| WHILE_LOOP LP function_call RP LB RB
| WHILE_LOOP LP expression RP LB RB
;
for : FOR_LOOP LP assignment_statement SEMICLN expression SEMICLN assignment_statement RP LB statement_List RB
| FOR_LOOP LP assignment_statement SEMICLN expression SEMICLN assignment_statement RP LB RB
;
line_comment : SINGLE_LINE_COMMENT
;
block_comment : MULTILINE_COMMENT  
;
%%
#include "lex.yy.c"
int main() {
return yyparse();
}int yyerror( char *s ) { printf("Error on line: %d\n Invalid Program! \n", 1 + lineno); }
