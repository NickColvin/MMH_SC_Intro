

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
		0.25.wait;
	}
}
)






( // a subset of the keys in the default event
(
mtranspose: 0,
gtranspose: 0.0,
ctranspose: 0.0,
octave: 5.0,
root: 0.0,					// root of the scale
degree: 0,
scale: #[0, 2, 4, 5, 7, 9, 11], 	// diatonic major scale
stepsPerOctave: 12.0,
detune: 0.0,					// detune in Hertz
harmonic: 1.0,				// harmonic ratio
octaveRatio: 2.0,
tempo: nil,
dur: 1.0,
stretch: 1.0,
legato: 0.8,
sustain: #{ ~dur * ~legato * ~stretch },
lag: 0.0,
strum: 0.0,
strumEndsTogether: false,
amp: #{ ~db.dbamp },
db: -20.0,
velocity: 64, 		// MIDI units 0-127
pan: 0.0, 			// pan center
trig: 0.5,
server: nil,
synthLib: nil,
group: 1,
out: 0,
addAction: 0,
instrument: \default,
variant: nil,
hasGate: true,		// assume SynthDef has gate
sendGate: nil,		// false => event does not specify note release
timingOffset: 0,
).play
)


