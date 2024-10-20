#ifndef EXPR_H
#define EXPR_H

#include <stdlib.h>

typedef struct ast {
    struct ast *left;
    struct ast *right;
    int value;
} ast;

ast *create(ast *left, ast *right);
ast *value(int value);
int evaluate(ast *root);
void free_ast(ast *root);

#endif // EXPR_H