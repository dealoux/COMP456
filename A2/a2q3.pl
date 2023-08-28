/* This program checks all the possibility of paths from node A to node Z using breadth-first search, returns the most cost-effective path and its cost if exist.
  path(): recursively search through the graph by breadth-first algorithm, and calculate the cost fron node A to Z using the given edges data
    1.	Line 23, initial call to path()
    2.	Line 25-34: breath-first search
  shortest_path():
    1.	Line 38, call the recursive path()
    2.	Line 39-41: making sure that the 1st call is the most cost-effective path by comparing all the possible paths
  Usage: shortest_path(A, Z, Path, Cost).
  E.g: shortest_path(a, d, Path, Cost). should return Path = [a, b, c, d], Cost = 6
      shortest_path(c, a, Path, Cost). should fail as there are no path from c to a
*/

/* Verifying function */
not_member(X, []).
not_member(X, [Y|L]) :-
  not_member(X, L),
  X \== Y.

/* Graph info */
edge(a, b, 3).
edge(b, c, 1).
edge(b, d, 5). 
edge(c, d, 2). 
edge(d, b, 2).

/* Recursive path constructing functions */
path(A, Z, Path, Cost) :- path(A, Z, [], Path, Cost).

path(A, Z, Visited, [A, Z], Cost) :-
  not_member(A, Visited),
  edge(A, Z, Cost).

path(A, Z, Visited, [A|T], Cost) :-
  not_member(A, Visited),
  edge(A, B, C1),
  path(B, Z, [A|Visited], T, C2),
  not_member(A, T),
  Cost is C1 + C2.

/* Main function */
shortest_path(A, Z, Path, Cost) :-
  path(A, Z, Path, Cost),
  \+ (path(A, Z, Path1, LowerCost), 
  Path1 \= Path, 
  Cost >= LowerCost).