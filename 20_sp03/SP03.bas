'***************************************************
'*           I2C routine for CMPS03                *
'Based on code by Gerald Coe and KurtE. Thanks guys!
'                  July 2007
'***************************************************

CONST SDA = 46 'Use port 46 for Data, constant SDA
CONST SCL = 47 'Use port 47 for Clock, constant SCL

'CONST SDA = 15
'CONST SCL = 16
DIM I2cBuf AS BYTE
DIM I2cAddr AS BYTE
DIM I2cReg AS BYTE
DIM I2cData AS BYTE

'DIM FP AS BYTE
'DIM LFP AS BYTE
'DIM X AS BYTE
'DIM Y AS BYTE

DIM I2cBit AS BYTE
DIM I2cTx AS BYTE
DIM I2cRx AS BYTE
'LCDINIT
TEMPO 230
MUSIC "EDC"

Main:
 GOSUB hello
 DELAY 2000
 GOSUB ready
 DELAY 2000
	
'I2cAddr = &Hc4 'SP03 default address
'I2cReg = 0 'Command Register
'I2cData = &H03 'Speak 1st predefined phrase
'GOSUB I2cByteWrite	

GOTO Main

hello:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0
	GOSUB FillSpeechBuffer_hello
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H40 'Speak Buffer command
	GOSUB I2cByteWrite
	RETURN
	
ready:
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0
	GOSUB FillSpeechBuffer_ready
	I2cAddr = &Hc4 'SP03 default address
	I2cReg = 0 'Command Register
	I2cData = &H40 'Speak Buffer command
	GOSUB I2cByteWrite
	RETURN

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

I2cStop:
	OUT SCL,1
	'DELAY 1
	OUT SDA,1
	RETURN
