(defvar myHouse
    '((street . "Golden Avenue")
      (houseNumber . 111)
      (floors . 4)))

(defvar myFlat1
    '((kind . ACCKIND_FLAT)
      (street . "Silver Street")
      (houseNumber . 81)
      (floor . 0)))

(defvar myFlat2
    '((kind . ACCKIND_FLAT)
      (street . "Silver Street")
      (houseNumber . 81)
      (floor . 7)))

(defvar myFlat3
    '((kind . ACCKIND_HOUSE)
      (street . "Silver Street")
      (houseNumber . 81)
      (floor . 7)))

(defvar myFlat4
    '((kind . ACCKIND_FLAT)
      (street . "Silver Street")
      (houseNumber . 81)))

(defvar myFlat5
    '((kind . ACCKIND_FLAT)
      (street . "Silver Street")
      (houseNumber . 81)
      (rooms . 3)
      (floor . 7)))

(defun accommodationp (accom)
    (let
        ((street (cdr (assoc 'street accom)))
         (houseNumber (cdr (assoc 'houseNumber accom)))
         (floors (cdr (assoc 'floors accom))))
        (and
          (= 3 (length accom)) ;; three components
          (stringp street)
          (integerp houseNumber)
          (> houseNumber 0)
          (integerp floors)
          (> floors 0))))

(print myHouse)
(print (accommodationp myHouse))

(print myFlat1)
(print (accommodationp myFlat1))

(print myFlat2)
(print (accommodationp myFlat2))

(print myFlat3)
(print (accommodationp myFlat3))

(print myFlat4)
(print (accommodationp myFlat4))

(print myFlat5)
(print (accommodationp myFlat5))
