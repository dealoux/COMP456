/* This program is the Farmer Wolf Goat and Cabbage problem knowledge base for an expert system 
    The problem can be solved by 2 possible paths, the user can choose to display only the 1st path or both paths
    State syntax: state(Farmer, Wolf, Goat, Cabbage) 
1st path
F W G C
e e e e
w e w e
e e w e
(w w w e)
(e w e e)
w w e w
e w e w
w w w w

2nd path
F W G C
e e e e
w e w e
e e w e
(w e w w)
(e e e w)
w w e w
e w e w
w w w w

/* Facts */
start(state(e, e, e, e)).
goal(state(w, w, w, w)).
opp(e, w).
opp(w, e).
unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, W, Y, Y)) :- opp(X, Y).
safe(X) :- \+ unsafe(X).
safe2(X) :- \+ unsafe(X). %For the 2nd path

/* Root rule */
rule( (path(Path) :- (try(X), path(X, Path))), 100).

/* Rules */
/* Path 1 root call */
rule( (try(path1) :- 
    safe(state(e, w, e, w))
    ), 100).
/* Path 2 root call */
rule( (try(path2) :- 
    safe2(state(e, w, e, w))
    ), 100).

/* e w e w */
rule( (safe(state(e, w, e, w)) :- 
    safe(state(w, w, e, w))
    ), 100).
/* Path 2 */
rule( (safe2(state(e, w, e, w)) :- 
    safe2(state(w, w, e, w))
    ), 100).

/* w w e w */
rule( (safe(state(w, w, e, w)) :- 
    safe(state(e, w, e, e))
    ), 100).
/* Path 2 */
rule( (safe2(state(w, w, e, w)) :- 
    two_paths,
    safe(state(e, e, e, w))
    ), 100).

/* e w e e (Path 1) */
rule( (safe(state(e, w, e, e)) :- 
    safe(state(w, w, w, e))
    ), 100).
/* e e e w (Path 2) */
rule( (safe(state(e, e, e, w)) :- 
    safe(state(w, e, w, w))
    ), 100).

/* w w w e (Path 1) */
rule( (safe(state(w, w, w, e)) :- 
    safe(state(e, e, w, e))
    ), 100). 
/* w e w w (Path 2) */
rule( (safe(state(w, e, w, w)) :- 
    safe(state(e, e, w, e))
    ), 100).

/* e e w e (both paths) */
rule( (safe(state(e, e, w, e)) :- 
    safe(state(w, e, w, e))
    ), 100).

/* w e w e (both paths) */
rule( (safe(state(w, e, w, e)) :- 
    start(state(e,e,e,e))
    ), 100).

/* start, e e e e (both paths) */
rule( (start(X) :- start), 100).

rule( path(path1, 'Path 1: (e, e, e, e) - (w, e, w, e) - (e, e, w, e) - (w, w, w, e) - (e, w, e, e) - (w, w, e, w) - (e, w, e, w) - (w w w w)'), 100).
rule( path(path2, 'Path 2: (e, e, e, e) - (w, e, w, e) - (e, e, w, e) - (w, e, w, w) - (e, e, e, w) - (w, w, e, w) - (e, w, e, w) - (w w w w)'), 100).

/* Askables */
askable(two_paths).
askable(start).