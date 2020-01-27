import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.EnumSet;

public class OSTypeBool
{
    enum OS { ANDROID, IOS, MACOSX, WINDOWS8, WP8, VXWORKS }

    enum OSType { DESKTOP, EMBEDDED, MOBILE }

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

    private static OSType os2OSType(OS os)
    {
        OSType type =
            (os == OS.ANDROID || os == OS.IOS || os == OS.WP8 ? OSType.MOBILE :
                (os == OS.WINDOWS8 || os == OS.MACOSX ? OSType.DESKTOP :
                    (os == OS.VXWORKS ? OSType.EMBEDDED)
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
        System.out.print("Known OSs = ");
        for (OS t : EnumSet.allOf(OS.class))
        {
            System.out.print(t + " ");
        }
        System.out.println();

        OS os = getEnumElement("operating system", OS.class);
        System.out.println(os + " is of type: " + os2OSType(os));
    }
}
