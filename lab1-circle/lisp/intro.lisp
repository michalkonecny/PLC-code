;; Lisp syntax for function (~method) call:
(format nil "hello ~d" 123) ;; returns "hello 123"
;; in Java syntax: format(null, "hello ~d", 123);

;; an expression returns a value and also can have side effects:
(print "hello") ;; prints "hello" to console, then returns "hello"
;; body of Lisp print in Java: { System.out.println("\"hello\""); return "hello" }

;; declare, assign and use a variable:
(setf name "Alice") ;; in Java: String name; name = "Alice";
name

;; revisit print: returns a value in addition to printing:
(setf name (print "Bob"))
name

;; operators are just functions:
(setf n (+ 1 2)) ;; in Java: int n; n = 1 + 2;
n

;; "if" and comparison are also functions:
(if (not (string= name "")) name "noname")
;; a readable Java translation:
;;   String temp;
;;   if (!name.equals("")) then { temp = name; } else { temp = "hello2"; }
;;   return temp;
;;
;; an exact Java translation:
;;   (!name.equals("")) ? name : "hello2"

;; any value can be used as a boolean:
(setf name "Alice")
(if name name "noname") ;; returns "Alice"
(setf name nil) ;; nil is the only value treated as false by "if"
(if name name "noname") ;; returns "noname"

;; we should not leave out the else branch:
(if name name nil)

;; sequencing multiple expressions:
(progn (print "hello:") (print name))

;; a program can be treated as data:
(setf myprogram '(print (+ 1 m))) ;; the tick is important
myprogram ;; returns (PRINT (+ 1 M))
;; (eval myprogram)  ;; throws error: "EVAL: variable M has no value"
(setf m 1)

;; the following has no easy equivalent in compiled languages such as Java:
(eval myprogram)  ;; prints 2
;; eval is used by the *interpreter* all the time
;; Java's eval would have to *compile* the given program fragment to bytecode first

;; an import can appear anywhere, happens dynamically thanks to interpreted execution:
;(load "included.lisp") ;; throws error: "EVAL: variable A has no value"

(setf a 1)
(load "included.lisp") ;; prints value of a, sets variable i to 101
i ;; returns 101
