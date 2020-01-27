public class accom
{
    
    private static class House
    {
        private String street;
        private int houseNumber;
        private int floors;

        public String getStreet() { return street; }
        public int getHouseNumber() { return houseNumber; }
        public int getFloors() { return floors; }

        public House(String street, int houseNumber, int floors)
        {
            this.street = street;
            this.houseNumber = houseNumber;
            this.floors = floors;
        }

        public String toString()
        {
            String result = "";
            result += floors;
            result += " storey house at ";
            result += getHouseNumber();
            result += " ";
            result += getStreet();

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

//     private static boolean isSameStreet(Accommodation acc1, Accommodation acc2)
//     {
//         return acc1.getStreet().equals(acc2.getStreet());
//     }
    
    private static House myHouse =
        new House("Golden Avenue", 111, 4);
    
//     private static Flat myFlat1 =
//         new Flat("Silver Street", 81, 0);

//     private static Flat myFlat2 =
//         new Flat("Silver Street", 81, 7);

    public static void main(String[] args)
    {
        System.out.println(myHouse);
//         System.out.println(myFlat1);
//         System.out.println(myFlat2);

//         System.out.println("Same street? " + isSameStreet(myFlat1, myFlat2));
    }
}