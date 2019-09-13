-- implementation of package Balance
-- see balance.ads for a specification
-- which gives a brief overview of the package

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body Balance is

    protected body State is
        
        procedure Set_All(a, b, c, d : Integer) is
        begin
            State.a := a;
            State.b := b;
            State.c := c;
            State.d := d;
            Print_State;
        end Set_All;

        -- this function is not declared in balance.ads, and thus is private:
        function Balanced(i, j: Integer) return Boolean is
        begin
            return abs(j-i) <= 1;
        end Balanced;

        entry Wait_Until_All_Balanced(a, b, c, d : out Integer)
        when (Balanced(a,b) and Balanced(b,c) and Balanced(c,d))
        is
        begin
            a := State.a;
            b := State.b;
            c := State.c;
            d := State.d;
        end Wait_Until_All_Balanced;
        
        -- private procedure used to help user see what happens:
        procedure Print_State is
        begin
            Put("a = "); Put(a,2); Put("; ");
            Put("b = "); Put(b,2); Put("; ");
            Put("c = "); Put(c,2); Put("; ");
            Put("d = "); Put(d,2); Put("; ");
            Put_Line("");
        end Print_State;

        procedure Balance(i, j : in out Integer)
        is
        begin
            if j < i - 1
                then i := i - 1; j := j + 1;
            else
                if i < j - 1
                    then i := i + 1; j := j - 1;
                end if;
            end if;
        end Balance;
        
        entry BalanceAB when not Balanced(a,b) is
        begin
            Balance(a,b);
            Print_State;
        end BalanceAB;

        entry BalanceBC when not Balanced(b,c) is
        begin
            Balance(b,c);
            Print_State;
        end BalanceBC;

        entry BalanceCD when not Balanced(c,d) is
        begin
            Balance(c,d);
            Print_State;
        end BalanceCD;

    end State;

    -- Tasks that keep calling Balance.. to balance the numbers asap:
    task body BalanceAB is
    begin
        loop
            State.BalanceAB;
        end loop;
    end BalanceAB;

    -- Tasks that keep calling Balance.. to balance the numbers asap:
    task body BalanceBC is
    begin
        loop
            State.BalanceBC;
        end loop;
    end BalanceBC;

    -- Tasks that keep calling Balance.. to balance the numbers asap:
    task body BalanceCD is
    begin
        loop
            State.BalanceCD;
        end loop;
    end BalanceCD;
end Balance;
