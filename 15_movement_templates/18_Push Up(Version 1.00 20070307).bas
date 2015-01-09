' Push_up
'== Push_up ==================================

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
	GOSUB push_up
	DELAY 1000
	
	GOSUB  back_raise
	
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN

'================================================

'================================================

standard_pose:

	MOVE G6A,100,  76, 145,  93, 100, 100 
	MOVE G6D,100,  76, 145,  93, 100, 100  
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100
	WAIT
	
	RETURN
'================================================
sit_position:
	SPEED 10
	MOVE G6A,100, 151,  27, 140, 100, 100
	MOVE G6D,100, 151,  27, 140, 100, 100
	MOVE G6B,100,  30,  80, , , 
	MOVE G6C,100,  30,  80, , , 
	WAIT
	
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	MOVE G6B,100,  30,  80, , , 
	MOVE G6C,100,  30,  80, , , 
	WAIT

	RETURN
	
	
	
	
	
	
push_up:	
	
MOVE G6A,101, 164,  23, 168, 100, 100
MOVE G6B,159,  30,  81, 100, 100, 100
MOVE G6C,160,  30,  81, 100, 100, 100
MOVE G6D,100, 167,  20, 169,  99, 100



FOR i=0 TO 10


MOVE G6A,101,  74, 139,  98,  96, 100
MOVE G6B,182,  77,  12, 100, 100, 100
MOVE G6C,174,  97,  25, 100, 100, 100
MOVE G6D,107,  74, 127, 105, 103, 100



MOVE G6A,101,  74, 139,  98,  96, 100
MOVE G6B,171,  12, 100, 100, 100, 100
MOVE G6C,170,  10,  99, 100, 100, 100
MOVE G6D,107,  74, 127, 105, 103, 100


	
	
MOVE G6A,101,  74, 139,  98,  96, 100
MOVE G6B,182,  77,  12, 100, 100, 100
MOVE G6C,174,  97,  25, 100, 100, 100
MOVE G6D,107,  74, 127, 105, 103, 100
	
	
NEXT i	

WAIT

RETURN




back_raise:
	SPEED 10

	
	MOVE G6A,100, 130, 120,  80, 110, 100
	MOVE G6D,100, 130, 120,  80, 110, 100
	MOVE G6B,150, 160,  10, 100, 100, 100
	MOVE G6C,150, 160,  10, 100, 100, 100
	WAIT
	
	MOVE G6A, 80, 155,  85, 150, 150, 100
	MOVE G6D, 80, 155,  85, 150, 150, 100
	MOVE G6B,185,  40, 60,  100, 100, 100
	MOVE G6C,185,  40, 60,  100, 100, 100
	WAIT
	
	MOVE G6A, 75, 165,  55, 165, 155, 100
	MOVE G6D, 75, 165,  55, 165, 155, 100
	MOVE G6B,185,  10, 100, 100, 100, 100
	MOVE G6C,185,  10, 100, 100, 100, 100
	WAIT
	
	MOVE G6A, 60, 165,  30, 165, 155, 100
	MOVE G6D, 60, 165,  30, 165, 155, 100
	MOVE G6B,170,  10, 100, 100, 100, 100
	MOVE G6C,170,  10, 100, 100, 100, 100
	WAIT
	
	MOVE G6A, 60, 165,  25, 160, 145, 100
	MOVE G6D, 60, 165,  25, 160, 145, 100
	MOVE G6B,150,  60,  90, 100, 100, 100
	MOVE G6C,150,  60,  90, 100, 100, 100
	WAIT
	
	MOVE G6A,100, 155,  25, 140, 100, 100
	MOVE G6D,100, 155,  25, 140, 100, 100
	MOVE G6B,130,  50,  85, 100, 100, 100
	MOVE G6C,130,  50,  85, 100, 100, 100
	WAIT

	GOSUB standard_pose 
	
	RETURN

