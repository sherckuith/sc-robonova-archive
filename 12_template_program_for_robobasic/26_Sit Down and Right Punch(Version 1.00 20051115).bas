' action_26
'== right forward attack    =====================
DIM A AS BYTE
DIM A16 AS BYTE

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
		
A = REMOCON(1)	
	IF A <> 27 THEN GOTO main

	GOSUB right_forward
	GOSUB standard_pose
	GOTO MAIN

'================================================
standard_pose:
	MOVE G6A,100,  76, 145,  93, 100, 100 
	MOVE G6D,100,  76, 145,  93, 100, 100  
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100
	WAIT
	RETURN
'================================================
right_forward:
	SPEED 7
	MOVE G6A, 108,  76, 145,  93, 100, 60 	
	MOVE G6D,  85,  71, 152,  91, 107, 60  
	MOVE G6B,  70,  40,  80,  ,  ,  ,
	MOVE G6C, 130,  40,  80,  ,  ,  ,
	WAIT
	
	SPEED 10
	HIGHSPEED SETON
	MOVE G6A,  66, 163,  85,  65, 130		
	MOVE G6D, 107, 164,  21, 125,  93
	MOVE G6B,  50,  72,  86
	MOVE G6C, 189,  40,  77
	WAIT
	
	DELAY 1000
	HIGHSPEED SETOFF
	
	
	GOSUB sit_pose
	RETURN	
'================================================
sit_pose:

	SPEED 10
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100	
	WAIT

	RETURN
'================================================