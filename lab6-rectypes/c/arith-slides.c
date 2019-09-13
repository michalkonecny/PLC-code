#include <stdio.h>
#include <malloc.h>

// leaf node structure:
typedef struct { int n; } IntExp;

// operator node structure:
typedef enum {PLUS, TIMES} Operator;

typedef struct
{ 
    Operator op;
    struct EXPNODE * left;
    struct EXPNODE * right;
      // incomplete struct, completion below
      // (struct EXPNODE = Expression)
}
OperatorExp; // the name of the new record type


typedef union
{
    OperatorExp opExp; // either this (an operator + 2 children)
    IntExp intExp; // or this (a number)
}
ExpNodeUnion; // the name of the new union type

typedef enum {INTEXP, OPEXP} ExpNodeRepr;

typedef struct EXPNODE 
   // struct named EXPNODE to complete the struct on lines 9,10
{
    ExpNodeRepr repr; // discriminant
    ExpNodeUnion content; // the union
} 
Expression;


int countNodes(Expression * expr)
{
    int result = 1;
    
    if ( (*expr).repr == OPEXP )
    {
        result = result + countNodes((*expr).content.opExp.left);
        result = result + countNodes((*expr).content.opExp.right);
    }
    
    return result;
}

int main(char** argv, int argc)
{
    // construct the expression plus(1, times(2, 3))
    // first, create the three leafs of the tree:
    Expression * num1 =
        (Expression *)malloc(sizeof(Expression));
    (* num1).repr = INTEXP; // indicate variant
    (* num1).content.intExp.n = 1; // initialise component

    Expression * num2 =
        (Expression *)malloc(sizeof(Expression));
    (* num2).repr = INTEXP;
    (* num2).content.intExp.n = 2;

    Expression * num3 =
        (Expression *)malloc(sizeof(Expression));
    (* num3).repr = INTEXP;
    (* num3).content.intExp.n = 3;

    // create the root node of times(2, 3):
    OperatorExp temp1 = { TIMES, num2, num3 };
    Expression * expTimes = 
        (Expression *)malloc(sizeof(Expression));
    (* expTimes).repr = OPEXP;
    (* expTimes).content.opExp = temp1;

    // create the root node of plus(1, times(2, 3)):
    OperatorExp temp2 = { PLUS, num1, expTimes };
    Expression * expPlus = 
        (Expression *)malloc(sizeof(Expression));
    (* expPlus).repr = OPEXP;
    (* expPlus).content.opExp = temp2;

    // test the countNodes function:
    int n = countNodes(expPlus);
    printf("countNodes(expPlus) = %d\n", n);

    return 0;
}
