%:- expects_dialect(swi).
:- discontiguous holdsAt/2, happensAt/2.
:- multifile holdsAt/2, happensAt/2.

% Load event definitions and mass evaluation meta-code:

:-['event_defs_orig.pl']. 
:-['crisp_utils.pl'].

% Perform full recognition (all possible LTA / ID tuples / time-points over a specific video:

er('01-Walk1'):-
  ['01-Walk1/wk1gtAppearenceIndv.pl'],
  ['01-Walk1/wk1gtMovementIndv_new.pl'],
  performFullER('01-Walk1/wk1gt.result').

er('02-Walk2'):-
  ['02-Walk2/wk2gtAppearenceIndv.pl'],
  ['02-Walk2/wk2gtMovementIndv_new.pl'],
  performFullER('02-Walk2/wk2gt.result').

er('03-Walk3'):-
  ['03-Walk3/wk3gtAppearenceIndv.pl'],
  ['03-Walk3/wk3gtMovementIndv_new.pl'],
  performFullER('03-Walk3/wk3gt.result').

er('04-Browse1'):-
  ['04-Browse1/br1gtAppearenceIndv.pl'],
  ['04-Browse1/br1gtMovementIndv_new.pl'],
  performFullER('04-Browse1/br1gt.result').

er('05-Browse2'):-
  ['05-Browse2/br2gtAppearenceIndv.pl'],
  ['05-Browse2/br2gtMovementIndv_new.pl'],
  performFullER('05-Browse2/br2gt.result').

er('06-Browse3'):-
  ['06-Browse3/br3gtAppearenceIndv.pl'],
  ['06-Browse3/br3gtMovementIndv_new.pl'],
  performFullER('06-Browse3/br3gt.result').

er('07-Browse4'):-
  ['07-Browse4/br4gtAppearenceIndv.pl'],
  ['07-Browse4/br4gtMovementIndv_new.pl'],
  performFullER('07-Browse4/br4gt.result').

er('08-Browse_WhileWaiting1'):-
  ['08-Browse_WhileWaiting1/bww1gtAppearenceIndv.pl'],
  ['08-Browse_WhileWaiting1/bww1gtMovementIndv_new.pl'],
  performFullER('08-Browse_WhileWaiting1/bww1gt.result').

er('09-Browse_WhileWaiting2'):-
  ['09-Browse_WhileWaiting2/bww2gtAppearenceIndv.pl'],
  ['09-Browse_WhileWaiting2/bww2gtMovementIndv_new.pl'],
  performFullER('09-Browse_WhileWaiting2/bww2gt.result').

er('10-Rest_InChair'):-
  ['10-Rest_InChair/ricgtAppearenceIndv.pl'],
  ['10-Rest_InChair/ricgtMovementIndv_new.pl'],
  performFullER('10-Rest_InChair/ricgt.result').

er('11-Rest_SlumpOnFloor'):-
  ['11-Rest_SlumpOnFloor/rsfgtAppearenceIndv.pl'],
  ['11-Rest_SlumpOnFloor/rsfgtMovementIndv_new.pl'],
  performFullER('11-Rest_SlumpOnFloor/rsfgt.result').

er('12-Rest_WiggleOnFloor'):-
  ['12-Rest_WiggleOnFloor/rwgtAppearenceIndv.pl'],
  ['12-Rest_WiggleOnFloor/rwgtMovementIndv_new.pl'],
  performFullER('12-Rest_WiggleOnFloor/rwgt.result').

er('13-Rest_FallOnFloor'):-
  ['13-Rest_FallOnFloor/rffgtAppearenceIndv.pl'],
  ['13-Rest_FallOnFloor/rffgtMovementIndv_new.pl'],
  performFullER('13-Rest_FallOnFloor/rffgt.result').

er('14-LeftBag'):-
  ['14-LeftBag/lb1gtAppearenceIndv.pl'],
  ['14-LeftBag/lb1gtMovementIndv_new.pl'],
  performFullER('14-LeftBag/lb1gt.result').

er('15-LeftBag_AtChair'):-
  ['15-LeftBag_AtChair/lb2gtAppearenceIndv.pl'],
  ['15-LeftBag_AtChair/lb2gtMovementIndv_new.pl'],
  performFullER('15-LeftBag_AtChair/lb2gt.result').

er('16-LeftBag_BehindChair'):-
	['16-LeftBag_BehindChair/lbbcgtAppearenceIndv.pl'],
	['16-LeftBag_BehindChair/lbbcgtMovementIndv_new.pl'],
	performFullER('16-LeftBag_BehindChair/lbbcgt.result').

er('17-LeftBox'):-
  ['17-LeftBox/lbgtAppearenceIndv.pl'],
  ['17-LeftBox/lbgtMovementIndv_new.pl'],
  performFullER('17-LeftBox/lbgt.result').

er('18-LeftBag_PickedUp'):-
  ['18-LeftBag_PickedUp/lbpugtAppearenceIndv.pl'],
  ['18-LeftBag_PickedUp/lbpugtMovementIndv_new.pl'],
  performFullER('17-LeftBox/lbpugt.result').

er('19-Meet_WalkTogether1'):-
  ['19-Meet_WalkTogether1/mwt1gtAppearenceIndv.pl'],
  ['19-Meet_WalkTogether1/mwt1gtMovementIndv_new.pl'],
  performFullER('17-LeftBox/mwt1gt.result').

er('20-Meet_WalkTogether2'):-
  ['20-Meet_WalkTogether2/mwt2gtAppearenceIndv.pl'],
  ['20-Meet_WalkTogether2/mwt2gtMovementIndv_new.pl'],
  performFullER('20-Meet_WalkTogether2/mwt2gt.result').

er('21-Meet_WalkSplit'):-
  ['21-Meet_WalkSplit/mws1gtAppearenceIndv.pl'],
  ['21-Meet_WalkSplit/mws1gtMovementIndv_new.pl'],
  performFullER('21-Meet_WalkSplit/mws1gt.result').

er('22-Meet_Split3rdGuy'):-
  ['22-Meet_Split3rdGuy/ms3ggtAppearenceIndv.pl'],
  ['22-Meet_Split3rdGuy/ms3ggtMovementIndv_new.pl'],
  performFullER('22-Meet_Split3rdGuy/ms3ggt.result').

er('23-Meet_Crowd'):-
  ['23-Meet_Crowd/mc1gtAppearenceIndv.pl'],
  ['23-Meet_Crowd/mc1gtMovementIndv_new.pl'],
  performFullER('23-Meet_Crowd/mc1gt.result').

er('24-Meet_Split'):-
  ['24-Meet_Split/spgtMovementIndv_new.pl'],
  ['24-Meet_Split/spgtAppearenceIndv.pl'],
  performFullER('24-Meet_Split/spgt.result').

er('25-Fight_RunAway1'):-
  ['25-Fight_RunAway1/fra1gtAppearenceIndv.pl'],
  ['25-Fight_RunAway1/fra1gtMovementIndv_new.pl'],
  performFullER('25-Fight_RunAway1/fra1gt.result').

er('26-Fight_RunAway2'):-
  ['26-Fight_RunAway2/fra2gtAppearenceIndv.pl'],
  ['26-Fight_RunAway2/fra2gtMovementIndv_new.pl'],
  performFullER('26-Fight_RunAway2/fra2gt.result').

er('27-Fight_OneManDown1'):-
  ['27-Fight_OneManDown/1/fomdgt1AppearenceIndv.pl'],
  ['27-Fight_OneManDown/1/fomdgt1MovementIndv_new.pl'],
  performFullER('27-Fight_OneManDown/1/fomdgt1.result').

er('27-Fight_OneManDown2'):-
  ['27-Fight_OneManDown/2/fomdgt2AppearenceIndv.pl'],
  ['27-Fight_OneManDown/2/fomdgt2MovementIndv_new.pl'],
  ['27-Fight_OneManDown/2/fomdgt2.result'].

er('27-Fight_OneManDown3'):-
  ['27-Fight_OneManDown/3/fomdgt3AppearenceIndv.pl'],
  ['27-Fight_OneManDown/3/fomdgt3MovementIndv_new.pl'],
  performFullER('27-Fight_OneManDown/3/fomdgt3.result').

er('28-Fight_Chase'):-
  ['28-Fight_Chase/fcgtAppearenceIndv.pl'],
  ['28-Fight_Chase/fcgtMovementIndv_new.pl'],
  performFullER('28-Fight_Chase/fcgt.result').

% Perform recognition over entire CAVIAR dataset:

fullCAVIAR:- findall(Vid, er(Vid), _).
