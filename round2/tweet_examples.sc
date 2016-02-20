// some tweets


// rhythmic knocking

play{t=Impulse.ar(6)+Dust.ar(1);x=(TExpRand.ar(_,_,t));Limiter.ar(GVerb.ar(GrainFM.ar(2,t,x.(1e-4,0.01),f=x.(80,400),f/4,9),9,0.5))};// #sc

// new age sounds

play{GVerb.ar(SinOsc.ar(Select.kr(Hasher.kr(Duty.kr((1..4)/4,0,Dwhite(0,1)))*5,midicps([0,3,5,7,10]+60))).sum,200,3)/20}

// space invadery weirdness

play{Splay.ar({|i|j=i+2;b=GbmanN.ar(j);c=b*880%3000;CombC.ar(FBSineC.ar(c,1.01*j,1/c,1.01),2,b.range(0.001,0.2).lag(2,0.01),b*j)}!3)}//#SC3

// mic in the wind

play{LeakDC.ar(CompanderD.ar(LPF.ar(Normalizer.ar(CompanderD.ar(BrownNoise.ar!2,0.1,0.1,4)),LFDNoise3.kr(8,90,150)),0.1,1,0.5))}

( // not quite a tweet
play{
	Splay.ar(
		{|i|
			j=i+2;
			b=LinCongN.ar(j);
			c=b*880%3000;
			CombC.ar(
				FBSineC.ar(c, 1.01*b, 1/b, 1.01),
				2,
				b.range(0.01, 1).lag(2, 0.01),
				b*j
			)
			}!4
	)
};
play{a};
)

// spacey buzz

(
play{Mix.new({|i|
	j=i+2;
	b=LinCongN.ar(j).range(0,15);
	d=Blip.ar(b.round*110,b);
	Pan2.ar(
			CombC.ar(
			    d,
				2,
				b.range(0.001, 0.1),
				j/b
			) + d,
		i%2-1
	)
	}!3)
}
)