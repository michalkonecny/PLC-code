/**
 * Class ArithExp is a union of three types of nodes;
 * an instance describes the root node and represents
 * the whole expression that it defines together with
 * its children and (grand-)...children.
 *
 * Classes ArithExpMinMax and ArithExpInt extend ArithExp.
 */
abstract class ArithExp
{

    /**
     * Count the number of nodes in this expression.
     *
     * @return the size of this expression as a number of operators and literal numbers
     */
    public abstract int countNodes();

    /** correctly evaluate the expression
     *
     * @return the number that the expression represents
     */
    public abstract int getValue();

    /**
     * go through all nodes in the expression tree
     * and change each min to max and vice versa
     */
    public abstract void flipMinMax();

}
