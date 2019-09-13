public class ttt
{

    private static enum Player { X, O };
    
    private static enum CellValue { X, O, B };

    private static class Board
    {
        public Board(CellValue[][] rows)
        {
            this.rows = rows;
        }
        
        public CellValue[][] rows;
        
        public String toString()
        {
            String result = "";
            for ( CellValue[] row : rows)
            {
                for ( CellValue cell : row )
                {
                    result += cell;
                }
                result += "\n";
            }
            return result;
        }
    }
    
    
    private static class GamePos
    {
        public Board board;
        public Player turn;
        public float value;
        
        GamePos(Board board, Player turn, float value)
        {
            this.board = board;
            this.turn = turn;
            this.value = value;
        }
        
        public String toString()
        {
            String result = "";
            result += board;
            result += "Player to make the next move: ";
            result += turn + "\n";
            result += "Estimated advantage of Player X against Player O: ";
            result += value + "\n";
            
            return result;
        }
    }
    
    private static GamePos gamePos1 = 
        new GamePos
        (
            new Board
            (
                new CellValue[][]
                {{CellValue.X, CellValue.X, CellValue.O},
                 {CellValue.O, CellValue.B, CellValue.X},
                 {CellValue.O, CellValue.B, CellValue.B}}
            ),
            Player.X,
            0
        );
    
/*    
    private static GamePos gamePos2 = 
        new GamePosWon
        (
            new Board
            (
                new CellValue[][]
                {{CellValue.X, CellValue.X, CellValue.O},
                 {CellValue.O, CellValue.X, CellValue.X},
                 {CellValue.O, CellValue.O, CellValue.X}}
            ),
            Player.X
        );
*/
        
    public static void main(String[] args)
    {
        System.out.println(gamePos1);
//         System.out.println(gamePos2);
    }
}