start(state(e, e, e, e)).
goal(state(w, w, w, w)).
opp(e, w).
opp(w, e).
unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, W, Y, Y)) :- opp(X, Y).
safe(X) :- \+ unsafe(X).
safe2(X) :- \+ unsafe(X). %For 2nd path

/* Root rule */
path(Path) :- (try(X), path(X, Path)).

/* Rules */
/* Path 1 root call */
try(path1) :- 
    safe(state(e, w, e, w)).
/* Path 2 root call */
try(path2) :- 
    safe2(state(e, w, e, w)).

/* e w e w */
safe(state(e, w, e, w)) :- 
    safe(state(w, w, e, w)).
/* Path 2 */
safe2(state(e, w, e, w)) :- 
    safe2(state(w, w, e, w)).

/* w w e w */
safe(state(w, w, e, w)) :- 
    safe(state(e, w, e, e)).
/* Path 2 */
safe2(state(w, w, e, w)) :- 
    two_paths,
    safe(state(e, e, e, w)).

/* e w e e (Path 1) */
safe(state(e, w, e, e)) :- 
    safe(state(w, w, w, e)).
/* e e e w (Path 2) */
safe(state(e, e, e, w)) :- 
    safe(state(w, e, w, w)).

/* w w w e (Path 1) */
safe(state(w, w, w, e)) :- 
    safe(state(e, e, w, e)). 
/* w e w w (Path 2) */
safe(state(w, e, w, w)) :- 
    safe(state(e, e, w, e)).

/* e e w e (both paths) */
safe(state(e, e, w, e)) :- 
    safe(state(w, e, w, e)).

/* w e w e (both paths) */
safe(state(w, e, w, e)) :- 
    start(state(e,e,e,e)).

/* start, e e e e (both paths) 
start(X) :- start. */

path(path1, 'Path 1: (e, e, e, e) - (w, e, w, e) - (e, e, w, e) - (w, w, w, e) - (e, w, e, e) - (w, w, e, w) - (e, w, e, w) - (w w w w)').
path(path2, 'Path 2: (e, e, e, e) - (w, e, w, e) - (e, e, w, e) - (w, e, w, w) - (e, e, e, w) - (w, w, e, w) - (e, w, e, w) - (w w w w)').