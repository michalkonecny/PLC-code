(defvar game-pos1
    '((kind . WON)
      (board . ((X X O) (O X X) (O O X)))
      (winner . X)))

(defvar game-pos2 
    '((kind . TOPLAY)
      (board . ((X X O) (O B X) (O B B)))
      (turn . X) 
      (value . 0)))

(defvar game-pos3
    '((kind . TOPLAY)
      (board . ((X X O) (O B X) (O B)))
      (turn . X) 
      (value . 0)))

(defvar game-pos4
    '((kind . TOPLAY)
      (board . ((X X O) (O X X) (O O X)))
      (winner . X)))

(defvar game-pos5
    '((kind . WON)
      (board . ((X X O) (O X X) (O O X)))
      (winner . X)
      (tournament . "Birmingham Championship")))

(defun playerp (a)
    (member a '(X O)))

(defun cell-valuep (a) ;; is "a" a cell value?
    (member a '(X O B)))

(defun boardp (a) ;; is "a" a board?
    (and
        (= 3 (length a)) ;; 3 rows
        (every (lambda (row) (= 3 (length row))) a) ;; 3 columns
        (every (lambda (row) (every 'cell-valuep row)) a) ;; cells contain cell values
        t))

(defun game-posp (pos)
    (let
        ((kind (cdr (assoc 'kind pos)))
         (board (cdr (assoc 'board pos)))
         (turn (cdr (assoc 'turn pos)))
         (value (cdr (assoc 'value pos))))
        (and ;; all of the following must hold:
            (= 4 (length pos)) ;; four components
            (eq kind 'TOPLAY)
            (boardp board)
            (playerp turn)
            (numberp value)
            t)))

(print game-pos1)
(print (game-posp game-pos1))

(print game-pos2)
(print (game-posp game-pos2))

(print game-pos3)
(print (game-posp game-pos3))

(print game-pos4)
(print (game-posp game-pos4))

(print game-pos5)
(print (game-posp game-pos5))
