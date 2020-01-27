import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class accomColl
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

    private abstract static class Accommodation
    {
        public Accommodation(String street, int houseNumber)
        {
            this.street = street;
            this.houseNumber = houseNumber;
        }

        public String getStreet() { return street; }
        public int getHouseNumber() { return houseNumber; }

        private String street;
        private int houseNumber;
    }

    private static class House extends Accommodation
    {
        public House(String street, int houseNumber, int floors, List<List<Room>> roomsPerFloor)
        {
            super(street, houseNumber);
            assert floors == roomsPerFloor.size();
            this.floors = floors;
            this.roomsPerFloor = roomsPerFloor;
        }

        public int getFloors() { return floors; }
        public List<List<Room>> getRoomsPerFloor() { return roomsPerFloor; }

        public String toString()
        {
            String result = "";
            result += floors;
            result += " storey house at ";
            result += getHouseNumber();
            result += " ";
            result += getStreet();
            result += " ";
            result += getRoomsPerFloor();

            return result;
        }

        private int floors;
        private List<List<Room>> roomsPerFloor;
    }

    private static class Flat extends Accommodation
    {
        private int floor;
        private List<Room> rooms;

        public int getFloor() { return floor; }
        public List<Room> getRooms() { return rooms; }

        public Flat(String street, int houseNumber, int floor, List<Room> rooms)
        {
            super(street, houseNumber);
            this.floor = floor;
            this.rooms = rooms;
        }

        public String toString()
        {
            String result = "";
            result += floorToTh(floor);
            result += " floor flat at ";
            result += getHouseNumber();
            result += " ";
            result += getStreet();
            result += " ";
            result += getRooms();

            return result;
        }
    }

    private static String floorToTh(int floor)
    {
        if (floor == 0)
        {
            return "ground";
        }
        else
        {
            switch(floor % 10)
            {
            case 1: return floor + "st";
            case 2: return floor + "nd";
            case 3: return floor + "rd";
            default: return floor + "th";
            }
        }
    }

    private static House myHouse1;
    private static House myHouse2;
    private static Flat myFlat1;
    private static Flat myFlat2;

    private static <T> void printListPerLine(String prompt, List<T> list)
    {
        System.out.println(prompt);
        for(T item : list)
        {
            System.out.println(" " + item);
        }
    }

    public static void main(String[] args)
    {
        // construct records about rooms and accommodation:

        List<Room> rooms1 = new ArrayList<Room>();
        rooms1.add(new Room(RoomKind.Kitchen, 450, 310));
        rooms1.add(new Room(RoomKind.Launge, 550, 450));

        List<Room> rooms2 = new ArrayList<Room>();
        rooms2.add(new Room(RoomKind.Bathroom, 200, 180));
        rooms2.add(new Room(RoomKind.Bedroom, 450, 390));
        rooms2.add(new Room(RoomKind.Bedroom, 400, 320));

        List<Room> rooms3 = new ArrayList<Room>();
        rooms3.add(new Room(RoomKind.Bathroom, 180, 180));
        rooms3.add(new Room(RoomKind.Bedroom, 410, 370));
        rooms3.add(new Room(RoomKind.Bedroom, 380, 310));

        List<List<Room>> roomsPerFloor1 = new ArrayList<List<Room>>();
        roomsPerFloor1.add(rooms1);
        roomsPerFloor1.add(rooms2);
        roomsPerFloor1.add(rooms3);

        myHouse1 = new House("Golden Avenue", 111, 3, roomsPerFloor1);
        myHouse2 = new House("Golden Avenue", 112, 3, roomsPerFloor1);

        List<Room> rooms4 = new ArrayList<Room>();
        rooms4.add(new Room(RoomKind.Kitchen, 350, 280));
        rooms4.add(new Room(RoomKind.Launge, 400, 320));
        rooms4.add(new Room(RoomKind.Bedroom, 320, 270));

        myFlat1 = new Flat("Silver Street", 81, 0, rooms4);
        myFlat2 = new Flat("Silver Street", 81, 7, rooms4);

        // construct a list with all accommodation instances:
        List<Accommodation> allAccommodation = new ArrayList<Accommodation>();
        allAccommodation.add(myHouse1);
        allAccommodation.add(myHouse2);
        allAccommodation.add(myFlat1);
        allAccommodation.add(myFlat2);

        printListPerLine("all accommodation:", allAccommodation);

        // construct a list of streets extracted from allAccommodation:
        List<String> streets = new ArrayList<String>();
        for (Accommodation accom: allAccommodation)
        {
            streets.add(accom.getStreet());
        }

        printListPerLine("streets:", streets);

        // construct a list of all flats in allAccommodation:
        List<Accommodation> flats = new ArrayList<Accommodation>();
        for (Accommodation accom: allAccommodation)
        {
            if (accom instanceof Flat)
            {
                flats.add(accom);
            }
        }

        printListPerLine("flats:", flats);

        // construct a list of floor counts from all houses in allAccommodation:
        List<Integer> houseFloorsSequence = new ArrayList<Integer>();
        // TASK 5.2.(b): Add code to change this list as described in the comment above.
        //               Moreover, your code must work as described,
        //               no matter what the list allAccommodation contains.

        printListPerLine("Floor counts for houses:", houseFloorsSequence);
   }
}
