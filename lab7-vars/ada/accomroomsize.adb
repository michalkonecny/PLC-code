with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
use Ada.Containers;

procedure AccomRoomSize is

    subtype LengthCM is Integer;
    subtype AreaCM2 is Integer;

    type RoomType is
        (Launge, Bedroom, Kitchen, Bathroom,
         DiningRoom, UtilityRoom, WC);

    package RoomType_IO is new Enumeration_IO(Enum => RoomType);
    use RoomType_IO;

    type Room is
        record
            rType : RoomType;
            x : LengthCM;
            y : LengthCM;
        end record;

    procedure Put_Room(rm : Room) is
    begin
        Put(rm.rType);
        Put("(");
        Put(Integer(rm.x), 0);
        Put("cm x ");
        Put(Integer(rm.y), 0);
        Put("cm)");
    end Put_Room;

    package RoomLists is new Ada.Containers.Vectors
        (Element_Type => Room, Index_Type => Natural);
    use RoomLists;

    procedure Put_Rooms(rooms : RoomLists.Vector) is
        i : RoomLists.Cursor;
        rm : Room;
    begin
        -- loop for all rooms:
        i := RoomLists.First(rooms);
        while i /= RoomLists.No_Element loop
            rm := RoomLists.Element(i);
            -- print each room:
            Put_Room(rm);
            Put_Line("");
            -- advance to the next room:
            RoomLists.Next(i);
        end loop;
    end Put_Rooms;

    function TotalArea(rooms : RoomLists.Vector) return AreaCM2 is
        i : RoomLists.Cursor;
        rm : Room;
        result : AreaCM2;
    begin
        result := 0;
        -- loop for all rooms:
        i := RoomLists.First(rooms);
        while i /= RoomLists.No_Element loop
            rm := RoomLists.Element(i);
            -- calculate the area and add it to the result:
            result := result + (rm.x * rm.y);
            -- advance to the next room:
            RoomLists.Next(i);
        end loop;
        return result;
    end TotalArea;

    procedure Put_Area(rooms : RoomLists.Vector) is
    begin
        Put("total area = ");
        Put(Integer(TotalArea(rooms)), 0);
        Put_Line("cm^2");
    end Put_Area;

    myRooms : RoomLists.Vector;
begin
    RoomLists.Clear(myRooms);
    RoomLists.Append(myRooms, (Kitchen, 450, 310));
    RoomLists.Append(myRooms, (Launge, 550, 450));
    RoomLists.Append(myRooms, (Bathroom, 250, 170));
    RoomLists.Append(myRooms, (Bedroom, 450, 390));
    Put_Rooms(myRooms);
    Put_Area(myRooms);
end AccomRoomSize;
