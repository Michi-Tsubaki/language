#!/usr/bin/env roseus

;;Recursion
(defun !1 (x)
  (if (= x 0)
      1
    (* x (!1 (- x 1)))))

;;Iteration
(defun !2 (x)
  (let ((r 1))
    (dotimes (i x)
      (setq r (* r (+ i 1))))
    r))
