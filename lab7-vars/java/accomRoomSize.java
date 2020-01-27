import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class accomRoomSize
{

    private enum RoomKind { Launge, Bedroom, Kitchen, Bathroom, DiningRoom, UtilityRoom, WC }
    
    private static class Room
    {
        public Room(RoomKind kind, int sizeXinCm, int sizeYinCm)
        {
            this.kind = kind;
            this.sizeXinCm = sizeXinCm;
            this.sizeYinCm = sizeYinCm;
        }

        public RoomKind getKind(){ return kind; }
        public int getSizeXinCm(){ return sizeXinCm; }
        public int getSizeYinCm(){ return sizeYinCm; }

        public String toString()
        {
            return "" + kind + " " + sizeXinCm + "cm x " + sizeYinCm + "cm";
        }

        private RoomKind kind;
        private int sizeXinCm;
        private int sizeYinCm;
    }

    private static <T> void printListPerLine(String prompt, List<T> list)
    {
        System.out.println(prompt);
        for(T item : list)
        {
            System.out.println(" " + item);
        }
    }

    private static int totalArea(List<Room> rooms)
    {
        int result = 0;
        for(Room room : rooms)
        {
            int x = room.getSizeXinCm();
            int y = room.getSizeYinCm();
            result += x * y;
        }
        return result;
    }

    public static void main(String[] args)
    {
        List<Room> myrooms = new ArrayList<Room>();
        myrooms.add(new Room(RoomKind.Kitchen, 450, 310));
        myrooms.add(new Room(RoomKind.Launge, 550, 450));
        myrooms.add(new Room(RoomKind.Bathroom, 250, 180));

        printListPerLine("my rooms = ", myrooms);
        System.out.println("total area = " + totalArea(myrooms) + "cm");

        myrooms.add(new Room(RoomKind.Bedroom, 450, 390));
        printListPerLine("my rooms = ", myrooms);
        System.out.println("total area = " + totalArea(myrooms) + "cm");
   }
}
