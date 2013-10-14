:- multifile holdsAt/2, happensAt/2.
:-use_module(library(lists)).
:- dynamic cached/1, temp_store/1, person/2, fighting/2, moving/2, meeting/2, leaving_object/2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Perform ER for HLE: fight, move, meet and leaving_object
% The resuls are stored into the specified 'Filename'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

performFullER(Filename):-
  open(Filename, write, Stream),
  allIDs(IDs),
  allTimePoints(Timepoints),
  cartesianUnique(IDs,IDs,Tuples), % Tuples is a list of lists, of form [[id0, id1], [id0, id2], ... , [idn, idn-1]]
  eventRec(Timepoints,Tuples,Stream),
  close(Stream),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ER utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% Gives all timepoints
%
allTimePoints(SL):- findall(T, (holdsAt(appearance(_)=_,T), number(T)), L), sort(L, SL).

%
% Gives all ID instances
%
allIDs(IDs):- findall(ID, holdsAt(appearance(ID)=_,_),IDs1), sort(IDs1, IDs).

%
% Perform ER for all fluents per timepoint
%

eventRec([], _Tuples, _Stream).

eventRec([TimeHead | RestTimePoints], Tuples, Stream):-
  recHLE(TimeHead, Tuples, Stream),
  eventRec(RestTimePoints, Tuples, Stream). % move on to next timepoint

recHLE(_Timepoint, [], _Stream).

recHLE(Timepoint, [Tuple | RestTuples], Stream):-
  Tuple = [ ID1, ID2 ],
  recognize(fighting(ID1, ID2) = true, Timepoint, Stream),
  recognize(moving(ID1, ID2) = true, Timepoint, Stream),
  recognize(meeting(ID1, ID2) = true, Timepoint, Stream),
  recognize(leaving_object(ID1, ID2) = true, Timepoint, Stream),
  recHLE(Timepoint, RestTuples, Stream). % move on to next ID tuple

recognize(Fluent = Value, T, Stream):-
  holdsAt(Fluent = Value, T), %!,
  writeResult(Fluent, T, Stream).

recognize(_, _T, _Stream).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I/O Utils
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

writeResult(F,T):- writeResult(F,T,'user_output').

writeResult(F,T,Stream):-
  FrameNum is T / 40,
  format(Stream, 'holdsAt(~w=true, ~w). % ~w', [F,FrameNum, T]),
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
