' hand clapping
'== hand clapping ==================================

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
	GOSUB hand_clapping
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN
	
'================================================
	

hand_clapping:

	SPEED 10
	WAIT

	HIGHSPEED SETON

	MOVE G6C, 145, 20, 70,  ,  ,  ,
	MOVE G6B, 145, 20, 70,  ,  ,  , 

	FOR a = 0 TO 3	
	MOVE G6C, 145, 20, 40,  ,  ,  ,
	MOVE G6B, 145, 20, 40,  ,  ,  , 	
	WAIT
	
	MOVE G6C, 145, 15, 25,  ,  ,  ,
	MOVE G6B, 145, 15, 25,  ,  ,  , 	
	WAIT
	
	MOVE G6C, 145, 20, 40,  ,  ,  ,
	MOVE G6B, 145, 20, 40,  ,  ,  , 	
	WAIT
	DELAY 100
	
	MOVE G6C, 145, 15, 25,  ,  ,  ,
	MOVE G6B, 145, 15, 25,  ,  ,  , 	
	WAIT
	
	MOVE G6C, 155, 20, 40,  ,  ,  ,
	MOVE G6B, 155, 20, 40,  ,  ,  , 	
	WAIT
	DELAY 100
	
	MOVE G6C, 155, 15, 25,  ,  ,  ,
	MOVE G6B, 155, 15, 25,  ,  ,  , 	
	WAIT

	MOVE G6C, 155, 20, 40,  ,  ,  ,
	MOVE G6B, 155, 20, 40,  ,  ,  , 	
	WAIT
		
	DELAY 400
	NEXT a
	
	MOVE G6C, 145, 20, 70,  ,  ,  ,
	MOVE G6B, 145, 20, 70,  ,  ,  , 	
	
	HIGHSPEED SETOFF
	RETURN	
'-------------------------------------
'================================================	

standard_pose:

	MOVE G6A,100,  76, 145,  93, 100, 100 
	MOVE G6D,100,  76, 145,  93, 100, 100  
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100
	WAIT
	
	RETURN
	
'================================================		
	
