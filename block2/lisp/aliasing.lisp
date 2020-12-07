(defun test ()
   ;;(format t "~%sample: ~a~%" sample)
   (let ((sample '((0 0)(0.1 0)(0.2 0)(0.3 0)(0.4 0)(0.5 0)(0.6 0)(0.7 0)(0.8 0)(0.9 0)(1 0))))
     (format t "~%sample: ~a~%" sample)
     (incf (second (assoc 0.1 sample)))
     (format t "~%sample: ~a~%" sample)))

;; ;; Let us start clisp and load this file:

;; [1]> (load "aliasing.lisp")
;; ;; Loading file aliasing.lisp ...
;; ;; Loaded file aliasing.lisp

;; ;; Let us inspect the code of function test:

;; [2]> (fdefinition 'test)
;; #<FUNCTION TEST NIL (DECLARE (SYSTEM::IN-DEFUN TEST))
;;    (BLOCK TEST
;;     (LET ((SAMPLE '((0 0) (0.1 0) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6
;;     0) (0.7 0) (0.8 0) (0.9 0) (1 0))))
;;      (FORMAT T "~%sample: ~a~%" SAMPLE) (INCF (SECOND (ASSOC 0.1
;;      SAMPLE))) (FORMAT T "~%sample: ~a~%" SAMPLE)))>

;; ;; Let us execute the function test:

;; [3]> (test)

;; sample: ((0 0) (0.1 0) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6 0) (0.7 0)
;; (0.8 0) (0.9 0) (1 0))

;; sample: ((0 0) (0.1 1) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6 0) (0.7 0)
;; (0.8 0) (0.9 0) (1 0))
;; NIL

;; ;; So far so good.  Let us now look at the code of function test again:

;; [4]> (fdefinition 'test)
;; #<FUNCTION TEST NIL (DECLARE (SYSTEM::IN-DEFUN TEST))
;;    (BLOCK TEST
;;     (LET ((SAMPLE '((0 0) (0.1 1) (0.2 0) (0.3 0) (0.4 0) (0.5 0) (0.6
;;     0) (0.7 0) (0.8 0) (0.9 0) (1 0))))
;;      (FORMAT T "~%sample: ~a~%" SAMPLE) (INCF (SECOND (ASSOC 0.1
;;      SAMPLE))) (FORMAT T "~%sample: ~a~%" SAMPLE)))>

;; ;; Oops! The code has changed...
