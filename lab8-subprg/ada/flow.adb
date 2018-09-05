with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Text_IO;
use Text_IO;

procedure Flow
is

    function Distance(Flow1 : Float; Flow2 : Float)
        return Float
    is
    begin
        return abs(Flow1 - Flow2);
    end Distance;

    -- AdjustDistance attempts to change the values
    -- of the parameters if they are quite close together
    -- so that they are more apart.
    -- Nevertheless, the sum of the values stays the same.
    procedure AdjustDistance
        (Flow1 : in out Float; Flow2 : in out Float) 
    is
    begin
        if Distance(Flow1,Flow2) < 10.0 then
            if Flow1 > Flow2 then
                Flow2 := Flow2 / 3.0;
                Flow1 := Flow1 + Flow2;
                Flow1 := Flow1 + Flow2;
            else
                Flow1 := Flow1 / 3.0;
                Flow2 := Flow2 + Flow1;
                Flow2 := Flow2 + Flow1;
            end if;
        end if;
    end AdjustDistance;
    
begin
    declare
        F1, F2, F3 : Float;
        
        procedure Put_F1F2F3 is
        begin
            Put("F1 = ");
            Put(F1,0,2,0);
            Put("; F2 = ");
            Put(F2,0,2,0);
            Put("; F3 = ");
            Put(F3,0,2,0);
            Put_Line("");
        end Put_F1F2F3;
        
    begin
        F1 := 3.0;
        F2 := 3.0;
        F3 := 3.0;
        
        -- test the AdjustDistance procedure:
        Put_F1F2F3;
        AdjustDistance(F1, F2);
        Put_F1F2F3;
        AdjustDistance(F2, F3);
        Put_F1F2F3;
        AdjustDistance(F3, F3); -- this looks bad...what actually happens?
        Put_F1F2F3;
    end;
end Flow;
