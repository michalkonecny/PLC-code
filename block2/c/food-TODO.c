#include <stdio.h>
#include <malloc.h>

// Food position record type:
typedef struct { int x; int y; } FoodPosition;

typedef struct { int numberOfFoods; FoodPosition * food; } FoodStore;

FoodStore * createFoodPositionStore(int maxSize)
{
  // TASK: declare and initialise variable "store"
  (*store).numberOfFoods = 0;
  // TASK: allocate memory to Foods
  return store;
}

void freeFoodStore(FoodStore * store)
{
  free((*store).food);
  free(store);
}

void printFoodStore(FoodStore * store)
{
  int i;
  for(i = 0; i < (*store).numberOfFoods; i++)
  {
    FoodPosition * fp = (*store).food + i;
    printf("Food (%d,%d)\n", (*fp).x, (*fp).y);
  }
}

int addFood(FoodStore * store, FoodPosition foodPos)
{
  FoodPosition * foodPosInStore = (*store).food + (*store).numberOfFoods;
  // TASK: add foodPos into the array
  (*store).numberOfFoods++;
}

int main(char** argv, int argc)
{
  FoodStore * s = createFoodPositionStore(20);
  FoodPosition f1 = {1,2};
  addFood(s, f1);
  FoodPosition f2 = {3,4};
  addFood(s, f2);
  printFoodStore(s);
  freeFoodStore(s);
  return 0;
}
