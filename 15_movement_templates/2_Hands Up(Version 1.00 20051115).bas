' action_02
'== Hands UP ====================================

DIM A AS BYTE

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
	IF A <> 2 THEN GOTO main

	GOSUB hans_up
	DELAY 500
	GOSUB standard_pose

	GOTO MAIN

'================================================
hans_up:
	SPEED 5
	MOVE G6A, 100,  76, 145,  93, 100
	MOVE G6D, 100,  76, 145,  93, 100	
	MOVE G6B, 100, 168, 150
	MOVE G6C, 100, 168, 150
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
