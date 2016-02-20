// hello world - what are UGens?

{ SinOsc.ar() }.play



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


// Chaos ugens

ChaosGen.allSubclasses.do(_.postln)

//

