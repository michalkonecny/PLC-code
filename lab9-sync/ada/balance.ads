-- specification of the package -
-- read this to get an overview of the package;
-- see balance.adb for the implementation

package Balance is
    
    -- state shared by all tasks (ie threads)
    protected State is
        
        -- a setter for a, b, c, d
        procedure Set_All(a, b, c, d : Integer);
        
        -- get a, b, c, d but only when differences between
        -- any neighbouring numbers are no more than 1;
        -- block the calling thread until this is the case
        entry Wait_Until_All_Balanced(a, b, c, d : out Integer);
        
        -- entries for detecting when neighbouring numbers
        -- are too far apart and balancing them:
        entry BalanceAB;
        entry BalanceBC;
        entry BalanceCD;
    private
        procedure Print_State;
        a, b, c, d : Integer := 0;
    end State;
    
    -- tasks for balancing neighbours in State:
    task BalanceAB;
    task BalanceBC;
    task BalanceCD;
end Balance;
