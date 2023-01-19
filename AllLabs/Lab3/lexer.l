%{
#include<stdbool.h>
#include"token.h"

int line_no = 1;
char idTable[100][50];
int idCount = 0;
bool id_in_table = false;
int id_no = 0;
void printTitle();
void printInfo(tokenType token);
%}

/*定义部分*/

NUMBER              ([1-9][0-9]*|0)
IDENTIFIER          ([_a-zA-Z][_a-zA-Z0-9]*)
OPERATOR            ([+\-*/%=,;!><(){}])
SINGLE_COMMENT      ("//"[^\n]*)
CHARCONSTANT        (\'.?\')
STRING              (\042[^\042\n]*\042)
%%

"\n"                { line_no++;              }       
"<="                { return LE;              }
">="                { return GE;              }
"=="                { return EQ;              }
"!="                { return NE;              }
"&&"                { return AND;             }
"||"                { return OR;              }
"main"              { return MAIN;            }   
"void"              { return VOID;            }
"int"               { return INT;             }
"char"              { return CHAR;            }
"while"             { return WHILE;           }
"if"                { return IF;              }
"else"              { return ELSE;            }
"return"            { return RETURN;          }
"break"             { return BREAK;           }
"continue"          { return CONTINUE;        }

{CHARCONSTANT}      { return CHARCONSTANT;    }    
{NUMBER}            { return NUMBER;          }
{STRING}            { return STRING;  }
{OPERATOR}          { return OPERATOR;        }
{SINGLE_COMMENT}    { /* do nothing*/         }
[ \t\r\a]+          { /* ignore all spaces */ }      
{IDENTIFIER}        { 
                      int i = 0;
                      for(;i<idCount;i++){
                          if(strcmp(yytext,idTable[i])==0){
                              id_in_table = true;  
                              break;      
                      }
                      }
                      if(!id_in_table)
                          strcpy(idTable[idCount++],yytext);
                      id_no = i;
                      id_in_table = false;
                      return IDENTIFIER;      }


%%

int main(int argc, char* argv[])
{
    int token;
    printTitle();
    while(token = yylex())
        printInfo(token);

    for(int i = 0;i<idCount;i++)
    {
        printf("%s\n",idTable[i]);
    }
    return 0;
}

void printInfo(tokenType token)
{ 
    if(token == IDENTIFIER){
        printf("%-20s%-20s%-20d%-20d\n",token_list[token-257],yytext,line_no,id_no);
    }
    else{
        printf("%-20s%-20s%-20d\n",token_list[token-257],yytext,line_no);
    }
}



void printTitle()
{
    printf("%-20s%-20s%-20s%-20s\n","Token","Lexme","LineNo","Attr");
    printf("------------------------------------------------------------------\n");
}

int yywrap(void) {
    return 1;
}