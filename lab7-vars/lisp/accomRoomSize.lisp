(defun roomArea (room)
    (let*
        (   ; declare and assign variables:
            (x (cdr (assoc 'x room))) ; pick the value of component x
            (y (cdr (assoc 'y room))) ; pick the value of component y
        )
        (* x y))) ; calculate area and return it

(defun totalAreaInMyRooms ()
    (apply #'+ (mapcar 'roomArea myRooms))) ; execute roomArea for each room in myRooms and sum it up

(defun test ()
    (let
        (
            ; declare and assign variable:
            (myRooms (list '((rType . bedroom) (x . 100) (y . 100))))
        )
        (print myRooms)
        (print (totalAreaInMyRooms))
    )
)

(defvar myRooms
    (list
        '((rType . kitchen) (x . 450) (y . 310))
        '((rType . launge) (x . 550) (y . 450))
        '((rType . bathroom) (x . 250) (y . 180))
        '((rType . bedroom) (x . 450) (y . 390))))
(test)
(print myRooms)
(print (totalAreaInMyRooms))
