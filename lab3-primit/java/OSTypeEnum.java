import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.EnumSet;

public class OSTypeEnum
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
        OSType type = null;
        
        switch (os)
        {
        case ANDROID:
        case IOS:
        case WP8:
            type = OSType.MOBILE;
            break;
        case WINDOWS8:
        case MACOSX:
            type = OSType.DESKTOP;
            break;
        case VXWORKS:
            type = OSType.EMBEDDED;
            break;
        }
        
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