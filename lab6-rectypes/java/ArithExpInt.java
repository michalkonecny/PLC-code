
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

    public double getValue()
    {
        return value;
    }

    public void incrementAllNumbers()
    {
        value ++;
    }

    public String toString()
    {
        return "" + value;
    }
}
