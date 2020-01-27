#include <stdio.h>
#include <malloc.h>

// leaf node structure:
typedef struct { int value; } ArithExpInt;

// operator node structure:
typedef enum {MIN, MAX} MinMaxOperator;

typedef struct
{ 
    MinMaxOperator op;
    struct ARITHEXP * subExprLeft;
    struct ARITHEXP * subExprRight;
      // incomplete struct, completion below
      // (struct ARITHEXP = ArithExp)
}
ArithExpMinMax; // the name of the new record type

typedef union
{
    ArithExpMinMax opExpr; // either this (an operator + 2 children)
    ArithExpInt intExpr; // or this (a number)
}
ArithExpUnion; // the name of the new union type

typedef enum {INTEXPR, OPEXPR} ArithExpRepr;

typedef struct ARITHEXP
   // struct named ARITHEXP to complete the struct on lines 13,14
{
    ArithExpRepr repr; // discriminant
    ArithExpUnion content; // the union
} 
ArithExp;


ArithExp * newInt(int value)
{
    ArithExp * result =
        (ArithExp *)malloc(sizeof(ArithExp));
    (* result).repr = INTEXPR; // indicate discriminant
    (* result).content.intExpr.value = value; // initialise content
    return result;
}

ArithExp * newMinMax(MinMaxOperator op, ArithExp * subExprLeft, ArithExp * subExprRight)
{
    ArithExp * result =
        (ArithExp *)malloc(sizeof(ArithExp));
    (* result).repr = OPEXPR; // indicate discriminant
    // initialise the content using the opExpr "view" of the space:
    ArithExpUnion content = { op, subExprLeft, subExprRight };
    // TASK 6.2.(d): add code completing the initialisation

    return result;
}

ArithExp * newMin(ArithExp * subExprLeft, ArithExp * subExprRight)
{
    return newMinMax(MIN, subExprLeft, subExprRight);
}

ArithExp * newMax(ArithExp * subExprLeft, ArithExp * subExprRight)
{
    return newMinMax(MAX, subExprLeft, subExprRight);
}

int countNodes(ArithExp * expr)
{
    int result = 1;

    if ( (*expr).repr == OPEXPR )
    {
        result = result + countNodes((*expr).content.opExpr.subExprLeft);
        result = result + countNodes((*expr).content.opExpr.subExprRight);
    }

    return result;
}

int evaluate(ArithExp * expr)
{
    int result;

    if ( (*expr).repr == OPEXPR )
    {
        int leftValue =
            evaluate((*expr).content.opExpr.subExprLeft);

        int rightValue =
            evaluate((*expr).content.opExpr.subExprRight);

        if ( (*expr).content.opExpr.op == MAX )
        {
            result = leftValue > rightValue ? leftValue : rightValue;
        }

        if ( (*expr).content.opExpr.op == MIN )
        {
            result = leftValue > rightValue ? rightValue : leftValue;
        }
    }

    if ( (*expr).repr == INTEXPR )
    {
        result = (*expr).content.intExpr.value;
    }

    return result;
}

int main(char** argv, int argc)
{
    // construct the expression min(1, max(2, 3)):
    ArithExp * exp1 = newMin(newInt(1), newMax(newInt(2), newInt(3)));

    // test the countNodes function:
    int nodesN = countNodes(exp1);
    printf("countNodes(exp1) = %d\n", nodesN);

    // test the evaluate function:
    int value = evaluate(exp1);
    printf("evaluate(exp1) = %d\n", value);
    
    return 0;
}
