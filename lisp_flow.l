#!/usr/bin/env roseus

;;euslispによる流れの記述など

;;Input and Output
;;Generally, the function for output is "format".
(format t "~A plus ~A equals ~A.~%" 2 3 5) ;;~% が pythonの\n に対応する開業
;;Generally, the function for input is "read".
(defun ask (string) (format t "~A" string) (finish-output) (read))
(ask "How old are you ?")

;;Variables
;;Local Variables are set by "let"
(let ((x 1) (y 2)) (+ x y))

(defparameter z 3)

(let (x 1) (+ x z))

(let ((x 1) (z 4)) (+ x z))
