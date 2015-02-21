
(
SynthDef(\squareSynth,

	{
		arg freq = 440, gate = 1, pan = 0, width = 0.5, filtFreq = 400, rq = 0.6, out = 0, amp = 0.7, atk = 0.01, dec = 0, sus = 1, rel = 0.05;
		var sig, env, delEnv;

		env = EnvGen.ar(Env.adsr(atk, dec, sus, rel), gate);
		delEnv = EnvGen.ar(Env.asr(0.01, 1, 1), gate, doneAction: 2);

		sig = Pulse.ar(freq, width);
		sig = RLPF.ar(sig, filtFreq, rq);
		sig = sig * env;

		sig = Pan2.ar(sig, pan);

		sig = sig + CombC.ar(sig, delaytime: 0.2, mul: 0.2);
		sig = sig * delEnv;

		sig = sig * amp;

		Out.ar(out, sig);
}).add;





)