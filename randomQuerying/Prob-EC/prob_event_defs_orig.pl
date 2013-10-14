/****************************************************************
 *                                                              *
 * Event Recognition			                        *
 *                                                              *
 *                                                              *
 * Implemented in SWI Prolog	                                *
 *								*
 ****************************************************************/


% PROLOG-INDEPENDENT
:- multifile holdsAt/2, happensAt/2.
:- discontiguous holdsAt/2, initiates/3, terminates/3, happensAt/2, initiatedAt/4, terminatedAt/4.

%ProbLog libraries

:- ensure_loaded(library(problog)).
:- ensure_loaded(library(problog/timer)).
:- ensure_loaded(library(lists)).

% Following flags useful for probabilistic loop cycle handling

%:- set_problog_flag(use_db_trie, true).
%:- set_problog_flag(use_old_trie, false).

% BDD timeout:

:- set_problog_flag(bdd_time, 10).

% Exploit AND-clusters in DNFs:

%:- set_problog_flag(variable_elimination, true).

% Load probabilistic EC dialect:

:- ['prob_ec.pl'].



/******************************************************************
 * LONG-TERM BEHAVIOURS						  *
 * meeting(Person1, Person2)					  *
,* fighting(Person1, Person2)					  *
 * moving(Person1, Person2)					  *
 * leaving-object(Person1, Person2)				  *		  			  *								  *
 *								  *
 * SHORT-TERM BEHAVIOURS					  *
 * walking, active, inactive, running
 ******************************************************************/

/******************************************************************
 * STATICALLY DETERMINED FLUENTS				  *
 * close(Person, Painting)					  *
 ******************************************************************/


% ===== COORDINATES OF PLACES OF INTEREST

place(shop1).
place(shop2).
place(shop3).

holdsAt( coord( shop1 )=(86, 205), _ ).
holdsAt( coord( shop2 )=(101, 260), _ ).
holdsAt( coord( shop3 )=(181, 51), _ ).

% ===== STATE STATICALLY DETERMINED FLUENTS

sdFluent( distance(_, _) ).
sdFluent( close(_, _, _) ).
sdFluent( coord(_) ).
sdFluent( orientation(_) ).
sdFluent( appearance(_) ).
sdFluent(person(_)).


% ===== DEFINE STATICALLY DETERMINED FLUENTS

browseDist( 24 ).
fightDist( 24 ).
moveDist( 34 ).
meetDist( 34 ).
interactDist( 25 ).
leaveDist( 30 ).

% close/3

holdsAt( close(Person1, Person2, Threshold) = true, T ) :-
	holdsAt( distance(Person1, Person2) = Dist, T ),
	Dist =< Threshold.

holdsAt( close(Person1, Person2, Threshold) = false, T ) :-
	holdsAt( distance(Person1, Person2) = Dist, T ),
	Dist > Threshold.

holdsAt( distance(Person1, Person2) = Ypot, T ) :-
	holdsAt( coord(Person1) = (X1, Y1), T ),
	holdsAt( coord(Person2) = (X2, Y2), T ),
	%\+ Person1 = Person2,
	XDiff is abs(X1-X2),
	YDiff is abs(Y1-Y2),
	SideA is XDiff*XDiff,
	SideB is YDiff*YDiff,
	Temp is SideA + SideB,
	Ypot is sqrt(Temp).

initiatedAt( person(Id)=true, Tmin, T, Tmax ) :-
   happens4( walking(Id), Tmin, T, Tmax),
   negate(happensAt( disappear(Id), T)).

initiatedAt( person(Id)=true, Tmin, T, Tmax ) :-
   happens4( running(Id), Tmin, T, Tmax),
   negate(happensAt( disappear(Id), T)).

initiatedAt( person(Id)=true, Tmin, T, Tmax ) :-
   happens4( active(Id), Tmin, T, Tmax),
   negate(happensAt( disappear(Id), T)).

initiatedAt( person(Id)=true, Tmin, T, Tmax ) :-
   happens4( abrupt(Id), Tmin, T, Tmax),
   negate(happensAt( disappear(Id), T)).

initiatedAt( person(Id)=false, Tmin, T, Tmax) :-
   happens4( disappear(Id), Tmin, T, Tmax).



% ==================================================
% LONG-TERM BEHAVIOUR: fighting(Person, Person2)
% ==================================================


% ----- initiate fighting

initiatedAt(fighting(Person, Person2) = true, Tmin, T, Tmax):-
	happens4(abrupt(Person), Tmin, T, Tmax), % This proves that Person is a person.
	holdsAt(person(Person2) = true, T),
	fightDist(Dist),
	holdsAt(close(Person, Person2, Dist) = true, T),
	negate(happensAt( inactive(Person2), T)).

% ----- terminate fighting: split up

initiatedAt(fighting(Person, Person2) = false, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	fightDist(Dist),
	holdsAt(close(Person, Person2, Dist) = false, T).

initiatedAt(fighting(Person2, Person) = false, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	fightDist(Dist),
	holdsAt(close(Person, Person2, Dist) = false, T).

initiatedAt(fighting(Person, Person2) = false, Tmin, T, Tmax):-
	happens4(running(Person), Tmin, T, Tmax),
	fightDist(Dist),
	holdsAt(close(Person, Person2, Dist) = false, T).

initiatedAt(fighting(Person2, Person) = false, Tmin, T, Tmax):-
	happens4(running(Person), Tmin, T, Tmax),
	fightDist(Dist),
	holdsAt(close(Person, Person2, Dist) = false, T).

initiatedAt(fighting(Person, _) = false, Tmin, T, Tmax):-
	happens4(disappear(Person), Tmin, T, Tmax).

initiatedAt(fighting(_, Person) = false, Tmin, T, Tmax):-
	happens4(disappear(Person), Tmin, T, Tmax).


% ==================================================
% LONG-TERM BEHAVIOUR: meeting(Person, Person2)
% ==================================================

% allow for a long-term behaviour to be both fighting and meeting
% ie, I cannot tell the difference

% ----- initiate meeting

initiatedAt(meeting(Person, Person2) = true, Tmin, T, Tmax):-
	happens4(active(Person), Tmin, T, Tmax),
	interactDist(Dist),
	holdsAt(close(Person, Person2, Dist) = true, T),
	holdsAt(person(Person2) = true, T),
	negate(happensAt(running(Person2), T)).

initiatedAt(meeting(Person, Person2) = true, Tmin, T, Tmax):-
	holdsAt(person(Person) = true, T),
	happens4(inactive(Person), Tmin, T, Tmax),
	interactDist(Dist),
	holdsAt(close(Person, Person2, Dist) = true, T),
	holdsAt(person(Person2) = true, T),
	negate(happensAt(running(Person2), T)),
	negate(happensAt(active(Person2), T)).

% ----- terminate meeting: split up

initiatedAt(meeting(Person, Person2) = false, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	meetDist(Dist),
	holdsAt(close(Person, Person2, Dist) = false, T).

initiatedAt(meeting(Person2, Person) = false, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	meetDist(Dist),
	holdsAt(close(Person, Person2, Dist) = false, T).

initiatedAt(meeting(Person, _) = false, Tmin, T, Tmax):-
	happens4(running(Person), Tmin, T, Tmax).

initiatedAt(meeting(_, Person) = false, Tmin, T, Tmax):-
	happens4(running(Person), Tmin, T, Tmax).

initiatedAt(meeting(Person, _) = false, Tmin, T, Tmax):-
	happens4(disappear(Person), Tmin, T, Tmax).

initiatedAt(meeting(_, Person) = false, Tmin, T, Tmax):-
	happens4(disappear(Person), Tmin, T, Tmax).

% ==================================================
% LONG-TERM BEHAVIOUR: moving(Person, Person2)
% ==================================================


% two people are moving together

% ----- initiate moving

initiatedAt(moving(Person, Person2) = true, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	moveDist( Dist ),
	holdsAt( close(Person, Person2, Dist)=true, T ),
	happensAt( walking(Person2), T ), % This will be enough to prove that Person2 is a person entity as well.
	holdsAt( orientation(Person)=O, T ),
	holdsAt( orientation(Person2)=O2, T ),
	Diff is abs(O-O2),
	Diff < 45.

% ----- terminate moving: split up

initiatedAt(moving(Person, Person2) = false, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	moveDist( Dist ),
	holdsAt( close(Person, Person2, Dist)=false, T ).

initiatedAt(moving(Person2, Person) = false, Tmin, T, Tmax):-
	happens4(walking(Person), Tmin, T, Tmax),
	moveDist( Dist ),
	holdsAt( close(Person, Person2, Dist)=false, T ).

% ----- terminate moving: stop moving

initiatedAt(moving(Person, Person2) = false, Tmin, T, Tmax):-
	happens4(active(Person), Tmin, T, Tmax),
	happensAt( active( Person2 ), T ).

initiatedAt(moving(Person, Person2) = false, Tmin, T, Tmax):-
	happens4(active(Person), Tmin, T, Tmax),
	happensAt( inactive( Person2 ), T ).

initiatedAt(moving(Person2, Person) = false, Tmin, T, Tmax):-
	happens4(active(Person), Tmin, T, Tmax),
	happensAt( active( Person2 ), T ).

initiatedAt(moving(Person2, Person) = false, Tmin, T, Tmax):-
	happens4(active(Person), Tmin, T, Tmax),
	happensAt( inactive( Person2 ), T ).

% ----- terminate moving: start running

initiatedAt(moving(Person, _) = false, Tmin, T, Tmax):-
	happens4(running(Person), Tmin, T, Tmax).

initiatedAt(moving(_, Person) = false, Tmin, T, Tmax):-
	happens4(running(Person), Tmin, T, Tmax).

initiatedAt(moving(Person, _) = false, Tmin, T, Tmax):-
	happens4(disappear(Person), Tmin, T, Tmax).

initiatedAt(moving(_, Person) = false, Tmin, T, Tmax):-
	happens4(disappear(Person), Tmin, T, Tmax).


% ==================================================
% LONG-TERM BEHAVIOUR: leaving_object(Person, Object)
% ==================================================

% ----- initiate leaving_object

initiatedAt(leaving_object(Person, Object) = true, Tmin, T, Tmax):-
	happens4(inactive(Object), Tmin, T, Tmax),
	holdsAt(appearance(Object) = appear, T),
	leaveDist( Dist ),
	holdsAt( close(Person, Object, Dist)=true, T),
	holdsAt(person(Person) = true, T).
	%happensAt( appear(Person), T0 ),
	%T0 < T.

% ----- terminate leaving_object: pick up object
%       disappear(Object) means that the Object has disappeared
%       which is what will happen if it has been picked up

initiatedAt(leaving_object(_, Object) = false, Tmin, T, Tmax):-
	happens4(disappear(Object), Tmin, T, Tmax).


% ====================================
% DEFINITION OF DERIVED EVENTS
% ====================================

happensAt(appear(ID), T):-
	holdsAt(appearance(ID) = appear, T).

happensAt(disappear(ID), T):-
	holdsAt(appearance(ID) = disappear, T).

% Probabilistic negation

negate(SDE):- problog_not(SDE).

negate(SDE):- \+ SDE.
