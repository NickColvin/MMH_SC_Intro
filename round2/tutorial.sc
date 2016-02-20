// hello world - what are UGens?

{ SinOsc.ar() }.play

// playback a file

{ b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav"); PlayBuf.ar(1, b, BufRateScale.kr(b)) }.play

/////////////////////////
// automatic music box //
/////////////////////////


(// start with an impulse
{
	Impulse.ar(1);

}.play
)

(// wrap it in a resonator
{
	Ringz.ar( Impulse.ar(1) );

}.play
)

(// modulate the frequency
{
	Ringz.ar( Impulse.ar(1), Pulse.kr(0.5, width: 0.5, mul: 220, add: 440) );

}.play
)

(// more than one
{
	Ringz.ar( Impulse.ar(1), Pulse.kr(0.5, width: 0.5, mul: 220, add: 440) ).dup(2);

}.play
)

(// add iteration args - talk about array expansion
{
	{|i|
		i=i+1;
		Ringz.ar( Impulse.ar(i), Pulse.kr(0.5, width: 0.5, mul: 220, add: 440) )
	}.dup(2);

}.play
)

(// mix it down
{
	Mix(
		{|i|
			i=i+1;
			Ringz.ar( Impulse.ar(i), Pulse.kr(0.5, width: 0.5, mul: 220, add: 440) )
		}.dup(3),

	);

}.play
)

(// add complexity
{
	Splay.ar(
		{|i|
			i=i+1;
			Ringz.ar( Impulse.ar(i), GbmanN.ar(2, mul: 220, add: 440) )
		}.dup(3),

	);

}.play
)

(// play around
{
	var sound = Splay.ar(
		{|i|
			var snd;
			i=i+1;
			snd = Impulse.ar(i);
			snd = Ringz.ar( snd, GbmanN.ar(1+i, mul: 20, add: 40+(i*5)).round.midicps);

			snd + CombC.ar(snd, 0.2, 0.1, mul: 0.3); // add some delay
		}.dup(4); // duplicate this

	);

	Limiter.ar(sound, 0.5); //protect your ears
}.play
)


(// play around
{
	var sound = Splay.ar(
		{|i|
			var snd;
			i=i+1;
			snd = Impulse.ar(i);
			snd = Ringz.ar( snd, GbmanN.ar(1+i, mul: 20, add: 40+(i*5)).round.midicps);

			snd + CombC.ar(snd, 0.2, 0.1, mul: 0.3); // add some delay
		}.dup(4); // duplicate this

	);

	Limiter.ar(sound, 0.5); //protect your ears
}.play
)

(// using demand rate
{
	var sound = Splay.ar(
		{|i|
			var snd, trig;
			i=i+1;
			trig = Lag.ar(Impulse.ar(i), 0.005);
			snd = Ringz.ar( trig, Demand.ar(trig, 0, Dshuf([0,2,4,5,7,9,11] + 30 + (i*10), inf).midicps));
			snd = snd * (1/i); // bring down the amplitude on each iteration

			snd = snd + CombC.ar(snd, 0.2, 0.1, mul: 0.3); // add some delay

		}.dup(4); // duplicate this

	);

	Limiter.ar(sound, 0.5); //protect your ears
}.play
)


// Chaos ugens

ChaosGen.allSubclasses.do(_.postln)

// What do these look like?

{LinCongN.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));
{HenonN.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));
{LatoocarfianN.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));
{CuspN.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));
{QuadN.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));
{GbmanN.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));
{LorenzL.ar}.plot(0.005, bounds: Rect(0, 0, 1000, 500));


