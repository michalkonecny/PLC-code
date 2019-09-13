
// a leaf node of an expression, containing an integer
class ArithExpDouble extends ArithExp
{
    public double value;

    public ArithExpDouble(double value)
    {
        this.value = value;
    }

    public int countNodes()
    {
        return 1;
    }

    public double getValue()
    {
        return value;
    }

    public void incrementAllNumbers()
    {
        value = value + 1;
    }

    public String toString()
    {
        return "" + value;
    }
}
