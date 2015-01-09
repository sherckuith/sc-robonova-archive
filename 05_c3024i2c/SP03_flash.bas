'***************************************************
'*           I2C routine for SP03   
' Requires special flash code (c3024i2c) in C3024 controlller
'              

'Based on code by NovaOne, Gerald Coe and KurtE. Thanks guys!
'                  July 2007
'***************************************************

CONST I2ctran = 6 'New virtual IO Port for I2c data transfer register
CONST I2ccmd = 7 ' New virtaul IO Port for I2c command Register
CONST I2cStatus = 7 ' New Virtual Port for I2c status register

CONST I2c_open = 0  ' Command Code to set I2c enable and initial state
CONST I2c_close = 1 'Command Code to disable I2c
CONST I2c_start = 2 ' Command Code to send start sequence
CONST I2c_repeat = 3 ' Command Code to send repeat start sequence
CONST I2c_stop = 4  'Command Code to send stop sequence
CONST I2c_ack = 5 'Command Code to make subsequent bytes read as ACK
CONST I2c_nack = 6 ' Command Code to make subsequent bytes read as NAK

CONST I2c_StACK = 0'Status if I2c returned ACK
CONST I2c_StNAK = 1 'Status if I2c returned NAK

CONST SP03addr = &Hc4  ' I2c address of SP03
CONST SP03cmd = 0  ' SP03 Command register
CONST SP03nop = 0	'SP03 nop command
CONST SP03speak = &H40 'SP03 Speak buffer command

CONST SP03volume = 0 'SP03 volume setting
CONST SP03speed = &H05 'SP03 speed setting
CONST SP03pitch = &H03 'SP03 pitch setting


DIM RR AS BYTE			' define first byte variable, because special
DIM I2CData AS BYTE
DIM I2CAddr AS BYTE
DIM I2CReg AS BYTE

TEMPO 230
MUSIC "EDC"

BYTEOUT	I2ccmd, I2c_open		' open the i2c port

Main:
 GOSUB hello

 DELAY 3000
	


'I2cAddr = &Hc4 'SP03 default address
'I2cReg = 0 'Command Register
'I2cData = &H03 'Speak 1st predefined phrase
'GOSUB I2cByteWrite	

GOTO Main

hello:


GOSUB FillSpeechBuffer 


I2cAddr = SP03addr 'SP03 default address
I2cReg = SP03cmd 'Command Register
I2cData = SP03speak 'Speak Buffer command
GOSUB I2cByteWrite


RETURN

FillSpeechBuffer:

BYTEOUT I2ccmd,I2c_start			 'Send start

BYTEOUT I2ctran,SP03addr		'Send SP03 address

BYTEOUT I2ctran,SP03cmd		'Send SP03 command register

BYTEOUT I2ctran,SP03nop		'Send SP03 nop

BYTEOUT I2ctran,SP03volume		'Send SP03 volume

BYTEOUT I2ctran,SP03speed		'Send SP03 speed

BYTEOUT I2ctran,SP03pitch		'Send SP03 pitch

BYTEOUT I2ctran,&H48		'Send 'H'

BYTEOUT I2ctran,&h65		'Send 'e'

BYTEOUT I2ctran,&H6C		'Send 'l'

BYTEOUT I2ctran,&H6C		'Send 'l'

BYTEOUT I2ctran,&H6F		'Send 'o'

BYTEOUT I2ctran,0		'Send null for end of phrase

BYTEOUT I2ccmd, I2c_stop

DELAY 2
RETURN



I2cByteWrite:

BYTEOUT I2ccmd,I2c_start			 'Send start

BYTEOUT I2ctran,I2cAddr		'Send  address

BYTEOUT I2ctran,I2cReg			'Send register

BYTEOUT I2ctran,I2cData		' Send data

BYTEOUT I2ccmd, I2c_stop		' Send stop

RETURN



I2cByteRead:
BYTEOUT I2ccmd,I2c_start			 'Send start

BYTEOUT I2ctran,I2cAddr		'Send  address

BYTEOUT I2ctran,I2cReg			'Send register

BYTEOUT I2ccmd, I2c_repeat		' Send repeat start

I2cData = BYTEIN(I2ctran)		' get data

BYTEOUT I2ccmd, I2c_stop		' Send stop

RETURN

