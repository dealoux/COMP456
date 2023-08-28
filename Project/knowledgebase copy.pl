/* This program is the Farmer Wolf Goat and Cabbage problem knowledge base for an expert system */


/* Facts */
/*
opp(e, w).
opp(w, e).
unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, W, Y, Y)) :- opp(X, Y). */

start(state(e, e, e, e)).
goal(state(w, w, w, w)).

/* Root rule 

/* Rules */
rule( (goal(X) :- state(e, w, e, w)), 100).

rule( (state(e, w, e, w) :- state(w, w, e, w)), 100).


rule( (state(w, w, e, w) :- state(e, w, e, e)), 100).
rule( (state(e, w, e, e) :- state(w, w, w, e)), 100).
rule( (state(w, w, w, e) :- state(e, e, w, e)), 100). 

/*
rule( (state(w, w, e, w) :- (getWolf, state(e, w, e, e)) ; state(e, e, e, w) ), 100).

rule( (state(e, w, e, e) :- state(w, w, w, e)), 100).
rule( (state(w, w, w, e) :- state(e, e, w, e)), 100).

rule( (state(e, e, e, w) :- state(w, e, w, w)), 100).
rule( (state(w, e, w, w) :- state(e, e, w, e)), 100). */

rule( (state(e, e, w, e) :- state(w, e, w, e)), 100).

rule( (state(w, e, w, e) :- start(state(e, e, e, e))), 100).

rule((start(X) :- start), 100).


askable(getWolf).
askable(start).

/*
F W G C
e e e e
w e w e
e e w e

1st solution (take wolf next)
w w w e
e w e e

2nd solution (take cabbage next)
w e w w
e e e w

w w e w
e w e w
w w w w
*/