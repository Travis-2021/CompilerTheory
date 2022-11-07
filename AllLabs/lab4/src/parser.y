%code top{
    #include <iostream>
    #include <assert.h>
    #include "parser.h"
    extern Ast ast;
    int yylex();
    int yyerror( char const * );
    Type *global_type;
}

%code requires {
    #include "Ast.h"
    #include "SymbolTable.h"
    #include "Type.h"
}

%union {
    int itype;
    char* strtype;
    StmtNode* stmttype;
    ExprNode* exprtype;
    Type* type;
}

%start Program
%token <strtype> ID 
%token <itype> INTEGER
%token IF ELSE WHILE
%token INT VOID CONST
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA
%token ADD SUB OR AND LESS ASSIGN
%token EQ NEQ GREAT GREATEQ LESSEQ MUL DIV MOD NOT
%token RETURN

%nterm <stmttype> Stmts Stmt AssignStmt BlockStmt IfStmt ReturnStmt DeclStmt FuncDef
%nterm <stmttype> ConstDecl ConstDefList ConstDef VarDecl VarDefList VarDef ExpStmt WhileStmt 
%nterm <exprtype> Exp AddExp Cond LOrExp PrimaryExp LVal RelExp LAndExp
%nterm <exprtype> EqExp MulExp UnaryExp FuncRParams OptFuncFParams FuncFParams FuncFParam
%nterm <type> Type

%precedence THEN
%precedence ELSE
%%
Program
    : Stmts {
        ast.setRoot($1);
    }
    ;
Stmts
    : Stmt {$$=$1;}
    | Stmts Stmt{
        $$ = new SeqNode($1, $2);
    }
    ;
Stmt
    : AssignStmt {$$=$1;}
    | ExpStmt {$$=$1;}
    | BlockStmt {$$=$1;}
    | IfStmt {$$=$1;}
    | WhileStmt {$$=$1;}
    | ReturnStmt {$$=$1;}
    | DeclStmt {$$=$1;}
    | FuncDef {$$=$1;}
    | SEMICOLON {$$=new EmptyStmt();}
    ;
LVal
    : ID {
        SymbolEntry *se;
        se = identifiers->lookup($1);
        if(se == nullptr)
        {
            fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
            delete [](char*)$1;
            assert(se != nullptr);
        }
        $$ = new Id(se);
        delete []$1;
    }
    ;
AssignStmt
    :
    LVal ASSIGN Exp SEMICOLON {
        $$ = new AssignStmt($1, $3);
    }
    ;

ExpStmt
    :
    Exp SEMICOLON {
        $$ = new ExpStmt($1);
    }
    ;

BlockStmt
    :   LBRACE 
        {identifiers = new SymbolTable(identifiers);} 
        Stmts RBRACE 
        {
            $$ = new CompoundStmt($3);
            SymbolTable *top = identifiers;
            identifiers = identifiers->getPrev();
            delete top;
        }
    | LBRACE RBRACE {
        $$=new EmptyStmt();
    }
    ;
IfStmt
    : IF LPAREN Cond RPAREN Stmt %prec THEN {
        $$ = new IfStmt($3, $5);
    }
    | IF LPAREN Cond RPAREN Stmt ELSE Stmt {
        $$ = new IfElseStmt($3, $5, $7);
    }
    ;
    
WhileStmt
    : WHILE LPAREN Cond RPAREN Stmt {
        $$ = new WhileStmt($3, $5);
    }
    ;

ReturnStmt
    :
    RETURN Exp SEMICOLON{
        $$ = new ReturnStmt($2);
    }
    ;
Exp
    :
    AddExp {$$ = $1;}
    ;
Cond
    :
    LOrExp {$$ = $1;}
    ;
PrimaryExp
    : LPAREN Exp RPAREN {
        $$ = $2;
    }
    | LVal {
        $$ = $1;
    }
    | INTEGER {
        SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, $1);
        $$ = new Constant(se);
    }
    ;
AddExp
    : MulExp {$$ = $1;}
    | AddExp ADD MulExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::ADD, $1, $3);
    }
    | AddExp SUB MulExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::SUB, $1, $3);
    }
    ;

MulExp
    : UnaryExp {$$=$1;}
    | MulExp MUL UnaryExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::MUL, $1, $3);
    }
    | MulExp DIV UnaryExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::DIV, $1, $3);
    }
    | MulExp MOD UnaryExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::MOD, $1, $3);
    }
    ;

UnaryExp
    : PrimaryExp {$$=$1;}
    | ID LPAREN FuncRParams RPAREN {
        SymbolEntry *t;
        t = identifiers->lookup($1);
        assert(t != nullptr);
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new FuncCallExpr(se, t, $3);
        delete []$1;
    }
    | ID LPAREN RPAREN {
        SymbolEntry *t;
        t = identifiers->lookup($1);
        assert(t != nullptr);
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new FuncCallExpr(se, t, nullptr);
        delete []$1;
    }
    | ADD UnaryExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new UnaryExpr(se, UnaryExpr::ADD, $2);
    }
    | SUB UnaryExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new UnaryExpr(se, UnaryExpr::SUB, $2);
    }
    | NOT UnaryExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new UnaryExpr(se, UnaryExpr::NOT, $2);
    }
    ;

FuncRParams
    : Exp {$$=$1;}
    | FuncRParams COMMA Exp {
        $$ = new FuncRParams($1,$3);
    }

RelExp
    : AddExp {$$ = $1;}
    | RelExp LESS AddExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::LESS, $1, $3);
    }
    | RelExp GREAT AddExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::GREAT, $1, $3);
    }
    | RelExp LESSEQ AddExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::LESSEQ, $1, $3);
    }
    | RelExp GREATEQ AddExp{
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::GREATEQ, $1, $3);
    }
    ;

EqExp
    : RelExp {$$=$1;}
    | EqExp EQ RelExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::EQ, $1, $3);
    }
    | EqExp NEQ RelExp {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::NEQ, $1, $3);
    }
LAndExp
    :
    EqExp {$$ = $1;}
    |
    LAndExp AND EqExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::AND, $1, $3);
    }
    ;
LOrExp
    :
    LAndExp {$$ = $1;}
    |
    LOrExp OR LAndExp
    {
        SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
        $$ = new BinaryExpr(se, BinaryExpr::OR, $1, $3);
    }
    ;
Type
    : INT {
        $$ = TypeSystem::intType;
        global_type = TypeSystem::intType;
    }
    | VOID {
        $$ = TypeSystem::voidType;
        global_type = TypeSystem::voidType;
    }
    ;


DeclStmt
    :
    ConstDecl {$$=$1;}
    |
    VarDecl {$$=$1;}
    ;
ConstDecl
    :
    CONST Type ConstDefList SEMICOLON {
        $$ = $3;
    }
    ;
ConstDefList
    :
    ConstDef{$$=$1;}
    |
    ConstDefList COMMA ConstDef
    {
        $$ = new DefList($1, $3);
    }
    ;
ConstDef
    :
    ID ASSIGN Exp {
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(global_type, $1, identifiers->getLevel());
        identifiers->install($1, se);
        $$ = new ConstDecl(new Id(se), $3);
        delete []$1;
    }
    ;
VarDecl
    :
    Type VarDefList SEMICOLON {
        $$ = $2;
    }
    ;
VarDefList
    :
    VarDefList COMMA VarDef {
        $$ = new DefList($1, $3);
    }
    |
    VarDef{
        $$ = $1;
    }
    ;
VarDef
    :
    ID {
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(global_type, $1, identifiers->getLevel());
        identifiers->install($1, se);
        $$ = new DeclStmt(new Id(se));
        delete []$1;
    }
    |
    ID ASSIGN Exp {
        SymbolEntry *se;
        se = new IdentifierSymbolEntry(global_type, $1, identifiers->getLevel());
        identifiers->install($1, se);
        $$ = new DeclStmt(new Id(se), $3);
        delete []$1;
    }
    ;

FuncDef
    :
    Type ID {
        SymbolEntry *se = new IdentifierSymbolEntry(nullptr, $2, identifiers->getLevel());
        identifiers->install($2, se);
        identifiers = new SymbolTable(identifiers);
    }
    LPAREN OptFuncFParams RPAREN
    BlockStmt
    {
        SymbolEntry *se;
        se = identifiers->lookup($2);
        assert(se != nullptr);
        Type *funcType;
        std::vector<Type*> paramsType;
        if($5!=nullptr)
            $5->getTypes(paramsType);
        funcType = new FunctionType($1,paramsType);
        se->setType(funcType);
        $$ = new FunctionDef(se, $5, $7);
        SymbolTable *top = identifiers;
        identifiers = identifiers->getPrev();
        delete top;
        delete []$2;
    }
    ;

OptFuncFParams
    : FuncFParams {$$ = $1;}
    | %empty {$$=nullptr;}
    ;

FuncFParams
    : FuncFParam {$$ = $1;}
    | FuncFParams COMMA FuncFParam{
        $$=new FuncFParams($1,$3);
    }
    ;

FuncFParam
    : Type ID {
        SymbolEntry *se = new IdentifierSymbolEntry($1, $2, identifiers->getLevel());
        identifiers->install($2, se);
        $$ = new FuncFParam(se);
    }
    ;

%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
