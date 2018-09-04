import java.util.List;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.InputMismatchException;

public class Overflow
{

    private static int getPositiveInteger(String varName)
    {
        boolean haveResult = false;
        int result = 0;
        Scanner stdin = new Scanner(System.in);

        while ( ! haveResult )
        {
            System.out.print("Input a positive integer " + varName + " = ");
            try
            {
                result = stdin.nextInt();
                if(result <= 0)
                {
                    System.out.println("Not a positive integer.");
                }
                else
                {
                    haveResult = true;
                }
            }
            catch (InputMismatchException e1)
            {
                try
                {
                    result = Math.round(stdin.nextFloat());
                    haveResult = true;
                    System.out.println("(Rounding to the nearest integer: " + result + ")");
                }
                catch (InputMismatchException e2)
                {
                    stdin.next();
                    System.out.println("Not a valid number.");
                }
            }
        }

        return result;
    }

    /**
    * Compute the sequence of powers n^0,n^1,...,n^m
    * for a given integer n and natural number m.
    * @param n = a number to raise to the power m
    * @param m = the power (has to be >= 0)
    * @return list containing n^0,n^1,...,n^m
    */
    private static List<Integer> power(int n, int m)
    {
        assert m >= 0 : ("power called with illegal value m = " + m);

        List<Integer> result = new LinkedList<Integer>();
        int power = 1;
        result.add(power);
        for ( int i = 1; i <= m; i++ )
        {
            int nextPower = power * n;
//             assert ?? : "power: Integer overflow";
            result.add(nextPower);
            power = nextPower;
        }
        return result;
    }

    /**
    * Compute the sequence of powers n^0,n^1,...,n^m
    * for a given floating point number n and a natural number m.
    * @param n = a number to raise to the power m
    * @param m = the power (has to be >= 0)
    * @return list containing n^0,n^1,...,n^m
    */
    private static List<Float> power_fp(float n, int m)
    {
        assert m >= 0 : ("illegal power " + m);

        List<Float> result = new LinkedList<Float>();
        float power = 1;
        for ( int i = 1; i <= m; i++ )
        {
            power = power * n;
//             assert ?? : "Floating-point overflow";
            result.add(power);
        }
        return result;
    }

    /**
    * Compute the series of partial sums of a harmonic series:
    * 1, 1+1/n, 1+1/n+1/n^2, ... , 1+1/n+...+1/n^m
    * @param n = the base of the series, inverted
    * @param m = number of terms of the series to add
    * @return list containing 1, 1+1/n, 1+1/n+1/n^2, ... , 1+1/n+...+1/n^m
    */
    private static List<Float> geom_fp(float n, int m)
    {
        assert m >= 0 : ("illegal power " + m);

        List<Float> result = new LinkedList<Float>();

        float power = 1;
        float sum = 1;
        result.add(sum);

        for ( int i = 0; i <= m; i++ )
        {
            power = power / n; // update from 1/n^(i-1) to 1/n^i
//             assert ?? : "Floating point underflow";
            sum = sum + power;
            result.add(sum);
        }
        return result;
    }

    public static void main(String[] args)
    {
        int n = getPositiveInteger("n");
        int m = getPositiveInteger("m");
        int t = getPositiveInteger("task (1=floating-point n^m; 2=integer n^m; 3=floating-point 1+1/n+1/n^2+...+1/n^m)");

        switch(t)
        {
            case 1: System.out.println(power_fp(n,m)); break;
            case 2: System.out.println(power(n,m)); break;
            case 3: System.out.println(geom_fp(n,m));
        }
    }
}
