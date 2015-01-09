' action_31
'== backward standup  ============================
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
	IF A <> 19 THEN GOTO main

	GOSUB backward_standup
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
backward_standup:

	SPEED 10
	
	MOVE G6A,100,  10, 100, 115, 100, 100
	MOVE G6D,100,  10, 100, 115, 100, 100
	MOVE G6B,100, 130,  10, 100, 100, 100
	MOVE G6C,100, 130,  10, 100, 100, 100
	WAIT

	MOVE G6A,100, 10,  83, 140, 100, 100
	MOVE G6D,100, 10,  83, 140, 100, 100
	MOVE G6B,20, 130,  10, 100, 100, 100
	MOVE G6C,20, 130,  10, 100, 100, 100
	WAIT

	MOVE G6A,100, 126,  60, 50, 100, 100
	MOVE G6D,100, 126,  60, 50, 100, 100
	MOVE G6B,20,  30,  90, 100, 100, 100
	MOVE G6C,20,  30,  90, 100, 100, 100
	WAIT
	
	MOVE G6A,100, 165,  70, 15, 100, 100
	MOVE G6D,100, 165,  70, 15, 100, 100
	MOVE G6B, 30,  20,  95,100, 100, 100
	MOVE G6C, 30,  20,  95,100, 100, 100
	WAIT
	
	MOVE G6A,100, 165,  40, 100, 100, 100
	MOVE G6D,100, 165,  40, 100, 100, 100
	MOVE G6B,110,  70,  50, 100, 100, 100
	MOVE G6C,110,  70,  50, 100, 100, 100
	WAIT
	
	RETURN
'================================================