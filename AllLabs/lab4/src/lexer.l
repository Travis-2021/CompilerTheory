%option noyywrap
%{
    #define YY_NO_UNPUT
    #define YY_NO_INPUT

    #include "parser.h"
    #include <ostream>
    #include <fstream>
    #include <string>
    using namespace std;

    extern FILE *yyin; 
    extern FILE *yyout;
    extern bool dump_tokens;

    void DEBUG_FOR_LAB4(std::string s){
        std::string DEBUG_INFO = "[DEBUG LAB4]: \t" + s + "\n";
        fputs(DEBUG_INFO.c_str(), yyout);
    }
%}

BIN ((0b|0B)[0|1]*)
OCT (0[0-7]+)
DEC ([1-9][0-9]*|0)
HEX ((0x|0X)[(0-9)|(a-f)|(A-F)]+)

ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]

LINECOMMENT \/\/[^\n]*
commentbegin "/*"
commentelement .|\n
commentend "*/"

%x BLOCKCOMMENT

%%
{LINECOMMENT} {
    if(dump_tokens)
        fprintf(yyout,"Begin a lineComment:\n");
}
{commentbegin} {
    BEGIN BLOCKCOMMENT;
    if(dump_tokens)
        fprintf(yyout,"Begin a blockComment:\n");
}
<BLOCKCOMMENT>{commentelement} {
    if(dump_tokens)
        fprintf(yyout,"%s",yytext);
}
<BLOCKCOMMENT>{commentend} {
    BEGIN INITIAL;
    if(dump_tokens)
        fprintf(yyout,"\nThis blockComment end!\n");
}

"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    if(dump_tokens)
        DEBUG_FOR_LAB4("INT\tint");
    return INT;
}
"void" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("VOID\tvoid");
    return VOID;
}
"const" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("CONST\tconst");
    return CONST;
}
"if" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("IF\tif");
    return IF;
};
"else" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ELSE\telse");
    return ELSE;
};
"while" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("WHILE\twhile");
    return WHILE;
}
"return" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RETURN\treturn");
    return RETURN;
}
"=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ASSIGN\t=");
    return ASSIGN;
}
">=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("GREATEQ\t>=");
    return GREATEQ;
}
"<=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LESSEQ\t<=");
    return LESSEQ;
}
">" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("GREAT\t>");
    return GREAT;
}
"<" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LESS\t<");
    return LESS;
}
"+" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("ADD\t+");
    return ADD;
}
"-" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("SUB\t-");
    return SUB;
}
"*" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("MUL\t*");
    return MUL;
}
"/" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("DIV\t/");
    return DIV;
}
"%" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("MOD\t%");
    return MOD;
}
"==" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("EQ\t==");
    return EQ;
}
"!=" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("NEQ\t!=");
    return NEQ;
}
"&&" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("AND\t&&");
    return AND;
}
"||" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("OR\t||");
    return OR;
}
"!" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("NOT\t!");
    return NOT;
}
"," {
    if(dump_tokens)
        DEBUG_FOR_LAB4("COMMA\t,");
    return COMMA;
}
";" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("SEMICOLON\t;");
    return SEMICOLON;
}
"(" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LPAREN\t(");
    return LPAREN;
}
")" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RPAREN\t)");
    return RPAREN;
}
"{" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("LBRACE\t{");
    return LBRACE;
}
"}" {
    if(dump_tokens)
        DEBUG_FOR_LAB4("RBRACE\t}");
    return RBRACE;
}

{BIN}  {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    string str = yytext_ptr + 2;
    yylval.itype = stoi(str, nullptr, 2);
    return INTEGER;
}
{OCT}  {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    string str = yytext_ptr + 1;
    yylval.itype = stoi(str, nullptr, 8);
    return INTEGER;
}
{DEC}  {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    yylval.itype = atoi(yytext);
    return INTEGER;
}
{HEX}  {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    string str = yytext_ptr + 2;
    yylval.itype = stoi(str, nullptr, 16);
    return INTEGER;
}

{ID} {
    if(dump_tokens)
        DEBUG_FOR_LAB4(yytext);
    char *lexeme;
    lexeme = new char[strlen(yytext) + 1];
    strcpy(lexeme, yytext);
    yylval.strtype = lexeme;
    return ID;
}
{EOL} yylineno++;
{WHITE}
%%
