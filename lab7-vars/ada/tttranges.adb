with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;


procedure tttRanges is

    type Cell_Value_T is
        (X, O, B);

    -- function to help formatting CellValues
    function Format_Cell_Value(cell_value : Cell_Value_T) return String
    is begin
        case cell_value is
            when X => return "X";
            when O => return "O";
            when B => return ".";
        end case;
    end Format_Cell_Value;

    subtype Row_Num_T is Integer range 1..3;
    subtype Col_Num_T is Integer range 1..3;

    type Row_T is
        array (Col_Num_T) of Cell_Value_T;
        -- indices are elements of type Col_Num_T (ie numbers 1..3)
        -- elements are cell values
    type Board_T is
        array (Row_Num_T) of Row_T;
        -- indices are elements of type Row_Num_T (ie numbers 1..3)
        -- elements are rows

    -- display a board to the terminal:
    procedure Put_Board(board : Board_T) is
        -- Put_Row is an inner procedure - visible only inside Put_Board
        -- display a row to the terminal:
        procedure Put_Row(row : Row_T) is
        begin
            for col_n in Col_Num_T loop -- for each value in the type Col_Num_T
                Put(Format_Cell_Value(row(col_n)));
            end loop;
            Put_Line("");
        end Put_Row;
    begin
        for row_n in Row_Num_T loop -- for each value in the type Row_Num_T
            Put_Row(board(row_n));
        end loop;
    end Put_Board;
    
    -- update a cell value in a board:
    procedure Update_Board
        (board : in out Board_T; 
         row_n : Row_Num_T; 
         col_n : Col_Num_T; 
         cell_value : Cell_Value_T)
    is
    begin
        board(row_n)(col_n) := cell_value;
    end Update_Board;
    
    -- flip a board by its main diagonal:
    procedure Flip_Board ( board : in out Board_T ) is
    begin
        for row_n in Row_Num_T loop
            for col_n in Col_Num_T loop
                -- swap the contents of board at row_n, col_n with the contents at col_n, row_n
                if ( row_n < col_n ) then
                     -- this condition ensures that we do not swap the same pair twice
                    declare 
                        -- in Ada, one cannot declare new variables
                        -- except in special blocks such as this one
                        temp : Cell_Value_T; -- needed to perform a swap
                        flipped_row_n : Row_Num_T := col_n;
                        flipped_col_n : Col_Num_T := row_n;
                    begin
                        temp := board(flipped_row_n)(flipped_col_n);
                        board(flipped_row_n)(flipped_col_n) := board(row_n)(col_n);
                        board(row_n)(col_n) := temp;
                    end;
                end if;
            end loop;
        end loop;
    end Flip_Board;
    
    board1 : Board_T;
begin
    board1 := ((X,X,O),(O,B,X),(O,B,B));
    Put_Board(board1);
    Flip_Board(board1);
    Put_Board(board1);
end tttRanges;

