(defun checkSnake (snake)
  (and (>= (length snake) 2) (every 'checkPos snake)))

(defun checkPos (fp)
  (let ((x (cdr (assoc 'x fp)))
        (y (cdr (assoc 'y fp))))
    (every 'checkXY (list x y))))

(defun checkXY (xy) (and (integerp xy) (>= xy 1) (<= xy 20)))

(setq snake1
   (list
    '((x . 1) (y . 2))
    '((x . 2) (y . 2))
    '((x . 3) (y . 2) (virus . "gotcha!"))
    ))

(if (checkSnake snake1) (print "snake1 is OK") (print "snake1 is not OK"))
; TASK: improve checkSnake so that it rejects snake1
