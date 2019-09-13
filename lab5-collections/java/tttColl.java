import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class tttColl
{

    private static enum CellValue { X, O, B };

    private static class Pos
    {
        public int row;
        public int column;
        public Pos(int r, int c)
        {
            this.row = r;
            this.column = c;
        }
        public String toString()
        {
            return "(" + row + "," + column + ")";
        }
    }

    private static class Board
    {
        public Board(CellValue[][] rows)
        {
            this.rows = rows;
        }
        
        public CellValue[][] rows; // 2-dim array
        
        public void changeCell // overwrites original board!
            (Pos pos, 
             CellValue newValue)
        {
            rows[pos.row][pos.column] = newValue;
        }
        
        public String toString()
        {
            String result = "";
            for ( CellValue[] row : rows) // for each row
            {
                for ( CellValue cell : row ) // for each colmn
                {
                    result += cell;
                }
                result += "\n"; // end of row -> new line
            }
            return result;
        }
    }
    
    private static Board board1 =
            new Board
            (
                new CellValue[][]
                {{CellValue.X, CellValue.X, CellValue.O},
                 {CellValue.O, CellValue.B, CellValue.X},
                 {CellValue.O, CellValue.B, CellValue.B}}
            );
    
    private static Board board2 =
            new Board
            (
                new CellValue[][]
                {{CellValue.X, CellValue.X, CellValue.O},
                 {CellValue.O, CellValue.B, CellValue.X},
                 {CellValue.O, CellValue.B, CellValue.B}}
            );

    private static enum Player { X, O };
    
    public static CellValue playerCellVal(Player player)
    {
        switch ( player )
        {
        case X: return CellValue.X;
        case O: return CellValue.O;
        default: return null;
        }
    }
    
    private abstract static class TTTEvent {} // no members

    private static class Move extends TTTEvent
    {
        public Player player;
        public Pos pos;
        
        Move(Player player, Pos pos)
        {
            super();
            this.player = player;
            this.pos = pos;
        }
                
        public String toString()
        {
            return "move by " + player + " at " + pos;
        }
    }
    
    
    
    private static class Pause extends TTTEvent
    {
        public Player player;
        
        Pause(Player p)
        {
            super();
            this.player = p;
        }
        
        public String toString()
        {
            return "pause by " + player;
        }
    }
    
    
    private static final Move move1 = 
        new Move
        (
            Player.X,
            new Pos(1,1)
        );
        
    public static void main(String[] args)
    {
        System.out.println(board1);
//         System.out.println(move1);
        
        // make a move:
        board2.changeCell
          (move1.pos, 
           playerCellVal(move1.player));
        System.out.println(board2);
        
        // initialise events list
        List<TTTEvent> events = new ArrayList<TTTEvent>();
        events.add(new Pause(Player.X));
        events.add(new Move(Player.X, new Pos(1,1)));
        events.add(new Pause(Player.O));
        events.add(new Move(Player.O, new Pos(1,2)));
        events.add(new Move(Player.X, new Pos(2,2)));
        
        // print all events
        for ( TTTEvent event : events)
        {
            System.out.println(event);
        }
/*
        // find and print the first pause event:
        for (TTTEvent event : events)
        {
            if ( event instanceof Pause )
            {
                System.out.println(event);
                break;
            }
        }
*/
        // extract all players from the events list
        List<Player> players = new ArrayList<Player>();
        for (TTTEvent event : events)
        {
            if (event instanceof Move)
            {
                players.add(((Move)event).player);
            }
            else if (event instanceof Pause)
            {
                players.add(((Pause)event).player);
            }
        }
        
        // filter out all pause events
        List<TTTEvent> events2 = new ArrayList<TTTEvent>();
        for (TTTEvent event : events)
        {
            if ( ! (event instanceof Pause))
            {
                events2.add(event);
            }
        }

        // extract all players that pause from the events list
        List<Player> pausingPlayers = new ArrayList<Player>();
        // TASK 5.2.(b): make sure this variable has the value described in the comment

        System.out.print("Pausing players: ");
        System.out.println(pausingPlayers);
    }
}