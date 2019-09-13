import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.EnumSet;

public class PLTypeBool
{
    enum PL { JAVA, C, ADA, PYTHON, LISP, HASKELL, PROLOG }
    
    enum PLType { OO, PROCEDURAL, FUNCTIONAL, LOGICAL }
    
    private static <E extends Enum<E>> E getEnumElement(String elementTypeName, Class<E> elementType)
    {
        boolean haveResult = false;
        E result = null;
        Scanner stdin = new Scanner(System.in);
        
        while ( ! haveResult )
        {
            System.out.print("Input " + elementTypeName + ": ");
            try
            {
                result = Enum.valueOf(elementType, stdin.next().toUpperCase());
                haveResult = true;
            }
            catch (IllegalArgumentException e)
            {
                System.out.println("Not a valid " + elementTypeName + ".");
                stdin.nextLine(); // skip the invalid input
            }
        }
        
        return result;
    }
  
    private static PLType pl2PLType(PL pl)
    {
        PLType type = 
            (pl == PL.JAVA || pl == PL.PYTHON ? PLType.OO :
                (pl == PL.C || pl == PL.ADA ? PLType.PROCEDURAL :
                    (pl == PL.PROLOG ? PLType.LOGICAL : 
                        true ? PLType.FUNCTIONAL
                    )
                )
            );
        /* 
            !!!! Beware: The above is not a recommended programming style.
            !!!!         It is used here only to develop understanding of
            !!!!         functional and imperative if-then-else statements.
        */
        return type;
    }

    public static void main(String[] args)
    {
        System.out.print("Known PLs = ");
        for (PL t : EnumSet.allOf(PL.class)) 
        {
            System.out.print(t + " ");
        }
        System.out.println();
        
        PL pl = getEnumElement("programming language", PL.class);
        System.out.println(pl + " is of type: " + pl2PLType(pl));
    }
}