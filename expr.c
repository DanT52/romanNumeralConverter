#include <stdlib.h>
#include "expr.h"


ast * create(ast *left, ast *right) {
    ast *e = malloc(sizeof(*e));
    e->value = 0;
    e->left = left;
    e->right = right;
    return e;
}

ast * value(int value) {
    ast *e = create(0, 0);
    e->value = value;
    return e;
}

int evaluate(ast *root) {
    if (!root) return 0;
    if (!root->left && !root->right) return root->value;
    int left_val = evaluate(root->left);
    int right_val = evaluate(root->right);
    return left_val + right_val; // add
}

// free the tree
void free_ast(ast *root) {
    if (!root) return;
    free_ast(root->left);
    free_ast(root->right);
    free(root);
}