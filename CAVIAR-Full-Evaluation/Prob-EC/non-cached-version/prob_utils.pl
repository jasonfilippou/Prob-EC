:- multifile holdsAt/2, happens/2.
%:- expects_dialect(swi).

% load some problog libraries
:- use_module(library(problog)).
:- use_module(library(problog/timer)).
:- use_module(library(lists)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform ER for HLE: fighting, moving, meeting and leaving_object
% The results are stored into the specified 'Filename'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

performFullER(Filename):-
  open(Filename, write, Stream),
  allIDs(IDs),
  allTimePoints(Timepoints),
  cartesianUnique(IDs,IDs, Tuples),
  recHLE(Tuples,Timepoints,fighting,Stream),
  recHLE(Tuples,Timepoints,moving,Stream),
  recHLE(Tuples,Timepoints,meeting,Stream),
  recHLE(Tuples,Timepoints,leaving_object,Stream),
  close(Stream),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ER utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% Gives all timepoints
%
%allTimePoints(SL):- findall(T, (happens(_,T), number(T)), L), sort(L, SL).

allTimePoints(SL):- findall(T, (holdsAt(coord(_)=_,T), number(T)), L), sort(L, SL).

%
% Gives all ID instances
%
allIDs(IDs):- findall(ID, holdsAt(appearance(ID)=_,_),IDs1), sort(IDs1, IDs).

%
% Perform ER for the specified fluent
%
recHLE(FluentLabel):- recHLE(FluentLabel, 'user_output').

recHLE(FluentLabel, Stream):-
  allIDs(IDs),
  allTimePoints(Timepoints),
  cartesian(IDs,IDs, Tuples),
  recHLE(Tuples,Timepoints,FluentLabel, Stream).

recHLE(Tuples,Timepoints,FluentLabel, Stream):-
  recHLETuples(FluentLabel, Timepoints, Tuples, Stream).

recHLETuples(FluentLabel, Timepoints, [Tuple | RestTuples], Stream):-
  Fluent =.. [FluentLabel | Tuple ],
  recognize(Fluent, Timepoints, Stream),
  flush_output(Stream),
  recHLETuples(FluentLabel, Timepoints, RestTuples, Stream).

recHLETuples(_FluentLabel, _Timepoints, [], _Stream ):-!.

recognize(Fluent, [TimeHead| TimeTail], Stream):-
  problog_exact(holdsAt(Fluent=true, TimeHead), P, S),
  writeResult(P, S, Fluent, TimeHead, Stream),
  recognize(Fluent, TimeTail, Stream ).

recognize(_Fluent, [], _Stream):- !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I/O Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

writeResult(F,T):- writeResult(F,T,'user_output').

writeResult(P, Status, F,T,Stream):-
  FrameNum is T / 40,
  format(Stream, '~w::holdsAt(~w=true, ~w). % ~w ~w', [P,F,FrameNum, T], Status),
%  format(Stream, 'holdsAt(~w=true, ~w). % ~w', [F,T,FrameNum]),
  nl(Stream),!.


writeList(L):- writeList(L, 'user_output').

writeList([],_):- !.

writeList([H|T], Stream):-
	write(Stream, H),
	nl(Stream),
	writeList(T, Stream).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cartesian product
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cartesian([], _L, []).
cartesian([A|N], L, M) :-
             pair(A,L,M1),
             cartesian(N, L, M2),
             append(M1, M2, M).
pair(_A, [], []).
pair(A, [B|L], [[A,B]|N] ) :- pair(A, L, N).

% cartesian product, without pairs of the same element
cartesianUnique([], _L, []).
cartesianUnique([A|N], L, M) :-
             pair2(A,L,M1),
             cartesianUnique(N, L, M2),
             append(M1, M2, M).
pair2(_A, [], []).
pair2(A, [B|L], [[A,B]|N] ) :- pair2(A, L, N), A\=B.
pair2(A, [A|L], N ):- pair2(A, L, N).
