(defun test ()
   ;;(format t "~%sample: ~a~%" sample)
   (let ((sample '((0 0)(0.1 0)(0.2 0)(0.3 0)(0.4 0)(0.5 0)(0.6 0)(0.7 0)(0.8 0)(0.9 0)(1 0))))
     (format t "~%sample: ~a~%" sample)
     (incf (second (assoc 0.1 sample)))
     (format t "~%sample: ~a~%" sample)))

(load "analyse.lisp")
;; Loading file analyse.lisp ...
;; Loaded file analyse.lisp
T
[98]> (fdefinition 'test)
#<FUNCTION TEST NIL (DECLARE (SYSTEM::IN-DEFUN TEST))
   (BLOCK TEST
    (LET ((SAMPLE '((0 0) (0.1 0) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6
    0) (0.7 0) (0.8 0) (0.9 0) (1 0))))
     (FORMAT T "~%sample: ~a~%" SAMPLE) (INCF (SECOND (ASSOC 0.1
     SAMPLE))) (FORMAT T "~%sample: ~a~%" SAMPLE)))>
[99]> (test)

sample: ((0 0) (0.1 0) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6 0) (0.7 0)
(0.8 0) (0.9 0) (1 0))

sample: ((0 0) (0.1 1) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6 0) (0.7 0)
(0.8 0) (0.9 0) (1 0))
NIL
[100]> (fdefinition 'test)
#<FUNCTION TEST NIL (DECLARE (SYSTEM::IN-DEFUN TEST))
   (BLOCK TEST
    (LET ((SAMPLE '((0 0) (0.1 1) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6
    0) (0.7 0) (0.8 0) (0.9 0) (1 0))))
     (FORMAT T "~%sample: ~a~%" SAMPLE) (INCF (SECOND (ASSOC 0.1
     SAMPLE))) (FORMAT T "~%sample: ~a~%" SAMPLE)))>
