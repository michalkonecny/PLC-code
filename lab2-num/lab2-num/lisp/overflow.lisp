(defun get-positive-integer (varName)
    (write-string (format nil "Input a positive integer: ~a = " varName))
    (let*
        ((line (read-line)) ;get a line as a string
         (element (read-from-string line))) ;parse the line
        (if (and (integerp element) (> element 0)) ;is it a positive integer?
            element ;yes, return it
            (progn
                (write-line "Not a positive integer, please try again.")  ;no, try again
                (get-positive-integer varName))))) ;using recursion

;; calculate a list n^m,n^(m-1),...,n^2,n,1 using exact arithmetic
(defun powers (n m)
    (if (< m 1)
        (list 1)
        ; else:
        (let* ((prevPowers (powers n (- m 1)))
              (prevPower (car prevPowers)))
            (cons (* n prevPower) prevPowers))))

;; calculate a list n^m,n^(m-1),...,n^2,n,1 using floating point
(defun powers-fp (n m)
    (if (< m 1)
        (list 1.0)
        ; else:
        (let* ((prevPowers (powers-fp n (- m 1)))
              (prevPower (car prevPowers)))
            (cons (* n prevPower) prevPowers))))

;; calculate a list containing:
;;    1+1/n+...+ 1/n^m, 1+1/n+...+ 1/n^(m-1), ... , 1+1/n, 1
(defun geom (n m)
    (if (< m 1)
        (list 1)
        ; else:
        (let* ((prevSums (geom n (- m 1)))
              (prevSum (car prevSums)))
            (cons
                (+ prevSum (car (powers (/ 1 n) m)))
                prevSums))))

;; calculate a list containing:
;;    1+1/n+...+ 1/n^m, 1+1/n+...+ 1/n^(m-1), ... , 1+1/n, 1
;; using floating point
(defun geom-fp (n m)
    (if (< m 1)
        (list 1.0)
        ; else:
        (let* ((prevSums (geom-fp n (- m 1)))
              (prevSum (car prevSums)))
            (cons
                (+ prevSum (car (powers-fp (/ 1 n) m)))
                prevSums))))

(let*
    ((n (get-positive-integer "n"))
     (m (get-positive-integer "m"))
     (taskVarDescr "task (1=floating-point n^m; 2=integer n^m; 3=floating-point 1+1/n+1/n^2+...+1/n^m; 4=rational 1+1/n+1/n^2+...+1/n^m)")
     (task (get-positive-integer taskVarDescr))
     (result
        (case task
        (1 (reverse (powers-fp n m)))
        (2 (reverse (powers n m)))
        (3 (reverse (geom-fp n m)))
        (4 (reverse (geom n m))))))
    (write result))
