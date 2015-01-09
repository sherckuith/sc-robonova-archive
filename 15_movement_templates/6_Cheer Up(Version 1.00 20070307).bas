' cheer_up
'== cheer_up ====================================

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


	GOSUB cheer_up
	DELAY 1000
	GOSUB standard_pose
	DELAY 1000

	GOTO MAIN
	
	
'================================================

cheer_up:

	SPEED 10
	MOVE G6A,100,  80, 167,  50, 100, 100
	MOVE G6D,100,  80, 167,  50, 100, 100
	MOVE G6B,100, 145, 125, , , 
	MOVE G6C,100, 145, 122, , , 
	WAIT
	
	FOR I = 0 TO 1
	MOVE G6B,100, 100, 140, , , , 
	MOVE G6C,100, 100, 140, , , , 
	WAIT
	MOVE G6B,100, 165, 160, , , , 
	MOVE G6C,100, 165, 160, , , , 
	WAIT
	
	NEXT I
	SPEED 8
	DELAY 200
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
'================================================

