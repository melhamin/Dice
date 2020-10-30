%{
#include <stdio.h>
%}
digit [0-9]
letter [A-Za-z_]
number {digit}
sign [+-]
identifier ({letter}({letter}|{digit})*)  
nl "\n"
%%
{digit}+ return(NUMBER);
var return(VARIABLE);
if return(IF);
else return(ELSE);
[(] return(LP);
[)] return(RP);
[{] return(LB);
[}] return(RB);
[;] return(SEMICLN);
"//".*{nl} return(LINE_COMMENT);                           
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] return(MULTILINE_COMMENT);
[=] return(ASGNMNT_OP);                                       
[.] return(DOT);
[\"] return(STRING_IDNT);
[\'] return(CHAR_IDNT);
"||" return(OR_OP);
"&&" return(AND_OP);
[!] return(NOT_OP);
"==" return(EQUAL_OP);
"!=" return(NOT_EQUAL_OP);
[<] return(LESS_T_OP);
[>] return(GREATER_T_OP);
"<=" return(LT_OR_EQUAL_OP);
">=" return(GT_OR_EQUAL_OP);
[*] return(MUL_OP);
[/] return(DIV_OP);
[+] return(ADD_OP);
[-] return(SUB_OP);
[%] return(MOD_OP);
[,] return(COMMA);
">>" return(IN_OP);
"<<" return(OUT_OP);
[ ] ;
input return(INPUT_CALL);
print return(OUTPUT_CALL);
while return(WHILE_LOOP);
for return(FOR_LOOP);
function return(FUNCTION);
takeoff return(TAKEOFF);
land return(LAND);
flip_right return(FLIP_RIGHT);
flip_left return(FLIP_LEFT);
flip_front return(FLIP_FRONT);
flip_back return(FLIP_BACK);
go return(GO);
go_up return(GO_UP);
go_down return(GO_DOWN);
go_forward return(GO_FORWARD);
go_backward return(GO_BACKWARD);
go_left return(GO_LEFT);
go_right return(GO_RIGHT);
rotate_c return(ROTATE_C);
rotace_cc return(ROTATE_CC);
video_on return(VIDEO_ON);
video_off return(VIDEO_OFF);
take_pic return(TAKE_PIC);
emergency_stop return(EMERGENCY_STOP);
set_speed return(SET_SPEED);
set_wifi return(SET_WIFI);
hover return(HOVER);
get_speed return(GET_SPEED);
get_altitude return(GET_ALTITUDE);
get_temperature return(GET_TEMPERATURE);
get_acceleration return(GET_ACCELERATION);
get_inclination return(GET_INCLINATION);
get_time return(GET_TIME);
get_battery return(GET_BATTERY);
connect return(CONNECT);


{identifier} return(IDENTIFIER);
{nl} { extern int lineno; lineno++; }
%%
int yywrap() { 
    printf("\nValid Program!\n");
    return 1; 
}