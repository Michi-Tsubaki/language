#!/usr/bin/env julia

using Plots

function Basel(nc)
	 a = 0
	 for n = 1:nc
	     a += 1/n^2
	 end
	 return sqrt(6a)
end

function test()
	 ncs = [1, 10, 100, 1000, 10000]
	 bs = []
	 for nc in ncs
	     b = Basel(nc)
	     push!(bs,abs(π-b)/π)
	     ##println("バーゼル級数和(nc = &nc): ",b,"\t",abs(π-b)/π)
	 end
	 return ncs, bs
end

ncs, bs = test()

using Plots
plot(ncs, bs)
savefig("basel.pdf")
plot(ncs,bs,xscale=:log10, yscale=:log10,markershape= :circle, label ="Basel", xlabel="cutoff num", ylabel="relative error")
savefig("basellog.pdf")
