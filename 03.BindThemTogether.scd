/*

As we've seen, patterns are a useful shorthand for creating abstract routines,
and combining into more complex streams of values.

So how does this relate to music and Events in Supercollider?

We'll take a look now at Pbind, which allows us to bind patterns to keys,
and generate a stream of events with the corresponding key values in the
default event to be overriden by velues returned by the patterns.

*/

~tones = [2, 4, 5, 4, 8, 7, 8, 9];

(
~melody = Pbind(
	\instrument, \default,
	\degree, Pseq(~tones, inf),
	\dur, Pseq([1, 0.5, 1, 0.5], inf),
);
)

~melody.play;
~melody.stop; // uh-oh, this doesn't work

/*

Calling 'play' on a Pbind generates an EventStreamPlayer. If you don't assign
this player to a reference, you'll have no way to stop the player other than
Cmd-Period.

This is a common error when dealing with Pbind.

*/

x = ~melody.play;
//
x.stop; // this works as expected
x.play; // this picks up where the stream left off.




/* Chaining patterns together */

~tempoPattern = Pbind(\tempo, 165/60);

p = Pchain(~tempoPattern, ~melody);

p.play;

/*

Patterns to the right are fed as input to patterns to their left.
This has the effect of left patterns filtering patterns to the right,
e.g. duplicate keys on the left will override incoming values from other
patterns.

There is a shorthand for this chaining: Pattern1 <> Pattern2 <> Pattern3 ...

*/

~chords = Pbind(\mtranspose, Pstep([0, 3, 1, 4], 6, inf));

p = ~tempoPattern <> ~chords <> ~melody;
p.play;

/*

By filtering this stream and using a different synth, we can create
a more familiar (and less hokey) line.

*/

(
~runaway = Pbind(
	\instrument, \squareSynth,
	\octave, 3,
	\dur, 0.25,
	\mtranspose, 0,
	\legato, 1,
	\filtFreq, Pseg([0, 1, 0], 32, 'lin', inf) * 400 + 150,
	\rq, 0.9 - Pseg([0, 0.7, 0], 16, 'lin', inf)
)
)


~result = ~runaway <> p;

x = ~result.play
x.stop


/*

Sequencing event streams

You can use patterns to sequence event patterns, also.

*/


(
Pseq([
	p,
	~result,
	p
]).play
)


/*

Oops! We fell prey to the infinite pattern problem again...

So what do you do if you have a pattern that never ends, and you'd
like to constrain it somehow? Use a constraint pattern like Pfindur, Pfinval, or Pfin.

Note that you can use a Pchain within other patterns as well.

*/

(
Pseq([
	Pfindur(12, p,),
	~runaway <> Pfindur(12, p,),
	Pfindur(12, p,)
]).play
)


/*

Stochastic example

As a final example, here is a complete (if cheesy) piece of stochastic algorithmic
music, using our venerable tone series stolen from pink floyd, with the
various parts, durations and rhythms chosen stochastically (randomly).

*/

(
~melody = Pbind(
	\instrument, \squareSynth,
	\degree, Prand(~tones, 16),
	\rest, Pwrand([0, Rest], [4, 1], inf),
	\octave, 6,
	\dur, Pxrand([2, 2, 1, 3, 4].normalizeSum * 4, inf),
	\filtFreq, Pbrown(300, 500, 10),
	\amp, 0.2,
	\pan, Pbrown(0, 1, 0.1),
	\rq, Pbrown(0.3, 0.9, 0.125)
);


~harmony = Pbind(
	\instrument, \squareSynth,
	\degree, Prand(~tones, inf) + [0, 2, 4] % 10,
	\dur, Pseq([1, 0.5, 1, 1.5], 4),
	\strum, Pwhite(0.01, 0.05),
	\pan, -0.5,
	\strumEndsTogether, true,
	\dec, 0.1,
	\sus, 0.2
);

~bass = Pbind(
	\instrument, \squareSynth,
	\degree, Pstep(Pwrand([0, 4, -3, 2, 5], [4, 3, 3, 1, 1].normalizeSum, inf), Prand([2, 0.5, 1.5], inf)),
	\dur, Pseq([1.5, 1.5, 1], 4),
	\filtFreq, 300,
	\rq, 0.5,
	\octave, 3,
	\atk, 0.1
);

)

(
Pseq([
	Ppar([~harmony]) <> (mtranspose: 0),
	Ppar([~harmony, ~bass]) <> (mtranspose: 0),
	Ppar([~melody, ~harmony, ~bass]) <> (mtranspose: 0),
	Ppar([~melody, ~harmony, ~bass]) <> (mtranspose: 3),
	Ppar([~melody, ~harmony, ~bass]) <> (mtranspose: 2.rrand(5.0)),
	Ppar([~melody, ~harmony, ~bass]) <> (mtranspose: 1.rrand(6.0)),
	Ppar([~melody, ~harmony, ~bass]) <> (mtranspose: 1),
	Ppar([~melody, ~harmony, ~bass]) <> (mtranspose: 4),
	Ppar([~harmony, ~bass]) <> (mtranspose: 0),
	~bass
]).play
)

