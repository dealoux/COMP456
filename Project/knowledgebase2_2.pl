/* This program is the Farmer Wolf Goat and Cabbage problem knowledge base for an expert system */

rule((move(St1, Cu1) :- 
  (start(state(St1, St2, St3, St4)),
  switch(state(St1, St2, St3, St4), state(Cu1, Cu2, Cu3, Cu4), [state(St1, St2, St3, St4)]))), 100).

/* Facts */
opp(e, w).
opp(w, e).
unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, W, Y, Y)) :- opp(X, Y).

start(state(e, e, e, e)).
goal(state(w, w, w, w)).

/* Rules */
switch(state(F1, W1, G1, C1), state(F2, W2, G2, C2), Path) :-
  is_end(state(F1, W1, G1, C1))
  ;
  move_state(state(F1, W1, G1, C1), state(F2, W2, G2, C2)),
  \+ checked(state(F2, W2, G2, C2), Path),
  switch(state(F2, W2, G2, C2), state(F3, W3, G3, C3), [state(F2, W2, G2, C2)|Path]).

/* move_state predicate, logic for all possible moving choices */
/* farmer takes wolf */
move_state(state(X, X, G, C), state(Y, Y, G, C)) :-
  opp(X, Y), \+ unsafe(state(Y, Y, G, C)).
/* farmer takes goat */
move_state(state(X, W, X, C), state(Y, W, Y, C)) :-
  opp(X, Y), \+ unsafe(state(Y, W, Y, C)).
/* farmer takes cabbage */
move_state(state(X, W, G, X), state(Y, W, G, Y)) :-
  opp(X, Y), \+ unsafe(state(Y, W, G, Y)).
/* farmer by self */
move_state(state(X, W, G, C), state(Y, W, G, C)) :-
  opp(X, Y), \+ unsafe(state(Y, W, G, C)).


/* goal_reached predicate, true when the current path reached the goal */
goal_reached(state(F, W, G, C)) :-
  goal(state(F_goal, W_goal, G_goal, C_goal)),
  F = F_goal, W = W_goal, G = G_goal, C = C_goal.


/* checked predicate, true when the current path has alrealdy been to the given state before */
checked(state(F, W, G, C), []) :- fail.
checked(state(F, W, G, C), [PathHead|PathTail]) :-
  state(F, W, G, C) == PathHead
  ;
  checked(state(F, W, G, C), PathTail).

askable(test).