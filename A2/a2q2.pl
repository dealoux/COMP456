/* This program return an acyclic path (list of nodes) from node A to Z if found
  Graph: syntax graph(Nodes, Edges)
  Nodes: list of nodes of the graph
  Edges: list of edges, syntax: edge(startNode, endNode), of the graph 
  Path: the result acyclic path from A to Z if found  
  Path1: a path in the graph, used for constructing the resulting Path
  Usage: path(A, Z, Graph, Path).
  E.g: path(a, d, graph([a, b, c, d], [edge(a, b), edge(b, c), edge(b, d), edge(c, d), edge(d, b)]), Path). should return Path = [a, b, d]
*/

/* Verifying functions, recursively check whether or not a value is in a list */
my_member(X, [X|L]).
my_member(X, [Y|L]) :- my_member(X, L).

not_member(X, []).
not_member(X, [Y|L]) :-
  not_member(X, L),
  X \== Y.

/* Recursive path constructing functions */
path1(A, [A|Path1], Graph, [A|Path1]).

path1(A, [Y|Path1], graph(Nodes, Edges), Path) :-
  my_member(c(X,Y), Edges),
  not_member(X, Path1),
  path1(A, [X,Y|Path1], graph(Nodes, Edges), Path).

/* Main function */
path(A, Z, Graph, Path) :- 
  path1(A, [Z], Graph, Path).