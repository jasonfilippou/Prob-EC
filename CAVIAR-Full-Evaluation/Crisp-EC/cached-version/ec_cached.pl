% Domain-independent caching-adapted Crisp-EC engine

:- set_prolog_flag(unknown, fail).
:- discontiguous holdsAt/2, happensAt/2.
:- multifile holdsAt/2, happensAt/2.

holdsAt(F=V,0):-
  \+ sdFluent(F), !,
  initially(F=V).

holdsAt(F=V,T):-
  \+ sdFluent(F),
  T > 0,
  cached(F = V),
  previousTimePoint(T, Tprev),
  \+ broken(F = V, Tprev), !. % Cut removed in Prob-EC axiom.

holdsAt(F=V,T):-
  \+ sdFluent(F),
  T > 0,
  previousTimePoint(T, Tprev),
  initiatedAt(F = V,Tprev).

broken(F = V1, T) :-
  initiatedAt(F=V2,T),  
  V1 \= V2.

previousTimePoint(T, Tprev):- Tprev is T - 40.
