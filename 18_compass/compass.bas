'*************************************************** 
'*           I2C routine for CMPS03                * 
'Based on code by Gerald Coe and KurtE. Thanks guys! 
'                  September 2007 
'*************************************************** 

CONST SDA = 46         'Use port 10 for Data, constant SDA 
CONST SCL = 47         'Use port 5 for Clock, constant SCL 
DIM I2cBuf AS BYTE         'Buffer Byte 
DIM I2cAddr AS BYTE         'Address Byte 
DIM I2cReg AS BYTE         'Register Byte 
DIM I2cData AS BYTE         'Data Byte 
DIM I2cDataWord AS INTEGER      '16 bit word data
DIM degrees AS INTEGER
DIM I2cAckBit AS BYTE         'only need 1 bit for Acknowledge Flag 
DIM I2cBit AS BYTE         'Bit index for shifting loops 
DIM I2cTx AS BYTE         'Transmitted Byte 
DIM I2cRx AS BYTE         'Recieved Byte 
LCDINIT 
TEMPO 230 
MUSIC "EDE" 
I2cAckBit = 0 
Main: 
   I2cAddr = &Hc0         'Default address of CMPS03 compass 
   I2cReg = 2         'Register containing Compass bearing as a word 
   GOSUB I2cWordRead    
   I2cReg = 1         'Register containing Compass bearing AS a BYTE 
   GOSUB I2cByteRead
   degrees = I2cDataWord/10
   LCDINIT
   PRINT &HFE, &H01 ' clear screen 
   PRINT &HFE, &H80, &H01 ' set cursor at position 1
   PRINT &H08 'backspace to position 0
   PRINT &HFE, &H0C 'blinking cursor off
   PRINT " Bearing: " 
   PRINT FORMAT (degrees, DEC)   'Display word bearing
'PRINT FORMAT (I2cData, DEC)
   DELAY 1000
    
GOTO Main 

I2cByteWrite: 
   GOSUB I2cStart         'Send start bit 
   I2cBuf = I2cAddr       
   GOSUB I2cOutByte      'Send module address 
   I2cBuf = I2cReg 
   GOSUB I2cOutByte      'Send the register number you wish to write 
      I2cBuf = I2cData 
      GOSUB I2cOutByte   'Send Data 
   GOSUB I2cStop         'Send stop bit 
RETURN 

I2cWordWrite: 
   GOSUB I2cStart         'Send start bit 
   I2cBuf = I2cAddr       
   GOSUB I2cOutByte      'Send module address 
   I2cBuf = I2cReg         'I2cReg must be a 16 bit register 
   GOSUB I2cOutByte      'Send the register number you wish to write 
      I2cData = I2cDataWord >> 8   'shift high order byte down 8 bits 
      I2cBuf = I2cData 
      GOSUB I2cOutByte      'Send high byte 
      I2cData = I2cDataWord AND &H00FF   'mask off high order byte 
      I2cBuf = I2cData 
      GOSUB I2cOutByte      'Send low byte 
   GOSUB I2cStop            'Send stop bit 
RETURN 

I2cByteRead:    
   GOSUB I2cStart         'Send start bit 
   I2cBuf = I2cAddr 
   GOSUB I2cOutByte      'Send module address 
   I2cBuf = I2cReg 
   GOSUB I2cOutByte      'Send the register number you wish to read 
   GOSUB I2cStart         'Send the required repeated start bit 
   I2cBuf = I2cAddr OR 1   'set write enable bit 
   GOSUB I2cOutByte      'Send the module address with write enable bit set 
      I2cAckBit = 1            ' 
      GOSUB I2cInByte      'Read required data 
      I2cData = I2cBuf   'copy data from buffer Byte 
   GOSUB I2cStop         'Send stop bit 
RETURN 

I2cWordRead:    
   GOSUB I2cStart         'Send start bit 
   I2cBuf = I2cAddr 
   GOSUB I2cOutByte      'Send module address 
   I2cBuf = I2cReg 
   GOSUB I2cOutByte      'Send the register number you wish to read 
   GOSUB I2cStart         'Send the required repeated start bit 
   I2cBuf = I2cAddr OR 1   'set write enable bit 
   GOSUB I2cOutByte      'Send the module address with write enable bit set 
      I2cAckBit = 0      'NAck 
      GOSUB I2cInByte      'read highorder byte 
      I2cDataWord = I2cBuf << 8   'shift high order byte up by 8 bits 
      I2cAckBit = 1      'Ack 
      GOSUB I2cInByte      'read low order byte 
      I2cDataWord = I2cDataWord + I2cBuf   'combine high and low order bytes 
       
   GOSUB I2cStop         'Send stop bit 
RETURN 



I2cOutByte: 

FOR I2cBit = 0 TO 7 
   I2cTx = I2cBuf AND &H80      'Mask off all but the Most significant bit 
   IF I2cTx <> 0 THEN          'Test the BSB and set up data ie 
         OUT SDA,1         'data = 1 
   ELSE 
         OUT SDA,0         'data = 0 
   ENDIF 
   OUT SCL, 1 
   OUT SCL, 0               'Clock the data out 
   I2cBuf = I2cBuf << 1 
NEXT I2cBit 

OUT SDA, 0      'should read the ack bit for error detection 
OUT SCL, 1 
OUT SCL, 0      'clock in the Ack' bit, and ignore it. 
RETURN 

I2cInByte: 
   I2cBuf =0                  'clear input buffer byte 
   OUT SDA, 1                   
   I2cRx = IN(SDA)               'release data line for input 
   FOR I2cBit = 0 TO 7 
         OUT SCL, 1             
         I2cRx = IN(SDA)         'Read one bit of the byte 
         OUT SCL, 0            'Pull clock low, ready for next bit 
         I2cBuf = I2cBuf << 1   'Shift the Data buffer one bit left 
         IF I2cRx <> 0 THEN 
            I2cBuf = I2cBuf +1   'if the data is a one set the Least Significant bit in the buffer 
         ENDIF 
   NEXT I2cBit 

   OUT SDA, I2cAckBit            'clock in the Ack (1)Or Nack (0)' bit, 1= we are reading another byte.    
   OUT SCL, 1                                                   '0= we are only reading one byte 
   OUT SCL, 0       
RETURN 

I2cStart: 
   OUT SDA,1      'Ensure data and clock lines are both high 
   OUT SCL,1 
   OUT SDA,0      'Sent start bit, ie lower data line while clock line is high 
   OUT SCL,0      'Lower clock line ready to start clocking data. 
RETURN 

I2cStop: 
   OUT SCL,1       
   OUT SDA,1      'Sent stop bit, ie raise data line while clock high 
RETURN
