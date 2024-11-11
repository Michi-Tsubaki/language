#!/usr/bin/env julia

#juliaにおけるflow記述

##if文
println("if")

x = 3
println("x=3")

if x > 4
   y = 3
elseif x < 0
   y = 30
else
   y = 10
end

println("y = $y")

##複数条件（かつ、または）
if x > 0 && x < 10
   y = 5
end

println("y = $y")

##if文の比較演算子の複数連結
if 0 < x < 10
   y = 5
end

println("y = $y")


##ex. ReLUの実装

function ReLU(x)
	 if x < 0
	    zero(x)
	 else
	    x
	 end
end

println("ReLU(1) = ", ReLU(1))

println("ReLU(-4) = ", ReLU(-4))


##三項演算子
println("三項演算子：「条件式? trueのときの処理: falseのときの処理」")

x = -3
println("x = -3")

x > 0 ? sqrt(3) : x
println("x > 0 ? sqrt(3) : x")

##繰り返しfor文
###等比級数の和
function f(r, n)
	 a = zero(r)
	 for i = 1:n
	     a += r^(i-1)
	 end
	 return a
end

println("f(0.5, 10) = ", f(0.5, 10))

###解析解との比較
fanalytic(r ,n) = (1-r^n)/(1-r)
println("fanalytic(0.5, 10) = ", fanalytic(0.5, 10))



#ex. 松原振動数の和
function g(x, T, nmax; τ=0.01)
	 a = 0im #aは複素数になるので，0imで初期化する
	 for n = -nmax:nmax
	     ωn = pi*T*(2n+1)
	     a += exp(im*ωn*τ)/(im*ωn-x)
	 end
	 return real(a*T)
end

xs = 