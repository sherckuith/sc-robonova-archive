' Hand shaking
'== Hand shaking ==================================

DIM A AS BYTE
DIM I AS BYTE
DIM robot_no AS BYTE
DIM mode AS BYTE


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
	GOSUB Hand_shaking
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN
	
'================================================
	

'-------------------------------------
Hand_shaking:

	SPEED 10
	WAIT

	HIGHSPEED SETON

	MOVE G6C, 190, 100, 100,  ,  ,  ,
	MOVE G6B, 190, 100, 100,  ,  ,  , 

	FOR a = 0 TO 3	
	MOVE G6C, 190, 100, 100,  ,  ,  ,
	MOVE G6B, 190, 45, 45,  ,  ,  , 	
	WAIT
	DELAY 200
	
	MOVE G6C, 190, 45, 45,  ,  ,  ,
	MOVE G6B, 190, 100, 100,  ,  ,  , 	
	WAIT
	DELAY 200
	NEXT a
	
	
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