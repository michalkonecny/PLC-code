public abstract class Test
{
    public static void main(String[] args)
    {
        ArithExp exp1 =
            new ArithExpBinary
                (
                    ArithExpBinary.BinaryOperator.TIMES,
                    new ArithExpInt(2),
                    new ArithExpBinary
                        (
                            ArithExpBinary.BinaryOperator.PLUS,
                            new ArithExpInt(3),
                            new ArithExpDouble(0.5)
                        )
                );

        ArithExp exp2 =
            new ArithExpBinary
                (
                    ArithExpBinary.BinaryOperator.POWER,
                    exp1,
                    exp1
                );

        printExpInfo("exp1", exp1);

        printExpInfo("exp2", exp2);

        exp1.incrementAllNumbers();
        printExpInfo("exp1 all numbers incremented", exp1);

        printExpInfo("exp2 after exp1 incremented", exp2);

        exp2.incrementAllNumbers();
        printExpInfo("exp2 all numbers incremented", exp2);

    }

    public static void printExpInfo(String exprName, ArithExp expr)
    {
        System.out.println("--------");
        System.out.println(exprName + " = " + expr);
//         System.out.println("check(" + exprName + ") = " + expr.check());
        System.out.println("countNodes(" + exprName + ") = " + expr.countNodes());
        System.out.println("--------");
    }
}


