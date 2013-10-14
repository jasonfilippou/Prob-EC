%:- expects_dialect(swi).
:- discontiguous holdsAt/2, happensAt/2.
:- multifile holdsAt/2, happensAt/2.

% Load event definitions and mass evaluation meta-code
:
:-['prob_event_defs_orig.pl']. 
:-['prob_utils.pl']. 

% Perform full recognition (all possible LTA / ID tuples / time-points over a specific video:

er('01-Walk1'):-
  ['01-Walk1/wk1gtAppearenceIndv.pbl'],
  ['01-Walk1/wk1gtMovementIndv.pbl'],
  performFullER('01-Walk1/wk1gt.result').

er('02-Walk2'):-
  ['02-Walk2/wk2gtAppearenceIndv.pbl'],
  ['02-Walk2/wk2gtMovementIndv.pbl'],
  performFullER('02-Walk2/wk2gt.result').

er('03-Walk3'):-
  ['03-Walk3/wk3gtAppearenceIndv.pbl'],
  ['03-Walk3/wk3gtMovementIndv.pbl'],
  performFullER('03-Walk3/wk3gt.result').

er('04-Browse1'):-
  ['04-Browse1/br1gtAppearenceIndv.pbl'],
  ['04-Browse1/br1gtMovementIndv.pbl'],
  performFullER('04-Browse1/br1gt.result').

er('05-Browse2'):-
  ['05-Browse2/br2gtAppearenceIndv.pbl'],
  ['05-Browse2/br2gtMovementIndv.pbl'],
  performFullER('05-Browse2/br2gt.result').

er('06-Browse3'):-
  ['06-Browse3/br3gtAppearenceIndv.pbl'],
  ['06-Browse3/br3gtMovementIndv.pbl'],
  performFullER('06-Browse3/br3gt.result').

er('07-Browse4'):-
  ['07-Browse4/br4gtAppearenceIndv.pbl'],
  ['07-Browse4/br4gtMovementIndv.pbl'],
  performFullER('07-Browse4/br4gt.result').

er('08-Browse_WhileWaiting1'):-
  ['08-Browse_WhileWaiting1/bww1gtAppearenceIndv.pbl'],
  ['08-Browse_WhileWaiting1/bww1gtMovementIndv.pbl'],
  performFullER('08-Browse_WhileWaiting1/bww1gt.result').

er('09-Browse_WhileWaiting2'):-
  ['09-Browse_WhileWaiting2/bww2gtAppearenceIndv.pbl'],
  ['09-Browse_WhileWaiting2/bww2gtMovementIndv.pbl'],
  performFullER('09-Browse_WhileWaiting2/bww2gt.result').

er('10-Rest_InChair'):-
  ['10-Rest_InChair/ricgtAppearenceIndv.pbl'],
  ['10-Rest_InChair/ricgtMovementIndv.pbl'],
  performFullER('10-Rest_InChair/ricgt.result').

er('11-Rest_SlumpOnFloor'):-
  ['11-Rest_SlumpOnFloor/rsfgtAppearenceIndv.pbl'],
  ['11-Rest_SlumpOnFloor/rsfgtMovementIndv.pbl'],
  performFullER('11-Rest_SlumpOnFloor/rsfgt.result').

er('12-Rest_WiggleOnFloor'):-
  ['12-Rest_WiggleOnFloor/rwgtAppearenceIndv.pbl'],
  ['12-Rest_WiggleOnFloor/rwgtMovementIndv.pbl'],
  performFullER('12-Rest_WiggleOnFloor/rwgt.result').

er('13-Rest_FallOnFloor'):-
  ['13-Rest_FallOnFloor/rffgtAppearenceIndv.pbl'],
  ['13-Rest_FallOnFloor/rffgtMovementIndv.pbl'],
  performFullER('13-Rest_FallOnFloor/rffgt.result').

er('14-LeftBag'):-
  ['14-LeftBag/lb1gtAppearenceIndv.pbl'],
  ['14-LeftBag/lb1gtMovementIndv.pbl'],
  performFullER('14-LeftBag/lb1gt.result').

er('15-LeftBag_AtChair'):-
  ['15-LeftBag_AtChair/lb2gtAppearenceIndv.pbl'],
  ['15-LeftBag_AtChair/lb2gtMovementIndv.pbl'],
  performFullER('15-LeftBag_AtChair/lb2gt.result').

er('16-LeftBag_BehindChair'):-
  ['16-LeftBag_BehindChair/lbbcgtAppearenceIndv.pbl'],
  ['16-LeftBag_BehindChair/lbbcgtMovementIndv.pbl'],
	performFullER('16-LeftBag_BehindChair/lbbcgt.result').

er('17-LeftBox'):-
  ['17-LeftBox/lbgtAppearenceIndv.pbl'],
  ['17-LeftBox/lbgtMovementIndv.pbl'],
  performFullER('17-LeftBox/lbgt.result').

er('18-LeftBag_PickedUp'):-
  ['18-LeftBag_PickedUp/lbpugtAppearenceIndv.pbl'],
  ['18-LeftBag_PickedUp/lbpugtMovementIndv.pbl'],
  performFullER('17-LeftBox/lbpugt.result').

er('19-Meet_WalkTogether1'):-
  ['19-Meet_WalkTogether1/mwt1gtAppearenceIndv.pbl'],
  ['19-Meet_WalkTogether1/mwt1gtMovementIndv.pbl'],
  performFullER('17-LeftBox/mwt1gt.result').

er('20-Meet_WalkTogether2'):-
  ['20-Meet_WalkTogether2/mwt2gtAppearenceIndv.pbl'],
  ['20-Meet_WalkTogether2/mwt2gtMovementIndv.pbl'],
  performFullER('20-Meet_WalkTogether2/mwt2gt.result').

er('21-Meet_WalkSplit'):-
  ['21-Meet_WalkSplit/mws1gtAppearenceIndv.pbl'],
  ['21-Meet_WalkSplit/mws1gtMovementIndv.pbl'],
  performFullER('21-Meet_WalkSplit/mws1gt.result').

er('22-Meet_Split3rdGuy'):-
  ['22-Meet_Split3rdGuy/ms3ggtAppearenceIndv.pbl'],
  ['22-Meet_Split3rdGuy/ms3ggtMovementIndv.pbl'],
  performFullER('22-Meet_Split3rdGuy/ms3ggt.result').

er('23-Meet_Crowd'):-
  ['23-Meet_Crowd/mc1gtAppearenceIndv.pbl'],
  ['23-Meet_Crowd/mc1gtMovementIndv.pbl'],
  performFullER('23-Meet_Crowd/mc1gt.result').

er('24-Meet_Split'):-
  ['24-Meet_Split/spgtMovementIndv.pbl'],
  ['24-Meet_Split/spgtAppearenceIndv.pbl'],
  performFullER('24-Meet_Split/spgt.result').

er('25-Fight_RunAway1'):-
  ['25-Fight_RunAway1/fra1gtAppearenceIndv.pbl'],
  ['25-Fight_RunAway1/fra1gtMovementIndv.pbl'],
  performFullER('25-Fight_RunAway1/fra1gt.result').

er('26-Fight_RunAway2'):-
  ['26-Fight_RunAway2/fra2gtAppearenceIndv.pbl'],
  ['26-Fight_RunAway2/fra2gtMovementIndv.pbl'],
  performFullER('26-Fight_RunAway2/fra2gt.result').

er('27-Fight_OneManDown1'):-
  ['27-Fight_OneManDown1/fomdgt1AppearenceIndv.pbl'],
  ['27-Fight_OneManDown1/fomdgt1MovementIndv.pbl'],
  performFullER('27-Fight_OneManDown1/fomdgt1.result').

er('27-Fight_OneManDown2'):-
  ['27-Fight_OneManDown2/fomdgt2AppearenceIndv.pbl'],
  ['27-Fight_OneManDown2/fomdgt2MovementIndv.pbl'],
  ['27-Fight_OneManDown2/fomdgt2.result'].

er('27-Fight_OneManDown3'):-
  ['27-Fight_OneManDown3/fomdgt3AppearenceIndv.pbl'],
  ['27-Fight_OneManDown3/fomdgt3MovementIndv.pbl'],
  performFullER('27-Fight_OneManDown3/fomdgt3.result').

er('28-Fight_Chase'):-
  ['28-Fight_Chase/fcgtAppearenceIndv.pbl'],
  ['28-Fight_Chase/fcgtMovementIndv.pbl'],
  performFullER('28-Fight_Chase/fcgt.result').

% Perform recognition over entire CAVIAR dataset:

fullCAVIAR:- findall(Vid, er(Vid), _).
