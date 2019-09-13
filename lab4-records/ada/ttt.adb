with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;


procedure TTT is

    type Player is
        (Player_X, Player_O); -- Ada enumerated type

    -- use default formatting and parsing of Player values
    package Player_IO is
        new Ada.Text_IO.Enumeration_IO(Player);
    use Player_IO;

    type CellValue is
        (X, O, B);

    -- function to help formatting CellValues
    function CellSymbol(cell : CellValue) return String
    is begin
        case cell is
            when X => return "X";
            when O => return "O";
            when B => return ".";
        end case;
    end CellSymbol;

    type TTTRow is
        array (1..3) of CellValue;
    type TTTBoard is
        array (1..3) of TTTRow;

    -- display a board to the terminal
    procedure Put_Board(board : TTTBoard) is
        procedure Put_Row(row : TTTRow) is
        begin
            for I in 1..3 loop
                Put(CellSymbol(row(I)));
            end loop;
            Put_Line("");
        end Put_Row;
    begin
        for I in 1..3 loop
            Put_Row(board(I));
        end loop;
    end Put_Board;

    -- start of code to focus on in Practical 4

    type GamePos is
        record
            board : TTTBoard;
            turn : Player;
            value : Float;
        end record;

    procedure Put_Pos(pos : GamePos) is
    begin
        Put_Board(pos.board);
        Put("Player to make the next move: ");
        Put(pos.turn);
        Put_Line("");
        Put("Estimated advantage of player X over player O is: ");
        Put(pos.value, 0, 0, 0);
        Put_Line("");
    end Put_Pos;

    gamePos1 : GamePos
        := (board =>
                ((X, X, O),
                 (O, B, X),
                 (O, B, B)),
            turn => Player_X,
            value => 0.0);

--     gamePos2 : GamePos
--         := (pos_variant => WON, -- the discriminant
--             board =>
--                 ((X, X, O),
--                  (O, X, X),
--                  (O, O, X)),
--             winner => Player_X);

begin
    Put_Pos(gamePos1);
    Put_Line("");
--     Put_Pos(gamePos2);
end TTT;
