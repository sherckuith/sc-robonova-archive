GOTO AUTO
FILL 255,10000

DIM A AS BYTE
DIM A16 AS BYTE
DIM A26 AS BYTE
DIM I AS BYTE

DIM RC0 AS BYTE		 'RECEIVER PORT 1
DIM RC1 AS BYTE 		 'RECEIVER PORT 2
DIM RC2 AS BYTE 		 'RECEIVER PORT 3
DIM RC3 AS BYTE		 'RECEIVER PORT 4
DIM X10 AS BYTE
DIM X1 AS BYTE
DIM RCRX AS BYTE
DIM TEMP AS BYTE





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
GOTO main
'---------------------------------------------------
MAIN:

'gosub robot_voltage
'gosub robot_tilt
GOSUB RC_CHECK

ON RCRX GOTO main,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17,key18,key19,key20,key21,key22,key23,key24,key25,key26,key27,key28,key29,key30,key31,key32,key33,key34,key35,key36,key37,key38,key39,key40,key41,key42,key43,key44,key45,key46,key47,key48,key49,key50,key51,key52,key53,key54,key55,key56,key57,key58,key59,key60,key61,key62,key63,key64,key65,key66,key67,key68,key69,key70,key71,key72,key73,key74,key75,key76,key77,key78,key79,key80,key81,key82,key83,key84,key85,key86,key87,key88

GOTO MAIN

'============================================================================

'Key routines
'After each key, add GOSUB AND the sub-routine you want TO RUN. Add the GOSUB before the GOTO MAIN. FOR example: GOSUB standup
'============================================================================
key1:
	SPEED 8
	GOSUB right_shift
	SPEED 6
	GOSUB standard_pose
	GOTO MAIN
key2:

	GOTO MAIN
key3:
	GOSUB backward_walk
	GOSUB standard_pose	
	GOTO MAIN
key4:

	GOTO MAIN
key5:
	SPEED 8
	GOSUB left_shift
	SPEED 6
	GOSUB standard_pose
	GOTO MAIN
key6:
	GOSUB left_turn
	GOSUB standard_pose
	GOTO MAIN
key7:
	GOSUB forward_walk
	GOSUB standard_pose
	GOTO MAIN
key8:
	GOSUB right_turn
	GOSUB standard_pose	
	GOTO MAIN
key9:
'not used
GOTO MAIN
key10:
	GOSUB righ_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO MAIN
key11:

	GOTO MAIN
key12:

	GOTO MAIN
key13:
	GOSUB pushup	
	GOTO MAIN
key14:

	GOTO MAIN
key15:
	
	GOTO MAIN
key16:

	GOTO MAIN
key17:
	GOSUB right_attack
	GOSUB standard_pose
	GOTO MAIN
key18:

	GOTO MAIN
key19:
'NOT USED
GOTO MAIN
key20:
	GOSUB right_shoot
	GOSUB standard_pose
	DELAY 500
	GOSUB left_shoot
	GOSUB standard_pose	
	DELAY 500
	GOTO MAIN
key21:

	GOTO MAIN
key22:
	GOSUB bow_pose
	GOSUB standard_pose
	GOTO MAIN
key23:
	GOSUB hans_up
	DELAY 500
	GOSUB standard_pose
	GOTO MAIN
key24:
	GOSUB sit_down_pose26
GOTO MAIN
key25:
	GOSUB sit_hans_up
	DELAY 1000
	GOSUB standard_pose
	GOTO MAIN
key26:
	GOSUB foot_up
	GOSUB standard_pose
	GOTO MAIN
key27:
	GOSUB body_move
	GOSUB standard_pose
	GOTO MAIN
key28:

	GOTO MAIN
key29:
'NOT USED
GOTO MAIN
key30:
	GOSUB back_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO MAIN
key31:

	GOTO MAIN
key32:

	GOTO MAIN
key33:
	GOSUB forward_punch
	SPEED 10
	GOSUB standard_pose
	GOTO MAIN
key34:

	GOTO MAIN
key35:

	GOTO MAIN
key36:

	GOTO MAIN
key37:
	GOSUB forward_standup
	GOSUB standard_pose
	GOTO MAIN
key38:

	GOTO MAIN
key39:
'NOT USED
GOTO MAIN
key40:

	GOTO MAIN
key41:

	GOTO MAIN
key42:

	GOTO MAIN
key43:

	GOTO MAIN
key44:

	GOTO MAIN
key45:

	GOTO MAIN
key46:

	GOTO MAIN
key47:

	GOTO MAIN
key48:

	GOTO MAIN
key49:
'NOT USED
GOTO MAIN
key50:
	GOSUB left_tumbling
	SPEED 10
	GOSUB standard_pose
	GOTO MAIN
key51:

	GOTO MAIN
key52:

	GOTO MAIN
key53:
	GOSUB pickup
	GOTO MAIN
key54:

	GOTO MAIN
key55:

	GOTO MAIN
key56:

	GOTO MAIN
key57:
	GOSUB left_attack
	GOSUB standard_pose
	GOTO MAIN
key58:

	GOTO MAIN
key59:
'NOT USED
GOTO MAIN
key60:
	SPEED 8
	GOSUB handstanding
	DELAY 1000
	SPEED 6
	GOSUB standard_pose
	GOTO MAIN
key61:

	GOTO MAIN
key62:

	GOTO MAIN
key63:

	GOTO MAIN
key64:

	GOTO MAIN
key65:

	GOTO MAIN
key66:

	GOTO MAIN
key67:
	GOSUB left_forward
	GOSUB standard_pose
	GOTO MAIN
key68:

	GOTO MAIN
key69:
'NOT USED
GOTO MAIN
key70:
	GOSUB forward_tumbling
	GOSUB standard_pose	
	GOTO MAIN
key71:

	GOTO MAIN
key72:

	GOTO MAIN
key73:
	GOSUB backward_standup
	GOSUB standard_pose
	GOTO MAIN
key74:

	GOTO MAIN
key75:

	GOTO MAIN

key76:

	GOTO MAIN
key77:

	GOTO MAIN
key78:

	GOTO MAIN
key79:
'NOT USED
GOTO MAIN
key80:
	GOSUB wing_move
	GOSUB standard_pose
	GOTO MAIN
key81:

	GOTO MAIN
key82:

	GOTO MAIN
key83:

	GOTO MAIN
key84:

	GOTO MAIN
key85:

	GOTO MAIN
key86:

	GOTO MAIN
key87:
	GOSUB right_forward
	GOSUB standard_pose
	GOTO MAIN
key88:
	GOSUB sit_down_pose16
	GOTO MAIN
'================================================================
' RC Data 
'----------------------------------------------------------------
' This is the pulse vaule from the rx. Differnet tx and rx combos supply different size pulses.

CONST PMIN = 30	'ADDED AS CONSTANT FOR QUICK ADJUSTMENT.
CONST PMAX = 160	'ADDED AS CONSTANT FOR QUICK ADJUSTMENT
'-------------------------------
RC_CHECK:

RCRX = 0
X10 = 0
X1 = 0
'if a pulse value falls within the range, move to RC_GET subroutine.

	TEMP = RCIN(0)
IF TEMP < PMIN OR TEMP > PMAX THEN GOTO RC_GET

	TEMP = RCIN(1)	
IF TEMP < PMIN OR TEMP > PMAX THEN GOTO RC_GET

	TEMP = RCIN(2)
IF TEMP < PMIN OR TEMP > PMAX THEN GOTO RC_GET

	TEMP = RCIN(3)
IF TEMP < PMIN OR TEMP > PMAX THEN GOTO RC_GET

	RETURN
'==================================================================
RC_GET:

DELAY 200

RC0 = RCIN(0)   'RX PORT 1 -- AD PORT 0
RC2 = RCIN(1)	'RX PORT 3 -- AD PORT 1
RC1 = RCIN(2)	'RX PORT 2 -- AD PORT 1
RC3 = RCIN(3)	'RX PORT 4 -- AD PORT 2


IF RC0<PMIN AND RC2<PMIN THEN 
X10 = 4

	ELSEIF RC0<PMIN AND RC2>PMAX THEN
	X10 = 6
		
		ELSEIF RC0>PMAX AND RC2<PMIN THEN
		X10 = 2
		
			ELSEIF RC0>PMAX AND RC2>PMAX THEN 
			X10 = 8
		
				ELSEIF RC0<PMIN THEN
				X10 = 5
		
					ELSEIF RC0>PMAX THEN 
					X10 = 1
		
						ELSEIF RC2<PMIN THEN
						X10 = 3
		
							ELSEIF RC2>PMAX THEN
							X10 = 7

ENDIF

IF RC3<PMIN AND RC1<PMIN THEN
X1 = 4
	
	ELSEIF RC3<PMIN AND RC1>PMAX THEN
	X1 = 6
	
		ELSEIF RC3>PMAX AND RC1<PMIN THEN
		X1 = 2
	
			ELSEIF RC3>PMAX AND RC1>PMAX THEN
			X1 = 8
	
				ELSEIF RC3<PMIN THEN
				X1 = 5
	
					ELSEIF RC3>PMAX THEN
					X1 = 1
	
						ELSEIF RC1<PMIN THEN
						X1 = 3
	
							ELSEIF RC1>PMAX THEN
							X1 = 7

ENDIF

	rcrx = X10 * 10
	RCRX = rcrx + X1
	
RETURN
	

'================================================
robot_voltage:						' [ 10 x Value / 256 = Voltage]
	DIM v AS BYTE

	A = AD(6)
	
	IF A < 148 THEN 				' 5.8v
	
	FOR v = 0 TO 2
	OUT 52,1
	DELAY 200
	OUT 52,0
	DELAY 200
	NEXT v
		
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
	IF A < 30 THEN  GOTO backward_standup
	RETURN
tilt_high:	
	A = AD(5)
	'IF A > 200 THEN GOTO backward_standup
	IF A > 200 THEN GOTO forward_standup
	RETURN
'================================================
lcd:
LOCATE 0,0
PRINT "bingo"
DELAY 1000
CLS

RETURN

'Movement Routines
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
	MOVE G6D, 100,  76, 145,  93, 100, 100  
	MOVE G6B, 100,  30,  80, 100, 100, 100
	MOVE G6C, 100,  30,  80, 100, 100, 100
	WAIT
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
	DIM w AS BYTE
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
	
'***************pushup ********************************

pushup:
SPEED 10
GOSUB sit2

'lean forward
MOVE G6A, 98, 161,  26, 160, 103, 100
MOVE G6B,180,  17,  98,    ,    ,    
MOVE G6C,177,  20,  91,    ,    ,    
MOVE G6D, 99, 158,  27, 157, 102, 100
	WAIT

'hands down
MOVE G6A,100, 163,  60, 154, 102,    
MOVE G6B,180,  17,  98,    ,    ,    
MOVE G6C,177,  20,  91,    ,    ,    
MOVE G6D,100, 164,  63, 148, 100,    
	WAIT
	
'extend legs
MOVE G6A,100, 61, 157,  74, 105,    

MOVE G6D,100, 61, 167,  68,  99,    
	WAIT

	
FOR i = 0 TO 5
'bend arms
MOVE G6A,100, 61, 157,  74, 105,    
MOVE G6B,180,  89,  11, 100, 100, 100
MOVE G6C,177,  84,  11, 100, 100, 100
MOVE G6D,100, 61, 166,  68,  98, 100
	WAIT

'straighten arms
MOVE G6B,181,  17,  98,    ,    ,    
MOVE G6C,177,  22,  92,    ,    ,    
	WAIT	
NEXT i

GOSUB one_hand_pushup
RETURN

'*********************************************************
'stand up from forward pushup
standup:

'legs out
SPEED 15
MOVE G6A, 76, 165,  54, 162, 156,
MOVE G6B,181,  17,  98,    ,    ,    
MOVE G6C,177,  22,  92,    ,    ,  
MOVE G6D, 76, 165,  54, 162, 156,    
	WAIT


'tilt body back
MOVE G6A, 76, 165,  54, 162, 156, 100
MOVE G6B,163,  17,  98, 100, 100, 100
MOVE G6C,163,  17,  98, 100, 100, 100
MOVE G6D, 76, 165,  54, 162, 156, 100
	WAIT


' lean back for stand up

MOVE G6A, 60, 164,  21, 162, 136,    
MOVE G6B,145,  17,  98, 100, 100, 100
MOVE G6C,145,  17,  98, 100, 100, 100
MOVE G6D, 60, 164,  21, 162, 136,    
	WAIT


GOSUB standard_pose
RETURN

'*******************one hand pushup********************************

one_hand_pushup:

'spread left leg 
MOVE G6A,100,  60, 156, 100, 162, 100

MOVE G6C,160,  13,  88, 100, 100, 100
MOVE G6D,103,  59, 162,  71,  96, 100
	WAIT

'lift left arm
MOVE G6B,181, 169, 178, 100, 100, 100
	WAIT

FOR i = 0 TO 5
'bend arms

MOVE G6C,177,  84,  11, 100, 100, 100
	WAIT

'straighten arms
MOVE G6C,177,  22,  92,    ,    ,    
	WAIT	
NEXT i

'move left arm back
MOVE G6B,180,  17,  98,    ,    ,    
	WAIT
	
GOSUB standup


RETURN


'***************************************
'Sit

Sit2:
MOVE G6A, 97, 156,  26, 130, 102,    
MOVE G6B,100,  96,  99, 100, 100, 100
MOVE G6C,100, 102,  98, 100, 100, 100
MOVE G6D, 97, 161,  27, 128, 104,    
	WAIT
RETURN

'***************************************
begin_pushup:
SPEED 10
GOSUB sit2

'lean forward
MOVE G6A, 98, 161,  26, 160, 103, 100
MOVE G6B,180,  17,  98,    ,    ,    
MOVE G6C,177,  20,  91,    ,    ,    
MOVE G6D, 99, 158,  27, 157, 102, 100
	WAIT

'hands down
MOVE G6A,100, 163,  60, 154, 102,    
MOVE G6B,180,  17,  98,    ,    ,    
MOVE G6C,177,  20,  91,    ,    ,    
MOVE G6D,100, 164,  63, 148, 100,    
	WAIT
	
'extend legs
MOVE G6A,100, 61, 157,  74, 105,    

MOVE G6D,100, 61, 167,  68,  99,    
	WAIT
RETURN
'**************pick up ball**********************************************

'object must be 3 x 3 inches

pickup:

GOSUB Sit2
SPEED 3
GOSUB bendandpick
GOSUB standandhold
GOSUB throw
GOSUB standard_pose
RETURN

bendandpick:
MOVE G6A, 97, 157,  24, 169, 102, 100
MOVE G6B,149,  25,  101, 100, 100, 100
MOVE G6C,151,  25, 101, 100, 100, 100
MOVE G6D, 97, 157,  24, 169, 102, 100
WAIT

MOVE G6A, 97, 157,  24, 169, 102, 100
MOVE G6B,149,  25,  52, 100, 100, 100
MOVE G6C,151,  25,  52, 100, 100, 100
MOVE G6D, 97, 157,  24, 169, 102, 100
WAIT

MOVE G6A, 97, 157,  24, 134, 102, 100
MOVE G6B,149,  25,  52, 100, 100, 100
MOVE G6C,151,  25,  52, 100, 100, 100
MOVE G6D, 97, 157,  24, 134, 102, 100
WAIT

RETURN

standandhold:
MOVE G6A,100,  77, 145,  95, 100, 100
MOVE G6B,149,  25,  52, 100, 100, 100
MOVE G6C,151,  25,  52, 100, 100, 100
MOVE G6D,100,  77, 145,  95, 100, 100
WAIT

RETURN


throw:

HIGHSPEED SETON
SPEED 15
MOVE G6A,100,  77, 145,  95, 100, 100
MOVE G6B,131,  25,  52, 100, 100, 100
MOVE G6C,131,  25,  52, 100, 100, 100
MOVE G6D,100,  77, 145,  95, 100, 100
WAIT

MOVE G6A,100,  77, 145,  95, 100, 100
MOVE G6B,153,  25,  52, 100, 100, 100
MOVE G6C,153,  25,  52, 100, 100, 100
MOVE G6D,100,  77, 145,  95, 100, 100
WAIT


MOVE G6A,100,  77, 145,  95, 100, 100
MOVE G6B,190,  25,  52, 100, 100, 100
MOVE G6C,190,  25,  52, 100, 100, 100
MOVE G6D,100,  77, 145,  95, 100, 100
WAIT

MOVE G6A,100,  77, 145,  95, 100, 100
MOVE G6B,190,  25,  69, 100, 100, 100
MOVE G6C,190,  25,  69, 100, 100, 100
MOVE G6D,100,  77, 145,  95, 100, 100
WAIT
HIGHSPEED SETOFF


RETURN