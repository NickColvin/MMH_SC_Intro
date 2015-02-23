/*

**** A quick event overview. ****

From the Event helpfile:

"An Event is an Environment that specifies an action to be taken in response
\to a -play message. The key/value pairs within the Event specify the
parameters of that action. Most methods Event inherits from its superclasses,
especially from Dictionary."

*/



().play 					// play default event
(note: 2).play 				// override the default note
(note: 2, octave: 4).play 	// override note and octave

r = Routine({12.do({|i| i.yield})}); // generate a stream of numbers from 0 to 11

r.next;
r.reset;

(		// create a loop: play the default event assigning values from 'r' to the value of the 'note' event key
fork{
	loop{
		var noteVal = r.next;
		if( noteVal == nil ) { r.reset; this.yield };

		(note: noteVal, root: 0, dur: 0.25).play;
		0.3.wait;
	}
}
)






( // a subset of the keys in the default event

(
mtranspose: 0,			// modal transposition of degree within a scale
gtranspose: 0.0,		// gamut transposition within the ~stepsPerOctave equal tempered scale
ctranspose: 0.0,		// chromatic transposition within the 12 tone equal tempered scale
octave: 5.0,			// octave offest of note
root: 0.0,			// transposes root of the scale
degree: 0,			// degree in scale
scale: #[0, 2, 4, 5, 7, 9, 11], // diatonic major scale
stepsPerOctave: 12.0,		//
detune: 0.0,			// detune in Hertz
harmonic: 1.0,			// multiplies the frequency determined by ~midinote, typically to an overtone
octaveRatio: 2.0,		// size of the octave (can be used with the Scale class)
tempo: nil,			// changes tempo of a TempoClock
dur: 1.0,			// time until next note (inter-onset time)
stretch: 1.0,			// inverse of tempo control, specific to the Event's stream
legato: 0.8,			// ratio of sustain to duration
sustain: #{ ~dur * ~legato * ~stretch },
lag: 0.0,			// delay (in seconds) relative to current time position of Stream
strum: 0.0,			// "breaks" a chord. May be negative, playing the chord backward
strumEndsTogether: false,	// if true, the strummed notes end together (with gated synths)
amp: #{ ~db.dbamp },		// the amplitude
db: -20.0,			// the above described in decibel
velocity: 64, 			// MIDI units 0-127
pan: 0.0, 			// pan center
trig: 0.5,			// trigger value
server: nil,			// if nil, Server.default is used
synthLib: nil,			//
group: 1,			// nodeID of group on the server
out: 0,				// usually an output bus number, but depends on the SynthDef
addAction: 0,			// 0, 1, 2, 3 or \addToHead, \addToTail, \addBefore, \addAfter
instrument: \default,		// this is the name of a SynthDef
variant: nil,			// this is not in the helpfile neither. perhaps better to omit here?
hasGate: true,			// assume SynthDef has gate
sendGate: nil,			// false => event does not specify note release
timingOffset: 0,		// gives a tempo-relative offset time to each synth
).play
)


