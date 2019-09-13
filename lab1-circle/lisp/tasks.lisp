;; code for Task 1.2(a):
(print (1 + 2))
;; the above expression throws an error

;; code for Task 1.2(b):
(format t "type something: ")
(setf input (read-line))
(format t "you typed: ~a" input)

;; code for Task 1.2(c):
(let ((prg '(+ 1 n))) (print prg)      )
;; The above Lisp expression first defines a very simple program,
;; and then prints the program.
