' sit & backward walking
'== sit & backward walking ==================================

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
	GOSUB sit_backward_walking
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN

'================================================

sit_backward_walking:
	SPEED 10
	MOVE G6B,100,  35,  80, 100, 100, 100
	MOVE G6C,100,  35,  80, 100, 100, 100
	WAIT
	
	FOR I = 0 TO 3
	
	MOVE G6A,115, 150,  24, 140,  94, 100
	MOVE G6D, 86, 151,  26, 140, 110, 100
	WAIT
	
	MOVE G6A,100, 131,  26, 162, 100, 100
	MOVE G6D,100, 160,  25, 133, 100, 100
	WAIT
	
	
	MOVE G6A, 86, 151,  26, 140, 110, 100
	MOVE G6D,115, 150,  24, 140,  94, 100
	WAIT
	
	MOVE G6A,100, 160,  25, 133, 100, 100
	MOVE G6D,100, 131,  26, 162, 100, 100
	WAIT
	
	NEXT I
	
	SPEED 8
	MOVE G6A,115, 150,  24, 140,  94, 100
	MOVE G6D, 86, 151,  26, 140, 110, 100
	WAIT
	
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
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
