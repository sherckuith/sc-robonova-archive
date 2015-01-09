' sit & right walking
'== sit & right walking ==================================

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
	GOSUB sit_right_walking
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN
	
'================================================
	
sit_right_walking:
	SPEED 8
	MOVE G6A, 86, 151,  23, 140, 105, 100
	MOVE G6D,112, 150,  23, 140, 100, 100
	MOVE G6B,100,  40,  75, 100, 100, 100
	MOVE G6C,100,  40,  75, 100, 100, 100
	WAIT
	
	MOVE G6A, 86, 151,  26, 140, 115, 100
	MOVE G6D, 86, 151,  26, 140, 115, 100
	WAIT
	
	'SPEED 10
	MOVE G6A,118, 154,  24, 140, 95, 100
	MOVE G6D, 80, 154,  24, 140, 110, 100
	'MOVE G6B,100,  70,  75, 100, 100, 100
	WAIT
	
	SPEED 8
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	MOVE G6B,100,  30,  80, , , 
	MOVE G6C,100,  30,  80, , , 
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