/* This program recursively checks and splits the given word into appropriate syllabi that satisfy the following 2 cases below
  split(): recursively advance the list of characters, check for possible syllabus.
    1.	Line 19, empty input, end of char list
    2.	Lines 21-25, vowel – consonant – vowel case
    3.	Lines 27-31, vowel - consonant – consonant – vowel case
    4.	Line 33-35, no matching case, advance the list by one char
  syllable(): 
    1.	Line 39, split the input into a list of chars
    2.	Line 40, call the recursive split(), display the split result if syllable, otherwise display the initial given input
  Usage: Syllable(Input, Result).
  E.g: Syllable(analog, R). should return ana-log
      Syllable(bumper, R). should return bum-per
      Syllable(calculator, R). should return cal-cul-ato-r
*/

/* Verifying function */
my_member(X, [X|L]).
my_member(X, [C2|L]) :- my_member(X, L).

/* Predicates */
vowel(C) :- my_member(C, [a, e, i, o, u, C2]).
consonant(C) :- \+ vowel(C).

/* Recursive splitting functions */
split([], []).

split([C1, C2, C3|T],[C1, C2, C3, '-'|T1]):- 
  vowel(C1), vowel(C3),
  atom_chars(Word, T),
  syllable(Word, T2),
  atom_chars(T2, T1). 

split([C1, C2, C3, C4|T],[C1, C2, '-', C3|T1]):-
  vowel(C1), consonant(C2), consonant(C3), vowel(C4),
  atom_chars(Word, [C4|T]),
  syllable(Word, T2),
  atom_chars(T2, T1).    

split([C1|T], [C1|T1]) :- 
  consonant(C1), 
  split(T, T1).

/* Main function */
syllable(Input, Result):-
  atom_chars(Input, Char_list),
  (split(Char_list, Word) -> atom_chars(Result, Word) ; Result=Input).