#!/usr/bin/env julia

#変数定義
println("[変数定義]")
a = 4
println("a = 4")
println("a^2+2a+2=")
println(a^2+2a+2)

a = 4.2
println("a = 4.2")
println("a^2+2a+2=")
println(a^2+2a+2)

a = 2.3+2im
println("a = 2.3+2im")
println("a^2+2a+2=")
println(a^2+2a+2)

#日本語も変数として扱うことができる
println("[アルファベットの文字列以外も変数名にできる]")
つばき = 3
みちとし = 4
println("つばき = 3")
println("みちとし = 4")
println("つばき + みちとし * 4=")
println(つばき + みちとし * 4)

#その他の記号も変数として扱うことができる（ギリシア文字）
λ = 2.0
println("λ = 2.0")
println("Φ=exp(-2/λ)")
println(exp(-2/λ))

#変数を使った計算
println("[変数を使った計算]")
a = 3
b = 4
c = a*cos(b)
d = exp(c)
println("a=3")
println("b=4")
println("c = a*cos(b)")
println(c)
println("d = exp(c)")
println(d)


#代入と比較
println("[代入]")
println("a=4")
a = 4
println("a = a+3")
a = a+3
println(a)
println("a += 3")
a += 3
println(a)
println("[比較]")
println("a=3")
a = 3
println("b=5")
b = 5
println(" a == a+3")
println(a == a+3)
println("a < b < 10")
println(a < b < 10)

#型
println("[型]")
a = 4
println("a = 4")
println("typeof(a)")
println(typeof(a))

a = 4.2
println("a = 4.2")
println("typeof(a)")
println(typeof(a))

a = 1.2 + 2.1im
println("a = 1.2 + 2.1im")
println("typeof(a)")
println(typeof(a))

a = "test"
println("a = \"test\"")
println("typeof(a)")
println(typeof(a))

#文字列型変数
println("[文字列型変数]")
a = "test"
println("a = \"test\"")
println("a=")
println(a)
b = ".jl"
println("b = \".jl\"")
println("c = a*b = ")
c = a*b
println(c)
println("d = b*a =  #不可換なので注意")
d = a*b
println(d)

#標準出力
println("[標準出力]")
a = 3
b = 4
println(a, "\t", b)
println("tabは\tで入力できる↑あり，↓なし")
println(a, b)
println("aの値は",a,"ですが，bの値は",b,"となり")
println("aの値は$a ですが, bの値は$b となり")
println("a = $a")
println("b = $(a+3)")

#ファイルの書き出し
println("[ファイルの書き出し]")
fp = open("test.txt","w")
println(fp,"hello world")
close(fp)
println("fp = open(\"test.txt\",\"w\")")
println("println(fp,\"hello world\")")
println("close(fp)")