#ifndef __AST_H__
#define __AST_H__

#include <fstream>
#include <vector>
#include "Type.h"
#include "SymbolTable.h"

class Node {
private:
    static int counter;
    int seq;
public:
    Node();

    int getSeq() const { return seq; };

    virtual void output(int level) = 0;
};

class ExprNode : public Node {
protected:
    SymbolEntry *se;
public:
    ExprNode(SymbolEntry *se) : se(se) {};

    virtual void getTypes(std::vector<Type *> &types) { types.push_back(se->getType()); };
};

class BinaryExpr : public ExprNode {
private:
    int op;
    ExprNode *expr1, *expr2;
public:
    enum {
        ADD, SUB, MUL, DIV, MOD, AND, OR, GREAT, LESS, GREATEQ, LESSEQ, EQ, NEQ
    };

    BinaryExpr(SymbolEntry *se, int op, ExprNode *expr1, ExprNode *expr2) : ExprNode(se), op(op), expr1(expr1),
                                                                            expr2(expr2) {};

    void output(int level);
};

class UnaryExpr : public ExprNode {
private:
    int op;
    ExprNode *expr;
public:
    enum {
        ADD, SUB, NOT
    };

    UnaryExpr(SymbolEntry *se, int op, ExprNode *expr) : ExprNode(se), op(op), expr(expr) {};

    void output(int level);
};

class Constant : public ExprNode {
public:
    Constant(SymbolEntry *se) : ExprNode(se) {};

    void output(int level);
};

class Id : public ExprNode {
public:
    Id(SymbolEntry *se) : ExprNode(se) {};

    void output(int level);
};

class StmtNode : public Node {
};

class CompoundStmt : public StmtNode {
private:
    StmtNode *stmt;
public:
    CompoundStmt(StmtNode *stmt) : stmt(stmt) {};

    void output(int level);
};

class SeqNode : public StmtNode {
private:
    StmtNode *stmt1, *stmt2;
public:
    SeqNode(StmtNode *stmt1, StmtNode *stmt2) : stmt1(stmt1), stmt2(stmt2) {};

    void output(int level);
};

class DeclStmt : public StmtNode {
private:
    Id *id;
    ExprNode *initVal;
public:
    DeclStmt(Id *id) : id(id) { initVal = nullptr; };

    DeclStmt(Id *id, ExprNode *initVal) : id(id), initVal(initVal) {};

    void output(int level);
};

class ConstDecl : public StmtNode {
private:
    Id *id;
    ExprNode *initVal;
public:
    ConstDecl(Id *id, ExprNode *initVal) : id(id), initVal(initVal) {};

    void output(int level);
};

class DefList : public StmtNode {
private:
    StmtNode *def1;
    StmtNode *def2;
public:
    DefList(StmtNode *stmt1, StmtNode *stmt2) : def1(stmt1), def2(stmt2) {};

    void output(int level);
};

class IfStmt : public StmtNode {
private:
    ExprNode *cond;
    StmtNode *thenStmt;
public:
    IfStmt(ExprNode *cond, StmtNode *thenStmt) : cond(cond), thenStmt(thenStmt) {};

    void output(int level);
};

class IfElseStmt : public StmtNode {
private:
    ExprNode *cond;
    StmtNode *thenStmt;
    StmtNode *elseStmt;
public:
    IfElseStmt(ExprNode *cond, StmtNode *thenStmt, StmtNode *elseStmt) : cond(cond), thenStmt(thenStmt),
                                                                         elseStmt(elseStmt) {};

    void output(int level);
};

class WhileStmt : public StmtNode {
private:
    ExprNode *cond;
    StmtNode *loopBodyStmt;
public:
    WhileStmt(ExprNode *cond, StmtNode *loopBodyStmt) : cond(cond), loopBodyStmt(loopBodyStmt) {};

    void output(int level);
};

class ReturnStmt : public StmtNode {
private:
    ExprNode *retValue;
public:
    ReturnStmt(ExprNode *retValue) : retValue(retValue) {};

    void output(int level);
};

class AssignStmt : public StmtNode {
private:
    ExprNode *lval;
    ExprNode *expr;
public:
    AssignStmt(ExprNode *lval, ExprNode *expr) : lval(lval), expr(expr) {};

    void output(int level);
};

class ExpStmt : public StmtNode {
private:
    ExprNode *expr;
public:
    ExpStmt(ExprNode *expr) : expr(expr) {};

    void output(int level);
};

class FuncRParams : public ExprNode {
private:
    ExprNode *params;
    ExprNode *param;
public:
    FuncRParams(ExprNode *params, ExprNode *param) : ExprNode(nullptr), params(params), param(param) {};

    void output(int level);
};

class FuncFParams : public ExprNode {
private:
    ExprNode *params;
    ExprNode *param;
public:
    FuncFParams(ExprNode *params, ExprNode *param) : ExprNode(nullptr), params(params), param(param) {};

    void output(int level);

    void getTypes(std::vector<Type *> &types) {
        params->getTypes(types);
        param->getTypes(types);
    };
};

class FuncFParam : public ExprNode {
public:
    FuncFParam(SymbolEntry *se) : ExprNode(se) {};

    void output(int level);
};

class FunctionDef : public StmtNode {
private:
    SymbolEntry *se;
    ExprNode *params;
    StmtNode *stmt;
public:
    FunctionDef(SymbolEntry *se, ExprNode *params, StmtNode *stmt) : se(se), params(params), stmt(stmt) {};

    void output(int level);
};

class FuncCallExpr : public ExprNode {
private:
    SymbolEntry *t;
    ExprNode *params;
public:
    FuncCallExpr(SymbolEntry *se, SymbolEntry *t, ExprNode *params) : ExprNode(se), t(t), params(params) {};

    void output(int level);
};

class EmptyStmt : public StmtNode {
public:
    EmptyStmt() {};

    void output(int level);
};

class Ast {
private:
    Node *root;
public:
    Ast() { root = nullptr; }

    void setRoot(Node *n) { root = n; }

    void output();
};

#endif
