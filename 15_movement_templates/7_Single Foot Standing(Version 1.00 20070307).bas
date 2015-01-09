' single foot standing
'== single foot standing ==================================

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
		

	SPEED 8
	GOSUB single_foot_standing
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN
	
'================================================
	

single_foot_standing:
SPEED 5
MOVE G6A,113,  56, 182,  75,  90, 60
MOVE G6D, 73,  56, 182,  75, 116, 60
MOVE G6B,100, 100, 100, 100, 100, 100
MOVE G6C,100,  40,  90, 100, 100, 100
WAIT

MOVE G6A,114,  56, 181,  75, 90, 100
MOVE G6D, 80, 155,  23, 135, 117, 100
MOVE G6B,100, 110, 100, 100, 100, 100
MOVE G6C,100, 110, 100, 100, 100, 100
WAIT
SPEED 2
MOVE G6A,108,  56, 181,  75, 133, 100
MOVE G6D, 80, 155,  23, 135, 155, 100
MOVE G6B,100, 140, 100, 100, 100, 100
MOVE G6C,100, 154, 100, 100, 100, 100
WAIT
DELAY 200
SPEED 2
MOVE G6A,110,  56, 181,  75, 133, 100
MOVE G6D,100,  59, 170,  85, 155, 100
MOVE G6B,100, 105, 100, 100, 100, 100
MOVE G6C,100, 154, 100, 100, 100, 100
WAIT




DELAY 1000
SPEED 10
FOR i = 0 TO 5
MOVE G6C,100, 174, 100, 100, 100, 100
WAIT
MOVE G6C,100, 134, 100, 100, 100, 100
WAIT
NEXT i
DELAY 3000
SPEED 3
MOVE G6A,110,  56, 181,  75, 133, 100
MOVE G6D, 80, 155,  23, 135, 155, 100
MOVE G6B,100, 110, 100, 100, 100, 100
MOVE G6C,100, 154, 100, 100, 100, 100
WAIT

DELAY 1000
MOVE G6A,114,  56, 181,  75, 90, 60
MOVE G6D, 80, 155,  23, 135, 117, 60
MOVE G6B,100, 120, 100, 100, 100, 100
MOVE G6C,100, 170, 100, 100, 100, 100
WAIT
SPEED 10
MOVE G6A,114,  56, 182,  75,  90, 100
MOVE G6D, 73,  56, 182,  75, 116, 100
MOVE G6B,100, 120, 100, 100, 100, 100
MOVE G6C,100,  40,  90, 100, 100, 100
WAIT

GOSUB standard_pose

RETURN
'================================================	

standard_pose:

	MOVE G6A,100,  76, 145,  93, 100, 100 
	MOVE G6D,100,  76, 145,  93, 100, 100  
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100
	WAIT
	
	RETURN
	
