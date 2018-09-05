import java.util.Scanner;
import java.util.InputMismatchException;

public class Digit
{

    private static int getInteger()
    {
        boolean haveResult = false;
        int result = 0;
        Scanner stdin = new Scanner(System.in);

        while ( ! haveResult )
        {
            System.out.print("Input number: ");
            try
            {
                result = stdin.nextInt();
                haveResult = true;
            }
            catch (InputMismatchException e)
            {
                System.out.println("Not a valid number.");
                stdin.nextLine(); // skip the invalid input
            }
        }

        return result;
    }


    public static void main(String[] args)
    {
        int n = getInteger();
        if ( ?????????????????????? ) // TODO
        {
            System.out.println("A");
        }
        else
        {
            System.out.println("B");
        }

    }
}
