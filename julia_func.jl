#!/usr/bin/env julia

#2. 数式をコードにしてみよう

##シンプルな書き方
###ex1
f(x)=cos(x)+2sin(2x^2)
println("f(x)=cos(x)+2sin(2x^2)")

println("f(1) = ",f(1))

c=4
println("c=4")

println("f(c)*f(c)+log(f(c)) = ",f(c)*f(c)+log(f(c)))

###ex2
g(x)=exp(im*x)*f(x)
println("g(x)=exp(im*x)*f(x)")

println("g(3) = ",g(3))

println("g(2*im+2) = ",g(2*im+2))

##二変数関数
###ex
f(x,y)=cos(x)*sin(y)
println("f(x,y)=cos(x)*sin(y)")

println("f(3) = ",f(3))

println("f(0,pi/2) = ",f(0,pi/2))


##Common Usage
function h(θ)
	 x = cos(θ)
	 y = sin(θ)
	 R = y/sqrt(x^2+y^2)
	 return exp(R)
end

println("function h(θ)")
println("	 x = cos(θ)")
println("	 y = sin(θ)")
println("	 R = y/sqrt(x^2+y^2)")
println("	 return exp(R)")
println("end")

println("h(0.1) = ",h(0.1))

##return can be abreviated!
println("returnは省略できる．その場合，endの1つ前の処理を返すことになる．")

function h_2(θ)
	 x = cos(θ)
	 y = sin(θ)
	 R = y/sqrt(x^2+y^2)
	 exp(R)
end
println("function _2h(θ)")
println("	 x = cos(θ)")
println("	 y = sin(θ)")
println("	 R = y/sqrt(x^2+y^2)")
println("	 exp(R)")
println("end")

println("h_2(0.1) = ",h_2(0.1))

##Optional Variables
println("\nOptional Vatiables")
function h_3(x, a = 2)
	 a * x
end
println("function h_3(x, a = 2)")
println("	 a*x")
println("end")

println("h_3(1) = ",h_3(1))
println("h_3(1,3) = ",h_3(1,3))


##Multiple Return
println("\nMultiple Return")
function j(x, y)
	 return x+y, x-y
end
println("function j(x,y)")
println("	 return x+y x-y")
println("end")

a= j(2,1)
println("a = j(2,1)")
println("a = ",a)
println("a[1] = ",a[1])
println("a[2] = ",a[2])
println("Remark: Return is tuple! and index is from 1! not zero")

##Tuple cannot be changed!
println("Tuple cannot be changed")
println("a[1] = 4")
println("The function `setindex!` exists, but no method is defined for this combination of argument types.")

##Pipe Operator
println("\nパイプライン演算子(|>) :: ある式の結果を別の式に1つ目の引数として渡す演算子")
T_nor(n,x) = exp(cos(n*acos(x))) #normal usage
println("T_nor(n,x) = exp(cos(n*acos(x))) #normal usage")
T_pip(n,x) = n*acos(x) |> cos |> exp #pipe usage #frome inner to outer
println("T_pip(n,x) = n*acos(x) |> cos |> exp #pipe usage #frome inner to outer")
println("T_nor(10,0.5) = ",T_nor(10,0.5))
println("T_pip(10,0.5) = ",T_pip(10,0.5))
