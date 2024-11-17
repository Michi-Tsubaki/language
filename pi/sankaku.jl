#!/usr/bin/env julia

##cos45°を半角公式で反復的に小さくしていくことで，円に近づけて円周率を求める

function sankaku()
	 c = sqrt(2)/2
	 hankakucos(c) = sqrt((1+c)/2)
	 n = 30 #正8^n角形までを繰り返し計算していく
	 N = 8

	 for i = 1:n
	     c = hankakucos(c)
	     N = N*2
	     l = sqrt(2 -2*c)
	     println("正$(8N)角形の場合: ", N*l/2,"\t", abs(π-N*l/2)/π)
	 end
end

sankaku()