-- specification of the package -
-- read this to get an overview of the package;
-- see bubble.adb for the implementation

package Bubble is

    -- state shared by all tasks (ie threads)
    protected State is

        -- a setter for a, b, c, d
        procedure Set_All(a, b, c, d : Integer);

        -- get a, b, c, d but only when a <= b <= c <= d
        -- block when they are not sorted
        entry Wait_Until_Sorted(a, b, c, d : out Integer);

        -- entries for detecting when neighbouring numbers
        -- are not in order and swapping them:
        entry Bubble_ab;
        entry Bubble_bc;
        entry Bubble_cd;
    private
        procedure Print_State;
        a, b, c, d : Integer := 0;
    end State;

    -- tasks for swapping neighbours in State:
    task Bubble_ab;
    task Bubble_bc;
    task Bubble_cd;
end Bubble;
