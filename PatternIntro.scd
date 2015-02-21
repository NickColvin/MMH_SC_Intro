/*

**** Introduction to Patterns ****


Patterns may be thought of as a shorthand for routines, with many pre-defined
algorithms for value production based on a few arguments. There is (much) more
to them than this simple description. For a more detailed description see
the 'Pattern' helpfile.

*/

p = Pseries(0, 1, 12);
q = p.asStream; // a pattern must be converted to a stream in order to yield values

r = Routine({12.do({|i| i.yield})});

12.do({ Post << Char.tab << r.next << " " << q.next << Char.nl; });



// **** List/Sequence Patterns ****



/* Pseries generates a series of values, beginning with 'start', incrementing by 'step',
	with the number of values indicated by 'length' */

p = Pseries(start: 0, step: 1, length: inf);
q = p.asStream;

35.do({q.next.postln});



// Pseq outputs a series of notes from a list, 'repeat's as specified, beginning on the index of 'offset'

~list = [0, 2, 4, 1, 3, 5, 6, 8];

p = Pseq(list: ~list, repeats: 1, offset: 0);
q = p.asStream;

8.do({q.next.postln});



// Prand takes a list and outputs a random element
p = Prand(~list, repeats: 10);
q = p.asStream;

10.do({q.next.postln});



// Pxrand takes a list and outputs a random element, never repeating an element

p = Pxrand(~list, repeats: 10);
q = p.asStream;

10.do({q.next.postln});


// **** Random Value Patterns ****


// Pwhite generates a stream of random numbers between 'lo' and 'hi' inclusive.

p = Pwhite(lo: 0, hi: 100, length: 20);
q = p.asStream;

20.do({q.next.postln});



// Pbrown generates a step-wise stream of random numbers between 'lo' and 'hi' by the laws of brownian motion.

p = Pbrown(lo: 0, hi: 100, step: 0.125, length: 20);
q = p.asStream;

20.do({q.next.postln});




/* Why use patterns instead of routines(other than saving a few characters)?
	Because you may nest patterns within patterns, which will have the effect
	of ceding control to the nested pattern, then resuming the enclosing pattern
	when the nexted pattern ends.*/

l = Pseq(~list);
m = Pwhite(20, 40, 5);
n = Pseries(-10, 0.324);
o = Pseq(["the", "end"]);

p = Pseq([l, m, n, o], repeats: 1);

q = p.asStream;

25.do({q.next.postln});


/*

You may notice that we never see that last 'o' pattern show up.
Because the 'Pseries' defaults to an infinite stream, it never cedes
control back to the containing Pseq. This is a common error when dealing
with patterns.

Set 'length' to 10 in the Pseries 'n' and you'll see the last pattern.

*/





