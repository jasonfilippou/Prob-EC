% PROLOG-INDEPENDENT
:- set_prolog_flag(unknown, fail).
:- discontiguous holdsAt/2, happensAt/2, initiatedAt/4.
:- multifile holdsAt/2, happensAt/2.

holdsAt(F=V,0) :- \+ sdFluent(F),
  initially(F=V).

holdsAt(F=V,T) :- \+ sdFluent(F),
  0 < T,    % just to be on the safe side
  initially(F=V),
  \+ broken(F=V,0,_,T), !.

holdsAt(F=V,T) :- \+ sdFluent(F),
  0 < T,    % just to be on the safe side
  initiatedAt(F=V,0,Ts,T),
  \+ broken(F=V,Ts,_, T).

broken(F=V1,Ts,Tstar, T) :-
  initiatedAt(F=V2,Ts,Tstar,T),  % Ts < Tstar < T
  (strong_initiates ; V1 \= V2).

strong_initiaties:-fail.

happens4(Ev,Tmin,T,Tmax) :-
     happensAt(Ev,T), Tmin < T, lessthan(T,Tmax). % used happensAt/2 instead of happens_within_narrative/2

lessthan(_,inf).
lessthan(T,Tmax) :- T < Tmax.

