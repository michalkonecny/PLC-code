
// a leaf node of an expression, containing an integer
class ArithExpInt extends ArithExp
{
    public int value;

    public ArithExpInt(int value)
    {
        this.value = value;
    }

    public int countNodes()
    {
        return 1;
    }

    public int getValue()
    {
        return value;
    }

    public void flipMinMax()
    { ; }
    // no need to flip anything in this case

    public String toString()
    {
        return "" + value;
    }
}
