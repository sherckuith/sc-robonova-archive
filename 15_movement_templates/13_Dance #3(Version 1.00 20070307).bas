' dance#3
'== dance#3 ==================================

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
		
'A = REMOCON(1)	
'	IF A <> 1 THEN GOTO main

	SPEED 8
	GOSUB dance3
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	DELAY 1000
	
	GOTO MAIN
	
'================================================
dance3:
MOVE G6A, 87, 120,  73, 130, 112, 100
MOVE G6D, 87, 120,  73, 130, 112, 100
MOVE G6B,102, 100, 100, 100, 100, 100
MOVE G6C,102, 100, 100, 100, 100, 100
WAIT
DELAY 1000
SPEED 5

FOR i = 0 TO 1
MOVE G6A,117, 166,  22, 130, 133, 100
MOVE G6D, 63,  77, 138, 102,  89, 100
WAIT
DELAY 500

MOVE G6A, 87, 120,  73, 130, 112, 100
MOVE G6D, 87, 120,  73, 130, 112, 100
WAIT
DELAY 500

MOVE G6A, 63,  77, 138, 102,  89, 100
MOVE G6D,117, 166,  22, 130, 133, 100
WAIT
DELAY 500

MOVE G6A, 87, 120,  73, 130, 112, 100
MOVE G6D, 87, 120,  73, 130, 112, 100
WAIT
DELAY 500

NEXT i
SPEED 5


MOVE G6A, 87, 120,  73, 125, 112, 100
MOVE G6D, 87, 120,  73, 125, 112, 100
WAIT
DELAY 500

SPEED 10

MOVE G6A, 100,  62, 165,  90, 100, 100
MOVE G6D, 100,  62, 165,  90, 100, 100
MOVE G6B,102,  30,  80, 100, 100, 100
MOVE G6C,102,  30,  80, 100, 100, 100


SPEED 10
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


