with Ada.Text_IO;
use Ada.Text_IO;
with Bubble;
use Bubble;

with Ada.Task_Identification;  
use Ada.Task_Identification;

procedure Bubble_Test is

A, B, C, D : Integer;

begin
    Put_Line("Starting");
    State.Set_All(5,1,3,1);
    State.Wait_Until_Sorted(A,B,C,D);
    Put_Line("Done");

    Abort_Task (Current_Task); 
    -- This is a hack to stop the program quickly.
    -- Without it the program will wait for the
    -- sorting tasks forever.
    -- A better solution would be to signal the sorting
    -- tasks explicitly so that they terminate naturally.
end Bubble_Test;
