'Template program for 2.4GHz wireless controller
'Hitec & Multiplex ROBONOVA-1
'by Thomas Heilmann
'www.robonova.de

DIM buffer AS BYTE
DIM char AS BYTE
DIM a AS BYTE
DIM b AS BYTE
DIM A16 AS BYTE


ERX 19200, a, bemt1				'Empty the RX buffer
bemt1:
ERX 19200, a, bemt2
bemt2:

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

'================================================
		
GOSUB standard_pose

main:

char="a"						'Byte 0
ETX 19200,char					'Send character

loop1:
ERX 19200,a,loop1				'Receive character


char="b"						'Byte 1
ETX 19200,char 					'Send character

loop2:
ERX 19200,b,loop2				'Receive character

GOTO movement

'================================================

movement:						'Use single Bit


buffer = a.0					
IF buffer = 0 THEN GOTO move14	'Select
buffer = a.1					
IF buffer = 0 THEN GOTO main	'L3
buffer = a.2
IF buffer = 0 THEN GOTO main	'R3
buffer = a.3					
IF buffer = 0 THEN GOTO move13	'Start
buffer = a.4					
IF buffer = 0 THEN GOTO move1	'Up
buffer = a.5					
IF buffer = 0 THEN GOTO move4	'Right
buffer = a.6					
IF buffer = 0 THEN GOTO move2	'Down
buffer = a.7					
IF buffer = 0 THEN GOTO move3	'Left


buffer = b.0					
IF buffer = 0 THEN GOTO move12	'L2
buffer = b.1					
IF buffer = 0 THEN GOTO move10	'R2
buffer = b.2					
IF buffer = 0 THEN GOTO move11	'L1
buffer = b.3					
IF buffer = 0 THEN GOTO move9	'R1
buffer = b.4					
IF buffer = 0 THEN GOTO move6	'Triangle
buffer = b.5					
IF buffer = 0 THEN GOTO move5	'Square
buffer = b.6					
IF buffer = 0 THEN GOTO move8	'Cross
buffer = b.7					
IF buffer = 0 THEN GOTO move7	'Circle


GOTO main

'================================================

move1:							
	GOSUB forward_walk
	GOSUB standard_pose
	GOTO main
		
move2:							
	GOSUB backward_walk
	GOSUB standard_pose
	GOTO main
		
move3:							
	SPEED 8
	GOSUB left_shift
	SPEED 6
	GOSUB standard_pose
	GOTO main
	
move4:							
	SPEED 8
	GOSUB right_shift
	SPEED 6
	GOSUB standard_pose
	GOTO main
	
move5:							
	GOSUB right_attack
	GOSUB standard_pose
	GOTO main
	
move6:							
	GOSUB forward_punch
	SPEED 10
	GOSUB standard_pose
	GOTO main

move7:							
	GOSUB left_attack
	GOSUB standard_pose
	GOTO main	

move8:							
	GOSUB sit_down_pose
	DELAY 1000
	GOSUB standard_pose
	GOTO main
	
move9:							
	GOSUB righ_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO main
move10:							
	GOSUB right_turn
	GOSUB standard_pose	
	GOTO main
move11:							
	GOSUB left_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO main
move12:							
	GOSUB left_turn
	GOSUB standard_pose
	GOTO main
move13:							
	GOSUB sit_down_pose16
	GOTO main
move14:							
	GOSUB bow_pose
	GOSUB standard_pose
	GOTO main
	
'================================================
'================================================

forward_walk:

	SPEED 5
MOVE24  85,  71, 152,  91, 112,  60, 100,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 112,  76, 145,  93,  92,  60,
	
	SPEED 14 
'left up
MOVE24  90, 107, 105, 105, 114,  60,  90,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 114,  76, 145,  93,  90,  60,
'---------------------------------------
'left down
MOVE24  90,  56, 143, 122, 114,  60,  80,  40,  80,    ,    ,    , 105,  40,  80,    ,    ,    , 113,  80, 145,  90,  90,  60,
MOVE24  90,  46, 163, 112, 114,  60,  80,  40,  80,    ,    ,    , 105,  40,  80,    ,    ,    , 112,  80, 145,  90,  90,  60,
	
	SPEED 10
'left center
MOVE24 100,  66, 141, 113, 100, 100,  90,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 100,  83, 156,  80, 100, 100,
MOVE24 113,  78, 142, 105,  90,  60, 100,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    ,  90, 102, 136,  85, 114,  60,

	SPEED 14
'right up
MOVE24 113,  76, 145,  93,  90,  60, 100,  40,  80,    ,    ,    ,  90,  40,  80,    ,    ,    ,  90, 107, 105, 105, 114,  60,
			
'right down
MOVE24 113,  80, 145,  90,  90,  60, 105,  40,  80,    ,    ,    ,  80,  40,  80,    ,    ,    ,  90,  56, 143, 122, 114,  60,
MOVE24 112,  80, 145,  90,  90,  60, 105,  40,  80,    ,    ,    ,  80,  40,  80,    ,    ,    ,  90,  46, 163, 112, 114,  60,
		
	SPEED 10
'right center
MOVE24 100,  83, 156,  80, 100, 100, 100,  40,  80,    ,    ,    ,  90,  40,  80,    ,    ,    , 100,  66, 141, 113, 100, 100,
MOVE24  90, 102, 136,  85, 114,  60, 100,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 113,  78, 142, 105,  90,  60,
		
	SPEED 14
'left up
MOVE24  90, 107, 105, 105, 114,  60,  90,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 113,  76, 145,  93,  90,  60,
'---------------------------------------

	SPEED 5
MOVE24  85,  71, 152,  91, 112,  60, 100,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 112,  76, 145,  93,  92,  60,
	
	RETURN
'================================================
'================================================
left_shift:

	SPEED 5
	GOSUB left_shift1
	SPEED 9
	GOSUB left_shift2
	
	GOSUB left_shift3
	GOSUB left_shift4
	
	SPEED 9
	GOSUB left_shift5
	GOSUB left_shift6
	
	RETURN
'================================================
left_shift1:
	MOVE G6A,  85,  71, 152,  91, 112,  60,
	MOVE G6D, 112,  76, 145,  93,  92,  60,
	MOVE G6B, 100,  40,  80,    ,    ,    ,
	MOVE G6C, 100,  40,  80,    ,    ,    ,	
	WAIT
	RETURN
'---------------------------
left_shift2:
	MOVE G6D, 110,  92, 124,  97,  93,  70,
	MOVE G6A,  76,  72, 160,  82, 128,  70,
	MOVE G6B, 100,  35,  90,    ,    ,    ,
	MOVE G6C, 100,  35,  90,    ,    ,    ,
	WAIT
	RETURN
'---------------------------
left_shift3:
	MOVE G6A,  93,  76, 145,  94, 109, 100,
	MOVE G6D,  93,  76, 145,  94, 109, 100,
	MOVE G6B, 100,  35,  90,    ,    ,    ,
	MOVE G6C, 100,  35,  90,    ,    ,    ,
	WAIT
	RETURN
'---------------------------
left_shift4:
	MOVE G6A, 110,  92, 124,  97,  93,  70,
	MOVE G6D,  76,  72, 160,  82, 128,  70,
	MOVE G6B, 100,  35,  90,    ,    ,    ,
	MOVE G6C, 100,  35,  90,    ,    ,    ,
	WAIT
	RETURN
'---------------------------
left_shift5:
	MOVE G6D,  86,  83, 135,  97, 114,  60,
	MOVE G6A, 113,  78, 145,  93,  93,  60,
	MOVE G6C,  90,  40,  80,    ,    ,    , 
	MOVE G6B, 100,  40,  80,    ,    ,    , 
	WAIT
	RETURN
'---------------------------	
left_shift6:
	MOVE G6D,  85,  71, 152,  91, 112,  60,
	MOVE G6A, 112,  76, 145,  93,  92,  60,
	MOVE G6C, 100,  40,  80,    ,    ,    ,
	MOVE G6B, 100,  40,  80,    ,    ,    ,
	WAIT
	RETURN
'================================================

'================================================
right_shift:

	SPEED 5
	GOSUB right_shift1
	
	SPEED 9
	GOSUB right_shift2
	
	GOSUB right_shift3
	
	GOSUB right_shift4
	
	SPEED 9
	GOSUB right_shift5
	GOSUB right_shift6
	
	RETURN
'================================================
right_shift1:
	MOVE G6D,  85,  71, 152,  91, 112, 60  
	MOVE G6A, 112,  76, 145,  93,  92, 60 
	MOVE G6C, 100,  40,  80,  ,  ,  ,
	MOVE G6B, 100,  40,  80,  ,  ,  ,
	WAIT
	RETURN
	
right_shift2:
	MOVE G6A,110,  92, 124,  97,  93,  70
	MOVE G6D, 76,  72, 160,  82, 128,  70
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN

right_shift3:
	MOVE G6A, 93,  76, 145,  94, 109, 100
	MOVE G6D, 93,  76, 145,  94, 109, 100
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN

right_shift4:
	MOVE G6D,110,  92, 124,  97,  93,  70
	MOVE G6A, 76,  72, 160,  82, 128,  70
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN

right_shift5:
	MOVE G6A, 86,  83, 135,  97, 114,  60
	MOVE G6D,113,  78, 145,  93,  93,  60
	MOVE G6B, 90,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,
	WAIT
	RETURN

right_shift6:
	MOVE G6A, 85,  71, 152,  91, 112,  60
	MOVE G6D,112,  76, 145,  93,  92,  60
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
	WAIT
	RETURN
'================================================	
'================================================
backward_walk:

	SPEED 5
	GOSUB backward_walk1
	
	SPEED 13
	GOSUB backward_walk2
	
	SPEED 7
	GOSUB backward_walk3
	GOSUB backward_walk4
	GOSUB backward_walk5

	SPEED 13
	GOSUB backward_walk6
		
	SPEED 7
	GOSUB backward_walk7
	GOSUB backward_walk8
	GOSUB backward_walk9

	SPEED 13
	GOSUB backward_walk2

	SPEED 5
	GOSUB backward_walk1

	RETURN
'================================================
backward_walk1:
	MOVE G6A, 85,  71, 152,  91, 112,  60
	MOVE G6D,112,  76, 145,  93,  92,  60
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
	WAIT
	RETURN

backward_walk2:
	MOVE G6A, 90, 107, 105, 105, 114,  60
	MOVE G6D,113,  78, 145,  93,  90,  60
	MOVE G6B, 90,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,
	WAIT
	RETURN
	
backward_walk9:
	MOVE G6A, 90,  56, 143, 122, 114,  60
	MOVE G6D,113,  80, 145,  90,  90,  60
	MOVE G6B, 80,  40,  80, , , ,
	MOVE G6C,105,  40,  80, , , ,
	WAIT
	RETURN

backward_walk8:
	MOVE G6A,100,  62, 146, 108, 100, 100
	MOVE G6D,100,  88, 140,  86, 100, 100
	MOVE G6B, 90,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,
	WAIT
	RETURN
		
backward_walk7:
	MOVE G6A,113,  76, 142, 105,  90,  60
	MOVE G6D, 90,  96, 136,  85, 114,  60	
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , , 
	WAIT
	RETURN

backward_walk6:
	MOVE G6D, 90, 107, 105, 105, 114,  60
	MOVE G6A,113,  78, 145,  93,  90,  60
	MOVE G6C,90,  40,  80, , , , 
	MOVE G6B,100,  40,  80, , , , 
	WAIT
	RETURN

backward_walk5:
	MOVE G6D, 90,  56, 143, 122, 114,  60
	MOVE G6A,113,  80, 145,  90,  90,  60
	MOVE G6C,80,  40,  80, , , , 
	MOVE G6B,105,  40,  80, , , , 
	WAIT
	RETURN

backward_walk4:
	MOVE G6D,100,  62, 146, 108, 100, 100 
	MOVE G6A,100,  88, 140,  86, 100, 100
	MOVE G6C,90,  40,  80, , ,,
	MOVE G6B,100,  40,  80, , , , 
	WAIT
	RETURN

backward_walk3:
	MOVE G6D,113,  76, 142, 105,  90,  60
	MOVE G6A, 90,  96, 136,  85, 114,  60
	MOVE G6C,100,  40,  80, , , ,
	MOVE G6B,100,  40,  80, , , ,
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
'================================================
right_attack:
	SPEED 7
	GOSUB right_attack1
	
	SPEED 12
	HIGHSPEED SETON
	MOVE G6D, 98, 157,  20, 134, 110, 100
	MOVE G6A, 57, 115,  77, 125, 134, 100
	MOVE G6B,112,  92,  99, 100, 100, 100
	MOVE G6C,107, 135, 108, 100, 100, 100
	WAIT	
	DELAY 1000
	HIGHSPEED SETOFF
	SPEED 15
	GOSUB sit_pose
	RETURN
'================================================
right_attack1:
	MOVE G6D,  85,  71, 152,  91, 107, 60  
	MOVE G6A, 108,  76, 145,  93, 100, 60 
	MOVE G6C, 100,  40,  80,  ,  ,  ,
	MOVE G6B, 100,  40,  80,  ,  ,  ,
	WAIT
	RETURN
'================================================
'================================================
sit_pose:

	SPEED 10
	MOVE G6A,100, 151,  23, 140, 101, 100,
	MOVE G6D,100, 151,  23, 140, 101, 100,
	MOVE G6B,100,  30,  80, 100, 100, 100,
	MOVE G6C,100,  30,  80, 100, 100, 100,	
	WAIT
	RETURN
'================================================
'================================================
forward_punch:
	SPEED 15
	MOVE G6A, 92, 100, 110, 100, 107, 100
	MOVE G6D, 92, 100, 110, 100, 107, 100
	MOVE G6B,190, 150,  10, 100, 100, 100
	MOVE G6C,190, 150,  10, 100, 100, 100
	WAIT
	SPEED 15
	HIGHSPEED SETON

	MOVE G6B,190,  10,  75, 100, 100, 100
	MOVE G6C,190, 140,  10, 100, 100, 100
	WAIT
	DELAY 500
	MOVE G6B,190, 140,  10, 100, 100, 100
	MOVE G6C,190,  10,  75, 100, 100, 100
	WAIT
	DELAY 500
	
	MOVE G6A, 92, 100, 113, 100, 107, 100
	MOVE G6D, 92, 100, 113, 100, 107, 100
	MOVE G6B,190, 150,  10, 100, 100, 100
	MOVE G6C,190, 150,  10, 100, 100, 100
	WAIT
	
	HIGHSPEED SETOFF
	MOVE G6A,100, 115,  90, 110, 100, 100
	MOVE G6D,100, 115,  90, 110, 100, 100
	MOVE G6B,100,  80,  60, 100, 100, 100
	MOVE G6C,100,  80,  60, 100, 100, 100
	WAIT
	RETURN
'================================================
'================================================
left_attack:
	SPEED 7
	GOSUB left_attack1
	
	SPEED 12
	HIGHSPEED SETON
	MOVE G6A, 98, 157,  20, 134, 110, 100
	MOVE G6D, 57, 115,  77, 125, 134, 100	
	MOVE G6B,107, 135, 108, 100, 100, 100
	MOVE G6C,112,  92,  99, 100, 100, 100
	WAIT
	DELAY 1000
	HIGHSPEED SETOFF
	SPEED 15
	GOSUB sit_pose
	RETURN
'================================================
left_attack1:
	MOVE G6A,  85,  71, 152,  91, 107, 60  
	MOVE G6D, 108,  76, 145,  93, 100, 60 
	MOVE G6B, 100,  40,  80,  ,  ,  ,
	MOVE G6C, 100,  40,  80,  ,  ,  ,
	WAIT
	RETURN
'================================================
'================================================
sit_down_pose:
	SPEED 10
	MOVE G6A, 100, 151,  23, 140, 101, 100
	MOVE G6D, 100, 151,  23, 140, 101, 100
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 100	
	WAIT
	RETURN
'================================================
'================================================
fast_walk: 
DIM A10 AS BYTE
	SPEED 10
	MOVE G6B,100,  30,  90, 100, 100, 100
	MOVE G6C,100,  30,  90, 100, 100, 100
	WAIT
	SPEED 7
fast_run01:
	MOVE G6A, 90,  72, 148,  93, 110,  70
	MOVE G6D,108,  75, 145,  93,  95,  70
	WAIT
	SPEED 15
fast_run02:
	MOVE G6A, 90,  95, 105, 115, 110,  70
	MOVE G6D,112,  75, 145,  93,  95,  70
	MOVE G6B, 90,  30,  90, 100, 100, 100
	MOVE G6C,110,  30,  90, 100, 100, 100
	WAIT
	SPEED 15
'----------------------------  4 times
	FOR A10 = 1 TO 4

fast_run20:
	MOVE G6A,100,  80, 119, 118, 106, 100
	MOVE G6D,105,  75, 145,  93, 100, 100
	MOVE G6B, 80,  30,  90, 100, 100, 100
	MOVE G6C,120,  30,  90, 100, 100, 100
fast_run21:
	MOVE G6A,105,  74, 140, 106, 100, 100
	MOVE G6D, 95, 105, 124,  93, 106, 100
	MOVE G6B,100,  30,  90, 100, 100, 100
	MOVE G6C,100,  30,  90, 100, 100, 100
fast_run22:
	MOVE G6D,100,  80, 119, 118, 106, 100
	MOVE G6A,105,  75, 145,  93, 100, 100
	MOVE G6C, 80,  30,  90, 100, 100, 100
	MOVE G6B,120,  30,  90, 100, 100, 100
fast_run23:
	MOVE G6D,105,  74, 140, 106, 100, 100
	MOVE G6A, 95, 105, 124,  93, 106, 100
	MOVE G6C,100,  30,  90, 100, 100, 100
	MOVE G6B,100,  30,  90, 100, 100, 100

	NEXT A10
'------------------------------
	SPEED 8
	MOVE G6A, 85,  80, 130,  95, 106, 100
	MOVE G6D,108,  73, 145,  93, 100, 100
	MOVE G6B, 80,  30,  90, 100, 100, 100
	MOVE G6C,120,  30,  90, 100, 100, 100
	WAIT
fast_run03:
	MOVE G6A, 90,  72, 148,  93, 110,  70
	MOVE G6D,108,  75, 145,  93,  93,  70
	WAIT
	SPEED 5

	RETURN
'================================================
'================================================
right_turn:
	SPEED 6
	MOVE G6A,  85,  71, 152,  91, 112,  60  
	MOVE G6D, 112,  76, 145,  93,  92,  60 
	MOVE G6B, 100,  40,  80,    ,    ,    ,
	MOVE G6C, 100,  40,  80,    ,    ,    ,
	WAIT

	SPEED 9
	MOVE G6D, 113,  75, 145,  97,  93,  60
	MOVE G6A,  90,  50, 157, 115, 112,  60 
	MOVE G6C, 105,  40,  70,    ,    ,    , 
	MOVE G6B,  90,  40,  70,    ,    ,    , 
	WAIT   

	MOVE G6D, 108,  78, 145,  98,  93,  60
	MOVE G6A,  95,  43, 169, 110, 110,  60 
	MOVE G6C, 105,  40,  70,    ,    ,    ,
	MOVE G6B,  80,  40,  70,    ,    ,    , 
	WAIT
	RETURN
'================================================
'================================================
wing_move:
	DIM i AS BYTE
	SPEED 5
	
	MOVE G6A, 85,  71, 152,  91, 112,  60
	MOVE G6D,112,  76, 145,  93,  92,  60
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
	WAIT
	
	MOVE G6A, 90,  98, 105, 115, 115,  60
	MOVE G6D,116,  74, 145,  98,  93,  60
	MOVE G6B,100, 150, 150, 100, 100, 100
	MOVE G6C,100, 150, 150, 100, 100, 100
	WAIT
	
	MOVE G6A, 90, 121,  36, 105, 115,  60
	MOVE G6D,116,  60, 146, 138,  93,  60
	MOVE G6B,100, 150, 150, 100, 100, 100
	MOVE G6C,100, 150, 150, 100, 100, 100
	WAIT

	MOVE G6A, 90,  98, 105,  64, 115,  60
	MOVE G6D,116,  50, 160, 160,  93,  60
	MOVE G6B,145, 110, 110, 100, 100, 100
	MOVE G6C,145, 110, 110, 100, 100, 100
	WAIT

	FOR i = 10 TO 15
		SPEED i
		MOVE G6B,145,  80,  80, 100, 100, 100
		MOVE G6C,145,  80,  80, 100, 100, 100
		WAIT
	
		MOVE G6B,145, 120, 120, 100, 100, 100
		MOVE G6C,145, 120, 120, 100, 100, 100
		WAIT
	NEXT i

	DELAY 1000
	SPEED 6

	MOVE G6A, 90,  98, 105,  64, 115,  60
	MOVE G6D,116,  50, 160, 160,  93,  60
	MOVE G6B,100, 160, 180, 100, 100, 100
	MOVE G6C,100, 160, 180, 100, 100, 100
	WAIT

	MOVE G6A, 90, 121,  36, 105, 115,  60
	MOVE G6D,116,  60, 146, 138,  93,  60
	MOVE G6B,100, 150, 150, 100, 100, 100
	MOVE G6C,100, 150, 150, 100, 100, 100
	WAIT
	SPEED 4

	MOVE G6A, 90,  98, 105, 115, 115,  60
	MOVE G6D,116,  74, 145,  98,  93,  60
	WAIT
	
	MOVE G6A, 85,  71, 152,  91, 112,  60
	MOVE G6D,112,  76, 145,  93,  92,  60
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
	WAIT
	RETURN
'================================================
'================================================
left_turn:
	SPEED 6
	MOVE G6D,  85,  71, 152,  91, 112,  60  
	MOVE G6A, 112,  76, 145,  93,  92,  60 
	MOVE G6C, 100,  40,  80,    ,    ,    ,
	MOVE G6B, 100,  40,  80,    ,    ,    ,
	WAIT

	SPEED 9
	MOVE G6A, 113,  75, 145,  97,  93,  60
	MOVE G6D,  90,  50, 157, 115, 112,  60 
	MOVE G6B, 105,  40,  70,    ,    ,    , 
	MOVE G6C,  90,  40,  70,    ,    ,    , 
	WAIT   

	MOVE G6A, 108,  78, 145,  98,  93,  60
	MOVE G6D,  95,  43, 169, 110, 110,  60 
	MOVE G6B, 105,  40,  70,    ,    ,    ,
	MOVE G6C,  80,  40,  70,    ,    ,    , 
	WAIT
	RETURN
'================================================
'================================================
sit_down_pose16:
	IF A16 = 0 THEN GOTO standard_pose16
	A16 = 0
	SPEED 10
	MOVE G6A, 100, 151,  23, 140, 101, 100
	MOVE G6D, 100, 151,  23, 140, 101, 100
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 100	
	WAIT
'== motor power off  ============================
	MOTOROFF G24
	TEMPO 230
	MUSIC "FEDC"
	RETURN
'================================================
standard_pose16:
	TEMPO 230
	MUSIC "CDE"
	GETMOTORSET G24,1,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,1,1,0
'== motor power on  =============================
	MOTOR G24
	A16 = 1
'================================================
	SPEED 10
	GOSUB standard_pose
	RETURN
'================================================
'================================================
left_tumbling:

SPEED 8
MOVE G6A,100, 135,  60, 123, 100, 100
MOVE G6D,100, 135,  60, 123, 100, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT


DELAY 100
SPEED 3
MOVE G6A,114, 135,  60, 123, 105, 100
MOVE G6D, 88, 110,  91, 116, 100, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT
DELAY 100
MOVE G6A,114, 135,  60, 123, 105, 100
MOVE G6D,89,  135,  60, 123, 100, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT

MOVE G6A,120, 135,  60, 123, 110, 100
MOVE G6D, 89, 135,  60, 123, 130, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT

SPEED 4
MOVE G6A,120, 135,  60, 123, 120, 100
MOVE G6D,89,  135,  60, 123, 158, 100
MOVE G6B,100, 165, 185, 100, 100, 100
MOVE G6C,100, 165, 185, 100, 100, 100
WAIT

SPEED 8
MOVE G6A,120, 131,  60, 123, 185, 100
MOVE G6D,120, 131,  60, 123, 183, 100
MOVE G6B,100, 165, 185, 100, 100, 100
MOVE G6C,100, 165, 185, 100, 100, 100
WAIT

DELAY 200

SPEED 5
MOVE G6A,120, 131,  60, 123, 185, 100
MOVE G6D,120, 131,  60, 123, 183, 100
MOVE G6B,100, 120, 145, 100, 100, 100
MOVE G6C,100, 120, 145, 100, 100, 100
WAIT

SPEED 6

MOVE G6A, 86, 112,  73, 127, 101, 100
MOVE G6D,105, 131,  60, 123, 183, 100
MOVE G6B,100, 120, 145, 100, 100, 100
MOVE G6C,100, 120, 145, 100, 100, 100
WAIT

SPEED 3
MOVE G6A, 86, 118,  73, 127, 101, 100
MOVE G6D,112, 131,  62, 123, 133, 100
MOVE G6B,100,  80,  80, 100, 100, 100
MOVE G6C,100,  80,  80, 100, 100, 100
WAIT

SPEED 3
MOVE G6A, 88, 115,  86, 115,  90, 100
MOVE G6D,107, 135,  62, 123, 113, 100
MOVE G6B,100,  80,  80, 100, 100, 100
MOVE G6C,100,  80,  80, 100, 100, 100
WAIT

SPEED 4
MOVE G6A,100, 135,  60, 123, 100, 100
MOVE G6D,100, 135,  60, 123, 100, 100
MOVE G6B,100,  80,  80, 100, 100, 100
MOVE G6C,100,  80,  80, 100, 100, 100
WAIT

RETURN
'================================================
'================================================
righ_tumbling:

SPEED 8
MOVE G6A,100, 135,  60, 123, 100, 100
MOVE G6D,100, 135,  60, 123, 100, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT
DELAY 100

SPEED 3
MOVE G6A, 83, 110,  91, 116, 100, 100
MOVE G6D,114, 135,  60, 123, 105, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT
DELAY 100

MOVE G6A,89,  135,  60, 123, 100, 100
MOVE G6D,114, 135,  60, 123, 105, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT

MOVE G6A, 89, 135,  60, 123, 130, 100
MOVE G6D,120, 135,  60, 123, 110, 100
MOVE G6B,100, 120, 140, 100, 100, 100
MOVE G6C,100, 120, 140, 100, 100, 100
WAIT

SPEED 4
MOVE G6A,89,  135,  60, 123, 158, 100
MOVE G6D,120, 135,  60, 123, 120, 100
MOVE G6B,100, 165, 185, 100, 100, 100
MOVE G6C,100, 165, 185, 100, 100, 100
WAIT

SPEED 8
MOVE G6A,120, 131,  60, 123, 183, 100
MOVE G6D,120, 131,  60, 123, 185, 100
MOVE G6B,100, 165, 185, 100, 100, 100
MOVE G6C,100, 165, 185, 100, 100, 100
WAIT

DELAY 200

SPEED 5
MOVE G6A,120, 131,  60, 123, 183, 100
MOVE G6D,120, 131,  60, 123, 185, 100
MOVE G6B,100, 120, 145, 100, 100, 100
MOVE G6C,100, 120, 145, 100, 100, 100
WAIT

SPEED 6
MOVE G6A,105, 131,  60, 123, 183, 100
MOVE G6D, 86, 112,  73, 127, 101, 100
MOVE G6B,100, 120, 145, 100, 100, 100
MOVE G6C,100, 120, 145, 100, 100, 100
WAIT

SPEED 3
MOVE G6A,112, 131,  62, 123, 133, 100
MOVE G6D, 86, 118,  73, 127, 101, 100
MOVE G6B,100,  80,  80, 100, 100, 100
MOVE G6C,100,  80,  80, 100, 100, 100
WAIT

SPEED 3
MOVE G6A,107, 135,  62, 123, 113, 100
MOVE G6D, 88, 115,  89, 115,  90, 100
MOVE G6B,100,  80,  80, 100, 100, 100
MOVE G6C,100,  80,  80, 100, 100, 100
WAIT

SPEED 4
MOVE G6A,100, 135,  60, 123, 100, 100
MOVE G6D,100, 135,  60, 123, 100, 100
MOVE G6B,100,  80,  80, 100, 100, 100
MOVE G6C,100,  80,  80, 100, 100, 100
WAIT

RETURN
'================================================
'================================================
bow_pose:
	MOVE G6A, 100,  58, 135, 160, 100, 100 
	MOVE G6D, 100,  58, 135, 160, 100, 100
	MOVE G6B, 100,  30,  80,  ,  ,  ,
	MOVE G6C, 100,  30,  80,  ,  ,  , 
	WAIT
	DELAY 1000
	RETURN
	
GOTO MAIN

'================================================

