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
DIM I AS BYTE

CONST ID = 0    ' 1:0, 2:32, 3:64, 4:96

'== Action command check (50 - 82)
IF RR > 50 AND RR < 83 THEN GOTO action_proc 

RR = 0

PTP SETON 				
PTP ALLON				

'== motor diretion setting ======================
DIR G6A,1,0,0,1,0,0		
DIR G6B,1,1,1,1,1,1		
DIR G6C,0,0,0,0,0,0		
DIR G6D,0,1,1,0,1,0		


'== motor start position read ===================
TEMPO 230
MUSIC "CDE"
GETMOTORSET G24,1,1,1,1,1,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,1,1,0
'== motor power on  =============================
SPEED 5
MOTOR G24	
GOSUB standard_pose
'================================================
MAIN:
'GOSUB robot_voltage
'GOSUB robot_tilt

'-----------------------------
IF RR = 0 THEN GOTO MAIN1

ON RR GOTO MAIN,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32
GOTO main_exit
'-----------------------------
MAIN1:
A = REMOCON(1)  
A = A - ID	
ON A GOTO MAIN,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32
GOTO MAIN
'-------------------------------------------------
action_proc:
A = RR - 50
ON A GOTO MAIN,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32
RETURN
'-----------------------------
main_exit:
	IF RR > 50 THEN RETURN
	RR = 0
	GOTO MAIN
'================================================

k1:
	GOSUB fast_run
	GOSUB standard_pose
	GOTO main_exit
k2:
	GOSUB fast_turn_right
	DELAY 1000
	GOSUB standard_pose
	GOTO main_exit
k3:
	GOSUB fast_turn_left
	DELAY 1000
	GOSUB standard_pose
	GOTO main_exit
k4:
	GOSUB avoid_matrix
	DELAY 1000
	GOSUB standard_pose
	GOTO main_exit
k5:
	GOSUB goalkeeper
	GOSUB standard_pose
	GOTO main_exit
k6:
	GOSUB cheer_up
	GOSUB standard_pose
	GOTO main_exit
k7:
	GOSUB single_foot_standing
	GOSUB standard_pose
	GOTO main_exit
k8:
	GOSUB hand_clapping
	GOSUB standard_pose	
	GOTO main_exit
k9:
	GOSUB hand_shaking
	GOSUB standard_pose
	GOTO main_exit	
k10:
	GOSUB break_dance
	GOSUB standard_pose
	GOTO main_exit	
	
k11:					' ^ 1
	GOSUB sit_forward_walking
	GOSUB standard_pose
	GOTO main_exit	
k12:					' _ 1
	GOSUB sit_backward_walking
	GOSUB standard_pose
	GOTO main_exit
k13:					' > 1
	
	GOSUB sit_left_walking
	GOSUB standard_pose
	GOTO main_exit
k14:					' < 1
	
	GOSUB sit_right_walking
	GOSUB standard_pose
	GOTO main_exit
	
k15:					' A
	GOSUB standard_pose
	GOTO main_exit
k16:	
	GOSUB standard_pose
	GOTO main_exit 
	
k17:					' C
	
	GOSUB standard_pose
	GOTO main_exit
k18:					' E
	GOSUB dance1
	GOTO main_exit
k19:					' P2
	GOSUB standard_pose
	GOTO main_exit
k20:					' B	
	GOSUB standard_pose
	GOTO main_exit
k21:					' ^ 2
	GOSUB standard_pose	
	GOTO main_exit	
k22:					' *	
	GOSUB standard_pose
	GOTO main_exit

k23: GOSUB dance2					' F
	
	GOSUB standard_pose	

	GOTO main_exit
k24:					' #		
			
	GOSUB standard_pose	
	GOTO main_exit
k25:					' P1
	GOSUB upstair
	GOSUB standard_pose
	GOTO main_exit
k26:
	GOSUB push_up					' [] 1	
	GOSUB standard_pose
	GOTO main_exit
k27:					' D
	GOSUB standard_pose
	GOTO main_exit	
k28:					' < 2
	GOSUB standard_pose
	GOTO main_exit		
k29:					' [] 2
	GOSUB standard_pose
	GOTO main_exit	
k30:					' > 2
	GOSUB standard_pose
	GOTO main_exit
k31:					' _ 2
	 
	GOSUB standard_pose
	GOTO main_exit

k32:					' G
	GOSUB dance3
	GOSUB standard_pose
	GOTO main_exit	

	
'================================================
robot_voltage:						' [ 10 x Value / 256 = Voltage]
	A = AD(6)
	TEMPO 230
	IF A < 133 THEN MUSIC "G"		' 6.25 Volt
	RETURN
'================================================
robot_tilt:	
	A = AD(5)
	IF A > 250 THEN RETURN
	  
	IF A < 30 THEN GOTO tilt_low
	IF A > 200 THEN GOTO tilt_high
	
	RETURN
tilt_low:
	A = AD(5)
	'IF A < 30 THEN  GOTO forward_standup
'	IF A < 30 THEN  GOTO backward_standup
	RETURN
tilt_high:	
	A = AD(5)
	'IF A > 200 THEN GOTO backward_standup
'	IF A > 200 THEN GOTO forward_standup
	RETURN
'================================================

fast_run:

PTP SETOFF
PTP ALLOFF

HIGHSPEED SETON

SPEED 5

	MOVE G6A,  99,  74, 145,  93, 101
	MOVE G6D,  99,  74, 145,  93, 101
	WAIT

DELAY 200
	
fast_run_1:

	MOVE G6D,  99,  86, 126, 113, 101'rising right foot
	MOVE G6A,  99,  82, 140,  91, 101'rising left foot(reach out right foot)	
	MOVE G6D,  99,  73, 140,  99, 101'take down right foot
		
	MOVE G6A,  99,  86, 128, 112, 101'rising left foot
	MOVE G6D,  99,  82, 140,  92, 101'rear right foot(reach out left foot)
	MOVE G6A,  99,  73, 140,  99, 101'take down left foot


'GOTO fast_run_1						  	

	MOVE G6D,  94,  92, 126, 119, 101'rising right foot
	MOVE G6D,  99,  70, 140, 103, 101'take down right foot
	
	'standard pose
	MOVE G6A, 99,  76, 145,  93, 101 
	MOVE G6D, 99,  76, 145,  93, 101
	
WAIT	
	
RETURN


'================================================	

fast_turn_right:
HIGHSPEED SETON
SPEED 6

	MOVE G6D, 99,  86, 165,  98, 101
	MOVE G6A, 99,  66, 125,  88, 106
	WAIT


'standard pose
	MOVE G6D, 99,  76, 145,  93, 101
	MOVE G6A, 99,  76, 145,  93, 101
	WAIT

HIGHSPEED SETOFF
RETURN


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

avoid_matrix:
SPEED 10
GOSUB standard_pose

'DELAY 1000
MOVE G6A, 72, 165,  23,  70, 143, 100
MOVE G6D, 72, 165,  23,  70, 143, 100
MOVE G6B,170, 100, 100, 100, 100, 100
MOVE G6C,170, 100, 100, 100, 100, 100


MOVE G6A, 79, 160,  23,  42, 185, 100
MOVE G6D, 79, 160,  23,  42, 185, 100
WAIT

DELAY 4000

SPEED 6
MOVE G6A, 72, 165,  23,  70, 143, 100
MOVE G6D, 72, 165,  23,  70, 143, 100
MOVE G6B,170, 50, 70, 100, 100, 100
MOVE G6C,170, 50, 70, 100, 100, 100
WAIT

MOVE G6A,100, 151,  23, 140, 101, 100
MOVE G6D,100, 151,  23, 140, 101, 100
MOVE G6B,100,  30,  80, , , 
MOVE G6C,100,  30,  80, , , 
WAIT

SPEED 8
GOSUB standard_pose

RETURN

'================================================	

goalkeeper:
SPEED 8
MOVE G6A, 58,  75, 148,  93, 190,  70
MOVE G6D, 58,  75, 148,  93, 190,  70
MOVE G6B,100, 110, 110, 100, 100, 100
MOVE G6C,100, 110, 110, 100, 100, 100
WAIT
DELAY 300

SPEED 5
MOVE G6A, 58,  75, 148,  30, 150,  70
MOVE G6D, 58,  75, 148,  30, 150,  70
MOVE G6B, 100, 180, 140, 100, 100, 100
MOVE G6C, 100, 180, 140, 100, 100, 100
WAIT
SPEED 10
DELAY 300
GOSUB standard_pose
GOSUB backward_standup
RETURN


backward_standup:

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

single_foot_standing:
SPEED 5
MOVE G6A,113,  56, 182,  75,  90, 60
MOVE G6D, 73,  56, 182,  75, 116, 60
MOVE G6B,100, 100, 100, 100, 100, 100
MOVE G6C,100,  40,  90, 100, 100, 100
WAIT

MOVE G6A,114,  56, 181,  75, 90, 100
MOVE G6D, 80, 155,  23, 135, 117, 100
MOVE G6B,100, 110, 100, 100, 100, 100
MOVE G6C,100, 110, 100, 100, 100, 100
WAIT
SPEED 2
MOVE G6A,108,  56, 181,  75, 133, 100
MOVE G6D, 80, 155,  23, 135, 155, 100
MOVE G6B,100, 140, 100, 100, 100, 100
MOVE G6C,100, 154, 100, 100, 100, 100
WAIT
DELAY 200
SPEED 2
MOVE G6A,110,  56, 181,  75, 133, 100
MOVE G6D,100,  59, 170,  85, 155, 100
MOVE G6B,100, 105, 100, 100, 100, 100
MOVE G6C,100, 154, 100, 100, 100, 100
WAIT

DELAY 1000
SPEED 10
FOR i = 0 TO 5
MOVE G6C,100, 174, 100, 100, 100, 100
WAIT
MOVE G6C,100, 134, 100, 100, 100, 100
WAIT
NEXT i
DELAY 3000
SPEED 3
MOVE G6A,110,  56, 181,  75, 133, 100
MOVE G6D, 80, 155,  23, 135, 155, 100
MOVE G6B,100, 110, 100, 100, 100, 100
MOVE G6C,100, 154, 100, 100, 100, 100
WAIT

DELAY 1000
MOVE G6A,114,  56, 181,  75, 90, 60
MOVE G6D, 80, 155,  23, 135, 117, 60
MOVE G6B,100, 120, 100, 100, 100, 100
MOVE G6C,100, 170, 100, 100, 100, 100
WAIT
SPEED 10
MOVE G6A,114,  56, 182,  75,  90, 100
MOVE G6D, 73,  56, 182,  75, 116, 100
MOVE G6B,100, 120, 100, 100, 100, 100
MOVE G6C,100,  40,  90, 100, 100, 100
WAIT

GOSUB standard_pose

RETURN

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

'================================================	


hand_shaking:

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

break_dance:

GOSUB front_lie_down
SPEED 6
MOVE G6A,100, 125,  65,  10, 100  
MOVE G6D,100, 125,  65,  10, 100 
MOVE G6B, 110,  30,  80,  ,  ,  , 
MOVE G6C,110,  30,  80,  ,  ,  , 
 

SPEED 3
MOVE G6A,100, 125,  65,  10, 100,  
MOVE G6D, 100, 125,  65,  10, 100 
MOVE G6B, 170,  30,  80,  ,  ,  ,
MOVE G6C, 170,  30,  80,  ,  ,  , 
WAIT

DELAY 200
SPEED 6
MOVE G6A,100,  89, 129,  57, 100,  
MOVE G6D, 100,  89, 129,  57, 100 
MOVE G6B, 180,  30,  80,  ,  ,  ,
MOVE G6C, 180,  30,  80,  ,  ,  , 

WAIT

MOVE G6A,100,  64, 179,  57, 100,  
MOVE G6D, 100,  64, 179,  57, 100 
MOVE G6B, 190,  50,  80,  ,  ,  ,
MOVE G6C, 190,  50,  80,  ,  ,  , 
WAIT
DELAY 500

MOVE G6A,100,  64, 179,  57, 160,  
MOVE G6D, 100,  64, 179,  57, 160 
WAIT

DELAY 1000

SPEED 3
MOVE G6A,100,  64, 179,  17, 160,  
MOVE G6D, 100,  64, 179,  97, 160 
WAIT

DELAY 1000

MOVE G6A,100,  64, 179,  97, 160,  
MOVE G6D, 100,  64, 179,  17, 160 
WAIT

DELAY 1000


MOVE G6A,100,  64, 179,  57, 160,  
MOVE G6D, 100,  64, 179,  57, 160 
WAIT
DELAY 500
SPEED 7

MOVE G6A,100,  64, 179,  57, 100  
MOVE G6D,100,  64, 179,  57, 100  
WAIT

MOVE G6A,100,  64, 179,  57, 190  
MOVE G6D,100,  64, 179,  57, 190  
WAIT

MOVE G6A,100,  64, 179,  57, 100  
MOVE G6D,100,  64, 179,  57, 100  
WAIT
DELAY 1000

MOVE G6B, 190,  50,  80,  ,  ,  , 
MOVE G6C,190,  50,  80,  ,  ,  , 
WAIT

MOVE G6A,100,  89, 129,  57, 100,  
MOVE G6D,100,  89, 129,  57, 100  
MOVE G6B, 180,  30,  80,  ,  ,  ,
MOVE G6C, 180,  30,  80,  ,  ,  , 
WAIT

SPEED 3
MOVE G6A,100, 125,  65,  10, 100,  
MOVE G6D, 100, 125,  65,  10, 100  
MOVE G6B, 170,  30,  80,  ,  ,  ,
MOVE G6C, 170,  30,  80,  ,  ,  , 
WAIT

SPEED 6
MOVE G6A,100, 125,  65,  10, 100,  
MOVE G6D, 100, 125,  65,  10, 100 
MOVE G6B, 110,  30,  80,  ,  ,  ,
MOVE G6C, 110,  30,  80,  ,  ,  , 
WAIT
 
GOSUB standard_pose 

GOSUB back_raise


RETURN


back_raise:
	SPEED 10
	'GOSUB 기본자세
	
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
	'DELAY 100
	
	GOSUB standard_pose 
	
	RETURN


front_lie_down:

	SPEED 10
	MOVE G6A,100, 155,  25, 140, 100, 100
	MOVE G6D,100, 155,  25, 140, 100, 100
	MOVE G6B,130,  50,  85, 100, 100, 100
	MOVE G6C,130,  50,  85, 100, 100, 100
	WAIT
	
	MOVE G6A, 60, 165,  25, 160, 145, 100
	MOVE G6D, 60, 165,  25, 160, 145, 100
	MOVE G6B,150,  60,  90, 100, 100, 100
	MOVE G6C,150,  60,  90, 100, 100, 100
	WAIT
	
	MOVE G6A, 60, 165,  30, 165, 155, 100
	MOVE G6D, 60, 165,  30, 165, 155, 100
	MOVE G6B,170,  10, 100, 100, 100, 100
	MOVE G6C,170,  10, 100, 100, 100, 100
	WAIT
	SPEED 3

	
	MOVE G6A, 75, 165,  55, 165, 155, 100
	MOVE G6D, 75, 165,  55, 165, 155, 100
	MOVE G6B,185,  10, 100, 100, 100, 100
	MOVE G6C,185,  10, 100, 100, 100, 100
	WAIT
	SPEED 10

	
	MOVE G6A, 80, 155,  85, 150, 150, 100
	MOVE G6D, 80, 155,  85, 150, 150, 100
	MOVE G6B,185,  40, 60,  100, 100, 100
	MOVE G6C,185,  40, 60,  100, 100, 100
	WAIT
		
	MOVE G6A,100, 130, 120,  80, 110, 100
	MOVE G6D,100, 130, 120,  80, 110, 100
	MOVE G6B,125, 160,  10, 100, 100, 100
	MOVE G6C,125, 160,  10, 100, 100, 100
	WAIT	
	
	GOSUB standard_pose
	
	RETURN

'-------------------------------------

dance1:

	SPEED 15
	WAIT

	FOR a = 0 TO 2
	MOVE G6A, 85,  76, 145,  93, 100, 100
	MOVE G6D, 85,  76, 145,  93, 100, 100
	MOVE G6B, 100, 55, 55,  ,  ,  ,
	MOVE G6C, 100, 55, 55,  ,  ,  , 
	WAIT

	MOVE G6D, 100,  76, 145,  93, 100, 100
	MOVE G6A, 100,  76, 145,  93, 100, 100
	MOVE G6C, 100, 45, 65,  ,  ,  ,
	MOVE G6B, 100, 45, 65,  ,  ,  , 
	WAIT
	DELAY 100
	NEXT a
	
	DELAY 200
	
	FOR a = 0 TO 2
	MOVE G6A, 85,  76, 145,  93, 100, 100
	MOVE G6D, 85,  76, 145,  93, 100, 100
	MOVE G6B, 100, 55, 55,  ,  ,  ,
	MOVE G6C, 100, 55, 55,  ,  ,  , 
	WAIT

	MOVE G6D, 100,  76, 145,  93, 100, 100
	MOVE G6A, 100,  76, 145,  93, 100, 100
	MOVE G6C, 100, 45, 65,  ,  ,  ,
	MOVE G6B, 100, 45, 65,  ,  ,  , 
	WAIT
	DELAY 100
	NEXT a
	
	FOR a = 0 TO 2
	MOVE G6A, 85,  76, 145,  93, 100, 100
	MOVE G6D, 85,  76, 145,  93, 100, 100
	MOVE G6B, 100, 55, 55,  ,  ,  ,
	MOVE G6C, 100, 55, 55,  ,  ,  , 
	WAIT

	MOVE G6D, 100,  76, 145,  93, 100, 100
	MOVE G6A, 100,  76, 145,  93, 100, 100
	MOVE G6C, 100, 45, 65,  ,  ,  ,
	MOVE G6B, 100, 45, 65,  ,  ,  , 
	WAIT
	DELAY 100
	NEXT a
	
	DELAY 200


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

'================================================	


dance2:

	SPEED 15

	FOR a = 0 TO 2
	MOVE G6A,101,  76, 145,  93, 100, 100
	MOVE G6D, 99,  76, 145,  93, 100, 102
	MOVE G6B, 100, 145, 180,  ,  ,  ,
	MOVE G6C, 100, 100, 145,  ,  ,  , 
	WAIT

	MOVE G6D,101,  76, 145,  93, 100, 100
	MOVE G6A, 99,  76, 145,  93, 100, 102
	MOVE G6C, 100, 145, 180,  ,  ,  ,
	MOVE G6B, 100, 120, 145,  ,  ,  , 
	WAIT
		DELAY 100
	NEXT a
	
	DELAY 100
	
	FOR a = 0 TO 2
	MOVE G6A,101,  76, 145,  93, 100, 100
	MOVE G6D, 99,  76, 145,  93, 100, 102
	MOVE G6B, 100, 145, 180,  ,  ,  ,
	MOVE G6C, 100, 120, 145,  ,  ,  , 
	WAIT

	MOVE G6D,101,  76, 145,  93, 100, 100
	MOVE G6A, 99,  76, 145,  93, 100, 102
	MOVE G6C, 100, 145, 180,  ,  ,  ,
	MOVE G6B, 100, 120, 145,  ,  ,  , 
		DELAY 100
	WAIT
	NEXT a
	
	DELAY 100
	
	FOR a = 0 TO 2
	MOVE G6A,101,  76, 145,  93, 100, 100
	MOVE G6D, 99,  76, 145,  93, 100, 102
	MOVE G6B, 100, 145, 180,  ,  ,  ,
	MOVE G6C, 100, 120, 145,  ,  ,  , 
	WAIT

	MOVE G6D,101,  76, 145,  93, 100, 100
	MOVE G6A, 99,  76, 145,  93, 100, 102
	MOVE G6C, 100, 145, 180,  ,  ,  ,
	MOVE G6B, 100, 120, 145,  ,  ,  , 
	WAIT
	NEXT a	
	
	RETURN

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

sit_forward_walking:
	SPEED 10
	MOVE G6B,100,  35,  80, 100, 100, 100
	MOVE G6C,100,  35,  80, 100, 100, 100
	WAIT
	
	FOR I = 0 TO 3
	
	MOVE G6A,115, 150,  24, 140,  94, 100
	MOVE G6D, 86, 151,  26, 140, 110, 100
	WAIT
	
	MOVE G6A,100, 160,  25, 133, 100, 100
	MOVE G6D,100, 131,  26, 162, 100, 100
	WAIT
	
	MOVE G6A, 86, 151,  26, 140, 110, 100
	MOVE G6D,115, 150,  24, 140,  94, 100
	WAIT
	
	MOVE G6A,100, 131,  26, 162, 100, 100
	MOVE G6D,100, 160,  25, 133, 100, 100
	WAIT
	
	NEXT I
	
	SPEED 8
	MOVE G6A,115, 150,  24, 140,  94, 100
	MOVE G6D, 86, 151,  26, 140, 110, 100
	WAIT
	
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	WAIT
	
	RETURN
	
'================================================	

sit_backward_walking:
	SPEED 10
	MOVE G6B,100,  35,  80, 100, 100, 100
	MOVE G6C,100,  35,  80, 100, 100, 100
	WAIT
	
	FOR I = 0 TO 3
	
	MOVE G6A,115, 150,  24, 140,  94, 100
	MOVE G6D, 86, 151,  26, 140, 110, 100
	WAIT
	
	MOVE G6A,100, 131,  26, 162, 100, 100
	MOVE G6D,100, 160,  25, 133, 100, 100
	WAIT
	
	
	MOVE G6A, 86, 151,  26, 140, 110, 100
	MOVE G6D,115, 150,  24, 140,  94, 100
	WAIT
	
	MOVE G6A,100, 160,  25, 133, 100, 100
	MOVE G6D,100, 131,  26, 162, 100, 100
	WAIT
	
	NEXT I
	
	SPEED 8
	MOVE G6A,115, 150,  24, 140,  94, 100
	MOVE G6D, 86, 151,  26, 140, 110, 100
	WAIT
	
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	WAIT
	RETURN

'================================================
sit_right_walking:
	SPEED 8
	MOVE G6A, 86, 151,  23, 140, 105, 100
	MOVE G6D,112, 150,  23, 140, 100, 100
	MOVE G6B,100,  40,  75, 100, 100, 100
	MOVE G6C,100,  40,  75, 100, 100, 100
	WAIT
	
	MOVE G6A, 86, 151,  26, 140, 115, 100
	MOVE G6D, 86, 151,  26, 140, 115, 100
	WAIT
	
	'SPEED 10
	MOVE G6A,118, 154,  24, 140, 95, 100
	MOVE G6D, 80, 154,  24, 140, 110, 100
	'MOVE G6B,100,  70,  75, 100, 100, 100
	WAIT
	
	SPEED 8
	MOVE G6A,100, 151,  23, 140, 101, 100
	MOVE G6D,100, 151,  23, 140, 101, 100
	MOVE G6B,100,  30,  80, , , 
	MOVE G6C,100,  30,  80, , , 
	WAIT
	
	RETURN
	
'================================================

sit_left_walking:
	SPEED 8 
	MOVE G6A,112, 150,  24, 140, 100, 100
	MOVE G6D, 86, 151,  24, 140, 105, 100
	MOVE G6B,100,  40,  75, 100, 100, 100
	MOVE G6C,100,  40,  75, 100, 100, 100
	WAIT
	
	MOVE G6A, 86, 150,  24, 140, 115, 100
	MOVE G6D, 86, 151,  24, 140, 115, 100
	WAIT
	
	MOVE G6A, 86, 151,  24, 140, 105, 100
	MOVE G6D,115, 150,  24, 140, 100, 100
	WAIT
	
	SPEED 5
	GOSUB sit_position
	RETURN	
	
	
'================================================

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






upstair:

SPEED 3
MOVE G24,  85,  75, 145,  93, 115,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 115,  75, 145,  93,  85,  

SPEED 5
MOVE G24,  82, 115,  65, 133, 118,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 115,  75, 145,  93,  85,  
MOVE G24,  90,  85,  75, 153, 110,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 115,  75, 145,  93,  85,  
MOVE G24,  90,  55, 105, 163, 110,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 115,  75, 145,  93,  85,  
MOVE G24, 100,  15, 145, 153, 105,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 115,  75, 145,  93,  85,  
MOVE G24, 100,  15, 145, 153, 105,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 110,  95, 125,  93,  90,  

DELAY 100

SPEED 4
MOVE G24, 115, 115,  45, 148,  85,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  ,  85, 110, 170,  20, 115,  
MOVE G24, 115, 125,  75, 128,  85,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  ,  85,  70, 175,  40, 115,  

DELAY 100

SPEED 5
MOVE G24, 115,  75, 145, 113,  85,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  ,  85, 110, 175,  20, 115,  
MOVE G24, 115,  75, 145, 113,  85,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  ,  85, 110,  95, 100, 115,  
MOVE G24, 115,  75, 145, 103,  85,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  ,  85,  98, 105, 120, 115,  

MOVE G24, 115,  75, 145,  93,  85,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  ,  85,  75, 145,  93, 115,  
	
SPEED 2

MOVE G24, 100,  75, 145,  93, 100,  , 100,  45,  70,  ,  ,  , 100,  45,  70,  ,  ,  , 100,  75, 145,  93, 100,  
MOVE G24, 100,  76, 145,  93, 100,  , 100,  30,  80,  ,  ,  , 100,  30,  80,  ,  ,  , 100,  76, 145,  93, 100,  

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
