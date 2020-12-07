with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;

procedure Food is

  type FoodPosition is record
    x1,y1 : Integer;
  end record;

  maxFoods : constant Integer := 20;

  type FoodStoreIndex is new Integer range 1..maxFoods;
  type FoodArray is array (FoodStoreIndex) of FoodPosition;

  type FoodStore is record
    numberOfFoods : Integer := 0;
    foods : FoodArray;
  end record;

  procedure AddFood(store : in out FoodStore; foodPos : FoodPosition) is
  begin
    store.numberOfFoods := store.numberOfFoods + 1;
    -- TASK: add foodPos to the store's array
  end AddFood;

  procedure Put_FoodStore(store : FoodStore) is
    foodPos : FoodPosition;
  begin
    for i in 1..store.numberOfFoods loop
      foodPos := store.foods(FoodStoreIndex(i));
      Put("Food ("); Put(foodPos.x1,0); Put(","); Put(foodPos.y1,0); Put(")");
      Put_Line("");
    end loop;
  end Put_FoodStore;

  s : FoodStore;
begin
  AddFood(s, (1,2));
  AddFood(s, (3,4));
  Put_FoodStore(s);
end Food;
