import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class tttScopes
{

    private static enum CellValue { X, O, B };

    private static class Board
    {
        public Board(CellValue[][] rows)
        {
            this.rows = rows;
        }
        
        private CellValue[][] rows; // 2-dim array
        
        public void changeCell // overwrites original board!
            (int row, int col, CellValue newValue)
        {
            rows[row][col] = newValue;
        }
        
        public void blank() // overwrites original board!
        {
            int row;
            for ( row = 0; row < 3; row ++)
            {
            
                int col;
                for ( col = 0; col < 3; col ++ )
                {
                    changeCell(row, col, CellValue.B);
                }
                
            }
        }
        
        public String toString()
        {
            String result = "";
            for ( CellValue[] row : rows) // for each row
            {
            
                for ( CellValue cell : row ) // for each column
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

    public static void main(String[] args)
    {
        System.out.println(board1);
        board1.blank();
        System.out.println(board1);
    }
}