'================================================
' templet program 
'
' RR : internal parameter variable / ROBOREMOCON / Action command
' A  : temporary variable          / REMOCON
' A16,A26 : temporary variable 
'
'== auto_main ===================================
GOTO AUTO
FILL 255,10000

DIM RR AS BYTE
DIM A AS BYTE
DIM B AS BYTE
DIM A16 AS BYTE
DIM A26 AS BYTE
DIM V AS BYTE
DIM VOLT AS BYTE
DIM VOLT2 AS BYTE
DIM TURN AS BYTE

DIM LDIST AS BYTE
DIM MDIST AS BYTE
DIM RDIST AS BYTE

LDIST = 0
MDIST = 0
RDIST = 0
TURN = 0


DIM I2cBuf AS BYTE
DIM I2cAddr AS BYTE
DIM I2cReg AS BYTE
DIM I2cData AS BYTE
DIM I2cBit AS BYTE
DIM I2cTx AS BYTE
DIM I2cRx AS BYTE

CONST SDA = 46 'Use port 46 for Data, constant SDA
CONST SCL = 47 'Use port 47 for Clock, constant SCL

CONST ID = 0     ' 1:0, 2:32, 3:64, 4:96,

'== Action command check (50 - 82)
IF RR > 50 AND RR < 83 THEN GOTO action_proc 

RR = 0

PTP SETON 				
PTP ALLON				

'== motor direction setting ======================
DIR G6A,1,0,0,1,0,0		
DIR G6B,1,1,1,1,1,1		
DIR G6C,0,0,0,0,0,0		
DIR G6D,0,1,1,0,1,1		


'== motor start position read ===================
'TEMPO 230
'MUSIC "CDE"
GETMOTORSET G24,1,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,1,1,0
'== motor power on  =============================
SPEED 5
MOTOR G24	
GOSUB standard_pose
LCDINIT
PRINT &HFE, &H01 ' clear screen 
PRINT &HFE, &H80, &H01 ' set cursor at position 1
PRINT &H08 'backspace to position 0
PRINT &HFE, &H0C 'blinking cursor off
GOSUB hello
GOSUB battery
'================================================
MAIN:
GOSUB robot_tilt

'-----------------------------
IF RR = 0 THEN GOTO MAIN1

ON RR GOTO MAIN,K1,K2,K3,K4
GOTO main_exit
'-----------------------------
MAIN1:
A = REMOCON(1)  
A = A - ID	
ON A GOTO MAIN,K1,K2,K3,K4
GOTO MAIN
'-------------------------------------------------
action_proc:
A = RR - 50
ON A GOTO MAIN,K1,K2,K3,K4
RETURN
'-----------------------------
main_exit:
	IF RR > 50 THEN RETURN
	RR = 0
	GOTO MAIN
'================================================
k1:
	DIM REPEATMOVE AS BYTE
	FOR REPEATMOVE = 1 TO 50
    GOSUB distance_check
    GOSUB battery
    NEXT REPEATMOVE
	GOTO main_exit

k2:
    GOSUB battery
	GOTO main_exit
	
k3:					
	GOSUB left_turn
	GOSUB standard_pose
	GOTO main_exit

k4:					
	GOSUB right_turn
	GOSUB standard_pose	
	GOTO main_exit
'================================================
distance_check:
	SPEED 2
    MOVE G6A, 100,  66, 145,  120, 100, 100 
	MOVE G6D, 100,  66, 145,  120, 100, 105
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 98
	SPEED 6

	HIGHSPEED SETON
	MOVE G6D, , , , , , 165
	DELAY 500
	RDIST = AD(0)
	IF RDIST > 50 THEN MUSIC "7A"
	DELAY 500
	WAIT
	MOVE G6D, , , , , , 35
	DELAY 500
	LDIST = AD(0)
	IF LDIST > 50 THEN MUSIC "7A"
	DELAY 500
	WAIT
	MOVE G6D, , , , , , 105
	DELAY 500
	MDIST = AD(0)
	IF MDIST > 50 THEN MUSIC "7A"
	DELAY 500
	HIGHSPEED SETOFF
	GOSUB standard_pose

' distance > 50 means something is close
' distance <= 50 means all clear in that direction
' turn - turn = 0 means last turn was left, turn = 1 means last turn was right
	
IF MDIST <= 50 THEN

		IF LDIST <= 50 AND RDIST <= 50 THEN
		GOSUB forward_walk
		GOSUB standard_pose
		ENDIF

		IF LDIST > 50 AND RDIST > 50 THEN
		GOSUB forward_walk
		GOSUB standard_pose
		ENDIF

		IF LDIST <= 50 AND RDIST > 50 THEN
		GOSUB veer_left
		TURN = 0
		GOSUB standard_pose
		GOSUB forward_walk
		GOSUB standard_pose
		ENDIF

		IF LDIST > 50 AND RDIST <= 50 THEN
		GOSUB veer_right
		TURN = 1
		GOSUB standard_pose
		GOSUB forward_walk
		GOSUB standard_pose
		ENDIF

ENDIF
	
IF MDIST > 50  THEN

		IF LDIST > 50 AND RDIST > 50 THEN
		GOSUB backward_walk
		GOSUB standard_pose
		GOSUB backward_walk
		GOSUB standard_pose
		GOSUB left_turn
		GOSUB left_turn
		GOTO distance_check
		ENDIF
		
		IF LDIST > 50 AND RDIST <= 50 THEN
		GOSUB backward_walk
		GOSUB standard_pose
		GOSUB right_turn
		GOSUB standard_pose
		TURN = 1
		GOTO distance_check
		ENDIF 
					
		IF RDIST > 50 AND LDIST <= 50 THEN
		GOSUB backward_walk
		GOSUB standard_pose
		GOSUB left_turn
		GOSUB standard_pose
		TURN = 0
		GOTO distance_check
		ENDIF 
		
		IF RDIST <= 50 AND LDIST <= 50 THEN
				
			IF TURN = 0 THEN
			GOSUB backward_walk
			GOSUB standard_pose
			GOSUB left_turn
			GOSUB standard_pose
			TURN = 1
			GOTO distance_check
			ENDIF
		
	   		IF TURN = 1 THEN
	  	 	GOSUB backward_walk
			GOSUB standard_pose
			GOSUB right_turn
			GOSUB standard_pose
			TURN = 0
			GOTO distance_check
			ENDIF
		
		ENDIF
ENDIF
	
	RETURN
	
'================================================

led_on:

	OUT 52,0
	RETURN

'================================================

led_off:

	OUT 52,1
	RETURN 

'================================================

hello:

		PRINT &HFE, &H01
		PRINT &HFE, &H80, &H01
		PRINT &H08 
		PRINT "HELLO ALAN"
		DELAY 3000
		RETURN

'================================================

battery:						' [ 10 x Value / 256 = Voltage]

	V = AD(1)
	VOLT = V*100/256

	IF VOLT > 64 THEN
		PRINT &HFE, &H01
		PRINT &HFE, &H80, &H01
		PRINT &H08 
		PRINT "BATTERY IS FULL"
	ELSEIF VOLT >= 62 AND VOLT <= 64 THEN
		PRINT &HFE, &H01
		PRINT &HFE, &H80, &H01
		PRINT &H08 
		PRINT "BATTERY IS GOOD"
	ELSEIF VOLT >= 60 AND VOLT <= 61 THEN
		PRINT &HFE, &H01
		PRINT &HFE, &H80, &H01
		PRINT &H08 
		PRINT "BATTERY IS FAIR"
	ELSEIF VOLT < 60 THEN
		GOSUB led_off
		PRINT &HFE, &H01
		PRINT &HFE, &H80, &H01
		PRINT &H08 
		PRINT "BATTERY IS LOW"
	ENDIF
	PRINT &H0A
	PRINT "VOLTAGE = "
	IF VOLT > 59 THEN
		PRINT "6" 
		VOLT2 = VOLT - 60
			IF VOLT2 = 0 THEN PRINT ".0"
			IF VOLT2 = 1 THEN PRINT ".1"
			IF VOLT2 = 2 THEN PRINT ".2"
			IF VOLT2 = 3 THEN PRINT ".3"
			IF VOLT2 = 4 THEN PRINT ".4"
			IF VOLT2 = 5 THEN PRINT ".5"
			IF VOLT2 = 6 THEN PRINT ".6"
			IF VOLT2 = 7 THEN PRINT ".7"
			IF VOLT2 = 8 THEN PRINT ".8"
			IF VOLT2 >= 9 THEN PRINT ".9"
	ENDIF
	IF VOLT < 60 THEN
		PRINT "5" 
		VOLT2 = VOLT - 50
			IF VOLT2 = 0 THEN PRINT ".0"
			IF VOLT2 = 1 THEN PRINT ".1"
			IF VOLT2 = 2 THEN PRINT ".2"
			IF VOLT2 = 3 THEN PRINT ".3"
			IF VOLT2 = 4 THEN PRINT ".4"
			IF VOLT2 = 5 THEN PRINT ".5"
			IF VOLT2 = 6 THEN PRINT ".6"
			IF VOLT2 = 7 THEN PRINT ".7"
			IF VOLT2 = 8 THEN PRINT ".8"
			IF VOLT2 = 9 THEN PRINT ".9"
	ENDIF
	PRINT "V"
	RETURN
'================================================
robot_tilt:	
	A = AD(3)
	B = AD(4)
	IF A < 100 THEN GOTO tilt_backward
	IF A > 170 THEN GOTO tilt_forward
	RETURN
tilt_backward:
	GOTO backward_standup
	RETURN
tilt_forward:	
	GOTO forward_standup
	RETURN
'================================================
standard_pose:
	MOVE G6A, 100,  76, 145,  93, 100, 100 
	MOVE G6D, 100,  76, 145,  93, 100, 105
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 98
	WAIT
    DELAY 1000
    GOSUB robot_tilt
	RETURN
'================================================
forward_walk:
	SPEED 5
	MOVE24  85,71,152,91,112,60,100,40,80, , , ,100,40,80, , , ,112,76,145,93,92,105
	SPEED 14 
	'left up
	MOVE24  90,107, 105, 105, 114,  60,  90,  40,  80, , , ,100,40,80, , , ,114,76,145,93,90,105
	'left down
	MOVE24  90,56,143,122, 114,  60,  80,  40,  80, , , ,105,40,80, , , ,113,80,145,90,90,105
	MOVE24  90,46,163,112, 114,  60,  80,  40,  80, , , ,105,40,80, , , ,112,80,145,90,90,105
	SPEED 10
	'left centre
	MOVE24 100,66,141,113,100,100,90,40,80, , , ,100,40,80, , , ,100,83,156,80,100,105
	MOVE24 113,78,142, 105,  90,  60, 100,  40,  80, ,    ,    , 100,  40,  80,    ,    ,    ,  90, 102, 136,  85, 114,  105
	SPEED 14
	'right up
	MOVE24 113,  76, 145,  93,  90,  60, 100,  40,  80, ,    ,    ,  90,  40,  80,    ,    ,    ,  90, 107, 105, 105, 114,  105
	'right down
	MOVE24 113,  80, 145,  90,  90,  60, 105,  40,  80, ,    ,    ,  80,  40,  80,    ,    ,    ,  90,  56, 143, 122, 114,  105
	MOVE24 112,  80, 145,  90,  90,  60, 105,  40,  80, ,    ,    ,  80,  40,  80,    ,    ,    ,  90,  46, 163, 112, 114,  105
	SPEED 10
	'right centre
	MOVE24 100,  83, 156,  80, 100, 100, 100,  40,  80, , ,    ,  90,  40,  80,    ,    ,    , 100,  66, 141, 113, 100, 105
	MOVE24  90, 102, 136,  85, 114,  60, 100,  40,  80, ,    ,    , 100,  40,  80,    ,    ,    , 113,  78, 142, 105,  90,  105
	SPEED 14
	'left up
	MOVE24  90, 107, 105, 105, 114,  60,  90,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 113,  76, 145,  93,  90,  105
	SPEED 5
	MOVE24  85,  71, 152,  91, 112,  60, 100,  40,  80,    ,    ,    , 100,  40,  80,    ,    ,    , 112,  76, 145,  93,  92,  105
	RETURN
'================================================

right_turn:

	DIM RT AS BYTE
	SPEED 6
	
	FOR RT = 1 TO 3
	SPEED 6	'don't lean too fast
	'feet together, lean left, stand on left,CGmid-foot
	MOVE G6A, 112,  76, 145,  93,  92,  60 
	MOVE G6D,  85,  71, 152,  91, 120,  105  
	'arms downish, need hands to clear hips
	MOVE G6B, 100,  40,  80, , , ,
	WAIT

	'right foot fwd, left foot back,
	'arms swung opposite (slightly), and slightly out

	SPEED 9
	MOVE G6A, 113,  75, 145,  97,  93,  60 
	MOVE G6D,  90,  50, 157, 115, 120,  105 
	MOVE G6B, 105,  40,  70
	MOVE G6C,  90,  40,  70
	WAIT   
'	RETURN
	'lean less left so right foot is just touching floor
	'right foot fwd, left foot back,
	'arms swung opposite (more)

	MOVE G6A, 108,  78, 145,  98,  93,  60 
	MOVE G6D,  95,  43, 169, 110, 120,  105 
	MOVE G6B, 105,  40,  70
	MOVE G6C,  80,  40,  70
	WAIT
	GOSUB standard_pose
	DELAY 100
	NEXT RT
		
	RETURN
'================================================

left_turn:

	DIM LT AS BYTE
	SPEED 6
	
	FOR LT = 1 TO 3
	
	SPEED 6	'don't lean too fast
	'feet together, lean right, stand on right,CGmid-foot
	MOVE G6A,  85,  71, 152,  91, 120,  60 
	MOVE G6D, 112,  76, 145,  93,  92,  105 
	'arms downish, need hands to clear hips
	MOVE G6B, 100,  40,  80, , , ,
	WAIT

	SPEED 9
	'left foot fwd, right foot back
	'arms swung opposite (slightly), and slightly out
	MOVE G6A,  90,  50, 157, 115, 120,  60 
	MOVE G6D, 113,  75, 145,  97,  93,  105 
	MOVE G6B,  90,  40,  70,    ,    ,    , 
	MOVE G6C, 105,  40,  70,    ,    ,    , 
	WAIT   

	'lean less right so left foot is just touching floor
	'left foot fwd, right foot back,
	'arms swung opposite (more)
	MOVE G6D, 108,  78, 145,  98,  93,  105 
	MOVE G6A,  95,  43, 169, 110, 120,  60 
	MOVE G6C, 105,  40,  70
	MOVE G6B,  80,  40,  70
	WAIT
	
	GOSUB standard_pose
	DELAY 500
	NEXT LT
	RETURN
'================================================

veer_right:

	DIM VR AS BYTE
	SPEED 6
	
	SPEED 6	'don't lean too fast
	'feet together, lean left, stand on left,CGmid-foot
	MOVE G6A, 112,  76, 145,  93,  92,  60 
	MOVE G6D,  85,  71, 152,  91, 120,  105  
	'arms downish, need hands to clear hips
	MOVE G6B, 100,  40,  80, , , ,
	WAIT

	'right foot fwd, left foot back,
	'arms swung opposite (slightly), and slightly out

	SPEED 9
	MOVE G6A, 113,  75, 145,  97,  93,  60 
	MOVE G6D,  90,  50, 157, 115, 120,  105 
	MOVE G6B, 105,  40,  70
	MOVE G6C,  90,  40,  70
	WAIT   
'	RETURN
	'lean less left so right foot is just touching floor
	'right foot fwd, left foot back,
	'arms swung opposite (more)

	MOVE G6A, 108,  78, 145,  98,  93,  60 
	MOVE G6D,  95,  43, 169, 110, 120,  105 
	MOVE G6B, 105,  40,  70
	MOVE G6C,  80,  40,  70
	WAIT
	GOSUB standard_pose
	DELAY 100
			
	RETURN
'================================================
veer_left:

	DIM VL AS BYTE
	SPEED 6
	
	SPEED 6	'don't lean too fast
	'feet together, lean right, stand on right,CGmid-foot
	MOVE G6A,  85,  71, 152,  91, 120,  60 
	MOVE G6D, 112,  76, 145,  93,  92,  105 
	'arms downish, need hands to clear hips
	MOVE G6B, 100,  40,  80, , , ,
	WAIT

	SPEED 9
	'left foot fwd, right foot back
	'arms swung opposite (slightly), and slightly out
	MOVE G6A,  90,  50, 157, 115, 120,  60 
	MOVE G6D, 113,  75, 145,  97,  93,  105 
	MOVE G6B,  90,  40,  70,    ,    ,    , 
	MOVE G6C, 105,  40,  70,    ,    ,    , 
	WAIT   

	'lean less right so left foot is just touching floor
	'left foot fwd, right foot back,
	'arms swung opposite (more)
	MOVE G6D, 108,  78, 145,  98,  93,  105 
	MOVE G6A,  95,  43, 169, 110, 120,  60 
	MOVE G6C, 105,  40,  70
	MOVE G6B,  80,  40,  70
	WAIT
	
	GOSUB standard_pose
	DELAY 500
	RETURN
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
	MOVE G6D,112,  76, 145,  93,  92,  105
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
	WAIT
	RETURN

backward_walk2:
	MOVE G6A, 90, 107, 105, 105, 114,  60
	MOVE G6D,113,  78, 145,  93,  90,  105
	MOVE G6B, 90,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,
	WAIT
	RETURN
	
backward_walk9:
	MOVE G6A, 90,  56, 143, 122, 114,  60
	MOVE G6D,113,  80, 145,  90,  90,  105
	MOVE G6B, 80,  40,  80, , , ,
	MOVE G6C,105,  40,  80, , , ,
	WAIT
	RETURN

backward_walk8:
	MOVE G6A,100,  62, 146, 108, 100, 100
	MOVE G6D,100,  88, 140,  86, 100, 105
	MOVE G6B, 90,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,
	WAIT
	RETURN
		
backward_walk7:
	MOVE G6A,113,  76, 142, 105,  90,  60
	MOVE G6D, 90,  96, 136,  85, 114,  105	
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , , 
	WAIT
	RETURN

backward_walk6:
	MOVE G6D, 90, 107, 105, 105, 114,  105
	MOVE G6A,113,  78, 145,  93,  90,  60
	MOVE G6C,90,  40,  80, , , , 
	MOVE G6B,100,  40,  80, , , , 
	WAIT
	RETURN

backward_walk5:
	MOVE G6D, 90,  56, 143, 122, 114,  105
	MOVE G6A,113,  80, 145,  90,  90,  60
	MOVE G6C,80,  40,  80, , , , 
	MOVE G6B,105,  40,  80, , , , 
	WAIT
	RETURN

backward_walk4:
	MOVE G6D,100,  62, 146, 108, 100, 105 
	MOVE G6A,100,  88, 140,  86, 100, 100
	MOVE G6C,90,  40,  80, , ,,
	MOVE G6B,100,  40,  80, , , , 
	WAIT
	RETURN

backward_walk3:
	MOVE G6D,113,  76, 142, 105,  90,  105
	MOVE G6A, 90,  96, 136,  85, 114,  60
	MOVE G6C,100,  40,  80, , , ,
	MOVE G6B,100,  40,  80, , , ,
	WAIT
	RETURN
'================================================
forward_standup:

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
	GOTO main_exit
	
'================================================
backward_standup:

	SPEED 10
	
	MOVE G6A,100,  10, 100, 115, 100, 100
	MOVE G6D,100,  10, 100, 115, 100, 100
	MOVE G6B,100, 130,  10, 100, 100, 100
	MOVE G6C,100, 130,  10, 100, 100, 100
	WAIT

	MOVE G6A,100,  10,  83, 140, 100, 100
	MOVE G6D,100,  10,  83, 140, 100, 100
	MOVE G6B, 20, 130,  10, 100, 100, 100
	MOVE G6C, 20, 130,  10, 100, 100, 100
	WAIT

	MOVE G6A,100, 126,  60,  50, 100, 100
	MOVE G6D,100, 126,  60,  50, 100, 100
	MOVE G6B, 20,  30,  90, 100, 100, 100
	MOVE G6C, 20,  30,  90, 100, 100, 100
	WAIT
	
	MOVE G6A,100, 165,  70,  15, 100, 100
	MOVE G6D,100, 165,  70,  15, 100, 100
	MOVE G6B, 30,  20,  95, 100, 100, 100
	MOVE G6C, 30,  20,  95, 100, 100, 100
	WAIT
	
	MOVE G6A,100, 165,  40, 100, 100, 100
	MOVE G6D,100, 165,  40, 100, 100, 100
	MOVE G6B,110,  70,  50, 100, 100, 100
	MOVE G6C,110,  70,  50, 100, 100, 100
	WAIT
	
	GOSUB standard_pose
	GOTO main_exit

'=================================================
