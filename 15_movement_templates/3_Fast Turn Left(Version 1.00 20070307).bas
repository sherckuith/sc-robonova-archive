' fast_turn_left
'==fast_turn_left==================================

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
		

	GOSUB fast_turn_left
	DELAY 3000
	
	GOTO MAIN
	
'================================================	


fast_turn_left:
HIGHSPEED SETON
SPEED 6

	MOVE G6A, 99,  86, 165,  98, 101
	MOVE G6D, 99,  66, 125,  88, 106
	WAIT
	
'standard pose
	MOVE G6A, 99,  76, 145,  93, 101
	MOVE G6D, 99,  76, 145,  93, 101
	WAIT

HIGHSPEED SETOFF
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
