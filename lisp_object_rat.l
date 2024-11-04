;;Robot_Sytem_3_kadai2(Optional)  ;;Coding Rational Class using Euslisp
;;Written by 03240281 Michi-Tsubaki
(defclass rat
  :super propertied-object
  :slots (numer denom))

(defmethod rat
  (:init
   (&optional (n 0) (d 1))
   (send self :set-rat n d)
   self)
  (:set-rat (n d) (setq numer n) (setq denom d))
  (:get-numer () numer)
  (:get-denom () denom)
  (:add-rat (x y) (send self :set-rat (+ (* (send x :get-numer) (send y :get-denom)) (* (send y :get-numer) (send x :get-denom))) (* (send x :get-denom) (send y :get-denom))))
  (:print-info
   ()
   (format t "~A / ~A~%" numer denom))
  )
  

;;Reference Code on Textbook (not using class)
;;(defun make-rat (n d) (cons n d))
;;(defun numer (x) (car x))
;;(defun denom (x) (cdr x))
;;(defun add-rat (x y)
;;  (make-rat (+ (* (numer x) (denom y))
;;	       (* (numer y) (denom x)))
;;	    (* (denom x) (denom y))))
;;(setq one-half (make-rat 1 2))
;;(add-rat one-half one-halft)
