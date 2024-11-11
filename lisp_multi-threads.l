#!/usr/bin/env roseus

(sys::make-thread 4) ;;スレッドプールにスレッドを生成する.

(setq g 0)

(defun test (l)
  (while (>= g 0)
    (format t "l = ~A, g = ~A~%" l g)
    (unix:sleep 1)
  )
)

(sys::thread-no-wait #'test 0)

(setq g 1)

(sys::thread-no-wait #'test 1)

(setq g -1)
