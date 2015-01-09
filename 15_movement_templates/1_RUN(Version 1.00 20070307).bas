' fast_run
'==fast_run==================================

DIM A AS BYTE
DIM I AS BYTE

PTP SETON 				
PTP ALLON				

'== motor diretion setting ======================
DIR G6A,1,0,0,1,0,0		
DIR G6B,1,1,1,1,1,1		
DIR G6C,0,0,0,0,0,0		
DIR G6D,0,1,1,0,1,0		

'== motor start position read ===================
GETMOTORSET G6A,1,1,1,1,1,0
GETMOTORSET G6B,1,1,1,0,0,0
GETMOTORSET G6C,1,1,1,0,0,0
GETMOTORSET G6D,1,1,1,1,1,0

	SPEED 5

'== motor power on  =============================
	MOTOR G24	

	GOSUB standard_pose

'================================================

MAIN:    	
		

	GOSUB fast_run
	'DELAY 2000
	
	GOTO MAIN
	
'================================================	

fast_run:

PTP SETOFF
PTP ALLOFF

HIGHSPEED SETON

SPEED 5

	MOVE G6A,  99,  74, 145,  93, 101
	MOVE G6D,  99,  74, 145,  93, 101
	WAIT

DELAY 200
	
fast_run_1:

	MOVE G6D,  99,  86, 126, 113, 101'rising right foot
	MOVE G6A,  99,  82, 140,  91, 101'rising left foot(reach out right foot)	
	MOVE G6D,  99,  73, 140,  99, 101'take down right foot
		
	MOVE G6A,  99,  86, 128, 112, 101'rising left foot
	MOVE G6D,  99,  82, 140,  92, 101'rear right foot(reach out left foot)
	MOVE G6A,  99,  73, 140,  99, 101'take down left foot


'GOTO fast_run_1						  	

	MOVE G6D,  94,  92, 126, 119, 101'rising right foot
	MOVE G6D,  99,  70, 140, 103, 101'take down right foot
	
	'standard pose
	MOVE G6A, 99,  76, 145,  93, 101 
	MOVE G6D, 99,  76, 145,  93, 101
	
WAIT	
	
RETURN

'================================================	

standard_pose:

	MOVE G6A,100,  76, 145,  93, 100, 100 
	MOVE G6D,100,  76, 145,  93, 100, 100  
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100
	WAIT
	
	RETURN
'================================================	
