(defvar pl-names-types 
    '((JAVA . OO) (C . PROCEDURAL) (ADA . PROCEDURAL) (PYTHON . OO) 
            (LISP . FUNCTIONAL) (HASKELL . FUNCTIONAL) (PROLOG . LOGICAL)))
    ; a list of pairs

(defvar pl-names
    (mapcar 'car pl-names-types)) 
     ; take the first element from each pair and put them in a list

(defvar pl-types
    (remove-duplicates 
        (mapcar 'cdr pl-names-types)))
        ; take the second element from each pair and put them in a list

(defun pl-namep (a)
    (member a pl-names))
    ; check whether a is in the list pl-names
    ; pl-namep means "is a PL name? predicate"

(defun pl-typep (a)
    (member a pl-types))
    ; check whether a is in the list pl-types
    ; pl-typep means "is a PL type? predicate"

(defun pl-name-to-type (name)
    (cdr (assoc name pl-names-types)))
    ; lookup a pair by the first element (ie pl name)
    ; and return the second element (ie the type)

(defun pl-type-to-name (code)
    (car (rassoc code pl-names-types)))
    ; lookup a pair by the second element (ie pl type)
    ; and return the first element of the first matching pair (ie pl name)

(defun get-pl-name ()
    (write-string "input PL: ")
    (let*
        ((line (read-line)) ;get a line as a string
         (element (read-from-string line))) ;parse the line
        (if (pl-namep element) ;is element a valid PL name?
            ; then:
            element ;yes, return it
            ; else:
            (progn ; progn = evaluate a sequence of expressions and return the result of the last one
                (write-line "Invalid PL, please try again.")
                (get-pl-name))))) ;start over using recursion

(write-string "Known PLs: ")
(write-string (format nil "~A~%" pl-names)) 
    ;"~%" means end of line
    ;"~A" means format a symbol aesthetically

(let ((pl-name (get-pl-name)))
    (write-string
        (format nil "~A is of type: ~A~%" pl-name (pl-name-to-type pl-name))))
