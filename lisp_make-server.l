#!/usr/bin/env roseus
;;一方のターミナルで
(open-server 1234 #'(lambda (s) (print (eval (read s)) s)))

;;他方のターミナルで
telnet <host名> 1234
