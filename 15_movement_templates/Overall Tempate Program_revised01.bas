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
DIM A16 AS BYTE
DIM A26 AS BYTE
DIM V AS BYTE
DIM VOLT AS BYTE

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
TEMPO 230
MUSIC "CDE"
GETMOTORSET G24,1,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,1,1,0
'== motor power on  =============================
SPEED 5
MOTOR G24	
GOSUB standard_pose
'GOSUB battery
'================================================
MAIN:
'GOSUB robot_voltage
'GOSUB robot_tilt

'-----------------------------
IF RR = 0 THEN GOTO MAIN1

ON RR GOTO MAIN,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16,K17,K18,K19,K20,K21,K22,K23,K24,K25,K26,K27,K28,K29,K30,K31,K32
GOTO main_exit
'-----------------------------
MAIN1:
A = REMOCON(1)  
A = A - ID	
ON A GOTO MAIN,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16,K17,K18,K19,K20,K21,K22,K23,K24,K25,K26,K27,K28,K29,K30,K31,K32
GOTO MAIN
'-------------------------------------------------
action_proc:
A = RR - 50
ON A GOTO MAIN,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16,K17,K18,K19,K20,K21,K22,K23,K24,K25,K26,K27,K28,K29,K30,K31,K32
RETURN
'-----------------------------
main_exit:
	IF RR > 50 THEN RETURN
	RR = 0
	GOTO MAIN
'================================================
k1:
	GOSUB bow_pose
	GOSUB standard_pose
	GOTO main_exit
k2:
	GOSUB hans_up
	DELAY 500
	GOSUB standard_pose
	GOTO main_exit
k3:
	GOSUB sit_down_pose
	DELAY 1000
	GOSUB standard_pose
	GOTO main_exit
k4:
	GOSUB sit_hans_up
	DELAY 1000
	GOSUB standard_pose
	GOTO main_exit
k5:
	GOSUB foot_up
	GOSUB standard_pose
	GOTO main_exit
k6:
	GOSUB body_move
	GOSUB standard_pose
	GOTO main_exit
k7:
	GOSUB wing_move
	GOSUB standard_pose
	GOTO main_exit
k8:
	GOSUB right_shoot
	GOSUB standard_pose
	DELAY 500
	GOSUB left_shoot
	GOSUB standard_pose	
	DELAY 500
	GOTO main_exit
k9:
	SPEED 8
	GOSUB handstanding
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	GOTO main_exit
k10:
	GOSUB fast_walk
	GOSUB standard_pose
	GOTO main_exit
k11:					' ^ 1
	GOSUB forward_walk
	GOSUB standard_pose
	GOTO main_exit	
k12:					' _ 1
	GOSUB backward_walk
	GOSUB standard_pose
	GOTO main_exit
k13:					' > 1
	SPEED 8
	GOSUB right_shift
	SPEED 6
	GOSUB standard_pose
	GOTO main_exit
k14:					' < 1
	SPEED 8
	GOSUB left_shift
	SPEED 6
	GOSUB standard_pose
	GOTO main_exit
k15:					' A
	GOSUB left_attack
	GOSUB standard_pose
	GOTO main_exit
k16:	
	GOSUB sit_down_pose16
	GOTO main_exit 
	
k17:					' C
	GOSUB left_forward
	GOSUB standard_pose
	GOTO main_exit
k18:					' E
	TEMPO 230
	MUSIC "C"					
	GOTO main_exit
k19:					' P2
	GOSUB backward_standup
	GOSUB standard_pose
	GOTO main_exit
k20:					' B	
	GOSUB right_attack
	GOSUB standard_pose
	GOTO main_exit
k21:					' ^ 2
	GOSUB forward_tumbling
	GOSUB standard_pose	
	GOTO main_exit	
k22:					' *	
	GOSUB left_turn
	GOSUB standard_pose
	GOTO main_exit
k23:					' F
	TEMPO 230
	MUSIC "D"					
	GOTO main_exit
k24:					' #
	GOSUB right_turn
	GOSUB standard_pose	
	GOTO main_exit
k25:					' P1
	GOSUB battery
	GOTO main_exit
k26:					' [] 1	
	GOSUB sit_down_pose26
	GOTO main_exit
k27:					' D
	GOSUB right_forward
	GOSUB standard_pose
	GOTO main_exit	
k28:					' < 2
	GOSUB left_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO main_exit		
k29:					' [] 2
	GOSUB forward_punch
	SPEED 10
	GOSUB standard_pose
	GOTO main_exit	
k30:					' > 2
	GOSUB righ_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO main_exit
k31:					' _ 2
	GOSUB back_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO main_exit
k32:					' G
	TEMPO 230
	MUSIC "E"					
	GOTO main_exit
'================================================
battery:						' [ 10 x Value / 256 = Voltage]

	'GOSUB led_off
	V = AD(1)
	VOLT = V*100/256
	IF VOLT > 65 THEN
		GOSUB talk_phrase27
	ELSEIF VOLT >= 63 AND VOLT <= 65 THEN
		GOSUB talk_phrase28
	ELSEIF VOLT >= 60 AND VOLT <= 62 THEN
		GOSUB talk_phrase29
	ELSEIF VOLT < 60 THEN
		GOSUB talk_phrase30
	ENDIF
	DELAY 1000
	'GOSUB ready
	RETURN
'================================================
robot_tilt:	

	A = AD(0)
	IF A > 250 THEN RETURN
	IF A < 30 THEN GOTO tilt_low
	IF A > 180 THEN GOTO tilt_high
	RETURN
tilt_low:
	A = AD(0)
	IF A < 30 THEN
	GOTO forward_standup
	ENDIF
	RETURN
tilt_high:	
	A = AD(0)
	IF A > 180 THEN
	GOTO backward_standup
	ENDIF
	RETURN
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
bow_pose:
	MOVE G6A, 100,  58, 135, 160, 100, 100 
	MOVE G6D, 100,  58, 135, 160, 100, 100
	MOVE G6B, 100,  30,  80,  ,  ,  ,
	MOVE G6C, 100,  30,  80,  ,  ,  , 
	WAIT
	DELAY 1000
	RETURN
'================================================
standard_pose:
	MOVE G6A, 100,  76, 145,  93, 100, 100 
	MOVE G6D, 100,  76, 145,  93, 100, 105
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 98
	WAIT
	MOVE G6D, , , , , , 150
	DELAY 2000
	WAIT
	MOVE G6D, , , , , , 50
	DELAY 2000
	WAIT
	MOVE G6D, , , , , , 105
	RETURN
'================================================
'================================================
hans_up:
	SPEED 5
	MOVE G6A, 100,  76, 145,  93, 100
	MOVE G6D, 100,  76, 145,  93, 100	
	MOVE G6B, 100, 168, 150
	MOVE G6C, 100, 168, 150
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
sit_hans_up:
	SPEED 10
	MOVE G6A, 100, 151,  23, 140, 101, 100,
	MOVE G6D, 100, 151,  23, 140, 101, 100
	MOVE G6B, 100, 168, 150
	MOVE G6C, 100, 168, 150
	WAIT
	RETURN
'================================================
'================================================
foot_up:
	SPEED 5
	MOVE G6A,  85,  71, 152,  91, 112,  60,
	MOVE G6D, 112,  76, 145,  93,  92,  60,
	MOVE G6B, 100,  40,  80,    ,    ,    ,
	MOVE G6C, 100,  40,  80,    ,    ,    ,	
	WAIT   
	MOVE G6A,  90,  98, 105, 115, 115,  60,
	MOVE G6D, 116,  74, 145,  98,  93,  60,
	MOVE G6B, 100,  95, 100, 100, 100, 100,
	MOVE G6C, 100, 105, 100, 100, 100, 100,
	WAIT
	MOVE G6A, 100, 151,  23, 140, 115, 100,
	WAIT
	DELAY 1000
	MOVE G6A,  85,  71, 152,  91, 112,  60,
	MOVE G6D, 112,  76, 145,  93,  92,  60,
	WAIT
	RETURN
'================================================
'================================================
body_move:
	SPEED 6
	GOSUB body_move1
	GOSUB body_move2
	GOSUB body_move3
	MOVE G6A,  93,  76, 145,  94, 109, 100
	MOVE G6D,  93,  76, 145,  94, 109, 100
	MOVE G6B, 100,  105, 100, , , ,
	MOVE G6C, 100,  105, 100, , , ,
	WAIT
	MOVE G6A, 104, 112,  92, 116, 107
	MOVE G6D,  79,  81, 145,  95, 108
	MOVE G6B, 100, 105, 100
	MOVE G6C, 100, 105, 100
	WAIT
	MOVE G6A,  93,  76, 145,  94, 109, 100
	MOVE G6D,  93,  76, 145,  94, 109, 100
	MOVE G6B, 100,  105, 100, , , ,
	MOVE G6C, 100,  105, 100, , , ,
	WAIT
	MOVE G6D, 104, 112,  92, 116, 107
	MOVE G6A,  79,  81, 145,  95, 108
	MOVE G6B, 100, 105, 100
	MOVE G6C, 100, 105, 100
	WAIT
	MOVE G6A,  93,  76, 145,  94, 109, 100
	MOVE G6D,  93,  76, 145,  94, 109, 100
	MOVE G6B, 100,  105, 100, , , ,
	MOVE G6C, 100,  105, 100, , , ,
	WAIT
	GOSUB body_move3
	GOSUB body_move2
	GOSUB body_move1
RETURN
'================================================
body_move3:
	MOVE G6A, 93,  76, 145,  94, 109, 100
	MOVE G6D, 93,  76, 145,  94, 109, 100
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN
'================================================
body_move2:
	MOVE G6D,110,  92, 124,  97,  93,  70
	MOVE G6A, 76,  72, 160,  82, 128,  70
	MOVE G6B,100,  35,  90, , , ,
	MOVE G6C,100,  35,  90, , , ,
	WAIT
	RETURN
'================================================
body_move1:
	MOVE G6A, 85,  71, 152,  91, 112, 60
	MOVE G6D,112,  76, 145,  93,  92, 60
	MOVE G6B,100,  40,  80, , , ,
	MOVE G6C,100,  40,  80, , , ,	
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
right_shoot:
	SPEED 4
MOVE G6A,112,  56, 180,  79, 104, 100
MOVE G6D, 70,  56, 180,  79, 102, 100
MOVE G6B,110,  45,  70, 100, 100, 100
MOVE G6C, 90,  45,  70, 100, 100, 100
WAIT
right_shoot1:
	SPEED 6
MOVE G6A,115,  60, 180,  79,  95, 100
MOVE G6D, 90,  90, 127,  65, 116, 100
MOVE G6B, 80,  45,  70, 100, 100, 100
MOVE G6C,120,  45,  70, 100, 100, 100
WAIT
	SPEED 15
	HIGHSPEED SETON
right_shoot2:
MOVE G6A,115,  52, 180,  79,  95, 100
MOVE G6D, 90,  90, 127, 147, 116, 100
MOVE G6B,140,  45,  70, 100, 100, 100
MOVE G6C, 60,  45,  70, 100, 100, 100
WAIT
	DELAY 500
	HIGHSPEED SETOFF
right_shoot3:
	SPEED 5
MOVE G6A,115,  76, 145,  93, 102, 100
MOVE G6D, 70,  76, 145,  93, 104, 100
MOVE G6B,110,  45,  70, 100, 100, 100
MOVE G6C, 90,  45,  70, 100, 100, 100
WAIT
RETURN	
'================================================
left_shoot:
	SPEED 4
MOVE G6A, 70,  56, 180,  79, 102, 100
MOVE G6D,112,  56, 180,  79, 104, 100
MOVE G6B, 90,  45,  70, 100, 100, 100
MOVE G6C,110,  45,  70, 100, 100, 100
WAIT
left_shoot1:
	SPEED 6
MOVE G6A, 90,  90, 127,  65, 116, 100
MOVE G6D,115,  60, 180,  79,  95, 100
MOVE G6B,140,  45,  70, 100, 100, 100
MOVE G6C, 60,  45,  70, 100, 100, 100
WAIT
	SPEED 15
	HIGHSPEED SETON
left_shoot2:
MOVE G6A, 90,  90, 127, 147, 116, 100
MOVE G6D,115,  52, 180,  79,  95, 100
MOVE G6B, 60,  45,  70, 100, 100, 100
MOVE G6C,140,  45,  70, 100, 100, 100
WAIT
	DELAY 500
	HIGHSPEED SETOFF
left_shoot3:
	SPEED 5
MOVE G6A, 70,  76, 145,  93, 104, 100
MOVE G6D,115,  76, 145,  93, 102, 100
MOVE G6B, 90,  45,  70, 100, 100, 100
MOVE G6C,110,  45,  70, 100, 100, 100
WAIT
RETURN
'================================================
'================================================
handstanding:
	GOSUB fall_forward
	GOSUB standard_pose
	GOSUB foot_up2
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
foot_up2:
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
sit_down_pose26:
	IF A26 = 0 THEN GOTO standard_pose26

	A26 = 0
	SPEED 10
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100	
	WAIT

	RETURN
'================================================
standard_pose26:
	A26 = 1
	MOVE G6A,100,  76, 145,  93, 100, 100 
	MOVE G6D,100,  76, 145,  93, 100, 100  
	MOVE G6B,100,  30,  80, 100, 100, 100
	MOVE G6C,100,  30,  80, 100, 100, 100
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
'================================================
forward_tumbling:

SPEED 8
GOSUB standard_pose
MOVE G6A,100, 155,  20, 140, 100, 100
MOVE G6D,100, 155,  20, 140, 100, 100
MOVE G6B,130,  50,  85, 100, 100, 100
MOVE G6C,130,  50,  85, 100, 100, 100
WAIT

MOVE G6A, 60, 165,  30, 165, 155, 100
MOVE G6D, 60, 165,  30, 165, 155, 100
MOVE G6B,170,  10, 100, 100, 100, 100
MOVE G6C,170,  10, 100, 100, 100, 100
WAIT

MOVE G6A, 75, 165,  55, 165, 155, 100
MOVE G6D, 75, 165,  55, 165, 155, 100
MOVE G6B,185,  10, 100, 100, 100, 100
MOVE G6C,185,  10, 100, 100, 100, 100
WAIT

MOVE G6A, 80, 155,  85, 150, 150, 100
MOVE G6D, 80, 155,  85, 150, 150, 100
MOVE G6B,185,  40, 60,  100, 100, 100
MOVE G6C,185,  40, 60,  100, 100, 100
WAIT

MOVE G6A,100, 130, 120,  80, 110, 100
MOVE G6D,100, 130, 120,  80, 110, 100
MOVE G6B,130, 160,  10, 100, 100, 100
MOVE G6C,130, 160,  10, 100, 100, 100
WAIT

MOVE G6A,100, 160, 110, 140, 100, 100
MOVE G6D,100, 160, 110, 140, 100, 100
MOVE G6B,140,  70,  20, 100, 100, 100
MOVE G6C,140,  70,  20, 100, 100, 100
WAIT

SPEED 15
MOVE G6A,100,  56, 110,  26, 100, 100
MOVE G6D,100,  71, 177, 162, 100, 100
MOVE G6B,170,  40,  50, 100, 100, 100
MOVE G6C,170,  40,  50, 100, 100, 100
WAIT

MOVE G6A,100,  62, 110,  15, 100, 100
MOVE G6D,100,  71, 128, 113, 100, 100
MOVE G6B,190,  40,  50, 100, 100, 100
MOVE G6C,190,  40,  50, 100, 100, 100
WAIT

SPEED 15
MOVE G6A,100,  55, 110,  15, 100, 100
MOVE G6D,100,  55, 110,  15, 100, 100
MOVE G6B,190,  40,  50, 100, 100, 100
MOVE G6C,190,  40,  50, 100, 100, 100
WAIT

SPEED 10

MOVE G6A,100, 110, 100,  15, 100, 100
MOVE G6D,100, 110, 100,  15, 100, 100
MOVE G6B,170, 160, 115, 100, 100, 100
MOVE G6C,170, 160, 115, 100, 100, 100
WAIT

MOVE G6A,100, 170,  70,  15, 100, 100
MOVE G6D,100, 170,  70,  15, 100, 100
MOVE G6B,190, 170, 120, 100, 100, 100
MOVE G6C,190, 170, 120, 100, 100, 100
WAIT

MOVE G6A,100, 170,  30, 110, 100, 100
MOVE G6D,100, 170,  30, 110, 100, 100
MOVE G6B,190,  40,  60, 100, 100, 100
MOVE G6C,190,  40,  60, 100, 100, 100
WAIT

GOSUB sit_pose
GOSUB standard_pose
RETURN
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
back_tumbling:

SPEED 8
GOSUB standard_pose
MOVE G6A, 100, 170,  71,  23, 100, 100
MOVE G6D, 100, 170,  71,  23, 100, 100
MOVE G6B,  80,  50,  70, 100, 100, 100
MOVE G6C,  80,  50,  70, 100, 100, 100
WAIT

MOVE G6A, 100, 133,  71,  23, 100, 100
MOVE G6D, 100, 133,  71,  23, 100, 100
MOVE G6B,  10,  96,  15, 100, 100, 100
MOVE G6C,  10,  96,  14, 100, 100, 100
WAIT

MOVE G6A, 100, 133,  49,  23, 100, 100
MOVE G6D, 100, 133,  49,  23, 100, 100
MOVE G6B,  45, 116,  15, 100, 100, 100
MOVE G6C,  45, 116,  14, 100, 100, 100
WAIT

MOVE G6A, 100, 133,  49,  23, 100, 100
MOVE G6D, 100,  70, 180, 160, 100, 100
MOVE G6B,  45,  50,  70, 100, 100, 100
MOVE G6C,  45,  50,  70, 100, 100, 100
WAIT

SPEED 15
MOVE G6A, 100, 133, 180, 160, 100, 100
MOVE G6D, 100, 133, 180, 160, 100, 100
MOVE G6B,  10,  50,  70, 100, 100, 100
MOVE G6C,  10,  50,  70, 100, 100, 100
WAIT

HIGHSPEED SETON
MOVE G6A, 100,  95, 180, 160, 100, 100
MOVE G6D, 100,  95, 180, 160, 100, 100
MOVE G6B, 160,  50,  70, 100, 100, 100
MOVE G6C, 160,  50,  70, 100, 100, 100
WAIT

HIGHSPEED SETOFF

MOVE G6A, 100, 130, 120,  80, 110, 100
MOVE G6D, 100, 130, 120,  80, 110, 100
MOVE G6B, 130, 160,  10, 100, 100, 100
MOVE G6C, 130, 160,  10, 100, 100, 100
WAIT
	
GOSUB back_standing

RETURN
'================================================
back_standing:

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
left_forward:
	SPEED 7
	
	MOVE G6A,  85,  71, 152,  91, 107, 60  
	MOVE G6D, 108,  76, 145,  93, 100, 60 
	MOVE G6B, 130,  40,  80,  ,  ,  ,
	MOVE G6C,  70,  40,  80,  ,  ,  ,
	WAIT
	
	SPEED 12
	HIGHSPEED SETON
	
	MOVE G6A, 107, 164,  21, 125,  93
	MOVE G6D,  66, 163,  85,  65, 130	
	MOVE G6B, 189,  40,  77
	MOVE G6C,  50,  72,  86
	WAIT
	
	DELAY 1000
	HIGHSPEED SETOFF
	
	GOSUB sit_pose
	RETURN
	
'================================================
'================================================
right_forward:
	SPEED 7
	MOVE G6D,  85,  71, 152,  91, 107, 60  
	MOVE G6A, 108,  76, 145,  93, 100, 60 	
	MOVE G6C, 130,  40,  80,  ,  ,  ,
	MOVE G6B,  70,  40,  80,  ,  ,  ,
	WAIT
	
	SPEED 10
	HIGHSPEED SETON
	MOVE G6D, 107, 164,  21, 125,  93
	MOVE G6A,  66, 163,  85,  65, 130		
	MOVE G6C, 189,  40,  77
	MOVE G6B,  50,  72,  86
	WAIT
	
	DELAY 1000
	HIGHSPEED SETOFF
	
	GOSUB sit_pose
	RETURN	
'================================================
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
	
	RETURN
'================================================
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
	RETURN
'=================================================

'================================================
'SP03 SPEECH
'================================================

talk_phrase1: 'MY POWER IS ON
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H01 'Speak phrase 1
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase2: 'YES ALAN
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H02 'Speak phrase 2
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase3: 'OK, WHAT NEXT
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H03 'Speak phrase 3
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase4: 'SORRY PLEASE REPEAT THAT
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H04 'Speak phrase 4
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase5: 'GOODBYE ALAN
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H05 'Speak phrase 5
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase6: 'WHICH WAY
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H06 'Speak phrase 6
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase7: 'READY
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H07 'Speak phrase 7
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase8: 
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H08 'Speak phrase 8
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase9: 'HELLO ALAN
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H09 'Speak phrase 9
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase10: 'MY HANDS ARE NOW UP
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H0A 'Speak phrase 10
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase11: '
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H0B 'Speak phrase 11
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase12: 'OK
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H0C 'Speak phrase 12
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase13: '
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H0D 'Speak phrase 13
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase14: '
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H0E 'Speak phrase 14
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase15:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H0F 'Speak phrase 15
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase16:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H10 'Speak phrase 16
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase17:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H11 'Speak phrase 17
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase18:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H12 'Speak phrase 18
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase19:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H13 'Speak phrase 19
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase20:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H14 'Speak phrase 20
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase21:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H15 'Speak phrase 21
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase22:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H16 'Speak phrase 22
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase23:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H17 'Speak phrase 23
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase24:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H18 'Speak phrase 24
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase25:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H19 'Speak phrase 25
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase26: 
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H1A 'Speak phrase 26
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase27: 'MY BATTERY IS FULLY CHARGED
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H1B 'Speak phrase 27
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase28: 'MY BATTERY LEVEL IS GOOD
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H1C 'Speak phrase 28
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase29: 'MY BATTERY IS ETTING LOW
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H1D 'Speak phrase 29
	GOSUB I2cByteWrite
	RETURN
	
'================================================

talk_phrase30: 'MY BATTERY LEVEL IS VERY LOW. PLEASE RECHARGE ME
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H1E 'Speak phrase 30
	GOSUB I2cByteWrite
	RETURN
	
'================================================

FillSpeechBuffer_ready:
	GOSUB I2cStart 'Start sequence
	I2cBuf = I2cAddr
	GOSUB I2cOutByte 'Send SP03 address
	I2cBuf = 0
	GOSUB I2cOutByte 'Select Command Register
	GOSUB I2cOutByte 'Send NOP
	GOSUB I2cOutByte 'Max volume = Zero??
	I2cBuf = &H05
	GOSUB I2cOutByte 'Speech Speed
	I2cBuf = &H03
	GOSUB I2cOutByte 'Speech Pitch
	'** Followed by the ASCII characters (85 maximum) of the words you would like RN to say
	I2cBuf = &H52 'R
	GOSUB I2cOutByte
	I2cBuf = &H65 'e
	GOSUB I2cOutByte
	I2cBuf = &H61 'a
	GOSUB I2cOutByte
	I2cBuf = &H64 'd
	GOSUB I2cOutByte
	I2cBuf = &H79 'y
	GOSUB I2cOutByte
	I2cBuf = 0 'Nul
	GOSUB I2cOutByte
	GOSUB I2cStop
	DELAY 2
	RETURN
	
'================================================

FillSpeechBuffer_hello:
	GOSUB I2cStart 'Start sequence
	I2cBuf = I2cAddr
	GOSUB I2cOutByte 'Send SP03 address
	I2cBuf = 0
	GOSUB I2cOutByte 'Select Command Register
	GOSUB I2cOutByte 'Send NOP
	GOSUB I2cOutByte 'Max volume = Zero??
	I2cBuf = &H05
	GOSUB I2cOutByte 'Speech Speed
	I2cBuf = &H03
	GOSUB I2cOutByte 'Speech Pitch
	'** Followed by the ASCII characters (85 maximum) of the words you would like RN to say for example, Hello
	I2cBuf = &H48 'H
	GOSUB I2cOutByte
	I2cBuf = &H65 'e
	GOSUB I2cOutByte
	I2cBuf = &H6C 'l
	GOSUB I2cOutByte
	I2cBuf = &H6C 'l
	GOSUB I2cOutByte
	I2cBuf = &H06F 'o
	GOSUB I2cOutByte
	I2cBuf = 0 'Nul
	GOSUB I2cOutByte
	GOSUB I2cStop
	DELAY 2
	RETURN
	
'================================================

I2cByteWrite:
	GOSUB I2cStart
	I2cBuf = I2cAddr
	GOSUB I2cOutByte
	I2cBuf = I2cReg
	GOSUB I2cOutByte
	I2cBuf = I2cData
	GOSUB I2cOutByte
	GOSUB I2cStop
	RETURN
	
'================================================

I2cByteRead:
	GOSUB I2cStart
	I2cBuf = I2cAddr
	GOSUB I2cOutByte
	I2cBuf = I2cReg
	GOSUB I2cOutByte
	GOSUB I2cStart			'the required repeated start bit
	I2cBuf = I2cAddr OR 1
	GOSUB I2cOutByte
	GOSUB I2cInByte
	I2cData = I2cBuf
	GOSUB I2cStop
	RETURN
	
'================================================

I2cOutByte:
	FOR I2cBit = 0 TO 7
		I2cTx = I2cBuf AND &H80
		IF I2cTx <> 0 THEN 
			OUT SDA,1
		ELSE
			OUT SDA,0
		ENDIF
		'DELAY 1
		OUT SCL, 1
		'DELAY 1
		OUT SCL, 0
		'DELAY 1
		I2cBuf = I2cBuf << 1
	NEXT I2cBit
	OUT SDA, 0
	'DELAY 1
	OUT SCL, 1
	'DELAY 1
	OUT SCL, 0
	RETURN
	
'================================================

I2cInByte:
	I2cBuf =0
	OUT SDA, 1
	I2cRx = IN(SDA)
	FOR I2cBit = 0 TO 7
		OUT SCL, 1
		'DELAY 1
		I2cRx = IN(SDA)
		OUT SCL, 0
		'DELAY 1
		I2cBuf = I2cBuf << 1
		IF I2cRx <> 0 THEN
			I2cBuf = I2cBuf +1
		ENDIF
		'DELAY 1
	NEXT I2cBit
	OUT SDA, 0
	'DELAY 1
	OUT SCL, 1
	'DELAY 1
	OUT SCL, 0
	'DELAY 1
	RETURN
	
'================================================

I2cStart:
	OUT SDA,1
	'DELAY 1
	OUT SCL,1
	'DELAY 1
	OUT SDA,0
	'DELAY 1
	OUT SCL,0
	'DELAY 1
	RETURN
	
'================================================

I2cStop:
	OUT SCL,1
	'DELAY 1
	OUT SDA,1
	RETURN
	
'================================================
'================================================
