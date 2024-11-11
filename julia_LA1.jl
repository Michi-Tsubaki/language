#!/usr/bin/env julia

a = [1, 2]
println("a = $a")

A = [1 2
     3 4]
println("A = $A")

b = A*a
println("b = A*a")
println("b = $b")

a = [1, 1]/sqrt(2)

b = [1,-1]/sqrt(2)

A = [0 -im
     im 0]

c = b'*A*a
println(c)

B = zeros(3,4)
println(B)

using LinearAlgebra
println(dot(a,b))
println(dot(a,a))
#import Pkg
#Pkg.add("DifferentialEquations")
using DifferentialEquations
f(u,p,t) = 1.01*u
u0 = 1/2
tspan = (0.0, 1.0)
prob = ODEProbrem(f, u0, tspan)