%option main
digit [0-9]
letter [A-Za-z_]
number {digit}
sign [+-]
identifier ({letter}({letter}|{digit})*)  
builtin_func ("take_off"|"land"|"flip_left"|"flip_right"|"flip_front"|"flip_back"|"go"|"go_up"|"go_down"|"go_forward"|"go_backward"|"go_left"|"go_right"|"rotate_c"|"rotate_cc"|"video_on"|"video_off"|"take_pic"|"emergency_stop"|"set_speed"|"set_wifi"|"hover"|"get_speed"|"get_altitude"|"get_temperature"|"get_acceleration"|"get_inclination"|"get_time"|"get_battery"|"connect")
%%
{digit}+ printf(" NUMBER");
var printf(" VARIABLE");
if printf(" IF");
[(] printf(" LP");
[)] printf(" RP");
[{] printf(" LB");
[}] printf(" RB");
[;] printf(" SEMICLN");
"//".* printf(" SINGLE_LINE_COMMENT");                           
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] printf("MULTILINE_COMMENT");
[=] printf(" ASGNMNT_OP");                                       
[.] printf(" DOT");
[\"] printf(" STRING_IDNT");
[\'] printf(" CHAR_IDNT");
"||" printf(" OR_OP");
"&&" printf(" AND_OP");
[!] printf(" NOT_OP");
"==" printf(" EQUAL_OP");
"!=" printf(" NOT_EQUAL_OP");
[<] printf(" LESS_T_OP");
[>] printf(" GREATER_T_OP");
"<=" printf(" LT_OR_EQUAL_OP");
">=" printf(" GT_OR_EQUAL_OP");
[*] printf(" MUL_OP");
[/] printf(" DIV_OP");
[+] printf(" ADD_OP");
[-] printf(" SUB_OP");
[%] printf(" MOD_OP");
[,] printf(" COMMA");
[ ] ;
input printf(" INPUT_CALL");
print printf(" OUTPUT_CALL");
while printf(" WHILE_LOOP");
for printf(" FOR_LOOP");
function printf("FUNCTION");
{builtin_func} printf(" BUILTIN_FUNC");
{identifier} printf(" IDENTIFIER");
%%



