#include<stdio.h>

typedef enum{
    LE=257,GE,EQ,NE,AND,OR,NOT,
    MAIN,VOID,INT,WHILE,IF,ELSE,RETURN,BREAK,CONTINUE,
    NUMBER,IDENTIFIER,OPERATOR

}tokenType;


char* token_list[]=
{
    "LE","GE","EQ","NE","AND","OR","NOT",
    "MAIN","VOID","INT","WHILE","IF","ELSE","RETURN","BREAK","CONTINUE",
    "NUMBER","IDENTIFIER","OPERATOR"
};
