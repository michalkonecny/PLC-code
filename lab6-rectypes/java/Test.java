public class Test
{
	// create local nicknames for the enumerated values MIN and MAX 
	// to avoid having to use the long names qualified by the class names:
	private static final ArithExpMinMax.MinMaxOperator MAX = ArithExpMinMax.MinMaxOperator.MAX;
	private static final ArithExpMinMax.MinMaxOperator MIN = ArithExpMinMax.MinMaxOperator.MIN;
    
	// makeMax takes a list of expressions and returns an
	// expression for calculating the maximum of the expressions in the list:
	// eg: makeMax [`min(1,2)',`3',`4'] returns the tree
	// `max(min(1,2),max(3,4))'
	// (using the Prolog syntax for the expressions)
    private static ArithExp makeMax(ArithExp[] expressions)
    {
        assert expressions.length > 0;
        
        ArithExp result = expressions[0]; // expressions must not be empty
        
        // proceed through the expressions from the last one to the second one:
        for (int i = expressions.length - 1; i > 0; i-- )
        {
            // update result to start with a new MAX node
            // with the current expression as its left child:
            result =
                new ArithExpMinMax(MAX, expressions[i], result);
        }
        
        return result;
    }
        
    public static void main(String[] args)
    {
        ArithExp exp1 =
            new ArithExpMinMax
                (
                    MIN,
                    new ArithExpInt(1),
                    new ArithExpMinMax
                        (
                            MAX,
                            new ArithExpInt(2),
                            new ArithExpInt(3)
                        )
                );

        printExpInfo("exp1", exp1);

        exp1.flipMinMax();
        printExpInfo("exp1 flipped", exp1);

        ArithExp[] temp = { exp1, exp1 };
        ArithExp exp2 = makeMax(temp);
        
        printExpInfo("exp2", exp2);

        exp1.flipMinMax();
        printExpInfo("exp1 flipped again", exp1);

        printExpInfo("exp2 after flipping exp1", exp2);

        exp2.flipMinMax();
        printExpInfo("exp2 flipped", exp2);

    }

    public static void printExpInfo(String exprName, ArithExp expr)
    {
        System.out.println("--------");
        System.out.println(exprName + " = " + expr);
        System.out.println("value of " + exprName + " = " + expr.getValue());
        System.out.println("node count of " + exprName + " = " + expr.countNodes());
        System.out.println("--------");
    }
}
