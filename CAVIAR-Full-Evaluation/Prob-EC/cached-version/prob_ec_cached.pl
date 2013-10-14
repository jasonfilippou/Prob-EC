% Domain-independent caching-adapted Prob-EC engine

:- set_prolog_flag(unknown, fail).
:- discontiguous holdsAt/2, happensAt/2.
:- multifile holdsAt/2, happensAt/2.
:-ensure_loaded(library(problog)).

holdsAt(F=V,0):-
  \+ sdFluent(F), !,
  initially(F=V).

holdsAt(F=V,T):-
  \+ sdFluent(F),
  T > 0,
  cached(F = V),
  previousTimePoint(T, Tprev),
  negate2(broken(F = V, Tprev)). % Crisp-EC contains a cut here.

holdsAt(F=V,T):-
  \+ sdFluent(F),
  T > 0,
  previousTimePoint(T, Tprev),
  initiatedAt(F = V,Tprev).

:-dynamic broken/2.

broken(F = V1, T) :-
  initiatedAt(F=V2,T),
  V1 \= V2.

:- problog_table broken/2.

previousTimePoint(T, Tprev):- Tprev is T - 40.

% negate2.

negate2(pred):- problog_neg(pred).

negate2(pred):- \+ pred.
