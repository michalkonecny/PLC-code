// an max or min node:
class ArithExpMinMax extends ArithExp
{
    public MinMaxOperator op; // min or max?
    public ArithExp subExpLeft; // operand1
    public ArithExp subExpRight; // operand2

    // enumerated type for indicating in each ArithExpOp
    // root node whether it is addition or multiplication
    public static enum MinMaxOperator { MIN, MAX }


    // the constructor:
    public ArithExpMinMax(MinMaxOperator op, ArithExp subExpLeft, ArithExp subExpRight)
    {
        this.op = op;
        this.subExpLeft = subExpLeft;
        this.subExpRight = subExpRight;
    }

    public int countNodes()
    {
        return 1 + subExpLeft.countNodes() + subExpRight.countNodes();
    }

    public void flipMinMax()
    {
        switch(op)
        {
            case MIN: op = MinMaxOperator.MAX; break;
            case MAX: op = MinMaxOperator.MIN; break;
        }
        subExpLeft.flipMinMax();
        subExpRight.flipMinMax();


    }

    public int getValue()
    {
        // evaluate both operand expressions:
        // TASK 6.2.(b) (Q2): (declare and assign variables leftValue and rightValue)


        switch(op)
        {
            case MIN: return Math.min(leftValue, rightValue);
            case MAX: return Math.max(leftValue, rightValue);
            default: return 0;
        }
    }

    public String toString()
    {
        return "" + op + "(" + subExpLeft + "," + subExpRight + ")";
    }
}
