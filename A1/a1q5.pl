/* This program takes a given integer and a given integer list then returns a list of appreance indexes of that integer in the list
 X: given integer
 L: given integer list
 C: current count
 N: next count (increasing by 1)
 R: current result list
 F: newly appended result list

 Usage: count(integer, list).
 E.g: count(1, [1,1,3,4,1]). Should return [1,2,5] 
*/

/* Indexing logic functions  */
count(X, [], C, R) :-
  write(R).

count(X, [H|T], C, R) :- X =\= H,
  N is C+1,
  count(X, T, N, R).

count(X, [H|T], C, R) :- X =:= H,
  append(R, [C], F),
  N is C+1,
  count(X, T, N, F).

/* Verifying functions, recursively check whether or not a value is in a list */
my_member(X, [X|L]).
my_member(X, [Y|L]) :- my_member(X, L).

/* Main functions */
count(X, L) :- \+ my_member(X, L),
  write('Value not in list').
count(X, L) :- my_member(X, L),
  C is 1,
  count(X, L, C, []).