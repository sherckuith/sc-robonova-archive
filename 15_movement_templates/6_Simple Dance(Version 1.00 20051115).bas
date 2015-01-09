' action_06
'== Body move ===================================

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
	IF A <> 6 THEN GOTO main

	GOSUB body_move
	GOSUB standard_pose

	GOTO MAIN

'================================================

body_move:
	SPEED 6
	GOSUB body_move1
	GOSUB body_move2
	GOSUB body_move3
	
	MOVE G6A, 93,  76, 145,  94, 109, 100
	MOVE G6D, 93,  76, 145,  94, 109, 100
	MOVE G6B,100,  105, 100, , , ,
	MOVE G6C,100,  105, 100, , , ,
	WAIT
	
	
	MOVE G6A, 104, 112,  92, 116, 107
	MOVE G6D,  79,  81, 145,  95, 108
	MOVE G6B, 100, 105, 100
	MOVE G6C, 100, 105, 100
	WAIT
	
	MOVE G6A, 93,  76, 145,  94, 109, 100
	MOVE G6D, 93,  76, 145,  94, 109, 100
	MOVE G6B,100,  105, 100, , , ,
	MOVE G6C,100,  105, 100, , , ,
	WAIT
	
	MOVE G6D, 104, 112,  92, 116, 107
	MOVE G6A,  79,  81, 145,  95, 108
	MOVE G6B, 100, 105, 100
	MOVE G6C, 100, 105, 100
	WAIT
	
	MOVE G6A, 93,  76, 145,  94, 109, 100
	MOVE G6D, 93,  76, 145,  94, 109, 100
	MOVE G6B,100,  105, 100, , , ,
	MOVE G6C,100,  105, 100, , , ,
	WAIT
	
	GOSUB body_move3
	GOSUB body_move2
	GOSUB body_move1
	
RETURN
'================================================
body_move3:
	MOVE G6A, 93,  76, 145,  94, 109, 100
	MOVE G6D, 93,  76, 145,  94, 109, 100
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN
'================================================

body_move2:
	MOVE G6D,110,  92, 124,  97,  93,  70
	MOVE G6A, 76,  72, 160,  82, 128,  70
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN
	
'================================================
body_move1:
	MOVE G6A, 85,  71, 152,  91, 112, 60
	MOVE G6D,112,  76, 145,  93,  92, 60
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
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