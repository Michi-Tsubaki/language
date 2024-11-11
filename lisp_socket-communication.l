#!/usr/bin/env roseus
;;ソケット通信
;;クライアント用の関数として, host, portで指定されているソケットストリームを返す(connect-server host port)が用意されている
(setq s (connect-server "www.jsk.t.u-tokyo.ac.jp" 80))
(format s "GET / HTTP1.1~%")
(format s "~%")
(read-line s nil)
(while (setq l (read-line s nil)) (print l))
