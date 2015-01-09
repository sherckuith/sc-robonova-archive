' matrix
'==matrix ==================================

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
		

	GOSUB avoid_matrix
	DELAY 1000
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN
	
'================================================
	
avoid_matrix:
SPEED 10
GOSUB standard_pose

'DELAY 1000
MOVE G6A, 72, 165,  23,  70, 143, 100
MOVE G6D, 72, 165,  23,  70, 143, 100
MOVE G6B,170, 100, 100, 100, 100, 100
MOVE G6C,170, 100, 100, 100, 100, 100


MOVE G6A, 79, 160,  23,  42, 185, 100
MOVE G6D, 79, 160,  23,  42, 185, 100
WAIT

DELAY 4000

SPEED 6
MOVE G6A, 72, 165,  23,  70, 143, 100
MOVE G6D, 72, 165,  23,  70, 143, 100
MOVE G6B,170, 50, 70, 100, 100, 100
MOVE G6C,170, 50, 70, 100, 100, 100
WAIT

MOVE G6A,100, 151,  23, 140, 101, 100
MOVE G6D,100, 151,  23, 140, 101, 100
MOVE G6B,100,  30,  80, , , 
MOVE G6C,100,  30,  80, , , 
WAIT

SPEED 8
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