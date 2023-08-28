/* This program calculates the factorial of a given integer
 N: current integer
 M: next integer (decreasing by 1)
 R: current factorial result
 F: newly calculated factorial result 

 Usage: fact(integer).
 E.g: fact(6). should return 720
*/

/* Factorial logic functions  */
fact(N, R) :- N < 2,
  write(R).
fact(N, R) :- N >= 2,
  M is N-1,
  F is R*N,
  fact(M, F).  

/* Main function */
fact(N) :-
  R is 1,
  fact(N, R).