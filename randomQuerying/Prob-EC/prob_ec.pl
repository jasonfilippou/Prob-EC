% PROLOG-INDEPENDENT
:- set_prolog_flag(unknown, fail).
:- discontiguous holdsAt/2, initiates/3, terminates/3, happensAt/2, initiatedAt/4.
:- multifile holdsAt/2, happensAt/2.

holdsAt(F=V,0) :- \+ sdFluent(F),
  initially(F=V).

holdsAt(F=V,T) :- \+ sdFluent(F),
  0 < T,    % just to be on the safe side
  initially(F=V),
  negate2(broken(F=V,0,T)).

holdsAt(F=V,T) :- \+ sdFluent(F),
  0 < T,    % just to be on the safe side
  initiatedAt(F=V,0,Ts,T),
  problog_neg(broken(F=V,Ts,T)).

:- dynamic broken/3.

broken(F=V1,Ts,T) :- % broken/3 instead of broken/4.
  initiatedAt(F=V2,Ts,_,T),  % Ts < Tstar < T
  V1 \= V2.

:- problog_table broken/3.

happens4(Ev,Tmin,T,Tmax) :-
     happensAt(Ev,T), Tmin < T, lessthan(T,Tmax). % used happensAt/2 instead of happens_within_narrative/2

lessthan(_,inf).
lessthan(T,Tmax) :- T < Tmax.

% negate2.

negate2(pred):- problog_neg(pred).

negate2(pred):- \+ pred.
