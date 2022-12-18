#ifndef __AST_H__
#define __AST_H__

#include <fstream>
#include "Operand.h"
#include <vector>
#include "Type.h"
#include "SymbolTable.h"

class SymbolEntry;
class Unit;
class Function;
class BasicBlock;
class Instruction;
class IRBuilder;

class Node
{
private:
    static int counter;
    int seq;
protected:
    std::vector<Instruction*> true_list;
    std::vector<Instruction*> false_list;
    static IRBuilder *builder;
    void backPatch(std::vector<Instruction*> &list, BasicBlock*bb);
    std::vector<Instruction*> merge(std::vector<Instruction*> &list1, std::vector<Instruction*> &list2);

public:
    Node();
    int getSeq() const {return seq;};
    static void setIRBuilder(IRBuilder*ib) {builder = ib;};
    virtual void output(int level) = 0;
    virtual void typeCheck() = 0;
    virtual void genCode() = 0;
    std::vector<Instruction*>& trueList() {return true_list;}
    std::vector<Instruction*>& falseList() {return false_list;}
};

class ExprNode : public Node
{
protected:
    SymbolEntry *se;
    Operand *dst;   // The result of the subtree is stored into dst.
public:
    ExprNode(SymbolEntry *se) : se(se){};
    virtual void getTypes(std::vector<Type*> &types){types.push_back(se->getType());};
    Operand* getOperand() {return dst;};
    SymbolEntry* getSymPtr() {return se;};
    //获取所有的符号表项 (形参)
    virtual void getSymbolEntrys(std::vector<SymbolEntry*>&ses){ses.push_back(se);};
    //（实参）
    virtual void getOperands(std::vector<Operand*> &operands){operands.push_back(dst);};
};

class BinaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr1, *expr2;
public:
    enum {AND, OR, GREAT, LESS, GREATEQ, LESSEQ, EQ, NEQ, ADD, SUB, MUL, DIV, MOD};
    BinaryExpr(SymbolEntry *se, int op, ExprNode*expr1, ExprNode*expr2) : ExprNode(se), op(op), expr1(expr1), expr2(expr2){dst = new Operand(se);};
    void output(int level);
    void typeCheck();
    void genCode();
};

class UnaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr;
public:
    enum {ADD, SUB, NOT};
    UnaryExpr(SymbolEntry *se, int op, ExprNode*expr) : ExprNode(se), op(op), expr(expr) {dst = new Operand(se);};
    void output(int level);
    void typeCheck();
    void genCode();
};

class Constant : public ExprNode
{
public:
    Constant(SymbolEntry *se) : ExprNode(se){dst = new Operand(se);};
    void output(int level);
    void typeCheck();
    void genCode();
};

class Id : public ExprNode
{
public:
    Id(SymbolEntry *se) : ExprNode(se){SymbolEntry *temp = new TemporarySymbolEntry(se->getType(), SymbolTable::getLabel()); dst = new Operand(temp);};
    void output(int level);
    void typeCheck();
    void genCode();
};

//隐式转换表达式
class TypeCastExpr : public ExprNode
{
private:
    ExprNode* expr;
public:
    TypeCastExpr(ExprNode* expr, Type* dstType) : ExprNode(nullptr),expr(expr){
        se = new TemporarySymbolEntry(dstType, SymbolTable::getLabel());
        dst = new Operand(se);
    };
    void output(int level);
    void typeCheck();
    void genCode();
};

class StmtNode : public Node
{};

class CompoundStmt : public StmtNode
{
private:
    StmtNode *stmt;
public:
    CompoundStmt(StmtNode *stmt) : stmt(stmt) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class SeqNode : public StmtNode
{
private:
    StmtNode *stmt1, *stmt2;
public:
    SeqNode(StmtNode *stmt1, StmtNode *stmt2) : stmt1(stmt1), stmt2(stmt2){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class DeclStmt : public StmtNode
{
private:
    Id *id;
    ExprNode *initVal;
public:
    DeclStmt(Id *id) : id(id){initVal = nullptr;};
    DeclStmt(Id *id, ExprNode *initVal) : id(id), initVal(initVal){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class ConstDecl : public StmtNode
{
private:
    Id *id;
    ExprNode *initVal;
public:
    ConstDecl(Id *id, ExprNode *initVal) : id(id), initVal(initVal){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class DefList : public StmtNode
{
private:
    StmtNode *def1;
    StmtNode *def2;
public:
    DefList(StmtNode*stmt1, StmtNode*stmt2) : def1(stmt1), def2(stmt2) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class IfStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
public:
    IfStmt(ExprNode *cond, StmtNode *thenStmt) : cond(cond), thenStmt(thenStmt){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class IfElseStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
    StmtNode *elseStmt;
public:
    IfElseStmt(ExprNode *cond, StmtNode *thenStmt, StmtNode *elseStmt) : cond(cond), thenStmt(thenStmt), elseStmt(elseStmt) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class WhileStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *loopBodyStmt;
public:
    WhileStmt(ExprNode *cond, StmtNode *loopBodyStmt) : cond(cond), loopBodyStmt(loopBodyStmt) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class ReturnStmt : public StmtNode
{
private:
    ExprNode *retValue;
public:
    ReturnStmt(ExprNode*retValue) : retValue(retValue) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class AssignStmt : public StmtNode
{
private:
    ExprNode *lval;
    ExprNode *expr;
public:
    AssignStmt(ExprNode *lval, ExprNode *expr) : lval(lval), expr(expr) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class ExpStmt : public StmtNode
{
private:
    ExprNode *expr;
public:
    ExpStmt(ExprNode *expr) : expr(expr) {};
    void output(int level);
    void typeCheck();
    void genCode();
};

class FuncRParams : public ExprNode
{
private:
    ExprNode *params;
    ExprNode *param;
public:
    FuncRParams(ExprNode *params, ExprNode *param) : ExprNode(nullptr), params(params), param(param) {};
    void output(int level);
    void typeCheck();
    void genCode(); 
    void getOperands(std::vector<Operand*>&operands);
};

class FuncFParams : public ExprNode
{
private:
    ExprNode *params;
    ExprNode *param;
public:
    FuncFParams(ExprNode *params, ExprNode *param) : ExprNode(nullptr), params(params), param(param) {};
    void output(int level);
    void getTypes(std::vector<Type *>&types){
        params->getTypes(types);
        param->getTypes(types);
    };
    void typeCheck();
    void genCode(); 
    void getSymbolEntrys(std::vector<SymbolEntry*>&ses);
};

class FuncFParam : public ExprNode
{
public:
    FuncFParam(SymbolEntry *se) : ExprNode(se) {};
    void output(int level);
    void typeCheck();  //不需要？？？
    void genCode(); 
};

class FunctionDef : public StmtNode
{
private:
    SymbolEntry *se;
    ExprNode *params;
    StmtNode *stmt;
public:
    FunctionDef(SymbolEntry *se, ExprNode *params, StmtNode *stmt) : se(se), params(params), stmt(stmt){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class FuncCallExpr : public ExprNode
{
private:
    SymbolEntry *t;
    ExprNode *params;
public:
    FuncCallExpr(SymbolEntry *se, SymbolEntry *t, ExprNode *params) : ExprNode(se), t(t),params(params) {dst = new Operand(se);};
    void output(int level);
    void typeCheck();
    void genCode();
};

class EmptyStmt : public StmtNode
{
public:
    EmptyStmt(){};
    void output(int level);
    void typeCheck();
    void genCode();
};

class Ast
{
private:
    Node* root;
public:
    Ast() {root = nullptr;}
    void setRoot(Node*n) {root = n;}
    void output();
    void typeCheck();
    void genCode(Unit *unit);
};

#endif
