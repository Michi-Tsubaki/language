#!/usr/bin/env julia

#標準出力
println("[標準出力]")
println("Hello, world!")

#四則演算
println("[四則演算]")
println("1+1=")
println(1+1)

println("3+5 - 2*4 + 5/3=")
println(3+5 - 2*4 + 5/3)

println("4/2=")
println(4/2)

println("4÷2=")
println(4÷2)

println("5/2=")
println(5/2)

println("5÷2= #pythonの5//2に対応")
println(5÷2)

println("5%2=")
println(5%2)

#基本的な数値計算
println("[基本的な数値計算]")
println("3^2 + sqrt(2)=")
println(3^2 + sqrt(2))

println("pi=")
println(pi)

println("π=")
println(π)

println("BigFloat(pi)=")
println(BigFloat(pi))

println("cos(1.5)+exp(2)")
println(cos(1.5)+exp(2))

println("sin(2*π)=")
println(sin(2*π))
println("sin(2π)=")
println(sin(2π))

#複素数
println("[複素数]")
print("4 + 5im=")
print(4 + 5im)

println("exp(4 + 5im)=")
println(exp(4 + 5im))

#分数
println("[分数]")
println("1//2+1//3= #pythonとは違うので注意")
println(1//2 + 1//3)

println("(2+3im)//(4+5im)")
println((2+3im)//(4+5im))

#コメントアウト
println("[コメントアウト]")
println("#= =#で囲むと複数行コメントアウトできる")