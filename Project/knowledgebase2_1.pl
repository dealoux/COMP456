rule((move(St1, Cu1) :- 
    (start(state(St1, St2, St3, St4)),
    switch(state(St1, St2, St3, St4), state(Cu1, Cu2, Cu3, Cu4), [state(St1, St2, St3, St4)]))), 100).

start(state(east_side, east_side, east_side, east_side)).
end(state(west_side, west_side, west_side, west_side)).

switch(state(F1, G1, W1, C1), state(F2, G2, W2, C2), History) :-
    is_end(state(F1, G1, W1, C1))
    ;
    move_state(state(F1, G1, W1, C1), state(F2, G2, W2, C2)),
    \+ is_history(state(F2, G2, W2, C2), History),
    switch(state(F2, G2, W2, C2), state(F3, G3, W3, C3), [state(F2, G2, W2, C2)|History]).

move_state(state(X,X,W,C), state(Y,Y,W,C)) :- 
    opp(X,Y), \+ unsafe(state(Y,Y,W,C)).
move_state(state(X,G,X,C), state(Y,G,Y,C)) :- 
    opp(X,Y), \+ unsafe(state(Y,G,Y,C)).
move_state(state(X,G,W,X), state(Y,G,W,Y)) :- 
    opp(X,Y), \+ unsafe(state(Y,G,W,Y)).
move_state(state(X,G,W,C), state(Y,G,W,C)) :- 
    opp(X,Y), \+ unsafe(state(Y,G,W,C)).

opp(east_side, west_side).
opp(west_side, east_side).

unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, Y, W, Y)) :- opp(X, Y).

is_end(state(F1, G1, W1, C1)) :-
    end(state(Side1, Side2, Side3, Side4)),
    Side1 == F1, Side2 == G1, 
    Side3 == W1, Side4 == C1.

is_history(state(F1, G1, W1, C1), []) :-
    fail.
is_history(state(F1, G1, W1, C1), [HisHead|HisTail]) :-
    state(F1, G1, W1, C1) == HisHead
    ;
    is_history(state(F1, G1, W1, C1), HisTail).

% This has to be added if there are no ask-able questions otherwise the program will fail
askable(test).