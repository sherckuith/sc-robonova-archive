' action_9
'== Hand standing ===============================

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
	IF A <> 9 THEN GOTO main

	SPEED 8
	GOSUB handstanding
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	
	GOTO MAIN
'================================================
handstanding:

	GOSUB fall_forward

	GOSUB standard_pose

	GOSUB foot_up
 
	GOSUB standard_pose

	GOSUB back_stand_up

RETURN

'================================================
fall_forward:

	SPEED 10
	MOVE G6A, 100, 155,  25, 140, 100, 100
	MOVE G6D, 100, 155,  25, 140, 100, 100
	MOVE G6B, 130,  50,  85, 100, 100, 100
	MOVE G6C, 130,  50,  85, 100, 100, 100
	WAIT
	
	MOVE G6A,  60, 165,  25, 160, 145, 100
	MOVE G6D,  60, 165,  25, 160, 145, 100
	MOVE G6B, 150,  60,  90, 100, 100, 100
	MOVE G6C, 150,  60,  90, 100, 100, 100
	WAIT
	
	MOVE G6A,  60, 165,  30, 165, 155, 100
	MOVE G6D,  60, 165,  30, 165, 155, 100
	MOVE G6B, 170,  10, 100, 100, 100, 100
	MOVE G6C, 170,  10, 100, 100, 100, 100
	WAIT
	SPEED 3
	
	MOVE G6A,  75, 165,  55, 165, 155, 100
	MOVE G6D,  75, 165,  55, 165, 155, 100
	MOVE G6B, 185,  10, 100, 100, 100, 100
	MOVE G6C, 185,  10, 100, 100, 100, 100
	WAIT
	SPEED 10
	
	MOVE G6A,  80, 155,  85, 150, 150, 100
	MOVE G6D,  80, 155,  85, 150, 150, 100
	MOVE G6B, 185,  40, 60,  100, 100, 100
	MOVE G6C, 185,  40, 60,  100, 100, 100
	WAIT
		
	MOVE G6A, 100, 130, 120,  80, 110, 100
	MOVE G6D, 100, 130, 120,  80, 110, 100
	MOVE G6B, 125, 160,  10, 100, 100, 100
	MOVE G6C, 125, 160,  10, 100, 100, 100
	WAIT	
	
	RETURN
'================================================
foot_up:
	SPEED 6
	MOVE G6A, 100, 125,  65,  10, 100,    ,  
	MOVE G6D, 100, 125,  65,  10, 100,    , 
	MOVE G6B, 110,  30,  80,    ,    ,    , 
	MOVE G6C, 110,  30,  80,    ,    ,    , 

	SPEED 3
	MOVE G6A, 100, 125,  65,  10, 100,    ,
	MOVE G6D, 100, 125,  65,  10, 100,    ,
	MOVE G6B, 170,  30,  80,    ,    ,    ,
	MOVE G6C, 170,  30,  80,    ,    ,    , 
	WAIT

	DELAY 200

	SPEED 6
	MOVE G6A, 100,  89, 129,  57, 100,    , 
	MOVE G6D, 100,  89, 129,  57, 100,    , 
	MOVE G6B, 180,  30,  80,    ,    ,    ,
	MOVE G6C, 180,  30,  80,    ,    ,    , 
	WAIT

	MOVE G6A, 100,  64, 179,  57, 100,    ,   
	MOVE G6D, 100,  64, 179,  57, 100,    ,  
	MOVE G6B, 190,  50,  80,    ,    ,    ,
	MOVE G6C, 190,  50,  80,    ,    ,    ,
	WAIT

	DELAY 2000

	MOVE G6A, 100,  64, 179,  57, 100,    ,   
	MOVE G6D, 100,  64, 179,  57, 100,    ,   
	MOVE G6B, 190,  50,  80,    ,    ,    ,
	MOVE G6C, 190,  50,  80,    ,    ,    ,
	WAIT

	MOVE G6A, 100,  89, 129,  57, 100,    , 
	MOVE G6D, 100,  89, 129,  57, 100,    ,   
	MOVE G6B, 180,  30,  80,    ,    ,    ,
	MOVE G6C, 180,  30,  80,    ,    ,    ,
	WAIT

	SPEED 3
	MOVE G6A, 100, 125,  65,  10, 100,    , 
	MOVE G6D, 100, 125,  65,  10, 100,    ,   
	MOVE G6B, 170,  30,  80,    ,    ,    ,
	MOVE G6C, 170,  30,  80,    ,    ,    ,
	WAIT

	SPEED 6
	MOVE G6A, 100, 125,  65,  10, 100,    ,   
	MOVE G6D, 100, 125,  65,  10, 100,    ,  
	MOVE G6B, 110,  30,  80,    ,    ,    ,
	MOVE G6C, 110,  30,  80,    ,    ,    ,
	WAIT

	RETURN

'================================================	
back_stand_up:

	SPEED 10
	
	MOVE G6A, 100, 130, 120,  80, 110, 100
	MOVE G6D, 100, 130, 120,  80, 110, 100
	MOVE G6B, 150, 160,  10, 100, 100, 100
	MOVE G6C, 150, 160,  10, 100, 100, 100
	WAIT
	
	MOVE G6A,  80, 155,  85, 150, 150, 100
	MOVE G6D,  80, 155,  85, 150, 150, 100
	MOVE G6B, 185,  40, 60,  100, 100, 100
	MOVE G6C, 185,  40, 60,  100, 100, 100
	WAIT
		
	MOVE G6A,  75, 165,  55, 165, 155, 100
	MOVE G6D,  75, 165,  55, 165, 155, 100
	MOVE G6B, 185,  10, 100, 100, 100, 100
	MOVE G6C, 185,  10, 100, 100, 100, 100
	WAIT	
	
	MOVE G6A,  60, 165,  30, 165, 155, 100
	MOVE G6D,  60, 165,  30, 165, 155, 100
	MOVE G6B, 170,  10, 100, 100, 100, 100
	MOVE G6C, 170,  10, 100, 100, 100, 100
	WAIT	
	
	MOVE G6A,  60, 165,  25, 160, 145, 100
	MOVE G6D,  60, 165,  25, 160, 145, 100
	MOVE G6B, 150,  60,  90, 100, 100, 100
	MOVE G6C, 150,  60,  90, 100, 100, 100
	WAIT	
	
	MOVE G6A, 100, 155,  25, 140, 100, 100
	MOVE G6D, 100, 155,  25, 140, 100, 100
	MOVE G6B, 130,  50,  85, 100, 100, 100
	MOVE G6C, 130,  50,  85, 100, 100, 100
	WAIT	
	
	RETURN
'================================================	
standard_pose:

	MOVE G6A, 100,  76, 145,  93, 100, 100 
	MOVE G6D, 100,  76, 145,  93, 100, 100  
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 100
	WAIT
	
	RETURN
'================================================