with Ada.Text_IO;
use Ada.Text_IO;
with Balance;
use Balance;

with Ada.Task_Identification;  
use Ada.Task_Identification;

procedure Balance_Test is

A, B, C, D : Integer;

begin
    Put_Line("Starting");
    State.Set_All(5,1,3,10);
    State.Wait_Until_All_Balanced(A,B,C,D);
    Put_Line("Done");

    Abort_Task (Current_Task); 
    -- This is a hack to stop the program quickly.
    -- Without it the program will wait for the
    -- balancing tasks forever.
    -- A better solution would be to signal the sorting
    -- tasks explicitly so that they terminate naturally.
end Balance_Test;
