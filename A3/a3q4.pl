/* This program try to solve the farmer problem using:
    1.	Breadth-first search, implemented by using the queue ADT
    usage: test_bf., should runs the program using breath-first search
    custom values test: go_bf(state(F, W, G, C), state(F, W, G, C)).

    2.	Depth-first search, implemented by using the stack ADT
    usage: test_df., should runs the program using depth-first search
    custom values test: go_df(state(F, W, G, C), state(F, W, G, C)).
*/

/* Depth-first search */
go_df(Start, Goal) :-
  empty_stack(Empty_open),
  stack([Start, nil], Empty_open, Open_stack),
  empty_set(Closed_set),
  path_df(Open_stack, Closed_set, Goal).

path_df(Open_stack, _, _) :-
  empty_stack(Open_stack),
  write('No solution found with these rules').

path_df(Open_stack, Closed_set, Goal) :-
  stack([State, Parent], _, Open_stack),
  State = Goal,
  write('A solution is found!'), nl,
  printSolution([State, Parent], Closed_set).

path_df(Open_stack, Closed_set, Goal) :-
  stack([State, Parent], Rest_open_stack, Open_stack),
  get_children_df(State, Rest_open_stack, Closed_set, Children),
  add_list_to_stack(Children, Rest_open_stack, New_open_stack),
  union([[State, Parent]], Closed_set, New_closed_set),
  path_df(New_open_stack, New_closed_set, Goal), !.

get_children_df(State, Rest_open_stack, Closed_set, Children) :-
  (bagof(Child, moves_df(State, Rest_open_stack, Closed_set, Child), Children)  ; Children = []).

moves_df(State, Rest_open_stack, Closed_set, [Next, State]) :-
  move(State, Next),
  \+ unsafe(Next), 
  \+ member_stack([Next, _], Rest_open_stack),
  \+ member_set([Next, _], Closed_set).

test_df :- go_df(state(w, w, w, w), state(e, e, e, e)).

/* Breadth-first search */
go_bf(Start, Goal) :-
  empty_queue(Empty_open_queue),
  enqueue([Start, nil], Empty_open_queue, Open_queue),
  empty_set(Closed_set),
  path_bf(Open_queue, Closed_set, Goal).

path_bf(Open_queue, _, _) :-
  empty_queue(Open_queue),
  write('No solution found with these rules.').

path_bf(Open_queue, Closed_set, Goal) :-
  dequeue([State, Parent], Open_queue, _),
  State = Goal,
  write('A solution if found!'), nl,
  printSolution([State, Parent], Closed_set).

path_bf(Open_queue, Closed_set, Goal) :-
  dequeue([State, Parent], Open_queue, Rest_open_queue),
  get_children_bf(State, Rest_open_queue, Closed_set, Children),
  add_list_to_queue(Children, Rest_open_queue, New_open_queue),
  union([[State, Parent]], Closed_set, New_closed_set),
  path_bf(New_open_queue, New_closed_set, Goal), !.

get_children_bf(State, Rest_open_queue, Closed_set, Children) :-
  (bagof(Child, moves_bf(State, Rest_open_queue, Closed_set, Child), Children) ; Children = []).

moves_bf(State, Rest_open_queue, Closed_set, [Next, State]) :-
  move(State, Next),
  \+ unsafe(Next), 
  \+ member_queue([Next, _], Rest_open_queue),
  \+ member_set([Next, _], Closed_set).

test_bf :- go_bf(state(w, w, w, w), state(e, e, e, e)).

/* Common */
printSolution([State, nil], _) :- write(State), nl.
printSolution([State, Parent], Closed_set) :-
  member_set([Parent, Grandparent], Closed_set),
  printSolution([Parent, Grandparent], Closed_set),
  write(State), nl.

writelist([]) :- nl.
writelist([H|T]) :- write(H), tab(1), writelist(T).

/* Stack ADT */
empty_stack([]).

stack(Top, Stack, [Top | Stack]).

member_stack(Element, Stack) :-
  member(Element, Stack).

add_list_to_stack(List, Stack, Result) :-
  append(List, Stack, Result).

/* Queue ADT */
empty_queue([]).

enqueue(E, [], [E]).
enqueue(E, [H|T], [H|T_new]) :-
  enqueue(E, T, T_new).

dequeue(E, [E|T], T).
dequeue(E, [E|T], _).

member_queue(Element, Queue) :-
  member(Element, Queue).

add_list_to_queue(List, Queue, Result) :-
  append(Queue, List, Result).

/* Set ADT */
empty_set([]).

member_set([State, Parent], [[State, Parent]|_]).
member_set(X, [_|T]) :- member_set(X, T).

add_if_not_in_set(X, S, S) :-
  member(X, S), !.
add_if_not_in_set(X, S, [X|S]).

union([], S, S).
union([H|T], S, S_new) :-
  union(T, S, S2),
  add_if_not_in_set(H, S2, S_new), !.

/* The farmer problem rules */
opp(e, w).
opp(w, e).
unsafe(state(X, Y, Y, C)) :- opp(X, Y).
unsafe(state(X, W, Y, Y)) :- opp(X, Y).

move(state(X, X, G, C), state(Y, Y, G, C)) :-
  opp(X, Y), \+ unsafe(state(Y, Y, G, C)),
  writelist(['try farmer takes wolf', Y, Y, G, C]).

move(state(X, W, X, C), state(Y, W, Y, C)) :-
  opp(X, Y), \+ unsafe(state(Y, W, Y, C)),
  writelist(['try farmer takes goat', Y, W, Y, C]).

move(state(X, W, G, X), state(Y, W, G, Y)) :-
  opp(X, Y), \+ unsafe(state(Y, W, G, Y)),
  writelist(['try farmer takes cabbage', Y, W, G, Y]).

move(state(X, W, G, C), state(Y, W, G, C)) :-
  opp(X, Y), \+ unsafe(state(Y, W, G, C)),
  writelist(['try farmer by self', Y, W, G, C]).

move(state(F, W, G, C), state(F, W, G, C)) :-
  writelist(['BACKTRACK from:', F, W, G, C]), fail.