#include "SymbolTable.h"
#include <iostream>
#include <sstream>
#include <vector>
#include "Type.h"

SymbolEntry::SymbolEntry(Type *type, int kind) 
{
    this->type = type;
    this->kind = kind;
}

ConstantSymbolEntry::ConstantSymbolEntry(Type *type, int value) : SymbolEntry(type, SymbolEntry::CONSTANT)
{
    this->value = value;
}

std::string ConstantSymbolEntry::toStr()
{
    std::ostringstream buffer;
    buffer << value;
    return buffer.str();
}


IdentifierSymbolEntry::IdentifierSymbolEntry(Type *type, std::string name, int scope) : SymbolEntry(type, SymbolEntry::VARIABLE), name(name)
{
    this->scope = scope;
    addr = nullptr;
}

IdentifierSymbolEntry::IdentifierSymbolEntry(Type *type, std::string name, int scope,int kind) : SymbolEntry(type, kind), name(name)
{
    this->scope = scope;
    addr = nullptr;
}

std::string IdentifierSymbolEntry::toStr()
{
    if(isGlobal())
        return "@" + name;
    return "%" + name;
}

TemporarySymbolEntry::TemporarySymbolEntry(Type *type, int label) : SymbolEntry(type, SymbolEntry::TEMPORARY)
{
    this->label = label;
}

std::string TemporarySymbolEntry::toStr()
{
    std::ostringstream buffer;
    buffer << "%t" << label;
    return buffer.str();
}

SymbolTable::SymbolTable()
{
    prev = nullptr;
    level = 0;
}

SymbolTable::SymbolTable(SymbolTable *prev)
{
    this->prev = prev;
    this->level = prev->level + 1;
}

/*
    Description: lookup the symbol entry of an identifier in the symbol table
    Parameters: 
        name: identifier name
    Return: pointer to the symbol entry of the identifier

    hint:
    1. The symbol table is a stack. The top of the stack contains symbol entries in the current scope.
    2. Search the entry in the current symbol table at first.
    3. If it's not in the current table, search it in previous ones(along the 'prev' link).
    4. If you find the entry, return it.
    5. If you can't find it in all symbol tables, return nullptr.
*/
SymbolEntry* SymbolTable::lookup(std::string name)
{
    if(symbolTable.find(name)!=symbolTable.end()){
        return symbolTable[name];
    }else{
        if(prev != nullptr){
            return prev->lookup(name);
        }else{
            return nullptr;
        }
    }
}

// install the entry into current symbol table.
void SymbolTable::install(std::string name, SymbolEntry* entry)
{
    //能找到，变量在同一作用域下重复声明
    if(symbolTable.find(name)!=symbolTable.end()){
        fprintf(stderr, "identifier \"%s\" has already been defined\n", name.c_str());
        // exit(-1);
    }
    
    symbolTable[name] = entry;
}


static void add_func(Type * type, std::vector<Type*> paramsType, std::string name){
    Type *funcType = new FunctionType(type,paramsType);
    SymbolEntry *se = new IdentifierSymbolEntry(funcType, name , identifiers->getLevel());
    identifiers->install(name, se);
}

//符号表初始化
void SymbolTable::init()
{
    add_func(TypeSystem::intType, {}, "getint");
    add_func(TypeSystem::intType, {}, "getch");
    add_func(TypeSystem::voidType, {TypeSystem::intType}, "putint");
    add_func(TypeSystem::voidType, {TypeSystem::intType}, "putch");
}

int SymbolTable::counter = 0;
static SymbolTable t;
SymbolTable *identifiers = &t;
SymbolTable *globals = &t;

////////
static SymbolTable sysyTable2;
SymbolTable *sysyTable = &sysyTable2;
