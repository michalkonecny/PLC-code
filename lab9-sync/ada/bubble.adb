-- implementation of package Bubble
-- see bubble.ads for a specification
-- which gives a brief overview of the package

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body Bubble is

    protected body State is

        procedure Set_All(a, b, c, d : Integer) is
        begin
            State.a := a;
            State.b := b;
            State.c := c;
            State.d := d;
            Print_State;
        end Set_All;

        entry Wait_Until_Sorted(a, b, c, d : out Integer)
        when (a <= b and b <= c and c <= d)
        is
        begin
            a := State.a;
            b := State.b;
            c := State.c;
            d := State.d;
        end Wait_Until_Sorted;

        -- private procedure used to help user see what happens:
        procedure Print_State is
        begin
            Put("a = "); Put(a,2); Put("; ");
            Put("b = "); Put(b,2); Put("; ");
            Put("c = "); Put(c,2); Put("; ");
            Put("d = "); Put(d,2); Put("; ");
            Put_Line("");
        end Print_State;

        procedure Swap(n, m : in out Integer)
        is
            temp : Integer;
        begin
            temp := n; n := m; m := temp;
        end Swap;

        entry Bubble_ab when a > b is
        begin
            Swap(a,b);
            Print_State;
        end Bubble_ab;

        entry Bubble_bc when b > c is
        begin
            Swap(b,c);
            Print_State;
        end Bubble_bc;

        entry Bubble_cd when c > d is
        begin
            Swap(c,d);
            Print_State;
        end Bubble_cd;

    end State;

    -- Tasks that keep calling Bubble.. to sort the numbers asap:
    task body Bubble_ab is
    begin
        loop
            State.Bubble_ab;
        end loop;
    end Bubble_ab;

    -- Tasks that keep calling Bubble.. to sort the numbers asap:
    task body Bubble_bc is
    begin
        loop
            State.Bubble_bc;
        end loop;
    end Bubble_bc;

    -- Tasks that keep calling Bubble.. to sort the numbers asap:
    task body Bubble_cd is
    begin
        loop
            State.Bubble_cd;
        end loop;
    end Bubble_cd;
end Bubble;
