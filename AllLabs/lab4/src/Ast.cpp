#include "Ast.h"
#include "SymbolTable.h"
#include <string>
#include "Type.h"

extern FILE *yyout;
int Node::counter = 0;

Node::Node() {
    seq = counter++;
}

void Ast::output() {
    fprintf(yyout, "program\n");
    if (root != nullptr)
        root->output(4);
}

void BinaryExpr::output(int level) {
    std::string op_str;
    switch (op) {
        case ADD:
            op_str = "add";
            break;
        case SUB:
            op_str = "sub";
            break;
        case MUL:
            op_str = "mul";
            break;
        case DIV:
            op_str = "div";
            break;
        case MOD:
            op_str = "mod";
            break;
        case AND:
            op_str = "and";
            break;
        case OR:
            op_str = "or";
            break;
        case GREAT:
            op_str = "great";
            break;
        case LESS:
            op_str = "less";
            break;
        case GREATEQ:
            op_str = "greateq";
            break;
        case LESSEQ:
            op_str = "lesseq";
            break;
        case EQ:
            op_str = "eq";
            break;
        case NEQ:
            op_str = "neq";
            break;
    }
    fprintf(yyout, "%*cBinaryExpr\top: %s\n", level, ' ', op_str.c_str());
    if (expr1 != nullptr)
        expr1->output(level + 4);
    if (expr2 != nullptr)
        expr2->output(level + 4);
}

void UnaryExpr::output(int level) {
    std::string op_str;
    switch (op) {
        case ADD:
            op_str = "add";
            break;
        case SUB:
            op_str = "sub";
            break;
        case NOT:
            op_str = "not";
            break;
    }
    fprintf(yyout, "%*cUnaryExpr\top: %s\n", level, ' ', op_str.c_str());
    if (expr != nullptr)
        expr->output(level + 4);
}


void Constant::output(int level) {
    std::string type, value;
    type = se->getType()->toStr();
    value = se->toStr();
    fprintf(yyout, "%*cIntegerLiteral\tvalue: %s\ttype: %s\n", level, ' ',
            value.c_str(), type.c_str());
}

void Id::output(int level) {
    std::string name, type;
    int scope;
    name = se->toStr();
    type = se->getType()->toStr();
    scope = dynamic_cast<IdentifierSymbolEntry *>(se)->getScope();
    fprintf(yyout, "%*cId\tname: %s\tscope: %d\ttype: %s\n", level, ' ',
            name.c_str(), scope, type.c_str());
}

void CompoundStmt::output(int level) {
    fprintf(yyout, "%*cCompoundStmt\n", level, ' ');
    if (stmt != nullptr)
        stmt->output(level + 4);
}

void SeqNode::output(int level) {
    fprintf(yyout, "%*cSequence\n", level, ' ');
    if (stmt1 != nullptr)
        stmt1->output(level + 4);
    if (stmt2 != nullptr)
        stmt2->output(level + 4);
}

void DeclStmt::output(int level) {
    fprintf(yyout, "%*cDeclStmt\n", level, ' ');
    if (id != nullptr)
        id->output(level + 4);
}

void ConstDecl::output(int level) {
    fprintf(yyout, "%*cConstDecl\n", level, ' ');
    if (id != nullptr)
        id->output(level + 4);
    if (initVal != nullptr)
        initVal->output(level + 4);
}

void DefList::output(int level) {
    fprintf(yyout, "%*cDefList\n", level, ' ');
    if (def1 != nullptr)
        def1->output(level + 4);
    if (def2 != nullptr)
        def2->output(level + 4);
}

void IfStmt::output(int level) {
    fprintf(yyout, "%*cIfStmt\n", level, ' ');
    if (cond != nullptr)
        cond->output(level + 4);
    if (thenStmt != nullptr)
        thenStmt->output(level + 4);
}

void IfElseStmt::output(int level) {
    fprintf(yyout, "%*cIfElseStmt\n", level, ' ');
    if (cond != nullptr)
        cond->output(level + 4);
    if (thenStmt != nullptr)
        thenStmt->output(level + 4);
    if (elseStmt != nullptr)
        elseStmt->output(level + 4);
}

void WhileStmt::output(int level) {
    fprintf(yyout, "%*cWhileStmt\n", level, ' ');
    if (cond != nullptr)
        cond->output(level + 4);
    if (loopBodyStmt != nullptr)
        loopBodyStmt->output(level + 4);
}

void ReturnStmt::output(int level) {
    fprintf(yyout, "%*cReturnStmt\n", level, ' ');
    if (retValue != nullptr)
        retValue->output(level + 4);
}

void AssignStmt::output(int level) {
    fprintf(yyout, "%*cAssignStmt\n", level, ' ');
    if (lval != nullptr)
        lval->output(level + 4);
    if (expr != nullptr)
        expr->output(level + 4);
}

void ExpStmt::output(int level) {
    fprintf(yyout, "%*cExpStmt\n", level, ' ');
    if (expr != nullptr)
        expr->output(level + 4);
}

void FunctionDef::output(int level) {
    std::string name, type;
    name = se->toStr();
    type = se->getType()->toStr();
    fprintf(yyout, "%*cFunctionDefine function name: %s, type: %s\n", level, ' ',
            name.c_str(), type.c_str());
    if (params != nullptr)
        params->output(level + 4);
    if (stmt != nullptr)
        stmt->output(level + 4);
}

void FuncCallExpr::output(int level) {
    std::string name, type;
    name = t->toStr();
    type = t->getType()->toStr();
    fprintf(yyout, "%*cFuncCallExpr function name: %s, type: %s\n", level, ' ',
            name.c_str(), type.c_str());
    if (params != nullptr)
        params->output(level + 4);
}

void FuncRParams::output(int level) {
    fprintf(yyout, "%*cFuncRParams\n", level, ' ');
    if (params != nullptr)
        params->output(level + 4);
    if (param != nullptr)
        param->output(level + 4);
}

void FuncFParams::output(int level) {
    fprintf(yyout, "%*cFuncFParams\n", level, ' ');
    if (params != nullptr)
        params->output(level + 4);
    if (param != nullptr)
        param->output(level + 4);
}

void FuncFParam::output(int level) {
    std::string name, type;
    name = se->toStr();
    type = se->getType()->toStr();
    fprintf(yyout, "%*cFuncFParam param name: %s, type: %s\n", level, ' ',
            name.c_str(), type.c_str());
}

void EmptyStmt::output(int level) {
    fprintf(yyout, "%*cEmptyStmt\n", level, ' ');
}
