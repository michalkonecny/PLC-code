#include <stdio.h>
#include <math.h>

float distance(float flow1, float flow2)
{
    return fabs(flow1 - flow2);
}

// adjustDistance attempts to change the values
// of the two parameters if they are quite close together
// so that they are more apart.
// Nevertheless, the sum of the values stays the same.
void adjustDistance(float &flow1, float &flow2)
{
    float d = distance(flow1,flow2);
    
    if ( d < 10 )
    {

        if (flow1 > flow2)
        {
            // reduce the smaller value to 1/3 of original value:
            flow2 = flow2 / 3;
            // compensate by increasing the larger value:
            flow1 = flow1 + flow2;
            flow1 = flow1 + flow2;
        }
        else
        {
            // reduce the smaller value to 1/3 of original value:
            flow1 = flow1 / 3;
            // compensate by increasing the larger value:
            flow2 = flow2 + flow1;
            flow2 = flow2 + flow1;
        }
    }
}

void printF1F2F3(float f1, float f2, float f3)
{
    printf("f1 = %4.2f, f2 = %4.2f, f3 = %4.2f\n", f1, f2, f3);
}

int main(int argc, char** argv)
{
    float f1, f2, f3;
    f1 = 3; f2 = 3; f3 = 4;
    
    printF1F2F3(f1,f2,f3);
    adjustDistance(f2,f3);
    printF1F2F3(f1,f2,f3);
    adjustDistance(f1,f2);
    printF1F2F3(f1,f2,f3);
    adjustDistance(f3,f3); // this does not look right...what happens exactly?
    printF1F2F3(f1,f2,f3);
}
