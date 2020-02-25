# -*- coding: utf-8 -*-
class Board:
    def __init__(self, rows): # constructor
        self.rows = rows
        self.check()
        
    def __repr__(self):  # formatting (like toString())
        result = ""
        for row in self.rows:
            for cell in row:
                result = result + cell
            result = result + "\n"
        return result
            
    def check(self):
        # do some dynamic type checking:
        assert len(self.rows) == 3
        for row in self.rows:
            assert len(row) == 3
            for cell in row:
                assert cell in ['X','O','B']
                
    def changeCell(self, cellValue, row, col):
        self.rows[row][col] = cellValue

board1 = Board(
    [['X','X','O'],
     ['X','B','O'],
     ['O','B','B']])
    # Python has no native arrays - use lists instead
    # Python has no enumerated types - use strings 'X' etc.

board2 = Board(
    [['X','X','O'],
     ['X','X','O'],
     ['O','O','X']])

print(board1)
board1.changeCell('X',1,1)
print(board1)

class Move:
    def __init__(self,player,pos): # constructor
        self.player = player
        self.pos = pos
    def __repr__(self): # formatting (like toString())
        return \
            "A move of player %s at position (%s,%s)" % \
             (self.player, self.pos[0], self.pos[1])
                # Python version of printf
    # backslash at end of line means: continue on next line

class Pause:
    def __init__(self,player): # constructor
        self.player = player
    def __repr__(self): # formatting (like toString())
        return \
            "A pause of player %s" % (self.player)
                # Python version of printf


# a heterogeneous list
events = [Move("X",[0,0]), Pause("X"), Move("O",[1,0])]

move = Move("X",[0,0])

# print all elements from the list
for event in events:
    print(event)

# empty line
print()

# search for an element of class Pause and print it
for event in events:
    if event.__class__ == Pause:
        print(event)
        break # stop the for loop

# empty line
print()

# compute players
players = [event.player for event in events]

for player in players:
    print(player)

# empty line
print()

# remove all pauses
events2 = \
    [event for event in events if event.__class__ != Pause]
    
for event in events2:
    print(event)

# non-blank fields from a board:
nonBlankFields = [cell for row in board1.rows for cell in row if cell != "B"]
print("nonBlankFields = ", nonBlankFields)

# heterogeneous dictionary:
board2score = { board1 : 2.0, board2 : "dunno" }
board2score[ board2 ] = 0.0 # like array update
print(board2score[ board1 ]) # like array lookup

