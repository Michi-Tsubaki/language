#!/usr/bin/env julia

function MC(N)
	 count = 0
	 for n = 1:N
	     x = rand() #Random Number 0~1
	     y = rand()
	     r = x^2+y^2
	     count += ifelse(r>1,0,1)
	 end
	 return 4*count/N
end

N = 10000
println("")
println("円周率は",MC(N))
println("円周率は",MC(N))
##実行するたびに値が変わるのは，生成されているラン数列が毎回変わるから！


##乱数シードの固定
using Random
function MC(N; seed=10)
	 Random.seed!(seed)
	 count = 0
	 for n = 1:N
	     x = rand() #Random Number 0~1
	     y = rand()
	     r = x^2+y^2
	     count += ifelse(r>1,0,1)
	 end
	 return 4*count/N
end


println("円周率は",MC(N))
println("円周率は",MC(N))

##描画
using Plots
function test()
ncs = [10^n for n=0:9]
ms = []
for nc in ncs
m = MC(nc)
push!(ms,abs(pi-m)/pi)
end
println(ms)
