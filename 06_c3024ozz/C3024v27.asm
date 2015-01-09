; Robobonova C3024 code 
; Modified to disble the interpreter for ozzfiddler

;***** Specify Device
		.device ATmega128

;***** I/O Register Definitions
		.equ	SREG	=$3F
		.equ	SPH		=$3E
		.equ	SPL		=$3D

		.equ	EEARH	=$1F
		.equ	EEARL	=$1E
		.equ	EEDR	=$1D
		.equ	EECR	=$1C

		.equ	PORTA	=$1B
		.equ	DDRA	=$1A
		.equ	PINA	=$19
		.equ	PORTB	=$18
		.equ	DDRB	=$17
		.equ	PINB	=$16
		.equ	PORTC	=$15
		.equ	DDRC	=$14
		.equ	PINC	=$13
		.equ	PORTD	=$12
		.equ	DDRD	=$11
		.equ	PIND	=$10

		.def	XL		=r26
		.def	XH		=r27
		.def	YL		=r28
		.def	YH		=r29
		.def	ZL		=r30
		.def	ZH		=r31
;-------------------------------------------------------------------------
; Data Memory
			.dseg
			.org 0x100

			.org 0x140
data0140:	.byte 192			;IM code variable storage

			.org 0x300
data0300:	.byte 32			; Desired servo position (10 to 190)

data0320:	.byte 32			; Present servo position (10 to 190)

data0340:	.byte 32			; Zero position offset

data0360:	.byte 32			; Adjusted position

data0380:	.byte 32			; position after direction this is pulse sent to servo

data03A0:	.byte 32			; speed counters

data03C0:	.byte 32			; speed delta

data03E0:	.byte 32			; Modify angle trigger

data0400:	.byte 32			; absolute angle change

data0420:	.byte 32			;

			.org 0x4C2
data04C2:	.byte 1				; Address of external EEPROM

data04C3:	.byte 1

data04C4:	.byte 1				; AI Motor serial baud rate

			.org 0x4CA
data04CA:	.byte 1				; G8A AIMOTOR ON/OFF bits(1 = on, 0 = off)
data04CB:	.byte 1				; G8B AIMOTOR ON/OFF bits(1 = on, 0 = off)
data04CC:	.byte 1				; G8C AIMOTOR ON/OFF bits(1 = on, 0 = off)
data04CD:	.byte 1				; G8D AIMOTOR ON/OFF bits(1 = on, 0 = off)
			
			.org 0x4D0
data04D0:	.byte 1
data04D1:	.byte 1

data04D2:	.byte 1				; Controller Status Byte
								; Bit 7 = PTP ALL 1 = on, 0 = off
								; Bit 6 = Stop 
								; Bit 5 = Command set if this is a command, not an IM
								; Bit 4 = Break
								; Bit 3 = get next command byte and respond with 0xAA
								; Bit 2 = Reset
								; Bit 1 =
								; Bit 0 = 
data04D3:	.byte 1
data04D4:	.byte 1				; Speed

data04D5:	.byte 1				; storage for IM stack high
data04D6: 	.byte 1				; storage for IM stack low

data04D7:	.byte 1				; servo phase
data04D8:	.byte 1
			.org 0x4DA
data04DA:	.byte 1				; PTP SET ON/OFF ( 1 = on, 0 = off)

data04DB:	.byte 1				; Largest move distance in move request

data04DC:	.byte 1				; Delay counter low
data04DD:	.byte 1				; Delay counter high
data04DE:	.byte 1				; Delay counter Busy

data04DF:	.byte 1				; High address of variable
data04E0:	.byte 1				; low address of variable
data04E1:	.byte 1				; type of variable 15 = byte, 16 = int, 1B = bit
data04E2:	.byte 1				; bit of bit variable

data04E3:	.byte 1				; Motor group G8A in motion (0 = moving 1 = complete)
data04E4:	.byte 1				; Motor group G8B in motion (0 = moving 1 = complete)
data04E5:	.byte 1				; Motor group G8C in motion (0 = moving 1 = complete)
data04E6:	.byte 1				; Motor group G8D in motion (0 = moving 1 = complete)

data04E7:	.byte 1				; Servo Direction G8A
data04E8:	.byte 1				; Servo Direction G8B
data04E9:	.byte 1				; Servo Direction G8C
data04EA:	.byte 1				; Servo Direction G8D

data04EB:	.byte 1				; Servo Enables G8A
data04EC:	.byte 1				; Servo Enables G8B
data04ED:	.byte 1				; Servo Enables G8C
data04EE:	.byte 1				; Servo Enables G8D

data04EF:	.byte 1				; High Speed ( 1 = on, 0 = off)

data04F0:	.byte 1				; AIMOTOR SETON ( Bit 7 1 = on, 0 = off set/clear by B6 code)

data04F1:	.byte 1

data04F2:	.byte 1				; high byte of Flash checksum from 0 to 64KB
data04F3:	.byte 1				; low byte of Flash checksum from 0 to 64KB

data04F4:	.byte 1				; Timer 0 int in progress bit 7

			.org 0x505
data0505:	.byte 1				; Tempo
data0506:	.byte 1

			.org 0x508
data0508:	.byte 1
data0509:	.byte 1
data050A:	.byte 1				; used by music
data050B:	.byte 1
data050C:	.byte 1
data050D:	.byte 1				; next four bytes used by music for pointer storage
data050E:	.byte 1
data050F:   .byte 1
data0510:	.byte 1

			.org 0x511
data0511:	.byte 1
data0512:	.byte 1				; Loader present Bit 7 set if boot loader detected else 0
data0513:	.byte 1				; increments on T0 timer ( 4 msec ) but does not appear to be used

			.org 0x52D
data052D:	.byte 1				; Size of external EEPROM in K bytes

			.org 0x52F
data052F:	.byte 1				; Gyro 
								; bit 0 = Gyro 1
								; Bit 1 = Gyro 2
								; bit 2 = Gyro 3
								; bit 3 = Gyro 4
								; bit 4 = 0 = GWS 1 = KRG-1

data0530:	.byte 1				; Gyro 1 read value
data0531:	.byte 1				; Gyro 2 read value
data0532:	.byte 1				; Gyro 3 read value
data0533:	.byte 1				; Gyro 4 read value

data0534:	.byte 32			; Gyro Setting, number and type
data0554:	.byte 32			; Gyro direction setting
data0574:	.byte 32			; Gyro Zero
data0594:	.byte 32			; Gyro sensitivity setting

data05B4:	.byte 1				; Gyro

			.org 0xCEE
data0CEE:	.byte 1
data0CEF:	.byte 1

			.org 0xD00
data0D00:	.byte 64			; Stack for IM code subroutines grows upwards

			.org 0xE00
data0E00:	.byte 128

			.org 0x1000
STACK:		.byte 256

;-------------------------------------------------------------------------
; Program Memory

		.cseg
		.org 0
;-------------------------------------------------------------------------
avr0000:
		rjmp	RESET			; 0000 C07F	Go to start of program
		reti					; 0001 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0002 C043
		reti					; 0003 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0004 C041
		reti					; 0005 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0006 C03F
		reti					; 0007 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0008 C03D
		reti					; 0009 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 000A C03B
		reti					; 000B 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 000C C039
		reti					; 000D 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 000E C037
		reti					; 000F 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0010 C035
		reti					; 0011 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0012 C033
		reti					; 0013 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0014 C031
		reti					; 0015 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0016 C02F
		reti					; 0017 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0018 C02D
		reti					; 0019 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 001A C02B
		reti					; 001B 9518
;-------------------------------------------------------------------------
		rjmp	avr00C2			; 001C C0A5 Timer 1 overflow Music
		reti					; 001D 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 001E C027
		reti					; 001F 9518
;-------------------------------------------------------------------------
		rjmp	avr00C0			; 0020 C09F	Timer 0 overflow Motion Timer
		reti					; 0021 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0022 C023
		reti					; 0023 9518
;-------------------------------------------------------------------------
		rjmp	avr0172			; 0024 C14D	USART RX Complete Interrupt
		reti					; 0025 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0026 C01F
		reti					; 0027 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0028 C01D
		reti					; 0029 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 002A C01B
		reti					; 002B 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 002C C019
		reti					; 002D 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 002E C017
		reti					; 002F 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0030 C015
		reti					; 0031 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0032 C013
		reti					; 0033 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0034 C011
		reti					; 0035 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0036 C00F
		reti					; 0037 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0038 C00D
		reti					; 0039 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 003A C00B
		reti					; 003B 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 003C C009
		reti					; 003D 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 003E C007
		reti					; 003F 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0040 C005
		reti					; 0041 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0042 C003
		reti					; 0043 9518
;-------------------------------------------------------------------------
		rjmp	avr0046			; 0044 C001
		reti					; 0045 9518
;-------------------------------------------------------------------------
avr0046:reti					; 0046 9518 return when no interrupt routine
;-------------------------------------------------------------------------
avr0047:
.db		0x2e, 0x00
.db 	"===============", 0x00
.db		" MRC3000F-FLASH", 0x00
.db		"     miniROBOT ", 0x00
.db		" by KJS JSB    ", 0x00
.db		" ver 2.70      ", 0x00
.db		" 2008.01. 04   ", 0x00
.db		"===============", 0x00
/*
;This is a data area	
		0047 002E
		0048 3D3D
		0049 3D3D
		004A 3D3D
		004B 3D3D
		004C 3D3D
		004D 3D3D
		004E 3D3D
		004F 003D
		0050 4D20
		0051 3352
		0052 3230
		0053 2034
		0054 2020
		0055 2020
		0056 2020
		0057 0020
		0058 2020
		0059 2020
		005A 6D20
		005B 6E69
		005C 5269
		005D 424F
		005E 544F
		005F 0020
		0060 6220
		0061 2079
		0062 4A4B
		0063 2053
		0064 534A
		0065 2042
		0066 2020
		0068 7620
		0069 7265
		006A 3220
		006B 352E
		006C 2030
		006D 2020
		006E 2020
		006F 0020
		0070 3220
		0071 3030
		0072 2E35
		0073 3031
		0074 202E
		0075 3732
		0076 2020
		0077 0020
		0078 3D3D
		0079 3D3D
		007A 3D3D
		007B 3D3D
		007C 3D3D
		007D 3D3D
		007E 3D3D
		007F 003D


;end of data area
*/
.org 0x080
;-----------------------------------------------------------------------
; This is the start
RESET:		ser	r16				; 0080 EF0F Reg 16 = 0xff
			out	SPL, r16			; 0081 BF0D Set stack pointer to 0x10ff
			ldi	r16, 0x10			; 0082 E100
			out	SPH, r16			; 0083 BF0E

; this appears to check if the bootloader is in place , or it will not allow the command interpreter to run
			call	sub00D4			; 0084 940E bit 7 of 0x512 set if OK

			rcall	sub0103			; 0086 D07C make and save checksum for 0 to 64KB in 0x4f2 and 0x4f3

			rcall	sub0115			; 0087 D08D EEPROM initialise get address and size

			rcall	sub017E			; 0088 D0F5 Port and Data Memory initialisation

			rcall	sub02C2			; 0089 D238 turn on led 1

			rcall	sub0263			; 008A D1D8 do we have rx rdy on USART1, wait

			rcall	sub0151			; 008B D0C5 set up the USART1

			rcall	sub012E			; 008C D0A1 set up the UASRT0

			lds	r16, 0x009B			; 008D 9100 009B  check USART1 ready
			sbrs	r16, 7			; 008F FF07
			rjmp	avr0091			; 0090 C000

avr0091:	rcall	sub02CD			; 0091 D23B turn on LED 0

			sei						; 0092 9478 enable interrupts

;------------------------------------------------------------------
; this is the main loop
;------------------------------------------------------------------



avr0093:sts	0x0CFF, XH			; 0093 93B0 0CFF save the X register
		sts	0x0CFE, XL			; 0095 93A0 0CFE


		wdr						; 0097 95A8 reset watchdog
		lds	r16, 0x04D2			; 0098 9100 04D2
		sbrs	r16, 3			; 009A FF03  
		rjmp	avr00A2			; 009B C006

		andi	r16, 0xF7		; 009C 7F07 here if bit 3 of 0x4D2 is set
		sts	0x04D2, r16			; 009D 9300 04D2 clear bit 3 of 0x4D2
		rcall	sub0629			; 009F D589 get character (dummy)
		ldi	r16, 0xAA			; 00A0 EA0A 
		rcall	sub0641			; 00A1 D59F send 0xAA char in response

avr00A2:	lds	r16, 0x009B		; 00A2 9100 009B get rx rdy
		sbrc	r16, 7			; 00A4 FD07
		rcall	sub0315			; 00A5 D26F call commmand decoder

		lds	r16, 0x04D2			; 00A6 9100 04D2
		sbrc	r16, 3			; 00A8 FD03
		rjmp	avr00B4			; 00A9 C00A if bit 3 of 0x4D2 is clear then carry on

		sbrc	r16, 4			; 00AA FD04 if bit 4 is clear then carry on
		rjmp	avr0093			; 00AB CFE7 goto main

		lds	r16, 0x04D2			; 00AC 9100 04D2
		sbrc	r16, 6			; 00AE FD06 if bit 6 is clear then carry on (not STOP)
		rjmp	avr0093			; 00AF CFE3 goto main

		lds	r16, 0x009B			; 00B0 9100 009B get rx rdy
		sbrc	r16, 7			; 00B2 FD07 if bit 7 is clear then carry on
		rjmp	avr0093			; 00B3 CFDF goto main

avr00B4:	lds	r16, 0x0512		; 00B4 9100 0512
		sbrs	r16, 7			; 00B6 FF07 if bit 7 of 0x0512 is set then do IM code
		rjmp	avr0093			; 00B7 CFDB go to main

		rcall	sub07D6			; 00B8 D71D get next Intermediate code
		ldi	ZH, 0x60			; 00B9 E6F0 and execute it
		mov	ZL, r16				; 00BA 2FE0
		ijmp					; 00BB 9409
		rjmp	avr0093			; 00BC CFD6 goto main


;-------------------------------------------------------------------------
; Enable Watchdog timer to 0.9 sec

avr00BD:	ldi	r16, 0x0E		; 00BD E00E Enable watchdog time = 0.9 sec
			out	$21, r16		; 00BE BD01 Watchdog register
			ret					; 00BF 9508
;-------------------------------------------------------------------------
avr00C0:	jmp	avr5190			; 00C0 940C 5190 Timer 0 overflow interrupt
avr00C2:	jmp	avr5596			; 00C2 940C 5596 Timer 1 overflow interrupt
;-------------------------------------------------------------------------
; Data used to check against boot loader area
avr00C4:
.db			0x00, 0x01, 0x02,0x03, 0x04, 0x05, 0x06, 0x07
.db			0x00, 0x10, 0x20,0x30, 0x40, 0x50, 0x60, 0x70


/*sub00C4:	00C4 0100  first data area
			00C5 0302
			00C6 0504
			00C7 0706
			00C8 1000
			00C9 3020
			00CA 5040
			00CB 7060
*/
;------------------------------------------------------------------------
; More data used to compare against boot loader area
avr00CC:
.db			0xf7, 0xdf, 0x0f, 0xd0, 0x0e, 0xef, 0x1f, 0xef
.db			0x1e, 0x17, 0x0f, 0x07, 0x48, 0xf0, 0x0e, 0xd0
/*
avr00CC:	00CC DFF7 This is second data area
			00CD D00F
			00CE EF0E
			00CF EF1F
			00D0 171E
			00D1 070F
			00D2 F048
			00D3 D00E
*/
;-------------------------------------------------------------------------
; Check if valid boot loader is present
; carry set if OK
sub00D4:	ldi	YH, high(avr00C4 << 1)	; 00D4 E0D1 Y = 0x188 this is word address 0x0C4
			ldi	YL, low(avr00C4 << 1)	; 00D5 E8C8 
			ldi	ZH, high(avrF001 << 1)	; 00D6 EEF0 Z = 0xE002 this is word address 0xF001 (boot loader)
			ldi	ZL, low(avrF001 << 1)	; 00D7 E0E2
			rcall	sub00E4				; 00D8 D00B
			brsh	sub00E2				; 00D9 F440

			ldi	YH, high(avr00CC << 1)	; 00DA E0D1 Y = 0x198 this is word address 
			ldi	YL, low(avr00CC << 1)	; 00DB E9C8
avr00DC:	ldi	ZH, high(avrF080 << 1)	; 00DC EEF1 Z=0xE100 this is word address 0xF080 (boot loader)
sub00DD:	ldi	ZL, low(avrF080 << 1)	; 00DD E0E0
			rcall	sub00E4				; 00DE D005
			brsh	sub00E2				; 00DF F410
			sec							; 00E0 9408
			ret							; 00E1 9508
;	-------------------------------------------------------------------------
sub00E2:	clc				; 00E2 9488
			ret				; 00E3 9508
;-------------------------------------------------------------------------
; Compare 16 bytes from Y pointer in low program memory to z pointer in high program memory space
; 
sub00E4:	ldi	r19, 0x10		; 00E4 E130
avr00E5:	push	ZH			; 00E5 93FF
			push	ZL			; 00E6 93EF
			mov	ZH, YH			; 00E7 2FFD
			mov	ZL, YL			; 00E8 2FEC
			ldi	r16, 0x00		; 00E9 E000 Address is to low program memory
			out	$3B, r16		; 00EA BF0B
			lpm	r0, Z			; 00EB 9004
			mov	r1, r0			; 00EC 2C10
			adiw	YL, 0x01	; 00ED 9621
			pop	ZL				; 00EE 91EF
			pop	ZH				; 00EF 91FF
			ldi	r16, 0x01		; 00F0 E001 Address is to high program memory
			out	$3B, r16		; 00F1 BF0B
			elpm	r0, Z+		; 00F2 9007
			cpse	r0, r1		; 00F3 1001
			rjmp	avr00FD		; 00F4 C008
			dec	r19				; 00F5 953A
			brne	avr00E5		; 00F6 F771
			lds	r16, 0x0512		; 00F7 9100 0512 set top bit in location 0x512 if they are same
			andi	r16, 0x7F		; 00F9 6800 *** This is changed to disable the command interpreter ***
			sts	0x0512, r16		; 00FA 9300 0512
			ret					; 00FC 9508
;-------------------------------------------------------------------------
avr00FD:	lds	r16, data0512		; 00FD 9100 0512
			andi	r16, 0x7F	; 00FF 770F clear top bit in locat 0x512 if different
			sts	data0512, r16		; 0100 9300 0512
			ret					; 0102 9508

;-------------------------------------------------------------------------
;Create Checksum of Program Memory and store in 0x04F2 and 0x04F3 This only checks first 64K bytes

sub0103:	ldi	ZH, high(avr0000 << 1)		; 0103 E0F0 Make program Memory Chksum
			ldi	ZL, low(avr0000 << 1)		; 0104 E0E0
			clr	YH				; 0105 27DD
			clr	YL				; 0106 27CC
avr0107:	clr	r16				; 0107 2700
avr0108:	lpm	r16, Z+			; 0108 9105
			add	YL, r16			; 0109 0FC0
			brsh	avr010C		; 010A F408
avr010B:	inc	YH				; 010B 95D3
avr010C:	tst	ZH				; 010C 23FF
			brne	avr0108		; 010D F7D1
			tst	ZL				; 010E 23EE
avr010F:	brne	avr0108		; 010F F7C1
			sts	0x04F2, YH		; 0110 93D0 04F2 STORE checksum
			sts	0x04F3, YL		; 0112 93C0 04F3
avr0114:	ret					; 0114 9508
;-------------------------------------------------------------------------
;
; EEPROM Read  first 8 locations and set 0x052d to 0x40 if all OK and 0x4C2 to count (8) if all OK
; 0x4C2 is address of external EEPROM
; 0x52D is size of EEPROM in K bytes

sub0115:	ldi	r20, 0x00		; 0115 E040
			ldi	r21, 0x08		; 0116 E058
avr0117:	ldi	XH, 0x00		; 0117 E0B0
			ldi	XL, 0x00		; 0118 E0A0
			mov	r17, r20		; 0119 2F14
			call	sub08B3		; 011A 940E 08B3
			brsh	avr011E		; 011C F408
			rjmp	avr0122		; 011D C004
avr011E:	inc	r20				; 011E 9543
			dec	r21				; 011F 955A
			brne	avr0117		; 0120 F7B1
			ret					; 0121 9508
avr0122:	ldi	r16, 0x40		; 0122 E400 Store 0x52D
			sts	0x052D, r16		; 0123 9300 052D
			sts	0x04C2, r20		; 0125 9340 04C2
			ret					; 0127 9508

;-------------------------------------------------------------------------
; data area for serial speeds
avr0128:
.db			0xBF, 0x5F, 0x2F, 0x1F, 0x17, 0x0F, 0x0B, 0x07, 0x05,0x03, 0x00, 0x00

/*			0128 5FBF
			0129 1F2F
			012A 0F17
			012B 070B
			012C 0305
			012D 0000
*/
;-------------------------------------------------------------------------
; set up USART 0
; UBRR1L = 11, UBRR1H low = 00 baud = 38400 bps

sub012E:	ldi	r16, 0x0B		; 012E E00B
			out	$09, r16		; 012F B909
			ldi	r16, 0x00		; 0130 E000
			sts	0x0090, r16		; 0131 9300 0090
			in	r16, $0A		; 0133 B10A
			ori	r16, 0x18		; 0134 6108 TX and RX enable
			out	$0A, r16		; 0135 B90A
			in	r16, $02		; 0136 B102 set data direction
			andi	r16, 0xFE	; 0137 7F0E
			ori	r16, 0x02		; 0138 6002
			out	$02, r16		; 0139 B902
			nop					; 013A 0000
			in	r16, $0C		; 013B B10C read char
			ret					; 013C 9508

;-------------------------------------------------------------------------
; USART0 send
sub013D:	wdr					; 013D 95A8
			sbis	$0B, 5		; 013E 9B5D wait for txempty
			rjmp	sub013D		; 013F CFFD
			out	$0C, r16		; 0140 B90C
			ret					; 0141 9508

;-------------------------------------------------------------------------
; USART0 recieve
sub0142:	call	sub0B7C		; 0142 940E 0B7C
			call	sub0B83		; 0144 940E 0B83

avr0146:	wdr					; 0146 95A8
			sbic	$0B, 7		; 0147 995F wait for data ready
			rjmp	avr014E		; 0148 C005
			in	r16, $36		; 0149 B706 wait for timer1 overflow
			sbrs	r16, 2		; 014A FF02
			rjmp	avr0146		; 014B CFFA
			clc					; 014C 9488 timed out
			ret					; 014D 9508

avr014E:	in	r16, $0C		; 014E B10C read char
			sec					; 014F 9408
			ret					; 0150 9508
;-------------------------------------------------------------------------
; Set UP USART1
; UBRR0L = 47, UBRR1H low = 00 baud = 9600 bps
sub0151:	ldi	r16, 0x2F		; 0151 E20F set up the USART
			sts	0x0099, r16		; 0152 9300 0099
			ldi	r16, 0x00		; 0154 E000
			sts	0x0098, r16		; 0155 9300 0098
			lds	r16, 0x009A		; 0157 9100 009A
			ori	r16, 0x18		; 0159 6108 set TXEN and RXEN
			sts	0x009A, r16		; 015A 9300 009A
			in	r16, DDRD		; 015C B301 get data direction
			andi	r16, 0xFB	; 015D 7F0B set direction for tx, rx
			ori	r16, 0x08		; 015E 6008
			out	DDRD, r16		; 015F BB01
			nop					; 0160 0000
			lds	r16, 0x009C		; 0161 9100 009C read USART data reg
			ret					; 0163 9508

;-------------------------------------------------------------------------
;Output USART1
; output data from r16
avr0164:	lds	r17, 0x009B		; 0164 9110 009B wait for data reg empty
			sbrs	r17, 5		; 0166 FF15
			rjmp	avr0164		; 0167 CFFC
			sts	0x009C, r16		; 0168 9300 009C
			ret					; 016A 9508
;-------------------------------------------------------------------------
; Input USART 1
avr016B:	lds	r16, 0x009B		; 016B 9100 009B wait for data rx complete
			sbrs	r16, 7		; 016D FF07
			rjmp	avr016B		; 016E CFFC
			lds	r16, 0x009C		; 016F 9100 009C get data
			ret					; 0171 9508
;-------------------------------------------------------------------------
;USART RX Complete Interrupt
; doesn't actually do anything !
avr0172:	push	r16			; 0172 930F
			in	r16, SREG		; 0173 B70F
			push	r16			; 0174 930F
			nop					; 0175 0000
			nop					; 0176 0000
			nop					; 0177 0000
			nop					; 0178 0000
			nop					; 0179 0000
			pop	r16				; 017A 910F
			out	SREG, r16		; 017B BF0F
			pop	r16				; 017C 910F
			reti				; 017D 9518
;-------------------------------------------------------------------------
;Initialisation Routines

sub017E:	rcall	sub02B6		; 017E D137 Tri-state all IO

			rcall	sub0228		; 017F D0A8 Get zero data from EEPROM into 0x340..

			rcall	sub023B		; 0180 D0BA Get Initial position data from EEPROM to 0x300.., 0x320..

			rcall	sub024E		; 0181 D0CC Get direction data from EEPROM into 0x407.. 0x4EA

			rcall	sub021D		; 0182 D09A Initialise speeds in 0x3c0.. and 0x4d4

			rcall	sub02A8		; 0183 D124 enable watchdog

			ldi	r16, 0x84		; 0184 E804 enable adc and interrupt
			out	$06, r16		; 0185 B906

			ldi	r16, 0x05		; 0186 E005 set TCCR0 Tosc/128 = 17.3 usec
			out	$33, r16		; 0187 BF03
	
			ldi	r16, 0x01		; 0188 E001 set TIMASK Overflow Int enable
			out	$37, r16		; 0189 BF07

			rcall	sub0191		; 018A D006 RAM initialise

			rcall	sub081D		; 018B D691 Open 2 wire interface

			rcall	sub02B2		; 018C D125 Timer 3 setup

			ldi	r16, 0x03		; 018D E003 Set the serial port speed initialise x4c4 with 0x3f
			call	sub25F5		; 018E 940E 25F5
			ret					; 0190 9508
;-------------------------------------------------------------------------
;Initialise RAM

sub0191:	rcall	nsub0263	; new 2.7 code
			
			rcall	sub0211		; 0191 D07F initalise 0x100

			rcall	sub01A7		; 0192 D014

			rcall	sub021D		; 0193 D089

			rcall	sub0199		; 0194 D004

			ldi	r16, 0x00		; 0195 E000  Timer 3 Normal Port functions
			sts	0x008B, r16		; 0196 9300 008B

			ret					; 0198 9508
	
;-------------------------------------------------------------------------
; initialise Y and X and their save locations
; Y = 0xd00, x=0010 in 0xcfe may be IM program counter

sub0199:	ldi	YH, 0x0D		; 0199 E0DD May be the IM stack
			ldi	YL, 0x00		; 019A E0C0
			adiw	YL, 0x02	; 019B 9622
			sts	0x04D6, YH		; 019C 93D0 04D6 location where y is saved
			sts	0x04D5, YL		; 019E 93C0 04D5
			ldi	XH, 0x00		; 01A0 E0B0
avr01A1:	ldi	XL, 0x10		; 01A1 E1A0
		sts	0x0CFF, XH			; 01A2 93B0 0CFF location where x is saved
		sts	0x0CFE, XL			; 01A4 93A0 0CFE
		ret						; 01A6 9508
;-------------------------------------------------------------------------
; data memory initialise
sub01A7:	clr	r25				; 01A7 2799

			clr	r16				; 01A8 2700
			sts	0x04D3, r16		; 01A9 9300 04D3
			sts	0x04D7, r16		; 01AB 9300 04D7 Phase number = 0
			clr	r16				; 01AD 2700
			sts	0x04EB, r16		; 01AE 9300 04EB
			sts	0x04EC, r16		; 01B0 9300 04EC
			sts	0x04ED, r16		; 01B2 9300 04ED
			sts	0x04EE, r16		; 01B4 9300 04EE
			sts	0x04CA, r16		; 01B6 9300 04CA
			sts	0x04CB, r16		; 01B8 9300 04CB
			sts	0x04CC, r16		; 01BA 9300 04CC
			sts	0x04CD, r16		; 01BC 9300 04CD

			clr	r16				; 01BE 2700
			sts	0x04DE, r16		; 01BF 9300 04DE Clear delay counter
			sts	0x04DC, r16		; 01C1 9300 04DC
			sts	0x04DD, r16		; 01C3 9300 04DD
			clr	r16				; 01C5 2700
			sts	0x04D0, r16		; 01C6 9300 04D0

			ldi	r16, 0x00		; 01C8 E000		Clear Timer 0 int in progress (bit 7)
			sts	0x04F4, r16		; 01C9 9300 04F4

			ldi	r16, 0x00		; 01CB E000
			sts	0x04F0, r16		; 01CC 9300 04F0

			ldi	r16, 0x00		; 01CE E000
			sts	0x04EF, r16		; 01CF 9300 04EF

			ldi	XH, 0x0F		; 01D1 E0BF get 0x0FB4 from internal EEPROM
			ldi	XL, 0xB4		; 01D2 EBA4
			rcall	sub07F6		; 01D3 D622
			sts	0x04D1, r16		; 01D4 9300 04D1

			clr	r16				; 01D6 2700
			sts	0x04D8, r16		; 01D7 9300 04D8

			ldi	r16, 0x00		; 01D9 E000    Clear controller Status
			sts	0x04D2, r16		; 01DA 9300 04D2

			ldi	r16, 0x00		; 01DC E000
			sts	0x050A, r16		; 01DD 9300 050A

			ldi	r16, 0x64		; 01DF E604
			sts	0x0505, r16		; 01E0 9300 0505 set temp to 100
			ldi	r16, 0x00		; 01E2 E000
			sts	0x04C3, r16		; 01E3 9300 04C3
			ldi	r16, 0x00		; 01E5 E000
			sts	0x0511, r16		; 01E6 9300 0511
			sts	data0513, r16		; 01E8 9300 0513

			ldi	r16, 0x00		; 01EA E000 Set for all GWS gyro
			sts	0x052F, r16		; 01EB 9300 052F

			ldi	r16, 0x2C		; 01ED E20C 0x530 for 4 locations = 44
			ldi	r17, 0x04		; 01EE E014
			ldi	YH, 0x05		; 01EF E0D5
			ldi	YL, 0x30		; 01F0 E3C0
avr01F1:	st	Y+, r16			; 01F1 9309
			dec	r17				; 01F2 951A
			brne	avr01F1		; 01F3 F7E9

			ldi	r16, 0x2C		; 01F4 E20C 0x574 for 32 locations = 44
			ldi	r17, 0x20		; 01F5 E210
			ldi	YH, 0x05		; 01F6 E0D5
			ldi	YL, 0x74		; 01F7 E7C4
avr01F8:	st	Y+, r16			; 01F8 9309
			dec	r17				; 01F9 951A
			brne	avr01F8		; 01FA F7E9

			ldi	r16, 0x00		; 01FB E000 0x534 for 32 locations = 0
			ldi	r17, 0x20		; 01FC E210
			ldi	YH, 0x05		; 01FD E0D5
			ldi	YL, 0x34		; 01FE E3C4
avr01FF:	st	Y+, r16			; 01FF 9309
			dec	r17				; 0200 951A
			brne	avr01FF			; 0201 F7E9

			ldi	r16, 0x01		; 0202 E001 0x554 for 32 locations = 1
			ldi	r17, 0x20		; 0203 E210
			ldi	YH, 0x05		; 0204 E0D5
			ldi	YL, 0x54		; 0205 E5C4
avr0206:	st	Y+, r16			; 0206 9309
			dec	r17				; 0207 951A
			brne	avr0206		; 0208 F7E9

			ldi	r16, 0x01		; 0209 E001 0x594 for 32 locations = 1
			ldi	r17, 0x20		; 020A E210
			ldi	YH, 0x05		; 020B E0D5
			ldi	YL, 0x94		; 020C E9C4
avr020D:	st	Y+, r16			; 020D 9309
			dec	r17				; 020E 951A
			brne	avr020D		; 020F F7E9
			ret					; 0210 9508
;-------------------------------------------------------------------------
; initialise 0x100 .. for 288 to 0x0a

sub0211:	ldi	XH, 0x01		; 0211 E0B1
			ldi	XL, 0x00		; 0212 E0A0
			ldi	r16, 0x0A		; 0213 E00A
			ser	r17				; 0214 EF1F
avr0215:	st	X+, r16			; 0215 930D
			dec	r17				; 0216 951A
			brne	avr0215		; 0217 F7E9
			ldi	r17, 0x21		; 0218 E211
avr0219:	st	X+, r16			; 0219 930D
			dec	r17				; 021A 951A
			brne	avr0219		; 021B F7E9
			ret					; 021C 9508

;-------------------------------------------------------------------------
; initialise Speeds
; initialise 0x3c0.. for 20 to 0x32

sub021D:	ldi	YH, 0x03		; 021D E0D3 Initialise move speed to 50
			ldi	YL, 0xC0		; 021E ECC0
			ldi	r18, 0x20		; 021F E220
avr0220:	ldi	r16, 0x32		; 0220 E302
			st	Y+, r16			; 0221 9309
			dec	r18				; 0222 952A
			brne	avr0220		; 0223 F7E1
			ldi	r16, 0x02		; 0224 default speed = 2  into 0x4d4
			sts	0x04D4, r16		; 0225 9300 04D4
			ret					; 0227 9508
	
;-------------------------------------------------------------------------
; get zero offset data from EEPROM
; clear data memory at 0x340... for 32 bytes if internal EEPROM 0xfe0 is >0x15 or < 0xEB

sub0228:	push	XL			; 0228 93AF
			push	XH			; 0229 93BF
			ldi	XH, 0x0F		; 022A E0BF
			ldi	XL, 0xE0		; 022B EEA0
			ldi	YH, 0x03		; 022C E0D3
			ldi	YL, 0x40		; 022D E4C0
			ldi	r18, 0x20		; 022E E220
avr022F:	rcall	sub0815		; 022F D5E5 get next eeprom data and inc
			cpi	r16, 0x15		; 0230 3105 if between +/- 15 is OK
			brlo	avr0235		; 0231 F018
			cpi	r16, 0xEB		; 0232 3E0B
			brsh	avr0235		; 0233 F408
			ldi	r16, 0x00		; 0234 E000
avr0235:	st	Y+, r16			; 0235 9309
			dec	r18				; 0236 952A
			brne	avr022F		; 0237 F7B9
			pop	XH				; 0238 91BF
			pop	XL				; 0239 91AF
			ret					; 023A 9508
;------------------------------------------------------------------------
; Get initial position data from EEPROM
; set data memory at 0x300... and 0x320.. for 32 byte if
; internal EEPROM 0x0fc0 < 0x0A or > 0xBF


sub023B:	ldi	XH, 0x0F		; 023B E0BF
			ldi	XL, 0xC0		; 023C ECA0
			ldi	YH, 0x03		; 023D E0D3
			ldi	YL, 0x00		; 023E E0C0
			ldi	ZH, 0x03		; 023F E0F3
			ldi	ZL, 0x20		; 0240 E2E0
			ldi	r18, 0x20		; 0241 E220
avr0242:	rcall	sub0815		; 0242 D5D2
			cpi	r16, 0x0A		; 0243 300A
			brlo	avr0248		; 0244 F018
			cpi	r16, 0xBF		; 0245 3B0F
			brsh	avr0248		; 0246 F408
			rjmp	avr0249		; 0247 C001
avr0248:	ldi	r16, 0x64		; 0248 E604
avr0249:	st	Y+, r16			; 0249 9309
			st	Z+, r16			; 024A 9301
			dec	r18				; 024B 952A
			brne	avr0242		; 024C F7A9
			ret					; 024D 9508
;-------------------------------------------------------------------------
;load some data from internal EEPROM to set RAM
; servo direction

sub024E:	ldi	XH, 0x0F		; 024E E0BF load 0x4e7 from EEPROM 0x0FB0
			ldi	XL, 0xB0		; 024F EBA0
			rcall	sub0815		; 0250 D5C4
			sts	0x04E7, r16		; 0251 9300 04E7
			ldi	XH, 0x0F		; 0253 E0BF load 0x4e8 from EEPROM 0x0FB1
			ldi	XL, 0xB1		; 0254 EBA1
			rcall	sub0815		; 0255 D5BF
			sts	0x04E8, r16		; 0256 9300 04E8
			ldi	XH, 0x0F		; 0258 E0BF load 0x4e9 from EEPROM 0x0FB2
			ldi	XL, 0xB2		; 0259 EBA2
			rcall	sub0815		; 025A D5BA
			sts	0x04E9, r16		; 025B 9300 04E9
			ldi	XH, 0x0F		; 025D E0BF load 0x4eA from EEPROM 0x0FB3
			ldi	XL, 0xB3		; 025E EBA3
			rcall	sub0815		; 025F D5B5
			sts	0x04EA, r16		; 0260 9300 04EA
			ret					; 0262 9508
;------------------------------------------------------------
; New 2.7 Code Reads EEPROM loc
nsub0263:	ldi		XH, 0x0F
			ldi		XL, 0xAF
			rcall	sub0815
			sts		0x0CFC, r16
			ret

;-------------------------------------------------------------------------
; long wait for USART1 rx rdy
sub0263:	push	r16			; 0263 930F
			push	r17			; 0264 931F
			push	r18			; 0265 932F
			push	r19			; 0266 933F
			ldi	r16, 0x0C		; 0267 E00C
avr0268:	ldi	r17, 0x00		; 0268 E010
avr0269:	ldi	r18, 0x00		; 0269 E020
avr026A:	wdr					; 026A 95A8
			lds	r19, 0x009B		; 026B 9130 009B test USART1 rx rdy
			sbrc	r19, 7		; 026D FD37
			rjmp	avr0275		; 026E C006
			dec	r18				; 026F 952A
			brne	avr026A		; 0270 F7C9
			dec	r17				; 0271 951A
			brne	avr0269		; 0272 F7B1
			dec	r16				; 0273 950A
			brne	avr0268		; 0274 F799
avr0275:	pop	r19				; 0275 913F
			pop	r18				; 0276 912F
			pop	r17				; 0277 911F
			pop	r16				; 0278 910F
			ret					; 0279 9508
;-------------------------------------------------------------------------
; medium wait for USART1 rx rdy
sub027A:	push	r16			; 027A 930F
			push	r17			; 027B 931F
			push	r18			; 027C 932F
			push	r19			; 027D 933F
			ldi	r16, 0x06		; 027E E006
avr027F:	ldi	r17, 0x00		; 027F E010
avr0280:	ldi	r18, 0x00		; 0280 E020
avr0281:	wdr					; 0281 95A8
			lds	r19, 0x009B		; 0282 9130 009B
			sbrc	r19, 7		; 0284 FD37
			rjmp	avr028C		; 0285 C006
			dec	r18				; 0286 952A
			brne	avr0281		; 0287 F7C9
			dec	r17				; 0288 951A
			brne	avr0280		; 0289 F7B1
			dec	r16				; 028A 950A
			brne	avr027F		; 028B F799
avr028C:	pop	r19				; 028C 913F
			pop	r18				; 028D 912F
			pop	r17				; 028E 911F
			pop	r16				; 028F 910F
			ret					; 0290 9508
;-------------------------------------------------------------------------
; short wait for USART1 rx rdy
sub0291:	push	r16			; 0291 930F
			push	r17			; 0292 931F
			push	r18			; 0293 932F
			push	r19			; 0294 933F
			ldi	r16, 0x02		; 0295 E002
avr0296:	ldi	r17, 0x00		; 0296 E010
avr0297:	ldi	r18, 0x00		; 0297 E020
sub0298:	wdr					; 0298 95A8
			lds	r19, 0x009B		; 0299 9130 009B
			sbrc	r19, 7		; 029B FD37
			rjmp	avr02A3		; 029C C006
			dec	r18				; 029D 952A
			brne	sub0298		; 029E F7C9
			dec	r17				; 029F 951A
			brne	avr0297		; 02A0 F7B1
			dec	r16				; 02A1 950A
			brne	avr0296		; 02A2 F799
avr02A3:	pop	r19				; 02A3 913F
			pop	r18				; 02A4 912F
			pop	r17				; 02A5 911F
			pop	r16				; 02A6 910F
			ret					; 02A7 9508

;-------------------------------------------------------------------------
; enable watchdog timer
;
sub02A8:	ldi	r16, 0x0F		; 02A8 E00F enable watchdog timer at 1.8 seconds
			out	$21, r16		; 02A9 BD01
			ret					; 02AA 9508
;-------------------------------------------------------------------------
; disable watchdog timer
sub02AB:	ldi	r16, 0x18		; 02AB E108
			out	$21, r16		; 02AC BD01
			ldi	r16, 0x10		; 02AD E100
			out	$21, r16		; 02AE BD01
			ldi	r16, 0x00		; 02AF E000
			out	$21, r16		; 02B0 BD01
			ret					; 02B1 9508

;-------------------------------------------------------------------------
; Timer 3 ( PWM) clk source = ClkIO = 7.3728Mhz
sub02B2:	ldi	r16, 0x01		; 02B2 E001
			sts	0x008A, r16		; 02B3 9300 008A
			ret					; 02B5 9508
;-------------------------------------------------------------------------
; Tristate all IO

sub02B6:	ldi	r16, 0x00		; 02B6 E000

			sts	0x0061, r16		; 02B7 9300 0061 DDRF = 0
			ldi	r16, 0x00		; 02B9 E000
			out	DDRA, r16		; 02BA BB0A
			out	DDRB, r16		; 02BB BB07
			out	DDRC, r16		; 02BC BB04
			out	DDRD, r16		; 02BD BB01
			out	$02, r16		; 02BE B902 DDRG = 0
			sts	0x0064, r16		; 02BF 9300 0064
			ret					; 02C1 9508


;-------------------------------------------------------------------------
; Turn on LED 1
sub02C2:	lds	r16, 0x0065		; 02C2 9100 0065 get port G
			andi	r16, 0xEF	; 02C4 7E0F clear bit 4
			sts	0x0065, r16		; 02C5 9300 0065
			lds	r16, 0x0064		; 02C7 9100 0064 get g dir 
			ori	r16, 0x10		; 02C9 6100set bit 4
			sts	0x0064, r16		; 02CA 9300 0064
			ret					; 02CC 9508
;-------------------------------------------------------------------------
; Turn on LED 0
sub02CD:	lds	r16, 0x0065		; 02CD 9100 0065
			andi	r16, 0xF7	; 02CF 7F07
			sts	0x0065, r16		; 02D0 9300 0065
			lds	r16, 0x0064		; 02D2 9100 0064
			ori	r16, 0x08		; 02D4 6008
			sts	0x0064, r16		; 02D5 9300 0064
			ret					; 02D7 9508
;-------------------------------------------------------------------------
; turn off LED 1
avr02D8:	lds	r16, 0x0065		; 02D8 9100 0065
			ori	r16, 0x10		; 02DA 6100
			sts	0x0065, r16		; 02DB 9300 0065
			lds	r16, 0x0064		; 02DD 9100 0064
			ori	r16, 0x10		; 02DF 6100
			sts	0x0064, r16		; 02E0 9300 0064
			ret					; 02E2 9508
;-------------------------------------------------------------------------
; turn off LED 0
avr02E3:	lds	r16, 0x0065		; 02E3 9100 0065
			ori	r16, 0x08		; 02E5 6008
			sts	0x0065, r16		; 02E6 9300 0065
			lds	r16, 0x0064		; 02E8 9100 0064
			ori	r16, 0x08		; 02EA 6008
			sts	0x0064, r16		; 02EB 9300 0064
			ret					; 02ED 9508


;-----------------------------------------------------------
; New 2.7 code
; clears RAM 0x0E00 to 0xEFF
nsub02F5:	push	r16
			push	r17
			ldi		YH, 0x0E
			ldi		YL, 0x00
			clr		r16
			clr		r17
loop02F5:	st		Y+, r16
			dec		r17
			brne	loop02f5
			pop		r17
			pop		r16
			ret
;-------------------------------------------------------------------------
;16 by 16 unsigned muliply 
; r16 = multiplicand low  r17 = multiplicand high
; r18 = multiplier low r19 = multiplier high
; r18 = product low, r19 = product mid low, r20 = product mid high, r21 = product high
sub02EE:	clr	r21			; 02EE 2755
			clr	r20			; 02EF 2744
			ldi	r22, 0x10	; 02F0 E160 
			lsr	r19			; 02F1 9536
			ror	r18			; 02F2 9527
avr02F3:	brsh	avr02F6	; 02F3 F410
			add	r20, r16	; 02F4 0F40
			adc	r21, r17	; 02F5 1F51
avr02F6:	ror	r21			; 02F6 9557
			ror	r20			; 02F7 9547
			ror	r19			; 02F8 9537
			ror	r18			; 02F9 9527
			dec	r22			; 02FA 956A
			brne	avr02F3	; 02FB F7B9
			ret				; 02FC 9508
;------------------------------------------------------------------------
; 16/16 unsigned division
; Remainder  = r16(l), r17(h)
; Dividend = r18(l), r19(h)
; Divisor = r20 (l), r21(h)
; Result = r18 (l), r19(h)
sub02FD:	clr	r16			; 02FD 2700
			sub	r17, r17	; 02FE 1B11
			ldi	r22, 0x11	; 02FF E161 loop count
avr0300:	rol	r18			; 0300 1F22
			rol	r19			; 0301 1F33
			dec	r22			; 0302 956A
			brne	avr0305	; 0303 F409
			ret				; 0304 9508

avr0305:	rol	r16			; 0305 1F00
			rol	r17			; 0306 1F11
			sub	r16, r20	; 0307 1B04
			sbc	r17, r21	; 0308 0B15
			brsh	avr030E	; 0309 F420
			add	r16, r20	; 030A 0F04
			adc	r17, r21	; 030B 1F15
			clc				; 030C 9488
			rjmp	avr0300	; 030D CFF2
avr030E:	sec				; 030E 9408
			rjmp	avr0300	; 030F CFF0
			ret				; 0310 9508
;-------------------------------------------------------------------------
;This is the F0 response string
avr0311:

.db			0x02, 0x02, 0x07, 0x04, 0xBE, 0x05, 0x00, 0x00

/*avr0311:	0311 0202 This is the F0 response string
			0312 0405
			0313 05BE
			0314 0000
			*/
;-------------------------------------------------------------------------
;-------------------------------------------------------------------------

; MAIN COMMAND DECODER 

;------------------------------------------------------------------------
sub0315:	lds	r16, 0x009B		; 0315 9100 009B
			sbrs	r16, 7		; 0317 FF07
			ret					; 0318 9508 return if no char

			rcall	sub0629		; 0319 D30F get the character
;-------------------
; New 2.7 code
			cpi		r16, 0xB5
			brne	navr0331
			rcall	sub0641
			ret
;-----------------------
navr0331:	mov	r17, r16		; 031A 2F10 Command Decoder
			andi	r17, 0xF0	; 031B 7F10

			cpi	r17, 0xF0		; 031C 3F10
			breq	avr0329		; 031D F059

			cpi	r17, 0xE0		; 031E 3E10
			breq	avr032B		; 031F F059

			cpi	r17, 0xD0		; 0320 3D10
			breq	avr032D		; 0321 F059

			cpi	r17, 0xB0		; 0322 3B10
			breq	avr032E		; 0323 F051

			cpi	r17, 0xA0		; 0324 3A10
			breq	avr0330		; 0325 F051

			cpi	r17, 0x80		; 0326 3810
			brlo	sub0331		; 0327 F048 is < 80 ?
			brne	avr0332		; 0328 F449 none of the above (9x,Cx)

avr0329:	rcall	sub0641		; 0329 D317 Command Fx, echo
			rjmp	avr0334		; 032A C009

avr032B:	rcall	sub0641		; 032B D315 Command Ex, echo
			rjmp	avr0362		; 032C C035

avr032D:	rjmp	avr039B		; 032D C06D Command Dx

avr032E:	rcall	sub0641		; 032E D312 Command Bx, echo
			rjmp	avr03CD		; 032F C09D

avr0330:	rjmp	avr038F		; 0330 C05E Command Ax

sub0331:	rjmp	avr03DD		; 0331 C0AB Command < 80

avr0332:	rcall	sub0641		; 0332 D30E Command 9x, echo
			rjmp	avr04D4		; 0333 C1A0 

;-----------------------------------------------------------------
;Fx Commands
;----------------------------------------------------------------
; FO Controller Info.
avr0334:	cpi	r16, 0xF0		; 0334 3F00 Command Fx
			brne	avr0337		; 0335 F409
			rjmp	avr04D5		; 0336 C19E
;-----------------------------------------------------------------
; F1 ?? EEPROM
avr0337:	cpi	r16, 0xF1		; 0337 3F01 F1 Something on 2 wire
			brne	avr033A		; 0338 F409
			rjmp	avr04E9		; 0339 C1AF

avr033A:	cpi	r16, 0xF2		; 033A 3F02  F2 read EEPROM
			brne	avr033D		; 033B F409
			rjmp	avr058A		; 033C C24D

avr033D:	cpi	r16, 0xF3		; 033D 3F03 F3 sets bits 3 and 4 in 0x4d2
			brne	avr0340		; 033E F409
			rjmp	avr059B		; 033F C25B
	
avr0340:	cpi	r16, 0xF4		; 0340 3F04 F4 more 2 wire
			brne	avr0343		; 0341 F409
			rjmp	avr05A2		; 0342 C25F

avr0343:	cpi	r16, 0xF5		; 0343 3F05 F5 clears int, clears bit 6 in 0x4d2, set high baud rate
			brne	avr0346		; 0344 F409
			rjmp	avr04C8		; 0345 C182

avr0346:	cpi	r16, 0xF6		; 0346 3F06 F6 
			brne	avr0349		; 0347 F409
			rjmp	avr04CB		; 0348 C182

avr0349:	cpi	r16, 0xF7		; 0349 3F07 F7 read data memory
			brne	avr034C		; 034A F409
			rjmp	avr05BF		; 034B C273

avr034C:	cpi	r16, 0xF8		; 034C 3F08 F8 write data memory
			brne	avr034F		; 034D F409
			rjmp	avr05D0		; 034E C281

avr034F:	cpi	r16, 0xFA		; 034F 3F0A FA Controller stop
			brne	avr0352		; 0350 F409
			rjmp	avr05E2		; 0351 C290

avr0352:	cpi	r16, 0xFB		; 0352 3F0B FB Controller start
			brne	avr0355		; 0353 F409
			rjmp	avr05F6		; 0354 C2A1

avr0355:	cpi	r16, 0xFC		; 0355 3F0C FC controller reset
			brne	avr0358		; 0356 F409
			rjmp	avr0602		; 0357 C2AA

avr0358:	cpi	r16, 0xFD		; 0358 3F0D FD not used
			brne	avr035B		; 0359 F409
			rjmp	avr0606		; 035A C2AB

avr035B:	cpi	r16, 0xFE		; 035B 3F0E FE not used
			brne	avr035E		; 035C F409
			rjmp	avr0607		; 035D C2A9

avr035E:	cpi	r16, 0xFF		; 035E 3F0F FF
			brne	avr0361		; 035F F409
			rjmp	avr0608		; 0360 C2A7

avr0361:	rjmp	avr04C2		; 0361 C160
;-------------------------------------------------------------------------
; Ex Commands

avr0362:	lds	r17, 0x04D2		; 0362 9110 04D2 set bit 6 in 0x4d2
			ori	r17, 0x20		; 0364 6210
			sts	0x04D2, r17		; 0365 9310 04D2
;-------------------------------------------------------------
;Command E0: Port Bit Read

avr0367:	cpi	r16, 0xE0		; 0367 3E00
			brne	avr036A		; 0368 F409
			rjmp	avr0468		; 0369 C0FE
;-------------------------------------------------------------
; Command E1: Port Byte Read

avr036A:	cpi	r16, 0xE1		; 036A 3E01
			brne	avr036D		; 036B F409
			rjmp	avr0473		; 036C C106
;-------------------------------------------------------------
; Command E2: ADC Read

avr036D:	cpi	r16, 0xE2		; 036D 3E02
			brne	avr0370		; 036E F409
			rjmp	avr047D		; 036F C10D
;--------------------------------------------------------------
; Command E3 Port Bit Write

avr0370:	cpi	r16, 0xE3		; 0370 3E03
			brne	avr0373		; 0371 F409
			rjmp	avr0487		; 0372 C114
;----------------------------------------------------------
;Command E4 Port Byte Write

avr0373:	cpi	r16, 0xE4		; 0373 3E04
			brne	avr0376		; 0374 F409
			rjmp	avr0491		; 0375 C11B
;----------------------------------------------------------
; Command E5 PWM Write

avr0376:	cpi	r16, 0xE5		; 0376 3E05
			brne	avr0379		; 0377 F409
			rjmp	avr049A		; 0378 C121
;----------------------------------------------------------
;Command E6 Write Servo Position

avr0379:	cpi	r16, 0xE6		; 0379 3E06
			brne	avr037C		; 037A F409
			rjmp	avr04A3		; 037B C127
;----------------------------------------------------------
;Command E7 Turn On servo

avr037C:	cpi	r16, 0xE7		; 037C 3E07
			brne	avr037F		; 037D F409
			rjmp	avr04AC		; 037E C12D
;----------------------------------------------------------
;Command E8 Turn off servo
avr037F:	cpi	r16, 0xE8		; 037F 3E08
			brne	avr0382		; 0380 F409
			rjmp	avr04B1		; 0381 C12F
;-----------------------------------------------------------
;Command E9 Set Servo Speed

avr0382:	cpi	r16, 0xE9		; 0382 3E09
			brne	sub0385		; 0383 F409
			rjmp	avr04B6		; 0384 C131

;-------------------------------------------------------------------------
; Command EA ? AI motor ?
sub0385:	cpi	r16, 0xEA		; 0385 3E0A
			brne	avr0388		; 0386 F409
			rjmp	avr04BC		; 0387 C134
;------------------------------------------------------------
;Command EB Write Servo Positions Synchronous Range

avr0388:	cpi	r16, 0xEB		; 0388 3E0B
			brne	avr038B		; 0389 F409
			rjmp	avr04BF		; 038A C134
;------------------------------------------------------------
;Command EC Download

avr038B:	cpi	r16, 0xEC		; 038B 3E0C
			brne	navr03A5		; 038C F409
			rjmp	avr0522		; 038D C194
;-----------------------------
;New 2.7 code Command ED
navr03a5:	cpi		r16, 0xED
			brne	avr038E
			rjmp	navr058E

avr038E:	rjmp	avr04C2		; 038E C133

;---------------------------------------------------------------------
; Ax commands

;-------------------------------------------------------
; Command A0
avr038F:	cpi	r16, 0xA0		; 038F 3A00
			brne	avr0392		; 0390 F409
			rjmp	avr0397		; 0391 C005
;-------------------------------------------------------------------------
;Command AF
avr0392:	cpi	r16, 0xAF		; 0392 3A0F
			brne	avr0395		; 0393 F409
			rjmp	avr0399		; 0394 C004
; not A0 or AF
avr0395:	sei					; 0395 9478
			rjmp	avr04C2		; 0396 C12B

avr0397:	jmp	avr4EE9			; 0397 940C 4EE9 command A0

avr0399:	jmp	avr4FDE			; 0399 940C 4FDE command AF
	
;------------------------------------------------------------------------
; Here for commands Dx
; command Dx
avr039B:	lds	r17, 0x04D2		; 039B 9110 04D2
;-------------------------------------------------------------------------
; Command D0
; servos off
			cpi	r16, 0xD0		; 039D 3D00
			brne	avr03A5		; 039E F431
			andi	r17, 0xFD	; 039F 7F1D clear bit 2 in 0x4d2
			sts	0x04D2, r17		; 03A0 9310 04D2
avr03A2:	ldi	r16, 0xD0		; 03A2 ED00
			jmp	avr4474			; 03A3 940C 4474
;-------------------------------------------------------------------------
; Command D1
; servos on
avr03A5:	cpi	r16, 0xD1		; 03A5 3D01
			brne	avr03AD		; 03A6 F431

			ori	r17, 0x02		; 03A7 6012 set bit 2 in 0x4d2
			sts	0x04D2, r17		; 03A8 9310 04D2
			ldi	r16, 0xD0		; 03AA ED00
			jmp	avr4474			; 03AB 940C 4474
;-------------------------------------------------------------------------
; Command D2 
; Read a servo position
avr03AD:	cpi	r16, 0xD2		; 03AD 3D02
			brne	avr03B0		; 03AE F409
			rjmp	avr042A		; 03AF C07A
;-------------------------------------------------------------------------
; Command D3 
;Read Group8 0 servo position
avr03B0:	cpi	r16, 0xD3		; 03B0 3D03
			brne	sub03B3		; 03B1 F409
			rjmp	avr0437		; 03B2 C084
;-------------------------------------------------------------------------
; Command D4 
; Read Group8 1 servo position
sub03B3:	cpi	r16, 0xD4		; 03B3 3D04
			brne	avr03B6		; 03B4 F409
			rjmp	avr043B		; 03B5 C085
;-------------------------------------------------------------------------
; Command D5 
; Read Group8 2 servo position
avr03B6:	cpi	r16, 0xD5		; 03B6 3D05
			brne	avr03B9		; 03B7 F409
			rjmp	avr043F		; 03B8 C086
;-------------------------------------------------------------------------
; Command D6 
; Read Group8 3 servo position

avr03B9:	cpi	r16, 0xD6		; 03B9 3D06
			brne	avr03BC		; 03BA F409
			rjmp	avr0443		; 03BB C087
;-------------------------------------------------------------------------
; Command D7
; Read Group6 0 servo position

avr03BC:	cpi	r16, 0xD7		; 03BC 3D07
			brne	sub03BF		; 03BD F409
			rjmp	avr0447		; 03BE C088 echo, r19 = 6, r20 = 0
;-------------------------------------------------------------------------
; Command D8 
; Read Group6 1 servo position

sub03BF:	cpi	r16, 0xD8		; 03BF 3D08
			brne	avr03C2		; 03C0 F409
			rjmp	avr044B		; 03C1 C089 echo, r19= 6 r20 = 6
;-------------------------------------------------------------------------
; Command D9
; Read Group6 2 servo position

avr03C2:	cpi	r16, 0xD9		; 03C2 3D09
			brne	avr03C5		; 03C3 F409
			rjmp	avr044F		; 03C4 C08A echo r19 = 6, r20 = 0xC
;-------------------------------------------------------------------------
; Command DA
; Read Group6 3 servo position

avr03C5:	cpi	r16, 0xDA		; 03C5 3D0A
			brne	avr03C8		; 03C6 F409
			rjmp	avr0453		; 03C7 C08B echo r19 = 6, r20 = 0x12
;-------------------------------------------------------------------------
; Command DB
; Read Group6 4 servo position

avr03C8:	cpi	r16, 0xDB		; 03C8 3D0B
			brne	avr03CB		; 03C9 F409
			rjmp	avr0457		; 03CA C08C echo r19 = 6, r20 = 0x18

avr03CB:	sei					; 03CB 9478 enable interrupts
			rjmp	avr04C2		; 03CC C0F5

;------------------------------------------------------------------
; Bx Commands

avr03CD:	cpi	r16, 0xB0		; 03CD 3B00 Test for wait
			brne	avr03D0		; 03CE F409
			rjmp	avr03E1		; 03CF C011

avr03D0:	cpi	r16, 0xB1		; 03D0 3B01 Set PTP
			brne	avr03D3		; 03D1 F409
			rjmp	avr03EC		; 03D2 C019

avr03D3:	cpi	r16, 0xB2		; 03D3 3B02 Set Speed
			brne	avr03D6		; 03D4 F409
			rjmp	avr03F1		; 03D5 C01B

avr03D6:	cpi	r16, 0xB3		; 03D6 3B03
			brne	avr03D9		; 03D7 F409
			rjmp	avr03FC		; 03D8 C023 Read internal chip EEPROM

avr03D9:	cpi	r16, 0xB4		; 03D9 3B04
			brne	avr03DC		; 03DA F409
			rjmp	avr040D		; 03DB C031 write on chip EEPROM

avr03DC:	rjmp	avr04C2		; 03DC C0E5 jump return

;-------------------------------------------------------------
; here if command is less than 0x80
avr03DD:	ldi	YL, low(data0140)		; 03DD E4C0 put the value into ram 0x140
			ldi	YH, high(data0140)		; 03DE E0D1
			st	Y, r16			; 03DF 8308
			rjmp	avr04C2		; 03E0 C0E1 jump return
;----------------------------------------------------------------------------
;here on command B0 Test for BUSY used to wait (motors in motion)
; return 00 or FF based on 

avr03E1:	rcall	sub0629		; 03E1 D247 get next char just a dummy for response
			ldi	r20, 0x00		; 03E2 E040
			ldi	r21, 0x18		; 03E3 E158
			call	sub2310		; 03E4 940E 
			brsh	avr03E9		; 03E6 F410
			ldi	r16, 0x00		; 03E7 E000
			rjmp	avr03EA		; 03E8 C001
avr03E9:	ser	r16				; 03E9 EF0F
avr03EA:	rcall	sub0641		; 03EA D256 send either 00 or FF depending on carry
			rjmp	avr04C2		; 03EB C0D6 jump return
;----------------------------------------------------------------------------
; here on command B1 Set PTP
;store char in 0x4da
avr03EC:	rcall	sub0629		; 03EC D23C get next char
			sts	0x04DA, r16		; 03ED 9300 04DA save in 0x4da
			rcall	sub0641		; 03EF D251 and echo back
;-------------------------------------------------------------------------
; here for F6 command do nothing

sub03F0:	rjmp	avr04C2		; 03F0 C0D1

;-------------------------------------------------------------------------
; here for command B2 Set Speed
; sets location 0x4d4 to value between 1 and 15
avr03F1:	rcall	sub0629		; 03F1 D237 get next char
			cpi	r16, 0x10		; 03F2 3100 if ge 0x10 then = 0x0f
			brlo	avr03F5		; 03F3 F008
			ldi	r16, 0x0F		; 03F4 E00F
avr03F5:	tst	r16				; 03F5 2300 if  val = 0, then = 1
			brne	avr03F8		; 03F6 F409
			ldi	r16, 0x01		; 03F7 E001
avr03F8:	sts	0x04D4, r16		; 03F8 9300 04D4 store in 0x4d4
			rcall	sub0641		; 03FA D246 echo
			rjmp	avr04C2		; 03FB C0C6 jump return

;------------------------------------------------------------
; here for command B3
; read on chip EEPROM
avr03FC:	push	XL			; 03FC 93AF
			push	XH			; 03FD 93BF
			rcall	sub0629		; 03FE D22A get next char
			brlo	avr040A		; 03FF F050 timeout
			rcall	sub0641		; 0400 D240 echo
			mov	XL, r16			; 0401 2FA0 X = next two byte address
			rcall	sub0629		; 0402 D226 get next char
			brlo	avr040A		; 0403 F030 echo
			rcall	sub0641		; 0404 D23C
			mov	XH, r16			; 0405 2FB0
			rcall	sub0629		; 0406 D222 get next char
			brlo	avr040A		; 0407 F010 timeout
			rcall	sub07F6		; 0408 D3ED read on chip EEPROM
			rcall	sub0641		; 0409 D237 send
avr040A:	pop	XH				; 040A 91BF
			pop	XL				; 040B 91AF
			rjmp	avr04D4		; 040C C0C7 jump return
;------------------------------------------------------------------------
; here for command B4
; write to chip EEPROM
avr040D:	push	XL			; 040D 93AF
			push	XH			; 040E 93BF
			com	r16				; 040F 9500 ;  complement B4
			mov	r19, r16		; 0410 2F30
			rcall	sub0629		; 0411 D217get next char
			brlo	avr0427		; 0412 F0A0 timeout
			rcall	sub0641		; 0413 D22D echo
			cp	r16, r19		; 0414 1703 = 4b (complement B4)
			brne	avr0427		; 0415 F489 bad then exit
			rcall	sub0629		; 0416 D212 get X
			brlo	avr0427		; 0417 F078
			rcall	sub0641		; 0418 D228
			mov	XL, r16			; 0419 2FA0
			rcall	sub0629		; 041A D20E
			brlo	avr0427		; 041B F058
			rcall	sub0641		; 041C D224
			mov	XH, r16			; 041D 2FB0
			rcall	sub0629		; 041E D20A get data to write
			brlo	avr0427		; 041F F038
			rcall	sub0641		; 0420 D220
			mov	r19, r16		; 0421 2F30
			rcall	sub07EE		; 0422 D3CB write eeprom
			rcall	sub0629		; 0423 D205
			brlo	avr0427		; 0424 F010
			mov	r16, r19		; 0425 2F03
			rcall	sub0641		; 0426 D21A
avr0427:	pop	XH				; 0427 91BF
			pop	XL				; 0428 91AF
			rjmp	avr04D4		; 0429 C0AA jump return

;-----------------------------------------------------
; Command D2
; Read a servo position
avr042A:	rcall	sub0641		; 042A D216 echo
			rcall	sub0629		; 042B D1FD get next char
			brlo	avr0467		; 042C F1D0 timeout
			rcall	sub0641		; 042D D213 echo
			mov	r19, r16		; 042E 2F30 r19 = servo number
			rcall	sub0629		; 042F D1F9 get next char
			brlo	avr0467		; 0430 F1B0 timeout
			mov	r16, r19		; 0431 2F03
			call	sub45CD		; 0432 940E 45CD
avr0434:	mov	r16, YL			; 0434 2F0C send value from YL
			rcall	sub0641		; 0435 D20B
			rjmp	avr04C2		; 0436 C08B clear bit 6 in 0x4d2 and ret
;--------------------------------------------------------------
; Command D3
; read group8 0 servo positions

avr0437:	rcall	sub0641		; 0437 D209
			ldi	r19, 0x08		; 0438 E038
			ldi	r20, 0x00		; 0439 E040
			rjmp	avr045B		; 043A C020
;--------------------------------------------------------------
; Command D4
; read group8 1 servo positions

avr043B:	rcall	sub0641			; 043B D205
			ldi	r19, 0x08		; 043C E038
			ldi	r20, 0x08		; 043D E048
			rjmp	avr045B			; 043E C01C
;---------------------------------------------------------------
; Command D5
; read group8 2 servo positions
avr043F:	rcall	sub0641		; 043F D201
			ldi	r19, 0x08		; 0440 E038
			ldi	r20, 0x10		; 0441 E140
			rjmp	avr045B		; 0442 C018
;---------------------------------------------------------------
; Command D6
; read group8 3 servo positions
avr0443:	rcall	sub0641		; 0443 D1FD
			ldi	r19, 0x08		; 0444 E038
			ldi	r20, 0x18		; 0445 E148
			rjmp	avr045B		; 0446 C014
;---------------------------------------------------------------
; Command D7
; read group6 0 servo positions

avr0447:	rcall	sub0641		; 0447 D1F9
			ldi	r19, 0x06		; 0448 E036
			ldi	r20, 0x00		; 0449 E040
			rjmp	avr045B		; 044A C010
;---------------------------------------------------------------
; Command D8
; read group6 1 servo positions
avr044B:	rcall	sub0641		; 044B D1F5
			ldi	r19, 0x06		; 044C E036
			ldi	r20, 0x06		; 044D E046
avr044E:	rjmp	avr045B		; 044E C00C
;---------------------------------------------------------------
; Command D9
; read group6 2 servo positions
avr044F:	rcall	sub0641		; 044F D1F1
			ldi	r19, 0x06		; 0450 E036
			ldi	r20, 0x0C		; 0451 E04C
			rjmp	avr045B		; 0452 C008
;---------------------------------------------------------------
; Command DA
; read group6 3 servo positions
avr0453:	rcall	sub0641		; 0453 D1ED
			ldi	r19, 0x06		; 0454 E036
			ldi	r20, 0x12		; 0455 E142
			rjmp	avr045B		; 0456 C004
;---------------------------------------------------------------
; Command DB
; read group6 4 servo positions
avr0457:	rcall	sub0641			; 0457 D1E9
		ldi	r19, 0x06			; 0458 E036
		ldi	r20, 0x18			; 0459 E148
		rjmp	avr045B			; 045A C000
;---------------------------------------------------------------
; Get the servo positions and return them

avr045B:	rcall	sub0629		; 045B D1CD get next char
			brlo	avr0467		; 045C F050 timeout
			push	r19			; 045D 933F save number of bytes to return
			mov	r16, r20		; 045E 2F04
			call	sub45CD		; 045F 940E 45CD
			mov	r16, YL			; 0461 2F0C get value from YL
			rcall	sub0641		; 0462 D1DE send the value
			pop	r19				; 0463 913F
			inc	r20				; 0464 9543
			dec	r19				; 0465 953A
			brne	avr045B		; 0466 F7A1
avr0467:	rjmp	avr04C2		; 0467 C05A
;----------------------------------------------------------------
; Command E0 Port Bit Read

avr0468:	rcall	sub0629		; 0468 D1C0 get next char (Port)
			rcall	sub0641		; 0469 D1D7 echo
			mov	r17, r16		; 046A 2F10
			call	sub0BCF		; 046B 940E 0BCF get the port bit using port no in r17 and response in r18
			push	r18			; 046D 932F
			rcall	sub0629		; 046E D1BA get next char
			pop	r18				; 046F 912F
			mov	r16, r18		; 0470 2F02
			rcall	sub0641		; 0471 D1CF send response = 0 or 1
			rjmp	avr04C2		; 0472 C04F

;------------------------------------------------------------------------ 
; Command E1 Port byte read
avr0473:	rcall	sub0629		; 0473 D1B5 get next char
			rcall	sub0641		; 0474 D1CC echo
			call	sub0DDA		; 0475 940E 0DDA get the port data
			push	r18			; 0477 932F
			rcall	sub0629		; 0478 D1B0 get next char
			pop	r18				; 0479 912F
			mov	r16, r18		; 047A 2F02
			rcall	sub0641		; 047B D1C5 send the response
			rjmp	avr04C2		; 047C C045
;-------------------------------------------------------------------------
; Command E2 ADC Read
avr047D:	rcall	sub0629		; 047D D1AB
			rcall	sub0641		; 047E D1C2
			call	sub0E89		; 047F 940E 0E89
			push	r18			; 0481 932F
			rcall	sub0629		; 0482 D1A6
			pop	r18				; 0483 912F
			mov	r16, r18		; 0484 2F02
			rcall	sub0641		; 0485 D1BB
			rjmp	avr04C2		; 0486 C03B
;--------------------------------------------------------------------------
; Command E3 Port Bit Write
avr0487:	rcall	sub0629		; 0487 D1A1
			rcall	sub0641		; 0488 D1B8
			push	r16			; 0489 930F
			rcall	sub0629		; 048A D19E
			rcall	sub0641		; 048B D1B5
			pop	r17				; 048C 911F
			mov	r23, r16		; 048D 2F70
			call	sub14F4		; 048E 940E 14F4
			rjmp	avr04C2		; 0490 C031
;--------------------------------------------------------------------------
; Command E4 Port Byte Write
avr0491:	rcall	sub0629		; 0491 D197
			rcall	sub0641		; 0492 D1AE
			push	r16			; 0493 930F
			rcall	sub0629		; 0494 D194
			rcall	sub0641		; 0495 D1AB
			pop	r17				; 0496 911F
			call	sub134F		; 0497 940E 134F
			rjmp	avr04C2		; 0499 C028
;-------------------------------------------------------------------------
;Command E5 PWM Write
avr049A:	rcall	sub0629		; 049A D18E
			rcall	sub0641		; 049B D1A5
			push	r16			; 049C 930F
			rcall	sub0629		; 049D D18B
			rcall	sub0641		; 049E D1A2
			pop	r17				; 049F 911F
			call	sub1ED0		; 04A0 940E 1ED0
			rjmp	avr04C2		; 04A2 C01F
;-------------------------------------------------------------------------
;Command E6 Write Servo Position
avr04A3:	rcall	sub0629		; 04A3 D185
			rcall	sub0641		; 04A4 D19C
			push	r16			; 04A5 930F
			rcall	sub0629		; 04A6 D182
			rcall	sub0641		; 04A7 D199
			pop	r17				; 04A8 911F
			call	sub1F27		; 04A9 940E 1F27
			rjmp	avr04C2		; 04AB C016
;--------------------------------------------------------------------------
; Command E7 Turn On a servo
avr04AC:	rcall	sub0629		; 04AC D17C
			rcall	sub0641		; 04AD D193
			call	sub1D1D		; 04AE 940E 1D1D
			rjmp	avr04C2		; 04B0 C011
;--------------------------------------------------------------------------
; Command E8 Turn off a servo
avr04B1:	rcall	sub0629		; 04B1 D177
			rcall	sub0641		; 04B2 D18E
			call	sub1DEB		; 04B3 940E 1DEB
			rjmp	avr04C2		; 04B5 C00C
;--------------------------------------------------------------------------
; Command E9 Set Speed of all servo
avr04B6:	rcall	sub0629		; 04B6 D172
			rcall	sub0641		; 04B7 D189
			mov	r17, r16		; 04B8 2F10
			call	sub1EBC		; 04B9 940E 1EBC back here if bit 5 was set in 0x4D2
			rjmp	avr04C2		; 04BB C006

;--------------------------------------------------------------------------
; Command EA AI Motor ?

avr04BC:	call	sub4446		; 04BC 940E 4446 Go do some AI motor stuff
			rjmp	avr04C2		; 04BE C003
;---------------------------------------------------------------------------
; Command EB sync move

avr04BF:	call	sub064C		; 04BF 940E 064C
			rjmp	avr04C2		; 04C1 C000


avr04C2:	lds	r17, 0x04D2		; 04C2 9110 04D2 Clear bit 5 in 0x4D2
			andi	r17, 0xDF	; 04C4 7D1F
			sts	0x04D2, r17		; 04C5 9310 04D2
			rjmp	avr04D4		; 04C7 C00C
;----------------------------------------------------------------------------
; Command F5
avr04C8:	call	sub43BF		; 04C8 940E 43BF 
			rjmp	avr04CE		; 04CA C003 reset baud of USART0 to 38.4
;----------------------------------------------------------------------------
; Command F6
avr04CB:	call	sub43F0		; 04CB 940E 43F0
			rjmp	avr04CE		; 04CD C000 reset baud of USART0 to 38.4
;---------------------------------------------------------------------------
; set baud rate of USART0 to 38.4K
avr04CE:	ldi	r16, 0x0B		; 04CE E00B
			out	$09, r16		; 04CF B909
			ldi	r16, 0x00		; 04D0 E000
			sts	0x0090, r16		; 04D1 9300 0090
			rjmp	avr04D4		; 04D3 C000


; Return
avr04D4:	ret					; 04D4 9508
;-------------------------------------------------------------------------
; Command F0 get controller information


avr04D5:	ldi	ZH, high(avr0311 << 1)	; 04D5 E0F6 Command FO Get Controller info
			ldi	ZL, low(avr0311 << 1)	; 04D6 E2E2 Pointer to Controller Info string (311)
			ldi	r19, 0x06				; 04D7 E036
avr04D8:	rcall	sub0629				; 04D8 D150 get next char
			brlo	avr04E2				; 04D9 F040 timeout
			cpi	r19, 0x03				; 04DA 3033
			breq	avr04E3				; 04DB F039
			lpm							; 04DC 95C8 get data pointed by Z
avr04DD:	mov	r16, r0					; 04DD 2D00
			rcall	sub0641				; 04DE D162
			adiw	ZL, 0x01			; 04DF 9631
			dec	r19						; 04E0 953A
			brne	avr04D8				; 04E1 F7B1
avr04E2:	rjmp	avr04D4				; 04E2 CFF1 exit here if all done
avr04E3:	adiw	ZL, 0x01			; 04E3 9631
			dec	r19						; 04E4 953A
			lds	r16, 0x052D				; 04E5 9100 052D, changed in 2.7 to to r0 send contents of 0x52d  (Memory size)
			rcall	sub0641				; 04E7 D159
			rjmp	avr04D8				; 04E8 CFEF loop till all done
;----------------------------------------------------------------------------

; Command F1
; 

avr04E9:	cli					; 04E9 94F8 Command F1
			mov	r20, r16		; 04EA 2F40 
			rcall	sub0613		; 04EB D127 copy 32 values from 0x320 to 0x300

			rcall	sub0958		; 04EC D46B Something to do with timer

			com	r16				; 04ED 9500 r16 = 0E
			mov	r19, r16		; 04EE 2F30 put into r19
			rcall	sub0629		; 04EF D139 wait for next char on timeout
			brlo	avr0515		; 04F0 F120 timed out
			rcall	sub0641		; 04F1 D14F echo
			cp	r16, r19		; 04F2 1703
			brne	avr0515		; 04F3 F509 wrong char should be complement of 0xF1 = 0x0E
			rcall	sub0629		; 04F4 D134 wait for next char on timeout
			brlo	avr0515		; 04F5 F0F8
			rcall	sub0641		; 04F6 D14A echo
			mov	ZL, r16			; 04F7 2FE0
			rcall	sub0629		; 04F8 D130 wait for next char on timeout
			brlo	avr0515		; 04F9 F0D8
			rcall	sub0641		; 04FA D146 echo
			mov	ZH, r16			; 04FB 2FF0
			mov	YL, ZL			; 04FC 2FCE Z and Y have the 16 bit number from bytes 3/4
			mov	YH, ZH			; 04FD 2FDF
			clr	XL				; 04FE 27AA x = 0
			clr	XH				; 04FF 27BB
avr0500:	rcall	sub0629		; 0500 D128 get next char on timeout
			brlo	avr0515		; 0501 F098 timeout
			mov	r17, r16		; 0502 2F10
			rcall	sub07E2		; 0503 D2DE 
			cp	r16, r17		; 0504 1701
			breq	avr050D		; 0505 F039
			sbiw	XL, 0x01	; 0506 9711
			mov	r16, r17		; 0507 2F01
			rcall	sub07BF		; 0508 D2B6
			sbiw	XL, 0x01	; 0509 9711
			rcall	sub07E2		; 050A D2D7
			rcall	sub0641		; 050B D135 echo
			rjmp	avr050F		; 050C C002
avr050D:	mov	r16, r17		; 050D 2F01
			rcall	sub0641		; 050E D132 echo
avr050F:	sbiw	ZL, 0x01	; 050F 9731
			cpi	ZL, 0x00		; 0510 30E0
			brne	avr0500		; 0511 F771
			cpi	ZH, 0x00		; 0512 30F0
			brne	avr0500		; 0513 F761
			rjmp	avr051A		; 0514 C005
avr0515:	lds	r16, 0x04D2		; 0515 9100 04D2
			ori	r16, 0x40		; 0517 6400
			sts	0x04D2, r16		; 0518 9300 04D2
avr051A:	rcall	sub0191		; 051A DC76
			lds	r16, 0x04D2		; 051B 9100 04D2
			ori	r16, 0x04		; 051D 6004
			sts	0x04D2, r16		; 051E 9300 04D2
			sei					; 0520 9478
			rjmp	avr04D4		; 0521 CFB2

;-----------------------------------------------------------
; Command EC

; Download to EEPROM program memory
avr0522:	cli					; 0522 94F8
			push	r1			; 0523 921F
			push	r2			; 0524 922F
			push	r3			; 0525 923F
			push	r4			; 0526 924F

			ldi	r16, 0x0A		; 0527 E00A Delay
avr0528:	ldi	r17, 0x00		; 0528 E010
avr0529:	dec	r17				; 0529 951A
			brne	avr0529		; 052A F7F1
			dec	r16				; 052B 950A
			brne	avr0528		; 052C F7D9

avr052D:	ldi	r16, 0x03		; 052D E003 High Speed Baud Rate
			sts	0x0099, r16		; 052E 9300 0099
			ldi	r16, 0x00		; 0530 E000
			sts	0x0098, r16		; 0531 9300 0098

			rcall	sub0613		; 0533 D0DF copy from 0x320 to 0x300 for 0x20
			rcall	sub0958		; 0534 D423 some timer function
			rcall	sub0629		; 0535 D0F3 get next char
			brsh	avr0538		; 0536 F408 
			rjmp	avr0570		; 0537 C038 timeout

avr0538:	rcall	sub0641		; 0538 D108 echo char
			mov	ZL, r16			; 0539 2FE0 z = next two chars
			rcall	sub0629		; 053A D0EE get next char
			brsh	avr053D		; 053B F408 
			rjmp	avr0570		; 053C C033
avr053D:	rcall	sub0641		; 053D D103 timeout
			mov	ZH, r16			; 053E 2FF0
			sbiw	ZL, 0x01	; 053F 9731 z = z-1
			clr	XH				; 0540 27BB x = 0
			clr	XL				; 0541 27AA
;-------------------
; new 2.7 code
			ser		r16
			sts		0xCFC, r16
;-------------------
avr0542:	cp	ZL, XL			; 0542 17EA
			cpc	ZH, XH			; 0543 07FB
			brlo	avr0546		; 0544 F008
			rjmp	avr0547		; 0545 C001

avr0546:	rjmp	navr05DF		; 0546 C027

avr0547:	rcall	sub0629		; 0547 D0E1 get next char
			brsh	avr054A		; 0548 F408 
			rjmp	avr0570		; 0549 C026 timeout

avr054A:	cpi	r16, 0x3F		; 054A 330F char = 0x3f ?
			breq	avr054D		; 054B F009
			rjmp	avr0570		; 054C C023

avr054D:	ldi	r16, 0x21		; 054D E201 send 0x21 = ACK
			rcall	sub0641		; 054E D0F2

			ldi	r16, 0x80		; 054F E800 get 128 bytes and store in 0x0E00 up
			mov	r2, r16			; 0550 2E20
			ldi	YH, 0x0E		; 0551 E0DE
			ldi	YL, 0x00		; 0552 E0C0
			clr	r1				; 0553 2411 clear checksum
avr0554:	rcall	sub0629		; 0554 D0D4 get next char
			brcc	ec001		; 0555 F0D0 timeout
;---------------
;new 2.7 code

			rjmp	navr05F0
;---------------------------
ec001:		add	r1, r16			; 0556 0E10 add into checksum
			st	Y+, r16			; 0557 9309 store char in 0e00 and inc
			dec	r2				; 0558 942A
			brne	avr0554		; 0559 F7D1

			rcall	sub0629		; 055A D0CE get next char
			brcc	ec002		; 055B F0A0
			rjmp	navr05F0
ec002:		cp	r1, r16			; 055C 1610 compare checksum
			brne	avr055F		; 055D F409
			rjmp	avr0560		; 055E C001
avr055F:	rjmp	avr0570		; 055F C010
avr0560:	ldi	YH, 0x0E		; 0560 E0DE
			ldi	YL, 0x00		; 0561 E0C0
			rcall	sub07CB		; 0562 D268 EEPROM stuff
			ldi	YH, 0x0E		;	 0563 E0DE
			ldi	YL, 0x00		; 0564 E0C0
			ldi	r20, 0x80		; 0565 E840 r20 = 0x80 Byte counter
avr0566:	call	sub07E2		; 0566 940E 07E2 EEPROM stuff
			ld	r17, Y+			; 0568 9119
			cp	r16, r17		; 0569 1701
			breq	ec003		; 056A F429
;---------------
; New 2.7 code
			rjmp	navr05F0
;----------------------------
ec003:		dec	r20				; 056B 954A
			brne	avr0566		; 056C F7C9
			rjmp	avr0542		; 056D CFD4 Jump back
;--------------------------------
;New 2.7 code
navr058E:
; New ED command
			cli
			push	r1
			push	r2
			push	r3
			push	r4
			ldi		r16, 0x0A	; delay
ed001:		ldi		r17, 0x00
ed002:		dec		r17
			brne	ed002
			dec		r16
			brne	ed001
			ldi		r16, 0x03	; high baud
			sts		0x0099, r16
			ldi		r16, 0x00
			sts		0x0098, r16
			rcall	navr0695
			rcall	navr09FE
			rcall	navr06AB
			brcc	ed003
			rjmp	navr05F0
ed003:		rcall	navr06C3
			mov		ZL, r16
			rcall	navr06AB
			brcc	ed004
			rjmp	navr05F0
ed004:			rcall	navr06C3
			mov		ZH, r16
			sbiw	ZL, 0x01
			ldi		XH, 0xDE
			ldi		XL, 0x00
			cp		ZL, XL
			cpc		ZH, XH
			brcs	ed005
			rjmp	navr05F0
ed005:		clr		XH
			clr		XL
			ldi		r16,0x00
			sts		0x0CFC, r16
ed020:		call	nsub02F5
			cp		ZL, XL
			cpc		ZH, XH
			brcs	ed006
			rjmp	ed021
ed006:		rjmp	navr05DF	
ed021:		rcall	navr06AB
			brcc	ed030
			rjmp	navr05F0
ed030:		cpi		r16, 0x3F
			breq	ed007
			rjmp	navr05F0
ed007:		ldi		r16, 0x21
			rcall	navr06C3
			clr		r16
			mov		r2, r16
			ldi		YH, 0x0E
			ldi		YL, 0x00
			clr		r1
ed008:		rcall	navr06AB
			brcc	ed009
			rjmp	navr05F0
ed009:		add		r1, r16
			st		Y+, r16
			dec		r2
			brne	ed008
			rcall	navr06AB
			brcc	ed010
			rjmp	navr05F0
ed010:		cp		r1, r16
			brne	ed011
			rjmp	ed012
ed011:			rjmp	navr05F0
ed012:		ldi		YH, 0x0E
			ldi		YL, 0x00
			rcall	navr084D
			brcs	navr05F0
			inc		XH
			rjmp	ed020

navr05DF:	push	XH
			push	XL
			ldi		XH, 0x0F
			ldi		XL, 0xAF
			rcall	navr08BB
			lds		r17, 0x0CFC
			cp		r16, r17
			breq	ed013
			mov		r16, r17
			ldi		XH, 0x0F
			ldi		XL, 0xAF
			rcall	navr08BF
ed013:			pop		XL
			pop		XH





;----------------------------------------------------------
	
avr056E:	ldi	r16, 0x45		; 056E E405 send 0x45 = '-'
			rjmp	avr0571		; 056F C001
navr05F0:
avr0570:	ldi	r16, 0x58		; 0570 E508 send 0x58 = ':'
avr0571:	rcall	sub0641		; 0571 D0CF
			pop	r4				; 0572 904F
			pop	r3				; 0573 903F
			pop	r2				; 0574 902F
			pop	r1				; 0575 901F

			rcall	sub0191		; 0576 DC1A Initialise RAM

			lds	r16, 0x04D2		; 0577 9100 04D2 Set bit 4 in 0x4D2
			ori	r16, 0x04		; 0579 6004
			sts	0x04D2, r16		; 057A 9300 04D2

			ldi	r16, 0x03		; 057C E003 Delay
avr057D:	ldi	r17, 0x00		; 057D E010
avr057E:	dec	r17				; 057E 951A
			brne	avr057E		; 057F F7F1
			dec	r16				; 0580 950A
			brne	avr057D		; 0581 F7D9

			ldi	r16, 0x2F		; 0582 E20F Set Baud rate slow again
			sts	0x0099, r16		; 0583 9300 0099
			ldi	r16, 0x00		; 0585 E000
			sts	0x0098, r16		; 0586 9300 0098

			sei					; 0588 9478 Enable ints and return
;---------------------
;New 2.7 code
			ldi		r16, 0x00
			out		0x3B, r16
			rjmp	avr04D4		; 0589 CF4A

; F2 Read from EEPROM
avr058A:	push	XL			; 058A 93AF Here for F2 (read EEPROM)
			push	XH			; 058B 93BF
			rcall	sub0629		; 058C D09C get address low
			brlo	avr0598		; 058D F050 timeout
			rcall	sub0641		; 058E D0B2 send echo
			mov	XL, r16			; 058F 2FA0 
			rcall	sub0629		; 0590 D098 get address high
			brlo	avr0598		; 0591 F030
			rcall	sub0641		; 0592 D0AE send echo
			mov	XH, r16			; 0593 2FB0
			rcall	sub0629		; 0594 D094 get next char
			brlo	avr0598		; 0595 F010
			rcall	sub07D6		; 0596 D23F
			rcall	sub0641		; 0597 D0A9 send char
avr0598:	pop	XH				; 0598 91BF
			pop	XL				; 0599 91AF
			rjmp	avr04D4		; 059A CF39

;-----------------------------------------------------
; Command F3 sets bits 3 and 4 in 0x4d2
avr059B:	lds	r16, 0x04D2		; 059B 9100 04D2 
			ori	r16, 0x10		; 059D 6100
			ori	r16, 0x08		; 059E 6008
			sts	0x04D2, r16		; 059F 9300 04D2
			rjmp	avr04D4		; 05A1 CF32

;-------------------------------------------------------------
; Command F4

avr05A2:	push	XL			; 05A2 93AF
			push	XH			; 05A3 93BF
			com	r16				; 05A4 9500
			mov	r19, r16		; 05A5 2F30
			rcall	sub0629		; 05A6 D082 Get next char
			brlo	avr05BC		; 05A7 F0A0 timeout
			rcall	sub0641		; 05A8 D098 echo char
			cp	r16, r19		; 05A9 1703 check char is complement
			brne	avr05BC		; 05AA F489 bad char
			rcall	sub0629		; 05AB D07D get next char
			brlo	avr05BC		; 05AC F078  timeout
			rcall	sub0641		; 05AD D093
			mov	XL, r16			; 05AE 2FA0 X = next 2 bytes
			rcall	sub0629		; 05AF D079
			brlo	avr05BC		; 05B0 F058
			rcall	sub0641		; 05B1 D08F
			mov	XH, r16			; 05B2 2FB0
			rcall	sub0629		; 05B3 D075get next char
			brlo	avr05BC		; 05B4 F038
			rcall	sub0641		; 05B5 D08B echo
			mov	r19, r16		; 05B6 2F30
			rcall	sub07B3		; 05B7 D1FB
			rcall	sub0629		; 05B8 D070 get next char
			brlo	avr05BC		; 05B9 F010
			mov	r16, r19		; 05BA 2F03 r19 = char
			rcall	sub0641		; 05BB D085
avr05BC:	pop	XH				; 05BC 91BF
			pop	XL				; 05BD 91AF
			rjmp	avr04D4		; 05BE CF15
;-----------------------------------------------------------
; F7 command read data memory

avr05BF:	push	XL			; 05BF 93AF
			push	XH			; 05C0 93BF
			rcall	sub0629		; 05C1 D067
			brlo	sub05CD		; 05C2 F050
			rcall	sub0641		; 05C3 D07D
			mov	YL, r16			; 05C4 2FC0
			rcall	sub0629		; 05C5 D063
			brlo	sub05CD		; 05C6 F030
			rcall	sub0641		; 05C7 D079
			mov	YH, r16			; 05C8 2FD0
			rcall	sub0629		; 05C9 D05F
			brlo	sub05CD		; 05CA F010
			ld	r16, Y			; 05CB 8108
			rcall	sub0641		; 05CC D074
sub05CD:	pop	XH				; 05CD 91BF
			pop	XL				; 05CE 91AF
			rjmp	avr04D4		; 05CF CF04
;--------------------------------------------------------------
; f8 command write data memory

avr05D0:	push	XL			; 05D0 93AF
			push	XH			; 05D1 93BF
			rcall	sub0629		; 05D2 D056
			brlo	avr05DF		; 05D3 F058
			rcall	sub0641		; 05D4 D06C
			mov	YL, r16			; 05D5 2FC0
			rcall	sub0629		; 05D6 D052
			brlo	avr05DF		; 05D7 F038
			rcall	sub0641		; 05D8 D068
			mov	YH, r16			; 05D9 2FD0
			rcall	sub0629		; 05DA D04E
			brlo	avr05DF		; 05DB F018
			rcall	sub0641		; 05DC D064
			st	Y, r16			; 05DD 8308
			ld	r16, Y			; 05DE 8108
avr05DF:	pop	XH				; 05DF 91BF
			pop	XL				; 05E0 91AF
			rjmp	avr04D4		; 05E1 CEF2
;-------------------------------------------------------------------------
; command FA controller stop
;
 
avr05E2:	ldi	YH, 0x03		; 05E2 E0D3 y = 0x3C0
			ldi	YL, 0xC0		; 05E3 ECC0
			push	r23			; 05E4 937F save r23
			ldi	r23, 0x20		; 05E5 E270
			ldi	r16, 0x11		; 05E6 E101
			ldi	r17, 0x00		; 05E7 E010
			ldi	r18, 0x03		; 05E8 E023
			ldi	r19, 0x00		; 05E9 E030
			rcall	sub02EE		; 05EA DD03 multiply 0x03 * 0x11
avr05EB:	st	Y+, r18			; 05EB 9329 set locations 0x3C0 to 0x3E0
			dec	r23				; 05EC 957A with result
			brne	avr05EB		; 05ED F7E9
			lds	r16, 0x04D2		; 05EE 9100 04D2 
			ori	r16, 0x40		; 05F0 6400 set bit 6 in 4d2
			sts	0x04D2, r16		; 05F1 9300 04D2
			pop	r23				; 05F3 917F
			rcall	sub0613		; 05F4 D01E copy from 0x320 to 0x300

sub05F5:	rjmp	avr04D4		; 05F5 CEDE jump return

;-------------------------------------------------------------------------
; command FB Controller start

avr05F6:	lds	r16, 0x04D2		; 05F6 9100 04D2 test bit 2 in 4d2
			sbrc	r16, 2		; 05F8 FD02 if set call 0x191
			rcall	sub0191		; 05F9 DB97
			lds	r16, 0x04D2		; 05FA 9100 04D2 
			andi	r16, 0xBF	; 05FC 7B0F clear bit 6 in 4d2
			andi	r16, 0xEF	; 05FD 7E0F clear bit 5 in 4d2
			sts	0x04D2, r16		; 05FE 9300 04D2
			sei					; 0600 9478 enable interupts
			rjmp	avr04D4		; 0601 CED2 jump to return
;-----------------------------------------------------------------
; command FC Controller Reset

avr0602:	rcall	sub017E		; 0602 DB7B 

			rcall	sub02C2		; 0603 DCBE

			rcall	sub02CD		; 0604 DCC8

			rjmp	avr04D4		; 0605 CECE jump to return
;-----------------------------------------------------------------
; command FD
avr0606:	rjmp	avr04D4		; 0606 CECD no command
;-----------------------------------------------------------------
; command FE
avr0607:	rjmp	avr04D4		; 0607 CECC no command

;-----------------------------------------------------------------
; command FF
avr0608:	push	XL			; 0608 93AF
			push	XH			; 0609 93BF

			rcall	sub0629		; 060A D01E get next char
			brlo	avr0610		; 060B F020 = FF
			rcall	sub0641		; 060C D034 echo
			ldi	XH, 0x01		; 060D E0B1 store char in 0x140
			ldi	XL, 0x40		; 060E E4A0
			st	X, r16			; 060F 930C
avr0610:	pop	XH				; 0610 91BF
			pop	XL				; 0611 91AF
			rjmp	avr04D4		; 0612 CEC1


;-------------------------------------------------------------------------
; copy from 0x320 to 0x300
navr0695:
sub0613:	push	XH			; 0613 93BF Copy the 20 values from data mem
			push	XL			; 0614 93AF 0x320 to 0x300
			push	YH			; 0615 93DF
			push	YL			; 0616 93CF
			push	r16			; 0617 930F
			push	r17			; 0618 931F
			ldi	XH, 0x03		; 0619 E0B3
			ldi	XL, 0x00		; 061A E0A0
			ldi	YH, 0x03		; 061B E0D3
			ldi	YL, 0x20		; 061C E2C0
			ldi	r16, 0x20		; 061D E200
avr061E:	ld	r17, Y+			; 061E 9119
			st	X+, r17			; 061F 931D
			dec	r16				; 0620 950A
			brne	avr061E		; 0621 F7E1
			pop	r17				; 0622 911F
			pop	r16				; 0623 910F
			pop	YL				; 0624 91CF
			pop	YH				; 0625 91DF
			pop	XL				; 0626 91AF
			pop	XH				; 0627 91BF
			ret					; 0628 9508
;-------------------------------------------------------------------------
; Get Command Char
navr06AB:
sub0629:	push	r19			; 0629 933F wait for next char on timeout
			ldi	r17, 0x14		; 062A E114
avr062B:	ldi	r18, 0x00		; 062B E020
avr062C:	ldi	r19, 0x00		; 062C E030
avr062D:	wdr					; 062D 95A8
			lds	r16, 0x009B		; 062E 9100 009B Char received ?
			sbrs	r16, 7		; 0630 FF07
			rjmp	avr0637		; 0631 C005
			lds	r16, 0x009C		; 0632 9100 009C
			clc					; 0634 9488
			pop	r19				; 0635 913F
			ret					; 0636 9508

avr0637:	dec	r19				; 0637 953A
			brne	avr062D		; 0638 F7A1
			dec	r18				; 0639 952A
			brne	avr062C		; 063A F789
			dec	r17				; 063B 951A
			brne	avr062B		; 063C F771
			sec					; 063D 9408
			pop	r19				; 063E 913F
			clr	r16				; 063F 2700
			ret					; 0640 9508
;-------------------------------------------------------------------------
; Send Command Char
navr06C3:
sub0641:	push	r16			; 0641 930F
avr0642:	wdr					; 0642 95A8
			lds	r16, 0x009B		; 0643 9100 009B
			sbrs	r16, 5		; 0645 FF05
			rjmp	avr0642		; 0646 CFFB
			pop	r16				; 0647 910F
			sts	0x009C, r16		; 0648 9300 009C
			clc					; 064A 9488
			ret					; 064B 9508
;-------------------------------------------------------------------------
; Command EB
; Synchronous Move

sub064C:	call	sub0629		; 064C 940E 0629
			brsh	avr0650		; 064E F408
			rjmp	avr0688		; 064F C038
avr0650:	call	sub0641		; 0650 940E 0641
			mov	r20, r16		; 0652 2F40
			call	sub0629		; 0653 940E 0629
			brlo	avr0688		; 0655 F190
			call	sub0641		; 0656 940E 0641
			mov	r21, r16		; 0658 2F50
			ldi	YH, 0x03		; 0659 E0D3
			ldi	YL, 0x00		; 065A E0C0
			call	sub23CA		; 065B 940E 23CA
			rcall	sub0689		; 065D D02B
			brlo	avr0688		; 065E F148
			lds	r16, 0x04D2		; 065F 9100 04D2
			sbrs	r16, 7		; 0661 FF07
			rjmp	avr0665		; 0662 C002
			ldi	r20, 0x00		; 0663 E040
			ldi	r21, 0x20		; 0664 E250
avr0665:	push	XH			; 0665 93BF
			push	XL			; 0666 93AF
			ldi	XH, 0x03		; 0667 E0B3
			ldi	XL, 0x00		; 0668 E0A0
			ldi	YH, 0x03		; 0669 E0D3
			ldi	YL, 0x20		; 066A E2C0
			ldi	ZH, 0x04		; 066B E0F4
			ldi	ZL, 0x00		; 066C E0E0
			call	sub23A7		; 066D 940E 23A7
			mov	r16, r21		; 066F 2F05
			call	sub22A4		; 0670 940E 22A4
			ldi	ZH, 0x04		; 0672 E0F4
			ldi	ZL, 0x00		; 0673 E0E0
			call	sub23D4		; 0674 940E 23D4
			mov	r16, r21		; 0676 2F05
			dec	r16				; 0677 950A
			call	sub22B3		; 0678 940E 22B3
			pop	XL				; 067A 91AF
			pop	XH				; 067B 91BF
			ldi	YH, 0x03		; 067C E0D3
			ldi	YL, 0xC0		; 067D ECC0
			ldi	ZH, 0x04		; 067E E0F4
			ldi	ZL, 0x00		; 067F E0E0
			call	sub23BF		; 0680 940E 23BF
			mov	r16, r21		; 0682 2F05
			call	sub22BF		; 0683 940E 22BF
			call	sub2331		; 0685 940E 2331
			ret					; 0687 9508
;-------------------------------------------------------------------------
;
avr0688:	ret				; 0688 9508
;-------------------------------------------------------------------------
; get and store serial bytes
; Y = address
; r16 = count
sub0689:	push	r21			; 0689 935F
			mov	r21, r16		; 068A 2F50
avr068B:	call	sub0629		; 068B 940E 0629
			brlo	avr069B		; 068D F068
			call	sub0641		; 068E 940E 0641
			cpi	r16, 0x00		; 0690 3000
			breq	avr0696		; 0691 F021
			st	Y+, r16			; 0692 9309
avr0693:	dec	r21				; 0693 955A
			brne	avr068B		; 0694 F7B1
			rjmp	avr0698		; 0695 C002
avr0696:	adiw	YL, 0x01	; 0696 9621
			rjmp	avr0693		; 0697 CFFB
avr0698:	clc					; 0698 9488
			pop	r21				; 0699 915F
			ret					; 069A 9508
avr069B:	sec					; 069B 9408
			pop	r21				; 069C 915F
			ret					; 069D 9508
;-------------------------------------------------------------------------
; Remocon (0)
sub069E:	lds	r16, 0x0061		; 069E 9100 0061 clear bit 7 (AD7) of Data Direction F (Input)
			andi	r16, 0x7F			; 06A0 770F
			sts	0x0061, r16		; 06A1 9300 0061

			ldi	r16, 0x7A		; 06A3 E70A R16 = 122
avr06A4:	wdr					; 06A4 95A8
			ldi	r17, 0x64		; 06A5 E614 delay
avr06A6:	dec	r17				; 06A6 951A
			brne	avr06A6		; 06A7 F7F1

			sbis	$00, 7		; 06A8 9B07 is bit 7 high loop
			rjmp	avr06AD		; 06A9 C003 else avr06AD
			dec	r16				; 06AA 950A
			brne	avr06A4		; 06AB F7C1
			rjmp	avr06C5		; 06AC C018
avr06AD:	cli					; 06AD 94F8 clear interrupts while doing this
			rcall	sub06EF		; 06AE D040
			brlo	avr06C5		; 06AF F0A8
			rcall	sub06C9		; 06B0 D018
			brlo	avr06C5		; 06B1 F098
			cpi	r16, 0x10		; 06B2 3100
			brne	avr06C5		; 06B3 F489
			rcall	sub06C9		; 06B4 D014
			brlo	avr06C5		; 06B5 F078
			cpi	r16, 0xEF		; 06B6 3E0F
			brne	avr06C5		; 06B7 F469
			rcall	sub06C9		; 06B8 D010
			brlo	avr06C5		; 06B9 F058
			mov	r21, r16		; 06BA 2F50
			rcall	sub06C9		; 06BB D00D
			brlo	avr06C5		; 06BC F040
			com	r16				; 06BD 9500
			cp	r16, r21		; 06BE 1705
			brne	avr06C5		; 06BF F429
			mov	r16, r21		; 06C0 2F05
			inc	r16				; 06C1 9503
			clc					; 06C2 9488
			sei					; 06C3 9478
			ret					; 06C4 9508

avr06C5:	ldi	r16, 0x00		; 06C5 E000 no receipt  response = 0
			sec					; 06C6 9408
			sei					; 06C7 9478
			ret					; 06C8 9508

sub06C9:	ldi	r20, 0x08		; 06C9 E048
			ldi	r19, 0x00		; 06CA E030
avr06CB:	rcall	sub06D5		; 06CB D009
			breq	avr06D3		; 06CC F031
			ror	r19				; 06CD 9537
			dec	r20				; 06CE 954A
			brne	avr06CB		; 06CF F7D9
			mov	r16, r19		; 06D0 2F03
			clc					; 06D1 9488
			ret					; 06D2 9508

avr06D3:	sec					; 06D3 9408
			ret					; 06D4 9508

sub06D5:	wdr					; 06D5 95A8
			ser	r16				; 06D6 EF0F
avr06D7:	ldi	r17, 0x1E		; 06D7 E11E
avr06D8:	sbic	$00, 7		; 06D8 9907
			rjmp	avr06DF		; 06D9 C005
			dec	r17				; 06DA 951A
			brne	avr06D8		; 06DB F7E1
			dec	r16				; 06DC 950A
			brne	avr06D7		; 06DD F7C9
			rjmp	avr06ED		; 06DE C00E

avr06DF:	wdr					; 06DF 95A8
			mov	r18, r16		; 06E0 2F20
			ser	r16				; 06E1 EF0F
avr06E2:	ldi	r17, 0x1E		; 06E2 E11E
avr06E3:	sbis	$00, 7		; 06E3 9B07
			rjmp	avr06EA		; 06E4 C005
			dec	r17				; 06E5 951A
			brne	avr06E3		; 06E6 F7E1
			dec	r16				; 06E7 950A
			brne	avr06E2		; 06E8 F7C9
			rjmp	avr06ED		; 06E9 C003

avr06EA:	cp	r16, r18		; 06EA 1702
			clz					; 06EB 9498
			ret					; 06EC 9508

avr06ED:	sez					; 06ED 9418
			ret					; 06EE 9508


sub06EF:	wdr					; 06EF 95A8
			ldi	r16, 0x7A		; 06F0 E70A r16 = 122
avr06F1:	ldi	r17, 0x50		; 06F1 E510 r17 = 80
avr06F2:	dec	r17				; 06F2 951A
			brne	avr06F2		; 06F3 F7F1
			sbic	$00, 7		; 06F4 9907 
			rjmp	avr0717		; 06F5 C021
			dec	r16				; 06F6 950A
			brne	avr06F1		; 06F7 F7C9
			wdr					; 06F8 95A8
			ldi	r16, 0xF4		; 06F9 EF04
avr06FA:	ldi	r17, 0x50		; 06FA E510
avr06FB:	dec	r17				; 06FB 951A
			brne	avr06FB		; 06FC F7F1
			sbic	$00, 7		; 06FD 9907
			rjmp	avr0702		; 06FE C003
			dec	r16				; 06FF 950A
			brne	avr06FA		; 0700 F7C9
			rjmp	avr0717		; 0701 C015
avr0702:	wdr					; 0702 95A8
			ldi	r16, 0x7A		; 0703 E70A
avr0704:	ldi	r17, 0x50		; 0704 E510
avr0705:	dec	r17				; 0705 951A
			brne	avr0705		; 0706 F7F1
			sbis	$00, 7		; 0707 9B07
			rjmp	avr0717		; 0708 C00E
			dec	r16				; 0709 950A
			brne	avr0704		; 070A F7C9
			wdr					; 070B 95A8
			ldi	r16, 0x7A		; 070C E70A
avr070D:	ldi	r17, 0x50		; 070D E510
avr070E:	dec	r17				; 070E 951A
			brne	avr070E		; 070F F7F1
			sbis	$00, 7		; 0710 9B07
			rjmp	avr0715		; 0711 C003
			dec	r16				; 0712 950A
			brne	avr070D		; 0713 F7C9
			rjmp	avr0717		; 0714 C002
avr0715:	clc					; 0715 9488
			ret					; 0716 9508

avr0717:	sec					; 0717 9408
			ret					; 0718 9508

;-------------------------------------------------------------------------
;Remocon (1)
sub0719:	lds	r16, 0x0061		; 0719 9100 0061
			andi	r16, 0x7F	; 071B 770F
			sts	0x0061, r16		; 071C 9300 0061
			ldi	r16, 0x00		; 071E E000
avr071F:	wdr					; 071F 95A8
			ldi	r17, 0x00		; 0720 E010
avr0721:	dec	r17				; 0721 951A
			nop					; 0722 0000
			nop					; 0723 0000
			nop					; 0724 0000
			nop					; 0725 0000
			sbis	$00, 7		; 0726 9B07
			rjmp	avr072C		; 0727 C004
			brne	avr0721		; 0728 F7C1
			dec	r16				; 0729 950A
			brne	avr071F		; 072A F7A1
			rjmp	avr0747		; 072B C01B
avr072C:	cli					; 072C 94F8
			rcall	sub074B		; 072D D01D
			brlo	avr0747		; 072E F0C0
			rcall	sub0793		; 072F D063
			brlo	avr0747		; 0730 F0B0
			cpi	r16, 0x00		; 0731 3000
			brne	avr0747		; 0732 F4A1
			rcall	sub0793		; 0733 D05F
			brlo	avr0747		; 0734 F090
			cpi	r16, 0x80		; 0735 3800
			brne	avr0747		; 0736 F481
			rcall	sub0793		; 0737 D05B
			brlo	avr0747		; 0738 F070
			cpi	r16, 0x00		; 0739 3000
			brne	avr0747		; 073A F461
			rcall	sub0793		; 073B D057
			brlo	avr0747		; 073C F050
			cpi	r16, 0x80		; 073D 3800
			brne	avr0747		; 073E F441
			rcall	sub077A		; 073F D03A
			brlo	avr0747		; 0740 F030
			lsr	r19				; 0741 9536
			mov	r16, r19		; 0742 2F03
			inc	r16				; 0743 9503
			clc					; 0744 9488
			sei					; 0745 9478
			ret					; 0746 9508

avr0747:	ldi	r16, 0x00		; 0747 E000
			sec					; 0748 9408
			sei					; 0749 9478
			ret					; 074A 9508
;-------------------------------------------------------------------------
sub074B:	wdr					; 074B 95A8
			ldi	r16, 0x00		; 074C E000
avr074D:	ldi	r17, 0x1B		; 074D E11B
avr074E:	wdr					; 074E 95A8
			sbic	$00, 7		; 074F 9907
			rjmp	avr0778		; 0750 C027
			dec	r17				; 0751 951A
			brne	avr074E		; 0752 F7D9
			inc	r16				; 0753 9503
			cpi	r16, 0x46		; 0754 3406
			brlo	avr074D		; 0755 F3B8
			ldi	r16, 0x00		; 0756 E000
avr0757:	ldi	r17, 0x64		; 0757 E614
avr0758:	wdr					; 0758 95A8
			sbic	$00, 7		; 0759 9907
			rjmp	avr0761		; 075A C006
			dec	r17				; 075B 951A
			brne	avr0758		; 075C F7D9
			inc	r16				; 075D 9503
			cpi	r16, 0x40		; 075E 3400
			brsh	avr0778		; 075F F4C0
			rjmp	avr0757		; 0760 CFF6
avr0761:	ldi	r16, 0x00		; 0761 E000
avr0762:	ldi	r17, 0x0C		; 0762 E01C
avr0763:	wdr					; 0763 95A8
			sbis	$00, 7		; 0764 9B07
			rjmp	avr0778		; 0765 C012
			dec	r17				; 0766 951A
			brne	avr0763		; 0767 F7D9
			inc	r16				; 0768 9503
			cpi	r16, 0x46		; 0769 3406
			brlo	avr0762		; 076A F3B8
			ldi	r16, 0x00		; 076B E000
avr076C:	ldi	r17, 0x0C		; 076C E01C
avr076D:	wdr					; 076D 95A8
			sbis	$00, 7		; 076E 9B07
			rjmp	avr0776		; 076F C006
			dec	r17				; 0770 951A
			brne	avr076C		; 0771 F7D1
			inc	r16				; 0772 9503
			cpi	r16, 0x28		; 0773 3208
			brsh	avr0778		; 0774 F418
			rjmp	avr076D		; 0775 CFF7
avr0776:	clc					; 0776 9488
			ret					; 0777 9508
avr0778:	sec					; 0778 9408
			ret					; 0779 9508
;-------------------------------------------------------------------------
;
sub077A:	ldi	r20, 0x08		; 077A E048
			ldi	r19, 0x00		; 077B E030
			ldi	r21, 0x00		; 077C E050
			ldi	r22, 0x00		; 077D E060
avr077E:	rcall	sub0793		; 077E D014
			brlo	avr0791		; 077F F088
			cpi	r20, 0x01		; 0780 3041
			breq	avr0785		; 0781 F019
			tst	r16				; 0782 2300
			breq	avr0785		; 0783 F009
			com	r22				; 0784 9560
avr0785:	rol	r16				; 0785 1F00
			rol	r19				; 0786 1F33
			rol	r21				; 0787 1F55
			dec	r20				; 0788 954A
			brne	avr077E		; 0789 F7A1
			mov	r21, r19		; 078A 2F53
			andi	r21, 0x01		; 078B 7051
			andi	r22, 0x01		; 078C 7061
			cp	r21, r22		; 078D 1756
			brne	avr0791		; 078E F411
			clc					; 078F 9488
			ret					; 0790 9508
avr0791:	sec					; 0791 9408
			ret					; 0792 9508
;-------------------------------------------------------------------------
;
sub0793:	ldi	r16, 0x00		; 0793 E000
avr0794:	ldi	r17, 0x0C		; 0794 E01C
avr0795:	wdr					; 0795 95A8
			sbic	$00, 7		; 0796 9907
			rjmp	avr079E		; 0797 C006
avr0798:	dec	r17				; 0798 951A
			brne	avr0795		; 0799 F7D9
			inc	r16				; 079A 9503
			cpi	r16, 0x80		; 079B 3800
			brsh	avr07B1		; 079C F4A0
			rjmp	avr0794		; 079D CFF6
avr079E:	mov	r18, r16		; 079E 2F20
			ldi	r16, 0x00		; 079F E000
avr07A0:	ldi	r17, 0x0C		; 07A0 E01C
avr07A1:	wdr					; 07A1 95A8
			sbis	$00, 7		; 07A2 9B07
			rjmp	avr07AA		; 07A3 C006
			dec	r17				; 07A4 951A
			brne	avr07A1		; 07A5 F7D9
			inc	r16				; 07A6 9503
			cpi	r16, 0x80		; 07A7 3800
			brsh	avr07B1		; 07A8 F440
			rjmp	avr07A0		; 07A9 CFF6
avr07AA:	ldi	r17, 0x00		; 07AA E010
			cp	r18, r16		; 07AB 1720
			brsh	avr07AE		; 07AC F408
			ldi	r17, 0x80		; 07AD E810
avr07AE:	mov	r16, r17		; 07AE 2F01
			clc					; 07AF 9488
			ret					; 07B0 9508
avr07B1:	sec					; 07B1 9408
			ret					; 07B2 9508
;-------------------------------------------------------------------------
;Write External EEPROM
; x = address location
; r17 = EEPROM device address
; r16 = data to write
sub07B3:	wdr					; 07B3 95A8
			push	XH			; 07B4 93BF
			push	XL			; 07B5 93AF
			push	r17			; 07B6 931F
			lds	r17, 0x04C2		; 07B7 9110 04C2 EEPROM Address
			rcall	sub07FD		; 07B9 D043
			pop	r17				; 07BA 911F
			pop	XL				; 07BB 91AF
			pop	XH				; 07BC 91BF
			adiw	XL, 0x01	; 07BD 9611
			ret					; 07BE 9508
;-------------------------------------------------------------------------
;
sub07BF:	wdr					; 07BF 95A8
			push	XH			; 07C0 93BF
			push	XL			; 07C1 93AF
			push	r17			; 07C2 931F
			lds	r17, 0x04C2		; 07C3 9110 04C2 EEPROM Address
			rcall	sub0803		; 07C5 D03D
			pop	r17				; 07C6 911F
			pop	XL				; 07C7 91AF
			pop	XH				; 07C8 91BF
			adiw	XL, 0x01	; 07C9 9611
			ret					; 07CA 9508
;-------------------------------------------------------------------------
;
navr084D:
sub07CB:	wdr					; 07CB 95A8
			push	XH			; 07CC 93BF
			push	XL			; 07CD 93AF
			push	r17			; 07CE 931F
			lds	r17, 0x04C2		; 07CF 9110 04C2 EEPROM Address
			rcall	sub0807		; 07D1 D035
			pop	r17				; 07D2 911F
			pop	XL				; 07D3 91AF
			pop	XH				; 07D4 91BF
			ret					; 07D5 9508
;-------------------------------------------------------------------------
; read External EEPROM and increment Address
;x = address location
; r17 = EEPROM device address
; r16 = returned data

sub07D6:	wdr						; 07D6 95A8
			push	XH				; 07D7 93BF
			push	XL				; 07D8 93AF
			push	r17				; 07D9 931F
			lds		r17, 0x04C2		; 07DA 9110 04C2 EEPROM Address
			rcall	sub080B			; 07DC D02E
			pop		r17				; 07DD 911F
			pop		XL				; 07DE 91AF
			pop		XH				; 07DF 91BF
			adiw	XL, 0x01		; 07E0 9611
			ret						; 07E1 9508
;-------------------------------------------------------------------------
; EEPROM 
sub07E2:	wdr						; 07E2 95A8
			push	XH				; 07E3 93BF
			push	XL				; 07E4 93AF
			push	r17				; 07E5 931F
			lds		r17, 0x04C2		; 07E6 9110 04C2 EEPROM Address
			rcall	sub0811			; 07E8 D028
			pop		r17				; 07E9 911F
			pop		XL				; 07EA 91AF
			pop		XH				; 07EB 91BF
			adiw	XL, 0x01		; 07EC 9611
			ret						; 07ED 9508
;-------------------------------------------------------------------------
; write internal EEPROM
; address in x, data in r16
sub07EE:	sbic	EECR, 1		; 07EE 99E1
			rjmp	sub07EE		; 07EF CFFE
			out	EEARL, XL		; 07F0 BBAE
			out	EEARH, XH		; 07F1 BBBF
			out	EEDR, r16		; 07F2 BB0D
			sbi	EECR, 2			; 07F3 9AE2
			sbi	EECR, 1			; 07F4 9AE1
		ret						; 07F5 9508
;-------------------------------------------------------------------------
; read internal EEPROM
; address in x, result in r16

sub07F6:	sbic	EECR, 1		; 07F6 99E1
			rjmp	sub07F6		; 07F7 CFFE
			out	EEARL, XL		; 07F8 BBAE
			out	EEARH, XH		; 07F9 BBBF
			sbi	EECR, 0			; 07FA 9AE0
			in	r16, EEDR		; 07FB B30D
			ret					; 07FC 9508
;-------------------------------------------------------------------------

sub07FD:	cli					; 07FD 94F8
			push	r18			; 07FE 932F
			rcall	sub082B		; 07FF D02B
			pop	r18				; 0800 912F
			sei					; 0801 9478
			ret					; 0802 9508
;-------------------------------------------------------------------------
sub0803:	push	r18			; 0803 932F
			rcall	sub082B		; 0804 D026
			pop	r18				; 0805 912F
			ret					; 0806 9508
;-------------------------------------------------------------------------
sub0807:	push	r18			; 0807 932F
;-------------
;New 2.7 code
			lds		r18, 0x0CFC
			cpi		r18, 0x00
			breq	navr807a
;------------
			rcall	sub086D		; 0808 D064
			pop	r18				; 0809 912F
			ret					; 080A 9508
;------------
;New2.7 code
navr807a:	push	ZH
			push	ZL
			mov		ZH, XH
			mov		ZL, XL
			ldi		r16, 0x01
			out		0x3B, r16
			call	0x0000F0AC
			ldi		r16, 0x00
			out		0x3b, r16
			pop		ZL
			pop		ZH
			pop		r18
			ret
			
;-----------
;-------------------------------------------------------------------------
; Read EEPROM

sub080B:	cli					; 080B 94F8
			push	r18			; 080C 932F
;----------------
;New2.7 code
			lds		r18, 0x0CFC
			cpi		r18, 0x00
			breq	navr80Ba
;--------------------
			rcall	sub08B3		; 080D D0A5
			pop	r18				; 080E 912F
			sei					; 080F 9478
			ret					; 0810 9508

;----------------
;New2.7 code
navr80ba:	push	ZH
			push	ZL
			mov		ZH, XH
			mov		ZL, XL
			ldi		r18,0x01
			out		0x3b, r18
			elpm	r16, Z+
			ldi		r18, 0x00
			out		0x3b, r18
			pop		ZL
			pop		ZH
			pop		r18
			sei
			ret
;-------------------
;-------------------------------------------------------------------------
;
sub0811:	push	r18			; 0811 932F
			rcall	sub08B3			; 0812 D0A0
			pop		r18				; 0813 912F
			ret					; 0814 9508
;-------------------------------------------------------------------------
; Read next internal EEPROM pointed by X
navr08BB:
sub0815:	wdr					; 0815 95A8 
			rcall	sub07F6		; 0816 DFDF
			adiw	XL, 0x01	; 0817 9611
			ret					; 0818 9508
;-------------------------------------------------------------------------
; Write next internal EEPROM pointed by X
navr08BF:
sub0819:	wdr					; 0819 95A8
			rcall	sub07EE		; 081A DFD3
			adiw	XL, 0x01	; 081B 9611
			ret					; 081C 9508
;-------------------------------------------------------------------------
; Open 2 wire interface

sub081D:	ldi	r16, 0x0A		; 081D E00A
			sts	0x0070, r16		; 081E 9300 0070
			ldi	r16, 0x94		; 0820 E904
			sts	0x0074, r16		; 0821 9300 0074
			ret					; 0823 9508
;-------------------------------------------------------------------------
; Close 2 wire Interface
sub0824:	ldi	r16, 0x00		; 0824 E000
			sts	0x0070, r16		; 0825 9300 0070
			ldi	r16, 0x00		; 0827 E000
			sts	0x0074, r16		; 0828 9300 0074
			ret					; 082A 9508
;-------------------------------------------------------------------------

sub082B:	ldi	r18, 0xA4		; 082B EA24
			sts	0x0074, r18		; 082C 9320 0074
			rcall	sub0921		; 082E D0F2
			lds	r18, 0x0071		; 082F 9120 0071
			andi	r18, 0xF8	; 0831 7F28
			cpi	r18, 0x08		; 0832 3028
			breq	avr0835		; 0833 F009
			rjmp	avr091C		; 0834 C0E7
avr0835:	lsl	r17				; 0835 0F11
			ori	r17, 0xA0		; 0836 6A10
			sts	0x0073, r17		; 0837 9310 0073
			ldi	r18, 0x84		; 0839 E824
			sts	0x0074, r18		; 083A 9320 0074
			rcall	sub0921		; 083C D0E4
			lds	r18, 0x0071		; 083D 9120 0071
			andi	r18, 0xF8	; 083F 7F28
			cpi	r18, 0x18		; 0840 3128
			breq	avr0843		; 0841 F009
			rjmp	avr091C		; 0842 C0D9
avr0843:	sts	0x0073, XH		; 0843 93B0 0073
			ldi	r18, 0x84		; 0845 E824
			sts	0x0074, r18		; 0846 9320 0074
			rcall	sub0921		; 0848 D0D8
			lds	r18, 0x0071		; 0849 9120 0071
			andi	r18, 0xF8	; 084B 7F28
			cpi	r18, 0x28		; 084C 3228
			breq	avr084F		; 084D F009
			rjmp	avr091C		; 084E C0CD
avr084F:	sts	0x0073, XL		; 084F 93A0 0073
			ldi	r18, 0x84		; 0851 E824
			sts	0x0074, r18		; 0852 9320 0074
			rcall	sub0921		; 0854 D0CC
			lds	r18, 0x0071		; 0855 9120 0071
			andi	r18, 0xF8	; 0857 7F28
			cpi	r18, 0x28		; 0858 3228
			breq	avr085B		; 0859 F009
			rjmp	avr091C		; 085A C0C1
avr085B:	sts	0x0073, r16		; 085B 9300 0073
			ldi	r16, 0x84		; 085D E804
			sts	0x0074, r16		; 085E 9300 0074
			rcall	sub0921		; 0860 D0C0
			lds	r18, 0x0071		; 0861 9120 0071
			andi	r18, 0xF8	; 0863 7F28
			cpi	r18, 0x28		; 0864 3228
			breq	avr0867		; 0865 F009
			rjmp	avr091C		; 0866 C0B5
avr0867:	ldi	r18, 0x94		; 0867 E924
			sts	0x0074, r18		; 0868 9320 0074
			rcall	sub0936		; 086A D0CB
			sec					; 086B 9408
			ret					; 086C 9508
;-------------------------------------------------------------------------
;
sub086D:	ldi	r18, 0xA4		; 086D EA24 send start
			sts	0x0074, r18		; 086E 9320 0074
			rcall	sub0921		; 0870 D0B0
			lds	r18, 0x0071		; 0871 9120 0071
			andi	r18, 0xF8	; 0873 7F28
			cpi	r18, 0x08		; 0874 3028
			breq	avr0877		; 0875 F009
			rjmp	avr091C		; 0876 C0A5
avr0877:	lsl	r17				; 0877 0F11
			ori	r17, 0xA0		; 0878 6A10
			sts	0x0073, r17		; 0879 9310 0073
			ldi	r18, 0x84		; 087B E824
			sts	0x0074, r18		; 087C 9320 0074
			rcall	sub0921		; 087E D0A2
			lds	r18, 0x0071		; 087F 9120 0071
			andi	r18, 0xF8	; 0881 7F28
			cpi	r18, 0x18		; 0882 3128
			breq	avr0885		; 0883 F009
			rjmp	avr091C		; 0884 C097
avr0885:	sts	0x0073, XH		; 0885 93B0 0073
			ldi	r18, 0x84		; 0887 E824
			sts	0x0074, r18		; 0888 9320 0074
			rcall	sub0921		; 088A D096
			lds	r18, 0x0071		; 088B 9120 0071
			andi	r18, 0xF8	; 088D 7F28
			cpi	r18, 0x28		; 088E 3228
			breq	avr0891		; 088F F009
			rjmp	avr091C		; 0890 C08B
avr0891:	sts	0x0073, XL		; 0891 93A0 0073
			ldi	r18, 0x84		; 0893 E824
			sts	0x0074, r18		; 0894 9320 0074
			rcall	sub0921		; 0896 D08A
			lds	r18, 0x0071		; 0897 9120 0071
			andi	r18, 0xF8	; 0899 7F28
			cpi	r18, 0x28		; 089A 3228
			breq	avr089D		; 089B F009
			rjmp	avr091C		; 089C C07F
avr089D:	ldi	r20, 0x80		; 089D E840
avr089E:	ld	r16, Y+			; 089E 9109
			sts	0x0073, r16		; 089F 9300 0073
			ldi	r16, 0x84		; 08A1 E804
			sts	0x0074, r16		; 08A2 9300 0074
			rcall	sub0921		; 08A4 D07C
			lds	r18, 0x0071		; 08A5 9120 0071
			andi	r18, 0xF8		; 08A7 7F28
			cpi	r18, 0x28		; 08A8 3228
			breq	avr08AB		; 08A9 F009
			rjmp	avr091C		; 08AA C071
avr08AB:	dec	r20				; 08AB 954A
			brne	avr089E		; 08AC F789
			ldi	r18, 0x94		; 08AD E924
			sts	0x0074, r18		; 08AE 9320 0074
			rcall	sub0936		; 08B0 D085
			sec					; 08B1 9408
			ret					; 08B2 9508
;-------------------------------------------------------------------------
; Start up 2 wire interface

sub08B3:	ldi	r18, 0xA4		; 08B3 EA24 send start
			sts	0x0074, r18		; 08B4 9320 0074 move to TWCR
			rcall	sub0921		; 08B6 D06A wait for 2 wire int
			brlo	avr08B9		; 08B7 F008
			rjmp	avr091C		; 08B8 C063 here if timeout
avr08B9:	lds	r18, 0x0071		; 08B9 9120 0071 get 2 wire status ?
			andi	r18, 0xF8	; 08BB 7F28
			cpi	r18, 0x08		; 08BC 3028 = 8
			breq	avr08BF		; 08BD F009
			rjmp	avr091C		; 08BE C05D
avr08BF:	mov	r18, r17		; 08BF 2F21
			lsl	r18				; 08C0 0F22
			ori	r18, 0xA0		; 08C1 6A20
			sts	0x0073, r18		; 08C2 9320 0073
			ldi	r18, 0x84		; 08C4 E824 clear twint
			sts	0x0074, r18		; 08C5 9320 0074
			rcall	sub0921		; 08C7 D059 wait for int
			brlo	avr08CA		; 08C8 F008
			rjmp	avr091C		; 08C9 C052
avr08CA:	lds	r18, 0x0071		; 08CA 9120 0071 get the status
			andi	r18, 0xF8	; 08CC 7F28
			cpi	r18, 0x18		; 08CD 3128
			breq	avr08D0		; 08CE F009
			rjmp	avr091C		; 08CF C04C
avr08D0:	sts	0x0073, XH		; 08D0 93B0 0073
			ldi	r18, 0x84		; 08D2 E824
			sts	0x0074, r18		; 08D3 9320 0074
			rcall	sub0921		; 08D5 D04B
			brlo	avr08D8		; 08D6 F008
			rjmp	avr091C		; 08D7 C044
avr08D8:	lds	r18, 0x0071		; 08D8 9120 0071
			andi	r18, 0xF8	; 08DA 7F28
			cpi	r18, 0x28		; 08DB 3228
			breq	avr08DE		; 08DC F009
			rjmp	avr091C		; 08DD C03E
avr08DE:	sts	0x0073, XL		; 08DE 93A0 0073
			ldi	r18, 0x84		; 08E0 E824
			sts	0x0074, r18		; 08E1 9320 0074
			rcall	sub0921		; 08E3 D03D
			brlo	avr08E6		; 08E4 F008
			rjmp	avr091C		; 08E5 C036
avr08E6:	lds	r18, 0x0071		; 08E6 9120 0071
			andi	r18, 0xF8	; 08E8 7F28
			cpi	r18, 0x28		; 08E9 3228
			breq	avr08EC		; 08EA F009
			rjmp	avr091C		; 08EB C030
avr08EC:	ldi	r18, 0xA4		; 08EC EA24
			sts	0x0074, r18		; 08ED 9320 0074
			rcall	sub0921		; 08EF D031
			brlo	avr08F2		; 08F0 F008
			rjmp	avr091C		; 08F1 C02A
avr08F2:	lds	r18, 0x0071		; 08F2 9120 0071
			andi	r18, 0xF8	; 08F4 7F28
			cpi	r18, 0x10		; 08F5 3120
			breq	avr08F8		; 08F6 F009
			rjmp	avr091C		; 08F7 C024
avr08F8:	mov	r18, r17		; 08F8 2F21
			lsl	r18				; 08F9 0F22
			ori	r18, 0xA1		; 08FA 6A21
			sts	0x0073, r18		; 08FB 9320 0073
			ldi	r18, 0x84		; 08FD E824
			sts	0x0074, r18		; 08FE 9320 0074
			rcall	sub0921		; 0900 D020
			brlo	avr0903		; 0901 F008
			rjmp	avr091C		; 0902 C019
avr0903:	lds	r18, 0x0071		; 0903 9120 0071
			andi	r18, 0xF8	; 0905 7F28
			cpi	r18, 0x40		; 0906 3420
			breq	avr0909		; 0907 F009
			rjmp	avr091C		; 0908 C013
avr0909:	ldi	r18, 0x84		; 0909 E824
			sts	0x0074, r18		; 090A 9320 0074
			rcall	sub0921		; 090C D014
			brlo	avr090F		; 090D F008
			rjmp	avr091C		; 090E C00D
avr090F:	lds	r16, 0x0073		; 090F 9100 0073
			lds	r18, 0x0071		; 0911 9120 0071
			andi	r18, 0xF8	; 0913 7F28
			cpi	r18, 0x58		; 0914 3528
			breq	avr0917		; 0915 F009
			rjmp	avr091C		; 0916 C005
avr0917:	ldi	r18, 0x94		; 0917 E924
			sts	0x0074, r18		; 0918 9320 0074
			sec					; 091A 9408
			ret					; 091B 9508
;-------------------------------------------------------------------------
;
avr091C:	ldi	r18, 0x94		; 091C E924 turn off 2 wire interface
			sts	0x0074, r18		; 091D 9320 0074
			clc					; 091F 9488
			ret					; 0920 9508
;-------------------------------------------------------------------------
;Wait for 2 wire ready on timeout
sub0921:	push	r16			; 0921 930F
			push	r17			; 0922 931F
			ldi	r16, 0x14		; 0923 E104
avr0924:	ldi	r17, 0x00		; 0924 E010
avr0925:	wdr					; 0925 95A8
			lds	r18, 0x0074		; 0926 9120 0074
			sbrs	r18, 7		; 0928 FF27
			rjmp	avr092E		; 0929 C004
			pop	r17				; 092A 911F
			pop	r16				; 092B 910F
			sec					; 092C 9408
			ret					; 092D 9508 carry set if OK
avr092E:	dec	r17				; 092E 951A
			brne	avr0925		; 092F F7A9
			dec	r16				; 0930 950A
			brne	avr0924		; 0931 F791
			pop	r17				; 0932 911F
			pop	r16				; 0933 910F
			clc					; 0934 9488
			ret					; 0935 9508 carry clear if timeout
;-------------------------------------------------------------------------
; Delay loop
sub0936:	ldi	r16, 0x6E		; 0936 E60E Delay 11 millisec
avr0937:	clr	r17				; 0937 2711
avr0938:	dec	r17				; 0938 951A
			brne	avr0938		; 0939 F7F1
			dec	r16				; 093A 950A
			brne	avr0937		; 093B F7D9
			ret					; 093C 9508
;-------------------------------------------------------------------------
;Initialise Timer 1
sub093D:	push	r16			; 093D 930F
			ser	r16				; 093E EF0F
			out	$2D, r16		; 093F BD0D TC1  High = 0xFF
			ldi	r16, 0x00		; 0940 E000
			out	$2C, r16		; 0941 BD0C TC1  Low = 0x00
			ldi	r16, 0x00		; 0942 E000
			out	$2E, r16		; 0943 BD0E TCR R1B = 0
			ldi	r16, 0x00		; 0944 E000
			out	$24, r16		; 0945 BD04 T Cnt 2 = 0
			ldi	r16, 0x05		; 0946 E005
			out	$25, r16		; 0947 BD05 Tccr2 = 5
			in	r16, $37		; 0948 B707
			ori	r16, 0x04		; 0949 6004 set timer 1 int EN
			out	$37, r16		; 094A BF07 set bit 2 in 0x37
			ldi	r16, 0x00		; 094B E000
			sts	0x050A, r16		; 094C 9300 050A   set 50A = 0
			pop	r16				; 094E 910F
			ret					; 094F 9508

;-------------------------------------------------------------------------
sub0950:	push	r16			; 0950 930F Sounder On
			ldi	r16, 0x01		; 0951 E001
			out	$2E, r16		; 0952 BD0E
			ldi	r16, 0x00		; 0953 E000
			out	$33, r16		; 0954 BF03
			sbi	DDRD, 5			; 0955 9A8D
			pop	r16				; 0956 910F
			ret					; 0957 9508
;-------------------------------------------------------------------------
navr09FE:
sub0958:	push	r16			; 0958 930F Sounder Off
			ldi	r16, 0x00		; 0959 E000
			out	$2E, r16		; 095A BD0E
			ldi	r16, 0x05		; 095B E005
			out	$33, r16		; 095C BF03
			cbi	DDRD, 5			; 095D 988D
			pop	r16				; 095E 910F
			ret					; 095F 9508
;-------------------------------------------------------------------------
; This never seems to be used

avr0960:	ldi	ZH, high(avr0A26  << 1)	; 0960 E1F4 Point to table at 0x0A26
			ldi	ZL, low(avr0A26  << 1)	; 0961 E4EC
			lsl	r16						; 0962 0F00 Double r16 offset
			add	ZL, r16					; 0963 0FE0 Add to pointer
			brsh	avr0966				; 0964 F408
			inc	ZH						; 0965 95F3
avr0966:	lpm							; 0966 95C8 Get data from table into Y
			mov	YL, r0					; 0967 2DC0
			adiw	ZL, 0x01			; 0968 9631
			lpm							; 0969 95C8
			mov	YH, r0					; 096A 2DD0

avr096B:	ldi	r18, 0x82				; 096B E822 load 82 into TCNT2
			out	$24, r18				; 096C BD24
avr096D:	in	r18, $36				; 096D B726 Get TIFR, 
			sbrs	r18, 6				; 096E FF26 Timer 2 overflow ?
			rjmp	avr096D				; 096F CFFD
			andi	r18, 0x40			; 0970 7420 clear overflow
			out	$36, r18				; 0971 BF26
			dec	r17						; 0972 951A loop number of time in r17
			brne	avr096B				; 0973 F7B9
			ret							; 0974 9508
;-------------------------------------------------------------------------
; Timer 1 interrupt routine
; Music routines

sub0975:	wdr					; 0975 95A8 clear watchdog
			push	r16			; 0976 930F
			lds	r16, 0x050A		; 0977 9100 050A get 0x50a if bit 2 set then return
			sbrc	r16, 2		; 0979 FD02
			rjmp	avr0A24		; 097A C0A9

			ori	r16, 0x04		; 097B 6004 set bit 2 in 0x50a
			sts	0x050A, r16		; 097C 9300 050A

			push	r17			; 097E 931F save registers
			push	ZH			; 097F 93FF
			push	ZL			; 0980 93EF
			push	XH			; 0981 93BF
			push	XL			; 0982 93AF
			in	r16, SREG		; 0983 B70F
			push	r16			; 0984 930F

			lds	r16, 0x050A		; 0985 9100 050A if bit 7 clear in 050a then return
			sbrs	r16, 7		; 0987 FF07
			rjmp	avr0A18		; 0988 C08F
	
			sbrs	r16, 6		; 0989 FF06 0x50a if bit 6 clear then skip next bit
			rjmp	avr0997		; 098A C00C
			andi	r16, 0xBF	; 098B 7B0F clear bit 6 in 0x50a
			sts	0x050A, r16		; 098C 9300 050A

			lds	r16, 0x050F		; 098E 9100 050F copy 0x50f to 0x50d
			sts	0x050D, r16		; 0990 9300 050D

			lds	r16, 0x0510		; 0992 9100 0510 copy 0x510 0x50e
			sts	0x050E, r16		; 0994 9300 050E

			rjmp	avr09C4		; 0996 C02D

avr0997:	lds	r16, 0x0508		; 0997 9100 0508 load TC1 count from 508 and 509
			out	$2D, r16		; 0999 BD0D
			lds	r16, 0x0509		; 099A 9100 0509
			out	$2C, r16		; 099C BD0C

			lds	r16, 0x050A		; 099D 9100 050A
			sbrc	r16, 4		; 099F FD04
			rjmp	avr09B3		; 09A0 C012

			lds	r16, 0x050A		; 09A1 9100 050A
			sbrs	r16, 3		; 09A3 FF03
			rjmp	avr09AD		; 09A4 C008
			lds	r16, 0x0506		; 09A5 9100 0506
			tst	r16				; 09A7 2300
			brne	avr09AD		; 09A8 F421

			in	r16, $24		; 09A9 B504 read TCNT2
			cpi	r16, 0xF0		; 09AA 3F00
			brlo	avr09AD		; 09AB F008
			rjmp	avr09B4		; 09AC C007
avr09AD:	sbic	PORTD, 5	; 09AD 9995 Toggle Buzzer
			rjmp	avr09B1		; 09AE C002
			sbi	PORTD, 5		; 09AF 9A95
			rjmp	avr09B2		; 09B0 C001
avr09B1:	cbi	PORTD, 5		; 09B1 9895
avr09B2:	rjmp	avr09B4		; 09B2 C001

avr09B3:	sbi	PORTD, 5		; 09B3 9A95

avr09B4:	in	r16, $36		; 09B4 B706 Timer 2 overflow ?
			sbrs	r16, 6		; 09B5 FF06
			rjmp	avr0A18		; 09B6 C061 No get out
			andi	r16, 0x40	; 09B7 7400 Yes clear overflow
			out	$36, r16		; 09B8 BF06
			lds	r16, 0x0505		; 09B9 9100 0505 get Tempo
			out	$24, r16		; 09BB BD04


			lds	r16, 0x0506		; 09BC 9100 0506 get the count from 0x0506
			tst	r16				; 09BE 2300
			breq	avr09C4		; 09BF F021
			dec	r16				; 09C0 950A decrement
			sts	0x0506, r16		; 09C1 9300 0506
			rjmp	avr0A18		; 09C3 C054 get out

avr09C4:	lds	XH, 0x050F		; 09C4 91B0 050F here if not done
			lds	XL, 0x0510		; 09C6 91A0 0510
			call	sub07D6		; 09C8 940E 07D6
			tst	r16				; 09CA 2300
			brne	avr09CD		; 09CB F409
			rjmp	avr0A04		; 09CC C037
avr09CD:	sts	0x0506, r16		; 09CD 9300 0506
			call	sub07D6		; 09CF 940E 07D6
			push	r16			; 09D1 930F
			adiw	XL, 0x01	; 09D2 9611
			call	sub07D6		; 09D3 940E 07D6
			sbiw	XL, 0x01	; 09D5 9711
			mov	r17, r16		; 09D6 2F10
			pop	r16				; 09D7 910F
			cp	r17, r16		; 09D8 1710
			brne	avr09DE		; 09D9 F421
			lds	r17, 0x050A		; 09DA 9110 050A
				ori	r17, 0x08	; 09DC 6018
			rjmp	avr09E1		; 09DD C003
avr09DE:	lds	r17, 0x050A		; 09DE 9110 050A
			andi	r17, 0xF7	; 09E0 7F17
avr09E1:	sts	0x050A, r17		; 09E1 9310 050A
			sbiw	XL, 0x01	; 09E3 9711
			sts	0x050F, XH		; 09E4 93B0 050F
			sts	0x0510, XL		; 09E6 93A0 0510
			cpi	r16, 0x7F		; 09E8 370F
			brne	avr09F0		; 09E9 F431
			lds	ZL, 0x050A		; 09EA 91E0 050A
			ori	ZL, 0x10		; 09EC 61E0
			sts	0x050A, ZL		; 09ED 93E0 050A
			rjmp	avr0A18		; 09EF C028
avr09F0:	lds	ZL, 0x050A		; 09F0 91E0 050A
			andi	ZL, 0xEF	; 09F2 7EEF
			sts	0x050A, ZL		; 09F3 93E0 050A
			ldi	r17, 0x0C		; 09F5 E01C
			add	r16, r17		; 09F6 0F01
			ldi	ZH, high(avr0A26 << 1)		; 09F7 E1F4
			ldi	ZL, low(avr0A26 << 1)		; 09F8 E4EC
			lsl	r16				; 09F9 0F00
			add	ZL, r16			; 09FA 0FE0
			brsh	avr09FD		; 09FB F408
			inc	ZH				; 09FC 95F3
avr09FD:	lpm	r16, Z+			; 09FD 9105
			sts	0x0509, r16		; 09FE 9300 0509
			lpm	r16, Z			; 0A00 9104
			sts	0x0508, r16		; 0A01 9300 0508
			rjmp	avr0A18		; 0A03 C014
avr0A04:	lds	r16, 0x050A		; 0A04 9100 050A
			sbrs	r16, 5		; 0A06 FF05
			rjmp	avr0A14		; 0A07 C00C
			ori	r16, 0x40		; 0A08 6400
			sts	0x050A, r16		; 0A09 9300 050A
			lds	r16, 0x050D		; 0A0B 9100 050D
			sts	0x050F, r16		; 0A0D 9300 050F
			lds	r16, 0x050E		; 0A0F 9100 050E
			sts	0x0510, r16		; 0A11 9300 0510
			rjmp	avr0A18		; 0A13 C004
avr0A14:	andi	r16, 0x7F	; 0A14 770F
			sts	0x050A, r16		; 0A15 9300 050A
			rcall	sub0958		; 0A17 DF40
avr0A18:	pop	r16				; 0A18 910F
			out	SREG, r16		; 0A19 BF0F
			pop	XL				; 0A1A 91AF
			pop	XH				; 0A1B 91BF
			pop	ZL				; 0A1C 91EF
			pop	ZH				; 0A1D 91FF
			pop	r17				; 0A1E 911F
			lds	r16, 0x050A		; 0A1F 9100 050A
			andi	r16, 0xFB	; 0A21 7F0B
			sts	0x050A, r16		; 0A22 9300 050A
avr0A24:	pop	r16				; 0A24 910F
			ret					; 0A25 9508
;-------------------------------------------------------------------------
; Note Table
avr0A26:
			.dw 0x4CD0, 0x5703, 0x6070, 0x6977
			.dw 0x71E6, 0x79DE, 0x815E, 0x8884
			.dw 0x8F46, 0x958D, 0x9B89, 0xA12E
			.dw 0xA681, 0xAB8E, 0xB044, 0xB4C2
			.dw 0xB8FF, 0xBCFB, 0xC0C3, 0xC449
			.dw 0xC7AA, 0xCAD2, 0xCDCF, 0xD0A2
			.dw 0xD34A, 0xD5D1, 0xD82C, 0xDA69
			.dw 0xDC8F, 0xDE8B, 0xE068, 0xE230
			.dw 0xE3E3, 0xE573, 0xE5D1, 0xE85C, 0xE9B0
			.dw 0xEAF4, 0xEC22, 0xED42, 0xEE52
			.dw 0xEF52, 0xF040, 0xF124, 0xF1F8
			.dw 0xF2C0, 0xF382, 0xF439, 0xF4E7
			.dw 0xF587, 0xF61F, 0xF6AC, 0xF731
			.dw 0xF7B1, 0xF82F, 0xF8A2, 0xF908
			.dw 0xF96C, 0xF9CF, 0xFA27, 0xFA7C
			.dw 0xFACE, 0xFB1B, 0xFB62, 0xFBA5
			.dw 0xFBE4, 0xFC20, 0xFC58, 0xFC8E
			.dw 0xFCC0,	0xFCF0, 0xFD1D, 0xFD49
			.dw 0x0000, 0x0000, 0x0000, 0x0000
			.dw 0x0000, 0x0000, 0x0000, 0x0000
			.dw 0x0000, 0x0000, 0x0000

/*
;This looks like a data table Probably the note table for music
		0A26 4CD0 = 19664
		0A27 5703 = 22275
		0A28 6070 = 24688
		0A29 6977
		0A2A 71E6
		0A2B 79DE
		0A2C 815E
		0A2D 8884
		0A2E 8F46
		0A2F 958D
		0A30 9B89
		0A31 A12E
		0A32 A681
		0A33 AB8E
		0A34 B044
		0A35 B4C2
		0A36 B8FF
		0A37 BCFB
		0A38 C0C3
		0A39 C449
		0A3A C7AA
		0A3B CAD2
		0A3C CDCF
		0A3D D0A2
		0A3E D34A
		0A3F D5D1
		0A40 D82C
		0A41 DA69
		0A42 DC8F
		0A43 DE8B
		0A44 E068
		0A45 E230
		0A46 E3E3
		0A47 E573
		0A48 E5D1
		0A49 E85C
		0A4A E9B0
		0A4B EAF4
		0A4C EC22
		0A4D ED42
		0A4E EE52
		0A4F EF52
		0A50 F040
		0A51 F124
		0A52 F1F8
		0A53 F2C0
		0A54 F382
		0A55 F439
		0A56 F4E7
		0A57 F587
		0A58 F61F
		0A59 F6AC
		0A5A F731
		0A5B F7B1
		0A5C F82F
		0A5D F8A2
		0A5E F908
		0A5F F96C
		0A60 F9CF
		0A61 FA27
		0A62 FA7C
		0A63 FACE
		0A64 FB1B
		0A65 FB62
		0A66 FBA5
		0A67 FBE4
		0A68 FC20
		0A69 FC58
		0A6A FC8E
		0A6B FCC0
		0A6C FCF0
		0A6D FD1D
		0A6E FD49
		0A6F 0000
		0A70 0000
		0A71 0000
		0A72 0000
		0A73 0000
		0A74 0000
		0A75 0000
		0A76 0000
		0A77 0000
		0A78 0000
		0A79 0000
*/

		.dw 0xDEC2, 0xEC00, 0x9300, 0x050A
		.dw 0xE106, 0xE918, 0x9300, 0x050F
		.dw 0x9310, 0x0510, 0xDECB, 0x9100
		.dw 0x050A, 0xFD07, 0xCFFC, 0xEC00
		.dw 0x9300, 0x050A, 0xE107, 0xE21E
		.dw	0x9300, 0x050F, 0x9310, 0x0510
		.dw 0xDEBD, 0x9100, 0x050A, 0xFD07
		.dw 0xCFFC, 0xEC00, 0x9300, 0x050A
		.dw 0xE107, 0xE918, 0x9300, 0x050F
		.dw 0x9310, 0x0510, 0xDEAF, 0x9100
		.dw 0x050A, 0xFD07, 0xCFFC, 0x9508

/*
		.
		0A7A DEC2
		0A7B EC00
		0A7C 9300 
		0A7D 050A
		0A7E E105
		0A7F E41C
		0A80 9300
		0A81 050F
		0A82 9310
		0A83 0510
		0A84 DECB
		0A85 9100
		0A86 050A
		0A87 FD07
		0A88 CFFC
		0A89 EC00
		0A8A 9300
		0A8B 050A
		0A8C E105
		0A8D EE12
		0A8E 9300
		08AF 050F
		0A90 9310
		0A91 0510
		0A92 DEBD
		0A93 9100
		0A94 050A
		0A95 FD07
		0A96 CFFC
		0A97 EC00
		0A98 9300
		0A99 050A
		0A9A E106
		0A9B E41C
		0A9C 9300
		0A9D 050F
		0A9E 9310
		0A9F 0510
		0AA0 DEAF
		0AA1 9100
		0AA2 050A
		0AA3 FD07
		0AA4 CFFC
		0AA5 9508
*/


			sub	r0, r12		; 0AA6 180C
			sub	r0, YL		; 0AA7 1A0C
			adc	r0, r12		; 0AA8 1C0C
			adc	r16, r12		; 0AA9 1D0C
			adc	r17, r24		; 0AAA 1F18
			adc	r17, r24		; 0AAB 1F18
			and	r16, r12		; 0AAC 210C
			and	r16, r12		; 0AAD 210C
			adc	r16, YL		; 0AAE 1F0C
			adc	r16, r12		; 0AAF 1D0C
			adc	r3, r0		; 0AB0 1C30
			adc	r1, r8		; 0AB1 1C18
			adc	r0, r12		; 0AB2 1C0C
			adc	r0, r12		; 0AB3 1C0C
			adc	r16, r12		; 0AB4 1D0C
			adc	r16, r12		; 0AB5 1D0C
			adc	r1, r8		; 0AB6 1C18
			sub	r4, r24		; 0AB7 1A48
			andi	r17, 0xF8		; 0AB8 7F18
			sub	r0, r12		; 0AB9 180C
			sub	r0, YL		; 0ABA 1A0C
			adc	r0, r12		; 0ABB 1C0C
			adc	r16, r12		; 0ABC 1D0C
			adc	r19, r16		; 0ABD 1F30
			and	r16, r12		; 0ABE 210C
			and	r16, r12		; 0ABF 210C
			adc	r16, YL		; 0AC0 1F0C
			adc	r16, r12		; 0AC1 1D0C
			adc	r3, r0		; 0AC2 1C30
			adc	r18, r4		; 0AC3 1D24
			adc	r0, r12		; 0AC4 1C0C
			sub	r1, r24		; 0AC5 1A18
			sub	r1, r24		; 0AC6 1A18
			sub	r4, r8		; 0AC7 1848
			andi	r17, 0xF8		; 0AC8 7F18
			and	r17, r8		; 0AC9 2118
			and	r16, r12		; 0ACA 210C
			adc	r16, YL		; 0ACB 1F0C
			and	r16, r12		; 0ACC 210C
			and	r16, YL		; 0ACD 230C
			eor	r1, r8		; 0ACE 2418
			adc	r16, YL		; 0ACF 1F0C
			and	r16, r12		; 0AD0 210C
			adc	r16, YL		; 0AD1 1F0C
			adc	r16, r12		; 0AD2 1D0C
			adc	r3, r0		; 0AD3 1C30
			adc	r16, r12		; 0AD4 1D0C
			adc	r16, r12		; 0AD5 1D0C
			adc	r16, r12		; 0AD6 1D0C
			adc	r0, r12		; 0AD7 1C0C
			sub	r1, r24		; 0AD8 1A18
			sub	r1, r8		; 0AD9 1818
			adc	r20, r24		; 0ADA 1F48
			andi	r17, 0xF8		; 0ADB 7F18
			and	r17, r8		; 0ADC 2118
			and	r16, r12		; 0ADD 210C
			adc	r16, YL		; 0ADE 1F0C
			and	r16, r12		; 0ADF 210C
			and	r16, YL		; 0AE0 230C
			eor	r1, r8		; 0AE1 2418
			adc	r16, YL		; 0AE2 1F0C
			and	r16, r12		; 0AE3 210C
			adc	r16, YL		; 0AE4 1F0C
			adc	r16, r12		; 0AE5 1D0C
			adc	r3, r0		; 0AE6 1C30
			adc	r16, r12		; 0AE7 1D0C
			adc	r16, r12		; 0AE8 1D0C
			adc	r16, r12		; 0AE9 1D0C
			adc	r0, r12		; 0AEA 1C0C
			sub	r1, r24		; 0AEB 1A18
			sub	r0, YL		; 0AEC 1A0C
			sub	r0, YL		; 0AED 1A0C
			sub	r4, r8		; 0AEE 1848
			andi	r17, 0xF8		; 0AEF 7F18
			nop				; 0AF0 0000
			eor	r1, r8		; 0AF1 2418
			and	r17, r8		; 0AF2 2118
			and	r19, r0		; 0AF3 2130
			and	r1, r24		; 0AF4 2218
			adc	r17, r24		; 0AF5 1F18
			adc	r19, r16		; 0AF6 1F30
			adc	r17, r8		; 0AF7 1D18
			adc	r17, r24		; 0AF8 1F18
			and	r17, r8		; 0AF9 2118
			and	r1, r24		; 0AFA 2218
			eor	r1, r8		; 0AFB 2418
			eor	r1, r8		; 0AFC 2418
			eor	r1, r8		; 0AFD 2418
			andi	r17, 0xF8		; 0AFE 7F18
			eor	r1, r8		; 0AFF 2418
			and	r17, r8		; 0B00 2118
			and	r19, r0		; 0B01 2130
			and	r1, r24		; 0B02 2218
			adc	r17, r24		; 0B03 1F18
			adc	r19, r16		; 0B04 1F30
			adc	r17, r8		; 0B05 1D18
			and	r17, r8		; 0B06 2118
			eor	r1, r8		; 0B07 2418
			eor	r1, r8		; 0B08 2418
			adc	r20, r8		; 0B09 1D48
			andi	r17, 0xF8		; 0B0A 7F18
			adc	r17, r24		; 0B0B 1F18
			adc	r17, r24		; 0B0C 1F18
			adc	r17, r24		; 0B0D 1F18
			adc	r17, r24		; 0B0E 1F18
			adc	r17, r24		; 0B0F 1F18
			and	r17, r8		; 0B10 2118
			and	r3, r16		; 0B11 2230
			and	r17, r8		; 0B12 2118
			and	r17, r8		; 0B13 2118
			and	r17, r8		; 0B14 2118
			and	r17, r8		; 0B15 2118
			and	r17, r8		; 0B16 2118
			and	r1, r24		; 0B17 2218
			eor	r3, r0		; 0B18 2430
			eor	r1, r8		; 0B19 2418
			and	r17, r8		; 0B1A 2118
			and	r19, r0		; 0B1B 2130
			and	r1, r24		; 0B1C 2218
			adc	r17, r24		; 0B1D 1F18
			adc	r19, r16		; 0B1E 1F30
			adc	r17, r8		; 0B1F 1D18
			and	r17, r8		; 0B20 2118
			eor	r1, r8		; 0B21 2418
			eor	r1, r8		; 0B22 2418
			adc	r20, r8		; 0B23 1D48
			andi	r17, 0xF8		; 0B24 7F18
			nop				; 0B25 0000


			sub	r1, r24		; 0B26 1A18
			sub	r0, YL		; 0B27 1A0C
			adc	r18, r20		; 0B28 1F24
			adc	r16, YL		; 0B29 1F0C
			adc	r0, YL		; 0B2A 1E0C
			adc	r0, r12		; 0B2B 1C0C
			sub	r2, r20		; 0B2C 1A24
			sub	r0, r22		; 0B2D 1A06
			sub	r0, r22		; 0B2E 1A06
			sub	r0, r22		; 0B2F 1A06
			sub	r0, r22		; 0B30 1A06
			sub	r0, r22		; 0B31 1A06
			sub	r0, r22		; 0B32 1A06
			adc	r16, YL		; 0B33 1F0C
			and	r16, YL		; 0B34 230C
			adc	r16, YL		; 0B35 1F0C
			and	r19, r12		; 0B36 213C
			andi	r16, 0xFC		; 0B37 7F0C
			and	r16, YL		; 0B38 230C
			and	r16, YL		; 0B39 230C
			and	r16, YL		; 0B3A 230C
			eor	r2, r20		; 0B3B 2624
			and	r16, YL		; 0B3C 230C
			and	r16, r12		; 0B3D 210C
			adc	r16, YL		; 0B3E 1F0C
			adc	r2, r4		; 0B3F 1C24
			sub	r0, YL		; 0B40 1A0C
			sub	r0, r22		; 0B41 1A06
			sub	r0, r22		; 0B42 1A06
			sub	r0, r22		; 0B43 1A06
			sub	r0, r22		; 0B44 1A06
			eor	r0, r12		; 0B45 240C
			and	r16, YL		; 0B46 230C
			and	r16, r12		; 0B47 210C
			adc	r19, YL		; 0B48 1F3C
			andi	r16, 0xFC		; 0B49 7F0C
			adc	r1, r24		; 0B4A 1E18
			adc	r16, YL		; 0B4B 1F0C
			and	r18, r4		; 0B4C 2124
			adc	r16, YL		; 0B4D 1F0C
			adc	r16, YL		; 0B4E 1F0C
			and	r16, r12		; 0B4F 210C
			and	r18, r20		; 0B50 2324
			and	r16, r12		; 0B51 210C
			and	r16, r6		; 0B52 2106
			and	r16, r6		; 0B53 2106
			and	r16, r6		; 0B54 2106
			and	r16, r6		; 0B55 2106
			eor	r18, r4		; 0B56 2524
			eor	r3, YL		; 0B57 263C
			andi	r16, 0xFC		; 0B58 7F0C
			sub	r1, r24		; 0B59 1A18
			sub	r0, YL		; 0B5A 1A0C
			adc	r18, r20		; 0B5B 1F24
			adc	r16, YL		; 0B5C 1F0C
			adc	r0, YL		; 0B5D 1E0C
			adc	r0, r12		; 0B5E 1C0C
			sub	r2, r20		; 0B5F 1A24
			sub	r0, YL		; 0B60 1A0C
			sub	r0, YL		; 0B61 1A0C
			sub	r0, r22		; 0B62 1A06
			sub	r0, r22		; 0B63 1A06
			adc	r16, YL		; 0B64 1F0C
			and	r16, YL		; 0B65 230C
			adc	r16, YL		; 0B66 1F0C
			and	r19, r12		; 0B67 213C
			andi	r16, 0xFC		; 0B68 7F0C
			and	r16, YL		; 0B69 230C
			and	r16, YL		; 0B6A 230C
			and	r16, r22		; 0B6B 2306
			and	r16, r22		; 0B6C 2306
			eor	r2, r20		; 0B6D 2624
			and	r16, YL		; 0B6E 230C
			and	r16, r12		; 0B6F 210C
			adc	r16, YL		; 0B70 1F0C
			adc	r2, r4		; 0B71 1C24
			sub	r0, YL		; 0B72 1A0C
			sub	r0, YL		; 0B73 1A0C
			sub	r0, r22		; 0B74 1A06
			sub	r0, r22		; 0B75 1A06
			eor	r0, r12		; 0B76 240C
			and	r16, YL		; 0B77 230C
			and	r16, r12		; 0B78 210C
			adc	r19, YL		; 0B79 1F3C
			andi	r16, 0xFC		; 0B7A 7F0C
			nop				; 0B7B 0000
; end of table ?
;-------------------------------------------------------------------------
; setup Timer 1  count = 48640 timer at 6.6 millisec
sub0B7C:	ldi	r16, 0xFE		; 0B7C EF0E	TC1 High = 0xFE
			out	$2D, r16		; 0B7D BD0D
			ldi	r16, 0x84		; 0B7E E804 TC1 Low = 0x84
			out	$2C, r16		; 0B7F BD0C
			ldi	r16, 0x05		; 0B80 E005 Prescale = 128
			out	$2E, r16		; 0B81 BD0E
			ret				; 0B82 9508
;-------------------------------------------------------------------------
; more timer 1 stuff
sub0B83:	in	r16, $36		; 0B83 B706 clear TOV1 in TIFR
			andi	r16, 0x04	; 0B84 7004
			out	$36, r16		; 0B85 BF06
			ldi	r16, 0xFE		; 0B86 EF0E Reset the counter
			out	$2D, r16		; 0B87 BD0D
			ldi	r16, 0x84		; 0B88 E804
			out	$2C, r16		; 0B89 BD0C
			ret				; 0B8A 9508
;-------------------------------------------------------------------------
; This seems to be the routine which converts EEPROM value to real numbers
; returns value in r23 (low) and r24 (high) also in Y
; also T bit if byte, and C bit if NULL
sub0B8B:	set					; 0B8B 9468 set the T flag
			rcall	sub07D6		; 0B8C DC49 get next byte from EEPROM
			clr	r24				; 0B8D 2788
			sts	0x0CFD, r16		; 0B8E 9300 0CFD
			cpi	r16, 0x00		; 0B90 3000 is it 0 
			brne	avr0B94		; 0B91 F411
			sec					; 0B92 9408 carry is set if NULL
			ret					; 0B93 9508

avr0B94:	cpi	r16, 0x10		; 0B94 3100 10 is literal 0
			brne	avr0B99		; 0B95 F419
			ldi	r23, 0x00		; 0B96 E070 r23 = 0 zero
			clt					; 0B97 94E8
			rjmp	avr0BCA		; 0B98 C031
avr0B99:	cpi	r16, 0x11		; 0B99 3101 11 is literal 1
			brne	avr0B9E		; 0B9A F419
			ldi	r23, 0x01		; 0B9B E071 r23 = 1
			clt					; 0B9C 94E8
			rjmp	avr0BCA		; 0B9D C02C
avr0B9E:	cpi	r16, 0x12		; 0B9E 3102 12 is byte value
			brne	avr0BA4		; 0B9F F421
			rcall	sub07D6		; 0BA0 DC35 get next byte
			mov	r23, r16		; 0BA1 2F70 r23 = byte
			clt					; 0BA2 94E8
			rjmp	avr0BCA		; 0BA3 C026
avr0BA4:	cpi	r16, 0x13		; 0BA4 3103 13 is int value
			brne	avr0BAB		; 0BA5 F429
			rcall	sub07D6		; 0BA6 DC2F get next byte
			mov	r23, r16		; 0BA7 2F70 r23 = low byte
			rcall	sub07D6		; 0BA8 DC2D and next byte
			mov	r24, r16		; 0BA9 2F80 r24 = high byte
			rjmp	avr0BCA		; 0BAA C01F
avr0BAB:	cpi	r16, 0x15		; 0BAB 3105 15 is variable byte
			brne	avr0BB3		; 0BAC F431
			rcall	sub07D6		; 0BAD DC28 get next byte
			ldi	YH, 0x01		; 0BAE E0D1 make address
			mov	YL, r16			; 0BAF 2FC0
			ld	r23, Y			; 0BB0 8178 r23 = byte variable from RAM
			clt					; 0BB1 94E8
			rjmp	avr0BCA		; 0BB2 C017
avr0BB3:	cpi	r16, 0x16		; 0BB3 3106 16 is int variable
			brne	avr0BBC		; 0BB4 F439
			rcall	sub07D6		; 0BB5 DC20
			ldi	YH, 0x01		; 0BB6 E0D1
			mov	YL, r16			; 0BB7 2FC0
			ld	r23, Y+			; 0BB8 9179 r23 = variable low
			ld	r24, Y			; 0BB9 8188 r24 = variable high
			sbiw	YL, 0x01	; 0BBA 9721
			rjmp	avr0BCA		; 0BBB C00E
avr0BBC:	cpi	r16, 0x1B		; 0BBC 310B 1B is bit from variable
			brne	avr0BCA		; 0BBD F461
avr0BBE:	rcall	sub07D6		; 0BBE DC17 get next byte = address
			ldi	YH, 0x01		; 0BBF E0D1
avr0BC0:	mov	YL, r16			; 0BC0 2FC0
			ld	r23, Y			; 0BC1 8178
avr0BC2:	rcall	sub07D6		; 0BC2 DC13 get next byte = bit mask
			and	r16, r23		; 0BC3 2307 and mask
			ldi	r24, 0x00		; 0BC4 E080 r24 = 0
			cpi	r16, 0x00		; 0BC5 3000
			breq	avr0BC9		; 0BC6 F011
avr0BC7:	ldi	r23, 0x01		; 0BC7 E071 r23 1 if set
			rjmp	avr0BCA		; 0BC8 C001
avr0BC9:	ldi	r23, 0x00		; 0BC9 E070 r23 = 0 if clear
avr0BCA:	clc					; 0BCA 9488 carry clear if not null
avr0BCB:	ret					; 0BCB 9508
;-------------------------------------------------------------------------
; Here for F0 IM code IN(n)
avr0BCC:	call	sub0B8B		; 0BCC 940E 0B8B
			mov	r17, r23		; 0BCE 2F17


;------------------------------------------------------------------------
; This routine seems to test port bits based on the contents of r17 and return true or false in r18 as 0 or 1
; 0 -> 7 = reg A bits 0 to 7
; 8 -> 0x0f = reg B bits 0 to 7
; 0x10 -> 0x17= reg c bits 7 to 0
; 0x19 -> reg e bit 7, 0x1a -> reg e bit 6
; 0x1b -> reg d bit 7, 0x1c -> reg d bit 6 0x1d -> reg d bit 5
; 0x1e -> reg g bit 1, 0x1f -> reg g bit 0
; 0x20 -> 0x27= reg f bits 0 to 7
; 0x28 -> reg d bit 2, 0x29 -> reg d bit 3 0x2a -> reg d bit 4
; 0x2b -> 0x30= reg e bits 0 to 5
; 0x30 -> reg g bit 3, 0x1a -> reg g bit 4
; 
; used by E0 command

sub0BCF:	clt				; 0BCF 94E8
			cpi	r17, 0x00		; 0BD0 3010
			brne	avr0BD7		; 0BD1 F429
			cbi	DDRA, 0	; 0BD2 98D0
			nop				; 0BD3 0000
			sbic	PINA, 0	; 0BD4 99C8
			set				; 0BD5 9468
avr0BD6:	rjmp	avr0D6E		; 0BD6 C197
avr0BD7:	cpi	r17, 0x01		; 0BD7 3011
			brne	avr0BDE		; 0BD8 F429
			cbi	DDRA, 1	; 0BD9 98D1
			nop				; 0BDA 0000
			sbic	PINA, 1	; 0BDB 99C9
			set				; 0BDC 9468
			rjmp	avr0D6E		; 0BDD C190
avr0BDE:	cpi	r17, 0x02		; 0BDE 3012
			brne	avr0BE5		; 0BDF F429
			cbi	DDRA, 2	; 0BE0 98D2
			nop				; 0BE1 0000
			sbic	PINA, 2	; 0BE2 99CA
			set				; 0BE3 9468
avr0BE4:	rjmp	avr0D6E		; 0BE4 C189
avr0BE5:	cpi	r17, 0x03		; 0BE5 3013
			brne	avr0BEC		; 0BE6 F429
			cbi	DDRA, 3	; 0BE7 98D3
			nop				; 0BE8 0000
avr0BE9:	sbic	PINA, 3	; 0BE9 99CB
			set				; 0BEA 9468
			rjmp	avr0D6E		; 0BEB C182
avr0BEC:	cpi	r17, 0x04		; 0BEC 3014
			brne	avr0BF3		; 0BED F429
			cbi	DDRA, 4	; 0BEE 98D4
avr0BEF:	nop				; 0BEF 0000
			sbic	PINA, 4	; 0BF0 99CC
avr0BF1:	set				; 0BF1 9468
			rjmp	avr0D6E		; 0BF2 C17B
avr0BF3:	cpi	r17, 0x05		; 0BF3 3015
			brne	avr0BFA		; 0BF4 F429
			cbi	DDRA, 5	; 0BF5 98D5
avr0BF6:	nop				; 0BF6 0000
			sbic	PINA, 5	; 0BF7 99CD
avr0BF8:	set				; 0BF8 9468
			rjmp	avr0D6E		; 0BF9 C174
avr0BFA:	cpi	r17, 0x06		; 0BFA 3016
			brne	avr0C01		; 0BFB F429
avr0BFC:	cbi	DDRA, 6	; 0BFC 98D6
avr0BFD:	nop				; 0BFD 0000
			sbic	PINA, 6	; 0BFE 99CE
			set				; 0BFF 9468
			rjmp	avr0D6E		; 0C00 C16D
avr0C01:	cpi	r17, 0x07		; 0C01 3017
			brne	avr0C08		; 0C02 F429
			cbi	DDRA, 7	; 0C03 98D7
avr0C04:	nop				; 0C04 0000
			sbic	PINA, 7	; 0C05 99CF
avr0C06:	set				; 0C06 9468
			rjmp	avr0D6E		; 0C07 C166
avr0C08:	cpi	r17, 0x08		; 0C08 3018
avr0C09:	brne	avr0C0F		; 0C09 F429
			cbi	DDRB, 0	; 0C0A 98B8
			nop				; 0C0B 0000
			sbic	PINB, 0	; 0C0C 99B0
			set				; 0C0D 9468
			rjmp	avr0D6E		; 0C0E C15F
avr0C0F:	cpi	r17, 0x09		; 0C0F 3019
			brne	avr0C16		; 0C10 F429
			cbi	DDRB, 1	; 0C11 98B9
			nop				; 0C12 0000
avr0C13:	sbic	PINB, 1	; 0C13 99B1
			set				; 0C14 9468
			rjmp	avr0D6E		; 0C15 C158
avr0C16:	cpi	r17, 0x0A		; 0C16 301A
			brne	avr0C1D		; 0C17 F429
			cbi	DDRB, 2	; 0C18 98BA
			nop				; 0C19 0000
			sbic	PINB, 2	; 0C1A 99B2
avr0C1B:	set				; 0C1B 9468
			rjmp	avr0D6E		; 0C1C C151
avr0C1D:	cpi	r17, 0x0B		; 0C1D 301B
			brne	avr0C24		; 0C1E F429
avr0C1F:	cbi	DDRB, 3	; 0C1F 98BB
			nop				; 0C20 0000
avr0C21:	sbic	PINB, 3	; 0C21 99B3
			set				; 0C22 9468
			rjmp	avr0D6E		; 0C23 C14A
avr0C24:	cpi	r17, 0x0C		; 0C24 301C
			brne	avr0C2B		; 0C25 F429
avr0C26:	cbi	DDRB, 4	; 0C26 98BC
			nop				; 0C27 0000
			sbic	PINB, 4	; 0C28 99B4
avr0C29:	set				; 0C29 9468
			rjmp	avr0D6E		; 0C2A C143
avr0C2B:	cpi	r17, 0x0D		; 0C2B 301D
			brne	avr0C32		; 0C2C F429
			cbi	DDRB, 5	; 0C2D 98BD
			nop				; 0C2E 0000
			sbic	PINB, 5	; 0C2F 99B5
			set				; 0C30 9468
			rjmp	avr0D6E		; 0C31 C13C
avr0C32:	cpi	r17, 0x0E		; 0C32 301E
avr0C33:	brne	avr0C39		; 0C33 F429
			cbi	DDRB, 6	; 0C34 98BE
			nop				; 0C35 0000
avr0C36:	sbic	PINB, 6	; 0C36 99B6
			set				; 0C37 9468
			rjmp	avr0D6E		; 0C38 C135
avr0C39:	cpi	r17, 0x0F		; 0C39 301F
avr0C3A:	brne	avr0C40		; 0C3A F429
avr0C3B:	cbi	DDRB, 7	; 0C3B 98BF
			nop				; 0C3C 0000
			sbic	PINB, 7	; 0C3D 99B7
			set				; 0C3E 9468
			rjmp	avr0D6E		; 0C3F C12E
avr0C40:	cpi	r17, 0x10		; 0C40 3110
avr0C41:	brne	avr0C47		; 0C41 F429
			cbi	DDRC, 7	; 0C42 98A7
avr0C43:	nop				; 0C43 0000
			sbic	PINC, 7	; 0C44 999F
avr0C45:	set				; 0C45 9468
			rjmp	avr0D6E		; 0C46 C127
avr0C47:	cpi	r17, 0x11		; 0C47 3111
			brne	avr0C4E		; 0C48 F429
			cbi	DDRC, 6	; 0C49 98A6
			nop				; 0C4A 0000
			sbic	PINC, 6	; 0C4B 999E
			set				; 0C4C 9468
			rjmp	avr0D6E		; 0C4D C120
avr0C4E:	cpi	r17, 0x12		; 0C4E 3112
			brne	avr0C55		; 0C4F F429
avr0C50:	cbi	DDRC, 5	; 0C50 98A5
			nop				; 0C51 0000
			sbic	PINC, 5	; 0C52 999D
			set				; 0C53 9468
			rjmp	avr0D6E		; 0C54 C119
avr0C55:	cpi	r17, 0x13		; 0C55 3113
			brne	avr0C5C		; 0C56 F429
			cbi	DDRC, 4	; 0C57 98A4
avr0C58:	nop				; 0C58 0000
avr0C59:	sbic	PINC, 4	; 0C59 999C
			set				; 0C5A 9468
			rjmp	avr0D6E		; 0C5B C112
avr0C5C:	cpi	r17, 0x14		; 0C5C 3114
			brne	avr0C63		; 0C5D F429
avr0C5E:	cbi	DDRC, 3	; 0C5E 98A3
			nop				; 0C5F 0000
			sbic	PINC, 3	; 0C60 999B
			set				; 0C61 9468
			rjmp	avr0D6E		; 0C62 C10B
avr0C63:	cpi	r17, 0x15		; 0C63 3115
			brne	avr0C6A		; 0C64 F429
avr0C65:	cbi	DDRC, 2	; 0C65 98A2
			nop				; 0C66 0000
			sbic	PINC, 2	; 0C67 999A
			set				; 0C68 9468
			rjmp	avr0D6E		; 0C69 C104
avr0C6A:	cpi	r17, 0x16		; 0C6A 3116
			brne	avr0C71		; 0C6B F429
avr0C6C:	cbi	DDRC, 1	; 0C6C 98A1
			nop				; 0C6D 0000
			sbic	PINC, 1	; 0C6E 9999
			set				; 0C6F 9468
avr0C70:	rjmp	avr0D6E		; 0C70 C0FD
avr0C71:	cpi	r17, 0x17		; 0C71 3117
			brne	avr0C78		; 0C72 F429
			cbi	DDRC, 0	; 0C73 98A0
			nop				; 0C74 0000
avr0C75:	sbic	PINC, 0	; 0C75 9998
			set				; 0C76 9468
avr0C77:	rjmp	avr0D6E		; 0C77 C0F6
avr0C78:	cpi	r17, 0x18		; 0C78 3118
			brne	avr0C7F		; 0C79 F429
avr0C7A:	cbi	$02, 7	; 0C7A 9817
			nop				; 0C7B 0000
			sbic	$01, 7	; 0C7C 990F
avr0C7D:	set				; 0C7D 9468
avr0C7E:	rjmp	avr0D6E		; 0C7E C0EF
avr0C7F:	cpi	r17, 0x19		; 0C7F 3119
			brne	avr0C86		; 0C80 F429
			cbi	$02, 6	; 0C81 9816
avr0C82:	nop				; 0C82 0000
			sbic	$01, 6	; 0C83 990E
			set				; 0C84 9468
			rjmp	avr0D6E		; 0C85 C0E8
avr0C86:	cpi	r17, 0x1A		; 0C86 311A
			brne	avr0C8D		; 0C87 F429
			cbi	DDRD, 7	; 0C88 988F
			nop				; 0C89 0000
			sbic	PIND, 7	; 0C8A 9987
			set				; 0C8B 9468
			rjmp	avr0D6E		; 0C8C C0E1
avr0C8D:	cpi	r17, 0x1B		; 0C8D 311B
			brne	avr0C94		; 0C8E F429
			cbi	DDRD, 6	; 0C8F 988E
			nop				; 0C90 0000
			sbic	PIND, 6	; 0C91 9986
			set				; 0C92 9468
avr0C93:	rjmp	avr0D6E		; 0C93 C0DA
avr0C94:	cpi	r17, 0x1C		; 0C94 311C
avr0C95:	brne	avr0C9B		; 0C95 F429
			cbi	DDRD, 5	; 0C96 988D
			nop				; 0C97 0000
			sbic	PIND, 5	; 0C98 9985
			set				; 0C99 9468
			rjmp	avr0D6E		; 0C9A C0D3
avr0C9B:	cpi	r17, 0x1D		; 0C9B 311D
			brne	avr0CA7		; 0C9C F451
avr0C9D:	lds	r16, 0x0064		; 0C9D 9100 0064
avr0C9F:	andi	r16, 0xFB		; 0C9F 7F0B
avr0CA0:	sts	0x0064, r16		; 0CA0 9300 0064
			lds	r16, 0x0063		; 0CA2 9100 0063
			sbrc	r16, 2		; 0CA4 FD02
			set				; 0CA5 9468
avr0CA6:	rjmp	avr0D6E		; 0CA6 C0C7
avr0CA7:	cpi	r17, 0x1E		; 0CA7 311E
			brne	avr0CB3		; 0CA8 F451
			lds	r16, 0x0064		; 0CA9 9100 0064
			andi	r16, 0xFD		; 0CAB 7F0D
			sts	0x0064, r16		; 0CAC 9300 0064
			lds	r16, 0x0063		; 0CAE 9100 0063
			sbrc	r16, 1		; 0CB0 FD01
			set				; 0CB1 9468
			rjmp	avr0D6E		; 0CB2 C0BB
avr0CB3:	cpi	r17, 0x1F		; 0CB3 311F
avr0CB4:	brne	avr0CBF		; 0CB4 F451
			lds	r16, 0x0064		; 0CB5 9100 0064
avr0CB7:	andi	r16, 0xFE		; 0CB7 7F0E
			sts	0x0064, r16		; 0CB8 9300 0064
			lds	r16, 0x0063		; 0CBA 9100 0063
			sbrc	r16, 0		; 0CBC FD00
			set				; 0CBD 9468
			rjmp	avr0D6E		; 0CBE C0AF
avr0CBF:	cpi	r17, 0x20		; 0CBF 3210
			brne	avr0CCA		; 0CC0 F449
			lds	r16, 0x0061		; 0CC1 9100 0061
			andi	r16, 0xFE		; 0CC3 7F0E
			sts	0x0061, r16		; 0CC4 9300 0061
			in	r16, $00		; 0CC6 B100
			sbrc	r16, 0		; 0CC7 FD00
			set				; 0CC8 9468
			rjmp	avr0D6E		; 0CC9 C0A4
avr0CCA:	cpi	r17, 0x21		; 0CCA 3211
			brne	avr0CD5		; 0CCB F449
			lds	r16, 0x0061		; 0CCC 9100 0061
			andi	r16, 0xFD		; 0CCE 7F0D
			sts	0x0061, r16		; 0CCF 9300 0061
			in	r16, $00		; 0CD1 B100
avr0CD2:	sbrc	r16, 1		; 0CD2 FD01
			set				; 0CD3 9468
			rjmp	avr0D6E		; 0CD4 C099
avr0CD5:	cpi	r17, 0x22		; 0CD5 3212
			brne	avr0CE0		; 0CD6 F449
avr0CD7:	lds	r16, 0x0061		; 0CD7 9100 0061
avr0CD9:	andi	r16, 0xFB		; 0CD9 7F0B
			sts	0x0061, r16		; 0CDA 9300 0061
			in	r16, $00		; 0CDC B100
avr0CDD:	sbrc	r16, 2		; 0CDD FD02
			set				; 0CDE 9468
			rjmp	avr0D6E		; 0CDF C08E
avr0CE0:	cpi	r17, 0x23		; 0CE0 3213
			brne	avr0CEB		; 0CE1 F449
			lds	r16, 0x0061		; 0CE2 9100 0061
avr0CE4:	andi	r16, 0xF7		; 0CE4 7F07
			sts	0x0061, r16		; 0CE5 9300 0061
			in	r16, $00		; 0CE7 B100
			sbrc	r16, 3		; 0CE8 FD03
avr0CE9:	set				; 0CE9 9468
avr0CEA:	rjmp	avr0D6E		; 0CEA C083
avr0CEB:	cpi	r17, 0x24		; 0CEB 3214
			brne	avr0CF6		; 0CEC F449
			lds	r16, 0x0061		; 0CED 9100 0061
			andi	r16, 0xEF		; 0CEF 7E0F
			sts	0x0061, r16		; 0CF0 9300 0061
			in	r16, $00		; 0CF2 B100
			sbrc	r16, 4		; 0CF3 FD04
			set				; 0CF4 9468
			rjmp	avr0D6E		; 0CF5 C078
avr0CF6:	cpi	r17, 0x25		; 0CF6 3215
			brne	avr0D01		; 0CF7 F449
avr0CF8:	lds	r16, 0x0061		; 0CF8 9100 0061
			andi	r16, 0xDF		; 0CFA 7D0F
			sts	0x0061, r16		; 0CFB 9300 0061
			in	r16, $00		; 0CFD B100
			sbrc	r16, 5		; 0CFE FD05
			set				; 0CFF 9468
			rjmp	avr0D6E		; 0D00 C06D
avr0D01:	cpi	r17, 0x26		; 0D01 3216
			brne	avr0D0C		; 0D02 F449
			lds	r16, 0x0061		; 0D03 9100 0061
			andi	r16, 0xBF		; 0D05 7B0F
			sts	0x0061, r16		; 0D06 9300 0061
			in	r16, $00		; 0D08 B100
			sbrc	r16, 6		; 0D09 FD06
			set				; 0D0A 9468
			rjmp	avr0D6E		; 0D0B C062
avr0D0C:	cpi	r17, 0x27		; 0D0C 3217
			brne	avr0D17		; 0D0D F449
			lds	r16, 0x0061		; 0D0E 9100 0061
			andi	r16, 0x7F		; 0D10 770F
			sts	0x0061, r16		; 0D11 9300 0061
			in	r16, $00		; 0D13 B100
			sbrc	r16, 7		; 0D14 FD07
avr0D15:	set				; 0D15 9468
			rjmp	avr0D6E		; 0D16 C057
avr0D17:	cpi	r17, 0x28		; 0D17 3218
			brne	avr0D1E		; 0D18 F429
			cbi	DDRD, 2	; 0D19 988A
avr0D1A:	nop				; 0D1A 0000
			sbic	PIND, 2	; 0D1B 9982
			set				; 0D1C 9468
			rjmp	avr0D6E		; 0D1D C050
avr0D1E:	cpi	r17, 0x29		; 0D1E 3219
			brne	avr0D25		; 0D1F F429
			cbi	DDRD, 3	; 0D20 988B
			nop				; 0D21 0000
			sbic	PIND, 3	; 0D22 9983
			set				; 0D23 9468
			rjmp	avr0D6E		; 0D24 C049
avr0D25:	cpi	r17, 0x2A		; 0D25 321A
			brne	avr0D2C		; 0D26 F429
avr0D27:	cbi	DDRD, 4	; 0D27 988C
avr0D28:	nop				; 0D28 0000
			sbic	PIND, 4	; 0D29 9984
avr0D2A:	set				; 0D2A 9468
				rjmp	avr0D6E		; 0D2B C042
avr0D2C:	cpi	r17, 0x2B		; 0D2C 321B
			brne	avr0D33		; 0D2D F429
avr0D2E:	cbi	$02, 0	; 0D2E 9810
			nop				; 0D2F 0000
			sbic	$01, 0	; 0D30 9908
			set				; 0D31 9468
			rjmp	avr0D6E		; 0D32 C03B
avr0D33:	cpi	r17, 0x2C		; 0D33 321C
			brne	avr0D3A		; 0D34 F429
avr0D35:	cbi	$02, 1	; 0D35 9811
			nop				; 0D36 0000
avr0D37:	sbic	$01, 1	; 0D37 9909
			set				; 0D38 9468
avr0D39:	rjmp	avr0D6E		; 0D39 C034
avr0D3A:	cpi	r17, 0x2D		; 0D3A 321D
			brne	avr0D41		; 0D3B F429
			cbi	$02, 2	; 0D3C 9812
			nop				; 0D3D 0000
			sbic	$01, 2	; 0D3E 990A
			set				; 0D3F 9468
			rjmp	avr0D6E		; 0D40 C02D
avr0D41:	cpi	r17, 0x2E		; 0D41 321E
			brne	avr0D48		; 0D42 F429
avr0D43:	cbi	$02, 3	; 0D43 9813
avr0D44:	nop				; 0D44 0000
			sbic	$01, 3	; 0D45 990B
			set				; 0D46 9468
			rjmp	avr0D6E		; 0D47 C026
avr0D48:	cpi	r17, 0x2F		; 0D48 321F
			brne	avr0D4F		; 0D49 F429
			cbi	$02, 4	; 0D4A 9814
			nop				; 0D4B 0000
avr0D4C:	sbic	$01, 4	; 0D4C 990C
			set				; 0D4D 9468
			rjmp	avr0D6E		; 0D4E C01F
avr0D4F:	cpi	r17, 0x30		; 0D4F 3310
avr0D50:	brne	avr0D56		; 0D50 F429
			cbi	$02, 5	; 0D51 9815
avr0D52:	nop				; 0D52 0000
			sbic	$01, 5	; 0D53 990D
			set				; 0D54 9468
			rjmp	avr0D6E		; 0D55 C018
avr0D56:	cpi	r17, 0x31		; 0D56 3311
avr0D57:	brne	avr0D62		; 0D57 F451
			lds	r16, 0x0064		; 0D58 9100 0064
			andi	r16, 0xF7		; 0D5A 7F07
avr0D5B:	sts	0x0064, r16		; 0D5B 9300 0064
			lds	r16, 0x0063		; 0D5D 9100 0063
			sbrc	r16, 3		; 0D5F FD03
			set				; 0D60 9468
			rjmp	avr0D6E		; 0D61 C00C
avr0D62:	cpi	r17, 0x32		; 0D62 3312
			brne	avr0D6E		; 0D63 F451
avr0D64:	lds	r16, 0x0064		; 0D64 9100 0064
			andi	r16, 0xEF		; 0D66 7E0F
			sts	0x0064, r16		; 0D67 9300 0064
			lds	r16, 0x0063		; 0D69 9100 0063
avr0D6B:	sbrc	r16, 4		; 0D6B FD04
			set				; 0D6C 9468
			rjmp	avr0D6E		; 0D6D C000
avr0D6E:	ldi	r19, 0x00		; 0D6E E030
			brts	avr0D72		; 0D6F F016
			ldi	r18, 0x00		; 0D70 E020
			rjmp	avr0D73		; 0D71 C001
avr0D72:	ldi	r18, 0x01		; 0D72 E021
avr0D73:	lds	r16, 0x04D2		; 0D73 9100 04D2
			sbrc	r16, 5		; 0D75 FD05
avr0D76:	ret				; 0D76 9508

;-------------------------------------------------------------------------
; 

			call	sub14CD		; 0D77 940E 14CD
			adiw	XL, 0x01	; 0D79 9611
			jmp	avr0093			; 0D7A 940C 0093
;-------------------------------------------------------------------------
; here for IM command F1 INKEY



avr0D7C:	rcall	sub0B8B		; 0D7C DE0E
			mov	r16, r23		; 0D7D 2F07
			out	$07, r16		; 0D7E B907
			sbi	$06, 7			; 0D7F 9A37
			sbi	$06, 6			; 0D80 9A36
			nop					; 0D81 0000
			nop					; 0D82 0000
avr0D83:	sbic	$06, 6		; 0D83 9936
			rjmp	avr0D83		; 0D84 CFFE
			in	r18, $04		; 0D85 B124
			in	r19, $05		; 0D86 B135
			ror	r19				; 0D87 9537
			ror	r18				; 0D88 9527
			ror	r19				; 0D89 9537
			ror	r18				; 0D8A 9527
			push	r18			; 0D8B 932F
			rcall	sub0B8B		; 0D8C DDFE
			mov	r16, r23		; 0D8D 2F07
			cpi	r18, 0xC8		; 0D8E 3C28
avr0D8F:	brsh	avr0DB0		; 0D8F F500
			cpi	r18, 0x12		; 0D90 3122
			brlo	avr0DB2		; 0D91 F100
			cpi	r18, 0x25		; 0D92 3225
			brlo	avr0DB4		; 0D93 F100
			cpi	r18, 0x35		; 0D94 3325
			brlo	avr0DB6		; 0D95 F100
			cpi	r18, 0x43		; 0D96 3423
			brlo	avr0DB8		; 0D97 F100
			cpi	r18, 0x50		; 0D98 3520
			brlo	avr0DBA		; 0D99 F100
			cpi	r18, 0x5A		; 0D9A 352A
			brlo	avr0DBC		; 0D9B F100
			cpi	r18, 0x64		; 0D9C 3624
			brlo	avr0DBE		; 0D9D F100
			cpi	r18, 0x6E		; 0D9E 362E
			brlo	avr0DC0		; 0D9F F100
			cpi	r18, 0x75		; 0DA0 3725
			brlo	avr0DC2		; 0DA1 F100
			cpi	r18, 0x7C		; 0DA2 372C
			brlo	avr0DC4		; 0DA3 F100
			cpi	r18, 0x82		; 0DA4 3822
			brlo	avr0DC6		; 0DA5 F100
			cpi	r18, 0x88		; 0DA6 3828
			brlo	avr0DC8		; 0DA7 F100
			cpi	r18, 0x8D		; 0DA8 382D
			brlo	avr0DCA		; 0DA9 F100
			cpi	r18, 0x92		; 0DAA 3922
			brlo	avr0DCC		; 0DAB F100
			cpi	r18, 0x97		; 0DAC 3927
			brlo	avr0DCE		; 0DAD F100
			cpi	r18, 0x9A		; 0DAE 392A
			brlo	avr0DD0		; 0DAF F100
avr0DB0:	ldi	r18, 0x00		; 0DB0 E020
			rjmp	avr0DD2		; 0DB1 C020
avr0DB2:	ldi	r18, 0x01		; 0DB2 E021
			rjmp	avr0DD2		; 0DB3 C01E
avr0DB4:	ldi	r18, 0x02		; 0DB4 E022
			rjmp	avr0DD2		; 0DB5 C01C
avr0DB6:	ldi	r18, 0x03		; 0DB6 E023
			rjmp	avr0DD2		; 0DB7 C01A
avr0DB8:	ldi	r18, 0x04		; 0DB8 E024
			rjmp	avr0DD2		; 0DB9 C018
avr0DBA:	ldi	r18, 0x05		; 0DBA E025
			rjmp	avr0DD2		; 0DBB C016
avr0DBC:	ldi	r18, 0x06		; 0DBC E026
			rjmp	avr0DD2		; 0DBD C014
avr0DBE:	ldi	r18, 0x07		; 0DBE E027
			rjmp	avr0DD2		; 0DBF C012
avr0DC0:	ldi	r18, 0x08		; 0DC0 E028
			rjmp	avr0DD2		; 0DC1 C010
avr0DC2:	ldi	r18, 0x09		; 0DC2 E029
			rjmp	avr0DD2		; 0DC3 C00E
avr0DC4:	ldi	r18, 0x0A		; 0DC4 E02A
			rjmp	avr0DD2		; 0DC5 C00C
avr0DC6:	ldi	r18, 0x0B		; 0DC6 E02B
			rjmp	avr0DD2		; 0DC7 C00A
avr0DC8:	ldi	r18, 0x0C		; 0DC8 E02C
			rjmp	avr0DD2		; 0DC9 C008
avr0DCA:	ldi	r18, 0x0D		; 0DCA E02D
			rjmp	avr0DD2		; 0DCB C006
avr0DCC:	ldi	r18, 0x0E		; 0DCC E02E
			rjmp	avr0DD2		; 0DCD C004
avr0DCE:	ldi	r18, 0x0F		; 0DCE E02F
			rjmp	avr0DD2		; 0DCF C002
avr0DD0:	ldi	r18, 0x10		; 0DD0 E120
			rjmp	avr0DD2		; 0DD1 C000
avr0DD2:	clr	r19				; 0DD2 2733
			call	sub14CD		; 0DD3 940E 14CD
			adiw	XL, 0x01	; 0DD5 9611
			jmp	avr0093			; 0DD6 940C 0093

;---------------------------------------------------------------------
; Here for IM code F2 BYTEIN


avr0DD8:	rcall	sub0B8B		; 0DD8 DDB2
			mov	r16, r23		; 0DD9 2F07
;------------------------------------------------------------------------

; Get the port data for E1 command
; r16 = reg
; 0 = a, 1 = b, 2 = c, 3 =d and g, 4 = e
sub0DDA:	cpi	r16, 0x00		; 0DDA 3000
			breq	avr0DE5		; 0DDB F049
			cpi	r16, 0x01		; 0DDC 3001
			breq	avr0DE6		; 0DDD F041
avr0DDE:	cpi	r16, 0x02		; 0DDE 3002
			breq	avr0DE7		; 0DDF F039
			cpi	r16, 0x03		; 0DE0 3003
			breq	avr0DE8		; 0DE1 F031
avr0DE2:	cpi	r16, 0x04		; 0DE2 3004
			breq	avr0DE9		; 0DE3 F029
			rjmp	avr0E32		; 0DE4 C04D

avr0DE5:	rjmp	avr0DEA		; 0DE5 C004
avr0DE6:	rjmp	avr0DEF		; 0DE6 C008
avr0DE7:	rjmp	avr0DF4		; 0DE7 C00C
avr0DE8:	rjmp	avr0E04		; 0DE8 C01B
avr0DE9:	rjmp	avr0E2C		; 0DE9 C042


avr0DEA:	ldi	r16, 0x00		; 0DEA E000
			out	DDRA, r16		; 0DEB BB0A
			nop					; 0DEC 0000
			in	r16, PINA		; 0DED B309
			rjmp	avr0E32		; 0DEE C043

avr0DEF:	ldi	r16, 0x00		; 0DEF E000
			out	DDRB, r16		; 0DF0 BB07
			nop					; 0DF1 0000
			in	r16, PINB		; 0DF2 B306
			rjmp	avr0E32		; 0DF3 C03E

avr0DF4:	ldi	r16, 0x00		; 0DF4 E000
			out	DDRC, r16		; 0DF5 BB04
			nop					; 0DF6 0000
			in	r16, PINC		; 0DF7 B303
			ldi	r18, 0x00		; 0DF8 E020
			ldi	r19, 0x08		; 0DF9 E038
avr0DFA:	lsl	r16				; 0DFA 0F00
			brsh	avr0DFE		; 0DFB F410
			sec					; 0DFC 9408
			rjmp	avr0DFF		; 0DFD C001
avr0DFE:	clc					; 0DFE 9488
avr0DFF:	ror	r18				; 0DFF 9527
			dec	r19				; 0E00 953A
			brne	avr0DFA		; 0E01 F7C1
			mov	r16, r18		; 0E02 2F02
			rjmp	avr0E32		; 0E03 C02E

avr0E04:	cbi	$02, 7			; 0E04 9817
			cbi	$02, 6			; 0E05 9816
			cbi	DDRD, 7			; 0E06 988F
			cbi	DDRD, 6			; 0E07 988E
			cbi	DDRD, 5			; 0E08 988D
			lds	r16, 0x0064		; 0E09 9100 0064
			andi	r16, 0xFB	; 0E0B 7F0B
			sts	0x0064, r16		; 0E0C 9300 0064
			lds	r16, 0x0064		; 0E0E 9100 0064
			andi	r16, 0xFD	; 0E10 7F0D
			sts	0x0064, r16		; 0E11 9300 0064
			lds	r16, 0x0064		; 0E13 9100 0064
			andi	r16, 0xFE	; 0E15 7F0E
			sts	0x0064, r16		; 0E16 9300 0064
			ldi	r16, 0x00		; 0E18 E000
			sbic	$01, 7		; 0E19 990F
			ori	r16, 0x01		; 0E1A 6001
			sbic	$01, 6		; 0E1B 990E
			ori	r16, 0x02		; 0E1C 6002
			sbic	PIND, 7		; 0E1D 9987
			ori	r16, 0x04		; 0E1E 6004
			sbic	PIND, 6		; 0E1F 9986
			ori	r16, 0x08		; 0E20 6008
			sbic	PIND, 5		; 0E21 9985
			ori	r16, 0x10		; 0E22 6100
			lds	r17, 0x0063		; 0E23 9110 0063
			sbrc	r17, 2		; 0E25 FD12
			ori	r16, 0x20		; 0E26 6200
			sbrc	r17, 1		; 0E27 FD11
			ori	r16, 0x40		; 0E28 6400
			sbrc	r17, 0		; 0E29 FD10
			ori	r16, 0x80		; 0E2A 6800
			rjmp	avr0E32		; 0E2B C006

avr0E2C:	ldi	r16, 0x00		; 0E2C E000
			sts	0x0061, r16		; 0E2D 9300 0061
			nop					; 0E2F 0000
			in	r16, $00		; 0E30 B100
			rjmp	avr0E32		; 0E31 C000

avr0E32:	mov	r18, r16		; 0E32 2F20
			lds	r17, 0x04D2		; 0E33 9110 04D2 is bit 5 set in 4D2  then return
			sbrc	r17, 5		; 0E35 FD15
			ret					; 0E36 9508


			ldi	r19, 0x00		; 0E37 E030 save the result to variable
avr0E38:	mov	r18, r16		; 0E38 2F20
avr0E39:	call	sub14CD		; 0E39 940E 14CD
avr0E3B:	adiw	XL, 0x01		; 0E3B 9611
			jmp	avr0093		; 0E3C 940C 0093
;-------------------------------------------------------------------------------
; Here for IM code F3 AD also for RCIN (n+100)



avr0E3E:	rcall	sub0B8B		; 0E3E DD4C get value for
			mov	r16, r23		; 0E3F 2F07
			mov	r17, r16		; 0E40 2F10
			subi	r17, 0x64	; 0E41 5614
			brlo	avr0E45		; 0E42 F010
			jmp	avr244E			; 0E43 940C 244E for RCIN
avr0E45:	rcall	sub0E64		; 0E45 D01E for AD
			out	$07, r16		; 0E46 B907
			sbi	$06, 7			; 0E47 9A37
			sbi	$06, 6			; 0E48 9A36
			nop					; 0E49 0000
			nop					; 0E4A 0000
avr0E4B:	sbic	$06, 6		; 0E4B 9936
			rjmp	avr0E4B		; 0E4C CFFE
			in	r18, $04		; 0E4D B124
			in	r19, $05		; 0E4E B135
			lds	r16, 0x04E1		; 0E4F 9100 04E1
			cpi	r16, 0x16		; 0E51 3106
			breq	avr0E5F		; 0E52 F061
			lds	r16, 0x04E1		; 0E53 9100 04E1
			cpi	r16, 0x15		; 0E55 3105
			breq	avr0E5A		; 0E56 F019
			clr	r18				; 0E57 2722
			clr	r19				; 0E58 2733
			rjmp	avr0E5F		; 0E59 C005
avr0E5A:	ror	r19				; 0E5A 9537
			ror	r18				; 0E5B 9527
			ror	r19				; 0E5C 9537
			ror	r18				; 0E5D 9527
			clr	r19				; 0E5E 2733
avr0E5F:	call	sub14CD		; 0E5F 940E 14CD save the result
			adiw	XL, 0x01	; 0E61 9611
			jmp	avr0093			; 0E62 940C 0093



sub0E64:	lds	r17, 0x0061		; 0E64 9110 0061
			cpi	r16, 0x00		; 0E66 3000
			breq	avr0E76		; 0E67 F071
			cpi	r16, 0x01		; 0E68 3001
			breq	avr0E78		; 0E69 F071
			cpi	r16, 0x02		; 0E6A 3002
			breq	avr0E7A		; 0E6B F071
			cpi	r16, 0x03		; 0E6C 3003
			breq	avr0E7C		; 0E6D F071
			cpi	r16, 0x04		; 0E6E 3004
			breq	avr0E7E		; 0E6F F071
			cpi	r16, 0x05		; 0E70 3005
			breq	avr0E80		; 0E71 F071
			cpi	r16, 0x06		; 0E72 3006
			breq	avr0E82		; 0E73 F071
			cpi	r16, 0x07		; 0E74 3007
			breq	avr0E84		; 0E75 F071
avr0E76:	andi	r17, 0xFE	; 0E76 7F1E
			rjmp	avr0E86		; 0E77 C00E
avr0E78:	andi	r17, 0xFD	; 0E78 7F1D
			rjmp	avr0E86		; 0E79 C00C
avr0E7A:	andi	r17, 0xFB	; 0E7A 7F1B
			rjmp	avr0E86		; 0E7B C00A
avr0E7C:	andi	r17, 0xF7	; 0E7C 7F17
			rjmp	avr0E86		; 0E7D C008
avr0E7E:	andi	r17, 0xEF	; 0E7E 7E1F
			rjmp	avr0E86		; 0E7F C006
avr0E80:	andi	r17, 0xDF	; 0E80 7D1F
			rjmp	avr0E86		; 0E81 C004
avr0E82:	andi	r17, 0xBF	; 0E82 7B1F
			rjmp	avr0E86		; 0E83 C002
avr0E84:	andi	r17, 0x7F	; 0E84 771F
			rjmp	avr0E86		; 0E85 C000
avr0E86:	sts	0x0061, r17		; 0E86 9310 0061
			ret					; 0E88 9508
;-------------------------------------------------------------------------
;

sub0E89:	lds	r17, 0x0061		; 0E89 9110 0061
			cpi	r16, 0x00		; 0E8B 3000
			breq	avr0E9B		; 0E8C F071
			cpi	r16, 0x01		; 0E8D 3001
			breq	avr0E9D		; 0E8E F071
			cpi	r16, 0x02		; 0E8F 3002
			breq	avr0E9F		; 0E90 F071
			cpi	r16, 0x03		; 0E91 3003
			breq	avr0EA1		; 0E92 F071
			cpi	r16, 0x04		; 0E93 3004
			breq	avr0EA3		; 0E94 F071
			cpi	r16, 0x05		; 0E95 3005
			breq	avr0EA5		; 0E96 F071
			cpi	r16, 0x06		; 0E97 3006
			breq	avr0EA7		; 0E98 F071
			cpi	r16, 0x07		; 0E99 3007
			breq	avr0EA9		; 0E9A F071
avr0E9B:	andi	r17, 0xFE		; 0E9B 7F1E
			rjmp	avr0EAB		; 0E9C C00E
avr0E9D:	andi	r17, 0xFD		; 0E9D 7F1D
			rjmp	avr0EAB		; 0E9E C00C
avr0E9F:	andi	r17, 0xFB		; 0E9F 7F1B
			rjmp	avr0EAB		; 0EA0 C00A
avr0EA1:	andi	r17, 0xF7		; 0EA1 7F17
			rjmp	avr0EAB		; 0EA2 C008
avr0EA3:	andi	r17, 0xEF		; 0EA3 7E1F
			rjmp	avr0EAB		; 0EA4 C006
avr0EA5:	andi	r17, 0xDF		; 0EA5 7D1F
			rjmp	avr0EAB		; 0EA6 C004
avr0EA7:	andi	r17, 0xBF		; 0EA7 7B1F
			rjmp	avr0EAB		; 0EA8 C002
avr0EA9:	andi	r17, 0x7F		; 0EA9 771F
			rjmp	avr0EAB		; 0EAA C000
avr0EAB:	sts	0x0061, r17		; 0EAB 9310 0061
			out	$07, r16		; 0EAD B907
			sbi	$06, 7	; 0EAE 9A37
			sbi	$06, 6	; 0EAF 9A36
			nop				; 0EB0 0000
			nop				; 0EB1 0000
avr0EB2:	sbic	$06, 6	; 0EB2 9936
			rjmp	avr0EB2		; 0EB3 CFFE
			in	r18, $04		; 0EB4 B124
			in	r19, $05		; 0EB5 B135
			ror	r19			; 0EB6 9537
			ror	r18			; 0EB7 9527
			ror	r19			; 0EB8 9537
			ror	r18			; 0EB9 9527
			clr	r19			; 0EBA 2733
			lds	r16, 0x04D2		; 0EBB 9100 04D2
			sbrc	r16, 5		; 0EBD FD05
			ret				; 0EBE 9508

;-----------------------------------------------------------------------
; Here for IM code F4 unused
avr0EBF:	jmp	avr0093		; 0EBF 940C 0093

;-------------------------------------------------------------------------
; Here for IM code F5 unused
avr0EC1:	jmp	avr0093		; 0EC1 940C 0093

;------------------------------------------------------------------------
; here for IM code F6 STATE

avr0EC3:	rcall	sub0B8B		; 0EC3 DCC7
			mov	r16, r23		; 0EC4 2F07
avr0EC5:	cpi	r16, 0x00		; 0EC5 3000
			breq	avr0ED0		; 0EC6 F049
			cpi	r16, 0x01		; 0EC7 3001
			breq	sub0ED2		; 0EC8 F049
			cpi	r16, 0x02		; 0EC9 3002
			breq	avr0ED4		; 0ECA F049
			cpi	r16, 0x03		; 0ECB 3003
			breq	avr0EE1		; 0ECC F0A1
			cpi	r16, 0x04		; 0ECD 3004
			breq	avr0EF7		; 0ECE F141
			rjmp	avr0EFA		; 0ECF C02A
avr0ED0:	in	r16, PORTA		; 0ED0 B30B
			rjmp	avr0EFA		; 0ED1 C028
sub0ED2:	in	r16, PORTB		; 0ED2 B308
			rjmp	avr0EFA		; 0ED3 C026
avr0ED4:	in	r16, PORTC		; 0ED4 B305
			ldi	r18, 0x00		; 0ED5 E020
			ldi	r19, 0x08		; 0ED6 E038
avr0ED7:	lsl	r16			; 0ED7 0F00
			brsh	avr0EDB		; 0ED8 F410
			sec				; 0ED9 9408
			rjmp	avr0EDC		; 0EDA C001
avr0EDB:	clc				; 0EDB 9488
avr0EDC:	ror	r18			; 0EDC 9527
			dec	r19			; 0EDD 953A
			brne	avr0ED7		; 0EDE F7C1
			mov	r16, r18		; 0EDF 2F02
			rjmp	avr0EFA		; 0EE0 C019
avr0EE1:	ldi	r16, 0x00		; 0EE1 E000
			in	r17, $03		; 0EE2 B113
			sbrc	r17, 7		; 0EE3 FD17
avr0EE4:	ori	r16, 0x01		; 0EE4 6001
			sbrc	r17, 6		; 0EE5 FD16
			ori	r16, 0x02		; 0EE6 6002
			in	r17, PORTD		; 0EE7 B312
			sbrc	r17, 7		; 0EE8 FD17
			ori	r16, 0x04		; 0EE9 6004 
			sbrc	r17, 6		; 0EEA FD16
			ori	r16, 0x08		; 0EEB 6008
			sbrc	r17, 5		; 0EEC FD15
			ori	r16, 0x10		; 0EED 6100
			lds	r17, 0x0065		; 0EEE 9110 0065
			sbrc	r17, 2		; 0EF0 FD12
			ori	r16, 0x20		; 0EF1 6200
			sbrc	r17, 1		; 0EF2 FD11
			ori	r16, 0x40		; 0EF3 6400
			sbrc	r17, 0		; 0EF4 FD10
			ori	r16, 0x80		; 0EF5 6800
			rjmp	avr0EFA		; 0EF6 C003
avr0EF7:	lds	r16, 0x0062		; 0EF7 9100 0062
			rjmp	avr0EFA		; 0EF9 C000
avr0EFA:	ldi	r19, 0x00		; 0EFA E030
			mov	r18, r16		; 0EFB 2F20
			call	sub14CD		; 0EFC 940E 14CD
			adiw	XL, 0x01		; 0EFE 9611
			jmp	avr0093			; 0EFF 940C 0093
;------------------------------------------------------------
; Here for IM code F7 unused
avr0F01:			jmp	avr0093	; 0F01 940C 0093

;------------------------------------------------------------
; Here for IM code F8 RND eeek ! not very random !
avr0F03:	lds	r18, 0x0088		; 0F03 9120 0088
			ldi	r19, 0x00		; 0F05 E030
			call	sub14CD		; 0F06 940E 14CD
			adiw	XL, 0x01	; 0F08 9611
			jmp	avr0093			; 0F09 940C 0093
;-------------------------------------------------------------
; Here for IM code F9 PEEK

avr0F0B:	call	sub0B8B		; 0F0B 940E 0B8B get value for address
			mov	YL, r23			; 0F0D 2FC7
			mov	YH, r24			; 0F0E 2FD8
			ld	r18, Y+			; 0F0F 9129 get content
			ld	r19, Y			; 0F10 8138
			call	sub14CD		; 0F11 940E 14CD return content
			adiw	XL, 0x01	; 0F13 9611
			jmp	avr0093			; 0F14 940C 0093

;-----------------------------------------------------------------
; Here for IM code FA ROMPEEK
avr0F16:	call	sub0B8B		; 0F16 940E 0B8B get value for address
			push	XL			; 0F18 93AF
			push	XH			; 0F19 93BF
			mov	XL, r23			; 0F1A 2FA7
			mov	XH, r24			; 0F1B 2FB8
			call	sub07D6		; 0F1C 940E 07D6 get date from external EEPROM
			mov	r18, r16		; 0F1E 2F20
			call	sub07D6		; 0F1F 940E 07D6 get data from external EEPROM
			mov	r19, r16		; 0F21 2F30
			pop	XH				; 0F22 91BF
			pop	XL				; 0F23 91AF
			adiw	XL, 0x01	; 0F24 9611
			call	sub14CD		; 0F25 940E 14CD Store result
			jmp	avr0093			; 0F27 940C 0093

;-------------------------------------------------------------------
; Here for IM code FB REMOCON

avr0F29:	rcall	sub0B8B		; 0F29 DC61 get value
			mov	r16, r23		; 0F2A 2F07
			cpi	r16, 0x00		; 0F2B 3000
			brne	avr0F30		; 0F2C F419
			call	sub069E		; 0F2D 940E 069E
			rjmp	avr0F35		; 0F2F C005
avr0F30:	cpi	r16, 0x01		; 0F30 3001
			brne	avr0F35		; 0F31 F419
			call	sub0719		; 0F32 940E 0719
			rjmp	avr0F35		; 0F34 C000
avr0F35:	mov	r18, r16		; 0F35 2F20
			clr	r19				; 0F36 2733
			call	sub14CD		; 0F37 940E 14CD Store result
			adiw	XL, 0x01	; 0F39 9611
			jmp	avr0093			; 0F3A 940C 0093

;---------------------------------------------------------------------
; Her for IM code FC AIMOTORIN

avr0F3C:	mov	r17, r16		; 0F3C 2F10
			call	sub40A8		; 0F3D 940E 40A8
			subi	r16, 0x1C	; 0F3F 510C
			mov	r18, r16		; 0F40 2F20
			clr	r19				; 0F41 2733
			call	sub14CD		; 0F42 940E 14CD Store result
			adiw	XL, 0x01	; 0F44 9611
			jmp	avr0093			; 0F45 940C 0093

;----------------------------------------------------------------------
; Here for IM code FD SONAR

avr0F47:	rcall	sub0B8B		; 0F47 DC43
			mov	r16, r23		; 0F48 2F07
			cli					; 0F49 94F8
			cpi	r16, 0x00		; 0F4A 3000
			breq	avr0F63		; 0F4B F0B9
			cpi	r16, 0x01		; 0F4C 3001
			breq	avr0F64		; 0F4D F0B1
			cpi	r16, 0x02		; 0F4E 3002
			breq	avr0F65		; 0F4F F0A9
			cpi	r16, 0x03		; 0F50 3003
			breq	avr0F66		; 0F51 F0A1
			cpi	r16, 0x04		; 0F52 3004
			breq	avr0F67		; 0F53 F099
			cpi	r16, 0x05		; 0F54 3005
			breq	avr0F68		; 0F55 F091
			cpi	r16, 0x06		; 0F56 3006
			breq	avr0F69		; 0F57 F089
			cpi	r16, 0x07		; 0F58 3007
			breq	avr0F6A		; 0F59 F081
			cpi	r16, 0x08		; 0F5A 3008
			breq	avr0F6B		; 0F5B F079
			cpi	r16, 0x09		; 0F5C 3009
			breq	avr0F6C		; 0F5D F071
			cpi	r16, 0x0A		; 0F5E 300A
			breq	avr0F6D		; 0F5F F069
			cpi	r16, 0x0B		; 0F60 300B
			breq	avr0F6E		; 0F61 F061
			rjmp	avr10FE		; 0F62 C19B
avr0F63:	rjmp	avr0F6F		; 0F63 C00B
avr0F64:	rjmp	avr0F90		; 0F64 C02B
avr0F65:	rjmp	avr0FB1		; 0F65 C04B
avr0F66:	rjmp	avr0FD2		; 0F66 C06B
avr0F67:	rjmp	avr0FF3		; 0F67 C08B
avr0F68:	rjmp	avr1014		; 0F68 C0AB
avr0F69:	rjmp	avr1035		; 0F69 C0CB
avr0F6A:	rjmp	avr1056		; 0F6A C0EB
avr0F6B:	rjmp	avr1077		; 0F6B C10B
avr0F6C:	rjmp	avr1098		; 0F6C C12B
avr0F6D:	rjmp	avr10B9		; 0F6D C14B
avr0F6E:	rjmp	avr10DA		; 0F6E C16B

avr0F6F:	sbi	DDRA, 0	; 0F6F 9AD0
			cbi	DDRA, 1	; 0F70 98D1
avr0F71:	sbi	PORTA, 0	; 0F71 9AD8
		ldi	r16, 0x1B		; 0F72 E10B
avr0F73:	dec	r16			; 0F73 950A
		brne	avr0F73		; 0F74 F7F1
		cbi	PORTA, 0	; 0F75 98D8
		ldi	r16, 0xFA		; 0F76 EC08
avr0F77:	wdr				; 0F77 95A8
		sbic	PINA, 1	; 0F78 99C9
avr0F79:	rjmp	avr0F81		; 0F79 C007
		nop				; 0F7A 0000
		nop				; 0F7B 0000
avr0F7C:	nop				; 0F7C 0000
avr0F7D:	nop				; 0F7D 0000
;---------
; new 2.7 code
		nop
		nop
		nop
;------------
		dec	r16			; 0F7E 950A
		brne	avr0F77		; 0F7F F7B9
avr0F80:	rjmp	avr10FE		; 0F80 C17D
avr0F81:	cli				; 0F81 94F8
		ldi	YH, 0x00		; 0F82 E0D0
		ldi	YL, 0x00		; 0F83 E0C0
avr0F84:	wdr				; 0F84 95A8
		ldi	r16, 0x0C		; 0F85 E00C
avr0F86:	dec	r16			; 0F86 950A
		brne	avr0F86		; 0F87 F7F1
avr0F88:	sbis	PINA, 1	; 0F88 9BC9
avr0F89:	rjmp	avr10FB		; 0F89 C171
		adiw	YL, 0x01		; 0F8A 9621
		cpi	YH, 0x32		; 0F8B 33D2
		brne	avr0F84		; 0F8C F7B9
		tst	YL			; 0F8D 23CC
avr0F8E:	brne	avr0F84		; 0F8E F7A9
		rjmp	avr10FE		; 0F8F C16E
avr0F90:	sbi	DDRA, 2	; 0F90 9AD2
		cbi	DDRA, 3	; 0F91 98D3
		sbi	PORTA, 2	; 0F92 9ADA
		ldi	r16, 0x1B		; 0F93 E10B
avr0F94:	dec	r16			; 0F94 950A
avr0F95:	brne	avr0F94		; 0F95 F7F1
		cbi	PORTA, 2	; 0F96 98DA
avr0F97:	ldi	r16, 0xFA		; 0F97 EC08
avr0F98:	wdr				; 0F98 95A8
		sbic	PINA, 3	; 0F99 99CB
		rjmp	avr0FA2		; 0F9A C007
avr0F9B:	nop				; 0F9B 0000
		nop				; 0F9C 0000
		nop				; 0F9D 0000
		nop				; 0F9E 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 0F9F 950A
		brne	avr0F98		; 0FA0 F7B9
		rjmp	avr10FE		; 0FA1 C15C
avr0FA2:	cli				; 0FA2 94F8
		ldi	YH, 0x00		; 0FA3 E0D0
avr0FA4:	ldi	YL, 0x00		; 0FA4 E0C0
avr0FA5:	wdr				; 0FA5 95A8
avr0FA6:	ldi	r16, 0x0C		; 0FA6 E00C
avr0FA7:	dec	r16			; 0FA7 950A
avr0FA8:	brne	avr0FA7		; 0FA8 F7F1
		sbis	PINA, 3	; 0FA9 9BCB
		rjmp	avr10FB		; 0FAA C150
		adiw	YL, 0x01		; 0FAB 9621
		cpi	YH, 0x32		; 0FAC 33D2
		brne	avr0FA5		; 0FAD F7B9
avr0FAE:	tst	YL			; 0FAE 23CC
		brne	avr0FA5		; 0FAF F7A9
avr0FB0:	rjmp	avr10FE		; 0FB0 C14D
avr0FB1:	sbi	DDRA, 4	; 0FB1 9AD4
		cbi	DDRA, 5	; 0FB2 98D5
		sbi	PORTA, 4	; 0FB3 9ADC
avr0FB4:	ldi	r16, 0x1B		; 0FB4 E10B
avr0FB5:	dec	r16			; 0FB5 950A
avr0FB6:	brne	avr0FB5		; 0FB6 F7F1
		cbi	PORTA, 4	; 0FB7 98DC
		ldi	r16, 0xFA		; 0FB8 EC08
avr0FB9:	wdr				; 0FB9 95A8
		sbic	PINA, 5	; 0FBA 99CD
		rjmp	avr0FC3		; 0FBB C007
		nop				; 0FBC 0000
		nop				; 0FBD 0000
		nop				; 0FBE 0000
		nop				; 0FBF 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 0FC0 950A
		brne	avr0FB9		; 0FC1 F7B9
		rjmp	avr10FE		; 0FC2 C13B
avr0FC3:	cli				; 0FC3 94F8
		ldi	YH, 0x00		; 0FC4 E0D0
		ldi	YL, 0x00		; 0FC5 E0C0
avr0FC6:	wdr				; 0FC6 95A8
		ldi	r16, 0x0C		; 0FC7 E00C
avr0FC8:	dec	r16			; 0FC8 950A
		brne	avr0FC8		; 0FC9 F7F1
		sbis	PINA, 5	; 0FCA 9BCD
avr0FCB:	rjmp	avr10FB		; 0FCB C12F
		adiw	YL, 0x01		; 0FCC 9621
avr0FCD:	cpi	YH, 0x32		; 0FCD 33D2
		brne	avr0FC6		; 0FCE F7B9
		tst	YL			; 0FCF 23CC
		brne	avr0FC6		; 0FD0 F7A9
		rjmp	avr10FE		; 0FD1 C12C
avr0FD2:	sbi	DDRA, 6	; 0FD2 9AD6
		cbi	DDRA, 7	; 0FD3 98D7
avr0FD4:	sbi	PORTA, 6	; 0FD4 9ADE
		ldi	r16, 0x1B		; 0FD5 E10B
avr0FD6:	dec	r16			; 0FD6 950A
		brne	avr0FD6		; 0FD7 F7F1
avr0FD8:	cbi	PORTA, 6	; 0FD8 98DE
avr0FD9:	ldi	r16, 0xFA		; 0FD9 EC08
avr0FDA:	wdr				; 0FDA 95A8
		sbic	PINA, 7	; 0FDB 99CF
		rjmp	avr0FE4		; 0FDC C007
		nop				; 0FDD 0000


avr0FDE:	nop				; 0FDE 0000 
		nop				; 0FDF 0000
		nop				; 0FE0 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 0FE1 950A
		brne	avr0FDA		; 0FE2 F7B9
avr0FE3:	rjmp	avr10FE		; 0FE3 C11A
avr0FE4:	cli				; 0FE4 94F8
		ldi	YH, 0x00		; 0FE5 E0D0
avr0FE6:	ldi	YL, 0x00		; 0FE6 E0C0
avr0FE7:	wdr				; 0FE7 95A8
		ldi	r16, 0x0C		; 0FE8 E00C
avr0FE9:	dec	r16			; 0FE9 950A
		brne	avr0FE9		; 0FEA F7F1
avr0FEB:	sbis	PINA, 7	; 0FEB 9BCF
		rjmp	avr10FB		; 0FEC C10E
		adiw	YL, 0x01		; 0FED 9621
		cpi	YH, 0x32		; 0FEE 33D2
avr0FEF:	brne	avr0FE7		; 0FEF F7B9
		tst	YL			; 0FF0 23CC
avr0FF1:	brne	avr0FE7		; 0FF1 F7A9
		rjmp	avr10FE		; 0FF2 C10B
avr0FF3:	sbi	DDRB, 0	; 0FF3 9AB8
		cbi	DDRB, 1	; 0FF4 98B9
		sbi	PORTB, 0	; 0FF5 9AC0
avr0FF6:	ldi	r16, 0x1B		; 0FF6 E10B
avr0FF7:	dec	r16			; 0FF7 950A
avr0FF8:	brne	avr0FF7		; 0FF8 F7F1
		cbi	PORTB, 0	; 0FF9 98C0
		ldi	r16, 0xFA		; 0FFA EC08
avr0FFB:	wdr				; 0FFB 95A8
		sbic	PINB, 1	; 0FFC 99B1
		rjmp	avr1005		; 0FFD C007
		nop				; 0FFE 0000
		nop				; 0FFF 0000
avr1000:	nop				; 1000 0000
avr1001:	nop				; 1001 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 1002 950A
avr1003:	brne	avr0FFB		; 1003 F7B9
		rjmp	avr10FE		; 1004 C0F9
avr1005:	cli				; 1005 94F8
		ldi	YH, 0x00		; 1006 E0D0
		ldi	YL, 0x00		; 1007 E0C0
avr1008:	wdr				; 1008 95A8
		ldi	r16, 0x0C		; 1009 E00C
avr100A:	dec	r16			; 100A 950A
		brne	avr100A		; 100B F7F1
		sbis	PINB, 1	; 100C 9BB1
		rjmp	avr10FB		; 100D C0ED
avr100E:	adiw	YL, 0x01		; 100E 9621
		cpi	YH, 0x32		; 100F 33D2
		brne	avr1008		; 1010 F7B9
sub1011:	tst	YL			; 1011 23CC
		brne	avr1008		; 1012 F7A9
		rjmp	avr10FE		; 1013 C0EA
avr1014:	sbi	DDRB, 2	; 1014 9ABA
avr1015:	cbi	DDRB, 3	; 1015 98BB
		sbi	PORTB, 2	; 1016 9AC2
avr1017:	ldi	r16, 0x1B		; 1017 E10B
avr1018:	dec	r16			; 1018 950A
		brne	avr1018		; 1019 F7F1
avr101A:	cbi	PORTB, 2	; 101A 98C2
sub101B:	ldi	r16, 0xFA		; 101B EC08
avr101C:	wdr				; 101C 95A8
		sbic	PINB, 3	; 101D 99B3
		rjmp	avr1026		; 101E C007
		nop				; 101F 0000
avr1020:	nop				; 1020 0000
avr1021:	nop				; 1021 0000
		nop				; 1022 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 1023 950A
avr1024:	brne	avr101C		; 1024 F7B9
avr1025:	rjmp	avr10FE		; 1025 C0D8
avr1026:	cli				; 1026 94F8
		ldi	YH, 0x00		; 1027 E0D0
avr1028:	ldi	YL, 0x00		; 1028 E0C0
avr1029:	wdr				; 1029 95A8
		ldi	r16, 0x0C		; 102A E00C
avr102B:	dec	r16			; 102B 950A
		brne	avr102B		; 102C F7F1
		sbis	PINB, 3	; 102D 9BB3
avr102E:	rjmp	avr10FB		; 102E C0CC
		adiw	YL, 0x01		; 102F 9621
		cpi	YH, 0x32		; 1030 33D2
		brne	avr1029		; 1031 F7B9
		tst	YL			; 1032 23CC
avr1033:	brne	avr1029		; 1033 F7A9
		rjmp	avr10FE		; 1034 C0C9
avr1035:	sbi	DDRB, 4	; 1035 9ABC
		cbi	DDRB, 5	; 1036 98BD
avr1037:	sbi	PORTB, 4	; 1037 9AC4
		ldi	r16, 0x1B		; 1038 E10B
avr1039:	dec	r16			; 1039 950A
		brne	avr1039		; 103A F7F1
		cbi	PORTB, 4	; 103B 98C4
		ldi	r16, 0xFA		; 103C EC08
avr103D:	wdr				; 103D 95A8
		sbic	PINB, 5	; 103E 99B5
		rjmp	avr1047		; 103F C007
avr1040:	nop				; 1040 0000
		nop				; 1041 0000
		nop				; 1042 0000
		nop				; 1043 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 1044 950A
		brne	avr103D		; 1045 F7B9
		rjmp	avr10FE		; 1046 C0B7
avr1047:	cli				; 1047 94F8
avr1048:	ldi	YH, 0x00		; 1048 E0D0
		ldi	YL, 0x00		; 1049 E0C0
avr104A:	wdr				; 104A 95A8
		ldi	r16, 0x0C		; 104B E00C
avr104C:	dec	r16			; 104C 950A
		brne	avr104C		; 104D F7F1
avr104E:	sbis	PINB, 5	; 104E 9BB5
		rjmp	avr10FB		; 104F C0AB
		adiw	YL, 0x01		; 1050 9621
		cpi	YH, 0x32		; 1051 33D2
avr1052:	brne	avr104A		; 1052 F7B9
		tst	YL			; 1053 23CC
		brne	avr104A		; 1054 F7A9
avr1055:	rjmp	avr10FE		; 1055 C0A8
avr1056:	sbi	DDRB, 6	; 1056 9ABE
		cbi	DDRB, 7	; 1057 98BF
		sbi	PORTB, 6	; 1058 9AC6
		ldi	r16, 0x1B		; 1059 E10B
avr105A:	dec	r16			; 105A 950A
		brne	avr105A		; 105B F7F1
		cbi	PORTB, 6	; 105C 98C6
avr105D:	ldi	r16, 0xFA		; 105D EC08
avr105E:	wdr				; 105E 95A8
		sbic	PINB, 7	; 105F 99B7
		rjmp	avr1068		; 1060 C007
		nop				; 1061 0000
avr1062:	nop				; 1062 0000
		nop				; 1063 0000
		nop				; 1064 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
avr1065:	dec	r16			; 1065 950A
avr1066:	brne	avr105E		; 1066 F7B9
		rjmp	avr10FE		; 1067 C096
avr1068:	cli				; 1068 94F8
		ldi	YH, 0x00		; 1069 E0D0
		ldi	YL, 0x00		; 106A E0C0
avr106B:	wdr				; 106B 95A8
		ldi	r16, 0x0C		; 106C E00C
avr106D:	dec	r16			; 106D 950A
		brne	avr106D		; 106E F7F1
		sbis	PINB, 7	; 106F 9BB7
avr1070:	rjmp	avr10FB		; 1070 C08A
		adiw	YL, 0x01		; 1071 9621
		cpi	YH, 0x32		; 1072 33D2
		brne	avr106B		; 1073 F7B9
		tst	YL			; 1074 23CC
		brne	avr106B		; 1075 F7A9
		rjmp	avr10FE		; 1076 C087
avr1077:	sbi	DDRC, 0	; 1077 9AA0
		cbi	DDRC, 1	; 1078 98A1
		sbi	PORTC, 0	; 1079 9AA8
		ldi	r16, 0x1B		; 107A E10B
avr107B:	dec	r16			; 107B 950A
		brne	avr107B		; 107C F7F1
avr107D:	cbi	PORTC, 0	; 107D 98A8
avr107E:	ldi	r16, 0xFA		; 107E EC08
avr107F:	wdr				; 107F 95A8
		sbic	PINC, 1	; 1080 9999
		rjmp	avr1089		; 1081 C007
		nop				; 1082 0000
avr1083:	nop				; 1083 0000
avr1084:	nop				; 1084 0000
		nop				; 1085 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
avr1086:	dec	r16			; 1086 950A
		brne	avr107F		; 1087 F7B9
		rjmp	avr10FE		; 1088 C075
avr1089:	cli				; 1089 94F8
		ldi	YH, 0x00		; 108A E0D0
avr108B:	ldi	YL, 0x00		; 108B E0C0
avr108C:	wdr				; 108C 95A8
		ldi	r16, 0x0C		; 108D E00C
avr108E:	dec	r16			; 108E 950A
avr108F:	brne	avr108E		; 108F F7F1
		sbis	PINC, 1	; 1090 9B99
		rjmp	avr10FB		; 1091 C069
		adiw	YL, 0x01		; 1092 9621
avr1093:	cpi	YH, 0x32		; 1093 33D2
		brne	avr108C		; 1094 F7B9
		tst	YL			; 1095 23CC
avr1096:	brne	avr108C		; 1096 F7A9
		rjmp	avr10FE		; 1097 C066
avr1098:	sbi	DDRC, 2	; 1098 9AA2
		cbi	DDRC, 3	; 1099 98A3
avr109A:	sbi	PORTC, 2	; 109A 9AAA
		ldi	r16, 0x1B		; 109B E10B
avr109C:	dec	r16			; 109C 950A
		brne	avr109C		; 109D F7F1
		cbi	PORTC, 2	; 109E 98AA
		ldi	r16, 0xFA		; 109F EC08
avr10A0:	wdr				; 10A0 95A8
		sbic	PINC, 3	; 10A1 999B
avr10A2:	rjmp	avr10AA		; 10A2 C007
		nop				; 10A3 0000
avr10A4:	nop				; 10A4 0000
		nop				; 10A5 0000
		nop				; 10A6 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
avr10A7:	dec	r16			; 10A7 950A
avr10A8:	brne	avr10A0		; 10A8 F7B9
		rjmp	avr10FE		; 10A9 C054
avr10AA:	cli				; 10AA 94F8
		ldi	YH, 0x00		; 10AB E0D0
		ldi	YL, 0x00		; 10AC E0C0
avr10AD:	wdr				; 10AD 95A8
		ldi	r16, 0x0C		; 10AE E00C
avr10AF:	dec	r16			; 10AF 950A
		brne	avr10AF		; 10B0 F7F1
		sbis	PINC, 3	; 10B1 9B9B
		rjmp	avr10FB		; 10B2 C048
		adiw	YL, 0x01		; 10B3 9621
		cpi	YH, 0x32		; 10B4 33D2
		brne	avr10AD		; 10B5 F7B9
avr10B6:	tst	YL			; 10B6 23CC
		brne	avr10AD		; 10B7 F7A9
		rjmp	avr10FE		; 10B8 C045
avr10B9:	sbi	DDRC, 4	; 10B9 9AA4
avr10BA:	cbi	DDRC, 5	; 10BA 98A5
		sbi	PORTC, 4	; 10BB 9AAC
		ldi	r16, 0x1B		; 10BC E10B
avr10BD:	dec	r16			; 10BD 950A
		brne	avr10BD		; 10BE F7F1
		cbi	PORTC, 4	; 10BF 98AC
		ldi	r16, 0xFA		; 10C0 EC08
avr10C1:	wdr				; 10C1 95A8
		sbic	PINC, 5	; 10C2 999D
		rjmp	avr10CB		; 10C3 C007
avr10C4:	nop				; 10C4 0000
		nop				; 10C5 0000
avr10C6:	nop				; 10C6 0000
		nop				; 10C7 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
avr10C8:	dec	r16			; 10C8 950A
		brne	avr10C1		; 10C9 F7B9
avr10CA:	rjmp	avr10FE		; 10CA C033
avr10CB:	cli				; 10CB 94F8
avr10CC:	ldi	YH, 0x00		; 10CC E0D0
		ldi	YL, 0x00		; 10CD E0C0
avr10CE:	wdr				; 10CE 95A8
		ldi	r16, 0x0C		; 10CF E00C
avr10D0:	dec	r16			; 10D0 950A
		brne	avr10D0		; 10D1 F7F1
		sbis	PINC, 5	; 10D2 9B9D
		rjmp	avr10FB		; 10D3 C027
		adiw	YL, 0x01		; 10D4 9621
		cpi	YH, 0x32		; 10D5 33D2
		brne	avr10CE		; 10D6 F7B9
avr10D7:	tst	YL			; 10D7 23CC
		brne	avr10CE		; 10D8 F7A9
avr10D9:	rjmp	avr10FE		; 10D9 C024
avr10DA:	sbi	DDRC, 6	; 10DA 9AA6
		cbi	DDRC, 7	; 10DB 98A7
		sbi	PORTC, 6	; 10DC 9AAE
		ldi	r16, 0x1B		; 10DD E10B
avr10DE:	dec	r16			; 10DE 950A
avr10DF:	brne	avr10DE		; 10DF F7F1
		cbi	PORTC, 6	; 10E0 98AE
		ldi	r16, 0xFA		; 10E1 EC08
avr10E2:	wdr				; 10E2 95A8
		sbic	PINC, 7	; 10E3 999F
		rjmp	avr10EC		; 10E4 C007
avr10E5:	nop				; 10E5 0000
avr10E6:	nop				; 10E6 0000
		nop				; 10E7 0000
		nop				; 10E8 0000
;-------------
;New 2.7 code
		nop
		nop
		nop
;---------------
		dec	r16			; 10E9 950A
avr10EA:	brne	avr10E2		; 10EA F7B9
avr10EB:	rjmp	avr10FE		; 10EB C012
avr10EC:	cli				; 10EC 94F8
		ldi	YH, 0x00		; 10ED E0D0
		ldi	YL, 0x00		; 10EE E0C0
avr10EF:	wdr				; 10EF 95A8
		ldi	r16, 0x0C		; 10F0 E00C
avr10F1:	dec	r16			; 10F1 950A
		brne	avr10F1		; 10F2 F7F1
avr10F3:	sbis	PINC, 7	; 10F3 9B9F
		rjmp	avr10FB		; 10F4 C006
		adiw	YL, 0x01		; 10F5 9621
		cpi	YH, 0x32		; 10F6 33D2
avr10F7:	brne	avr10EF		; 10F7 F7B9
		tst	YL			; 10F8 23CC
		brne	avr10EF		; 10F9 F7A9
		rjmp	avr10FE		; 10FA C003
avr10FB:	mov	r19, YH		; 10FB 2F3D
		mov	r18, YL		; 10FC 2F2C
		rjmp	avr1100		; 10FD C002
avr10FE:	ldi	r19, 0x00		; 10FE E030
		ldi	r18, 0x00		; 10FF E020
avr1100:	call	sub14CD		; 1100 940E 14CD store result
		adiw	XL, 0x01		; 1102 9611
		sei				; 1103 9478
		jmp	avr0093		; 1104 940C 0093

;-------------------------------------------------------
;Here for IM code FE MOTORIN

avr1106:	rcall	sub0B8B		; 1106 DA84 get value
			mov	r16, r23		; 1107 2F07
;----------
;taken out in 2.7
;			cpi	r16, 0x20		; 1108 3200
;			brsh	avr110C		; 1109 F410
			jmp	avr45C6			; 110A 940C 45C6
avr110C:	ldi	r19, 0x00		; 110C E030
			ldi	r18, 0x00		; 110D E020
avr110E:	call	sub14CD		; 110E 940E 14CD store result
			jmp	avr0093			; 1110 940C 0093

;----------------------------------------------------------
; Here for IM code C0 IF
avr1112:	clr	r16				; 1112 2700
			sts	0x04C5, r16		; 1113 9300 04C5
			call	sub07D6		; 1115 940E 07D6 get next byte low address
			mov	r17, r16		; 1117 2F10
			call	sub07D6		; 1118 940E 07D6 get next byte high address
			mov	r18, r16		; 111A 2F20
avr111B:	call	sub0B8B		; 111B 940E 0B8B
			mov	r19, r23		; 111D 2F37
			mov	r20, r24		; 111E 2F48
			call	sub07D6		; 111F 940E 07D6
			push	r16			; 1121 930F
			call	sub0B8B		; 1122 940E 0B8B
			andi	r25, 0xC7		; 1124 7C97
			cp	r20, r24		; 1125 1748
			breq	avr112C		; 1126 F029
			brsh	avr112A		; 1127 F410
			ori	r25, 0x08		; 1128 6098
			rjmp	avr1134		; 1129 C00A
avr112A:	ori	r25, 0x20		; 112A 6290
avr112B:	rjmp	avr1134		; 112B C008
avr112C:	cp	r19, r23		; 112C 1737
			breq	avr1133		; 112D F029
			brsh	avr1131		; 112E F410
			ori	r25, 0x08		; 112F 6098
			rjmp	avr1134		; 1130 C003
avr1131:	ori	r25, 0x20		; 1131 6290
			rjmp	avr1134		; 1132 C001
avr1133:	ori	r25, 0x10		; 1133 6190
avr1134:	pop	r16				; 1134 910F
			cpi	r16, 0x30		; 1135 3300
			brne	avr113A		; 1136 F419
			sbrc	r25, 3		; 1137 FD93
			rjmp	avr1153		; 1138 C01A
			rjmp	avr115B		; 1139 C021
avr113A:	cpi	r16, 0x31		; 113A 3301
			brne	avr113F		; 113B F419
			sbrc	r25, 5		; 113C FD95
			rjmp	avr1153		; 113D C015
			rjmp	avr115B		; 113E C01C
avr113F:	cpi	r16, 0x32		; 113F 3302
			brne	avr1144		; 1140 F419
			sbrs	r25, 5		; 1141 FF95
			rjmp	avr1153		; 1142 C010
			rjmp	avr115B		; 1143 C017
avr1144:	cpi	r16, 0x33		; 1144 3303
			brne	avr1149		; 1145 F419
			sbrs	r25, 3		; 1146 FF93
			rjmp	avr1153		; 1147 C00B
			rjmp	avr115B		; 1148 C012
avr1149:	cpi	r16, 0x34		; 1149 3304
			brne	avr114E		; 114A F419
			sbrs	r25, 4		; 114B FF94
			rjmp	avr1153		; 114C C006
			rjmp	avr115B		; 114D C00D
avr114E:	cpi	r16, 0x35		; 114E 3305
			brne	avr1153		; 114F F419
			sbrc	r25, 4		; 1150 FD94
			rjmp	avr1153		; 1151 C001
			rjmp	avr115B		; 1152 C008
avr1153:	lds	r16, 0x04C5		; 1153 9100 04C5
			sbrc	r16, 7		; 1155 FD07
			rjmp	avr1159		; 1156 C002
			ori	r16, 0x40		; 1157 6400
			rjmp	avr1163		; 1158 C00A
avr1159:	ori	r16, 0x20		; 1159 6200
			rjmp	avr1163		; 115A C008

avr115B:	lds	r16, 0x04C5		; 115B 9100 04C5
			sbrc	r16, 7		; 115D FD07
			rjmp	avr1161		; 115E C002
			andi	r16, 0xBF	; 115F 7B0F
			rjmp	avr1163		; 1160 C002
avr1161:	andi	r16, 0xDF	; 1161 7D0F
			rjmp	avr1163		; 1162 C000
avr1163:	ori	r16, 0x80		; 1163 6800
			sts	0x04C5, r16		; 1164 9300 04C5
			call	sub07D6		; 1166 940E 07D6
			cpi	r16, 0x00		; 1168 3000
			breq	avr117A		; 1169 F081
			cpi	r16, 0x27		; 116A 3207
			breq	avr116E		; 116B F011
			cpi	r16, 0x28		; 116C 3208
			rjmp	avr1174		; 116D C006
avr116E:	lds	r16, 0x04C5		; 116E 9100 04C5
			ori	r16, 0x10		; 1170 6100
			sts	0x04C5, r16		; 1171 9300 04C5
			rjmp	avr111B		; 1173 CFA7
avr1174:	lds	r16, 0x04C5		; 1174 9100 04C5
			ori	r16, 0x08		; 1176 6008
			sts	0x04C5, r16		; 1177 9300 04C5
			rjmp	avr111B		; 1179 CFA1
avr117A:	lds	r16, 0x04C5		; 117A 9100 04C5
			sbrc	r16, 4		; 117C FD04
			rjmp	avr1181		; 117D C003
			sbrc	r16, 3		; 117E FD03
			rjmp	avr1186		; 117F C006
			rjmp	avr118B		; 1180 C00A
avr1181:	sbrs	r16, 6		; 1181 FF06
			rjmp	avr1191		; 1182 C00E
			sbrs	r16, 5		; 1183 FF05
			rjmp	avr1191		; 1184 C00C
			rjmp	avr118E		; 1185 C008
avr1186:	sbrc	r16, 6		; 1186 FD06
			rjmp	avr118E		; 1187 C006
			sbrc	r16, 5		; 1188 FD05
			rjmp	avr118E		; 1189 C004
			rjmp	avr1191		; 118A C006
avr118B:	sbrs	r16, 6		; 118B FF06
			rjmp	avr1191		; 118C C004
			rjmp	avr118E		; 118D C000

avr118E:	ldi	ZH, 0x00		; 118E E0F0
			ldi	ZL, 0x93		; 118F E9E3
			ijmp				; 1190 9409

avr1191:	mov	XL, r17		; 1191 2FA1
			mov	XH, r18		; 1192 2FB2
			ldi	ZH, 0x00		; 1193 E0F0
			ldi	ZL, 0x93		; 1194 E9E3
			ijmp				; 1195 9409
;-------------------------------------------------------
; Here for IM code BF FOR

avr1196:	rcall	sub0B8B		; 1196 D9F4 get IM value into Y
			in	r16, SREG		; 1197 B70F
			push	r16			; 1198 930F
			push	YL			; 1199 93CF
			push	YH			; 119A 93DF
avr119B:	rcall	sub0B8B		; 119B D9EF
			pop	YH				; 119C 91DF
			pop	YL				; 119D 91CF
			pop	r16				; 119E 910F
			out	SREG, r16		; 119F BF0F
			st	Y+, r23			; 11A0 9379 store r23 into RAM
			brtc	avr11A3		; 11A1 F40E
			st	Y, r24			; 11A2 8388 if int value store r24 too
avr11A3:	ldi	ZH, 0x00		; 11A3 E0F0
avr11A4:	ldi	ZL, 0x93		; 11A4 E9E3
			ijmp				; 11A5 9409
;--------------------------------------------------------------
; Here for IM Code C2 NEXT
;
avr11A6:	rcall	sub0B8B		; 11A6 D9E4 get next IM value
			ldi	r17, 0x01		; 11A7 E011 add 1
			ldi	r18, 0x00		; 11A8 E020
			add	r23, r17		; 11A9 0F71
			adc	r24, r18		; 11AA 1F82
			st	Y+, r23			; 11AB 9379
			brtc	avr11AF		; 11AC F416
			st	Y, r24			; 11AD 8388
			rjmp	avr11CA		; 11AE C01B
avr11AF:	cpi	r23, 0x00		; 11AF 3070 is it NULL
			breq	avr11B2		; 11B0 F009
			rjmp	avr11CA		; 11B1 C018
avr11B2:	call	sub07D6		; 11B2 940E 07D6
			mov	r17, r16		; 11B4 2F10
			call	sub07D6		; 11B5 940E 07D6
			mov	XL, r17		; 11B7 2FA1
			mov	XH, r16		; 11B8 2FB0
			adiw	XL, 0x01		; 11B9 9611
			rcall	sub0B8B		; 11BA D9D0
			rcall	sub0B8B		; 11BB D9CF
			rjmp	avr11CA		; 11BC C00D

;------------------------------------------------------------------
; Here for IM code C3 TO
avr11BD:	rcall	sub0B8B		; 11BD D9CD
			mov	r17, r23		; 11BE 2F17
			mov	r18, r24		; 11BF 2F28
			rcall	sub0B8B		; 11C0 D9CA
			cp	r24, r18		; 11C1 1782
			brlo	avr11CA		; 11C2 F038
			brne	avr11C6		; 11C3 F411
			cp	r23, r17		; 11C4 1771
			brlo	avr11CA		; 11C5 F020
avr11C6:	adiw	XL, 0x02	; 11C6 9612 all done skip over
			ldi	ZH, 0x00		; 11C7 E0F0
			ldi	ZL, 0x93		; 11C8 E9E3
			ijmp				; 11C9 9409
;-----------------------------------------------------------------------
; Here for IM code C4  GOTO
avr11CA:	call	sub07D6		; 11CA 940E 07D6 get next address and put into X
			mov	r17, r16		; 11CC 2F10
avr11CD:	call	sub07D6		; 11CD 940E 07D6
			mov	XL, r17			; 11CF 2FA1
			mov	XH, r16			; 11D0 2FB0
			ldi	ZH, 0x00		; 11D1 E0F0
			ldi	ZL, 0x93		; 11D2 E9E3
avr11D3:	ijmp				; 11D3 9409
;--------------------------------------------------------------------
; Here for IM code  C5 GOSUB

avr11D4:	mov	YL, XL			; 11D4 2FCA
			mov	YH, XH			; 11D5 2FDB
			adiw	YL, 0x02	; 11D6 9622
			mov	r17, YL			; 11D7 2F1C
			mov	r18, YH			; 11D8 2F2D
			lds	YL, 0x04D5		; 11D9 91C0 04D5 Y = IM stack pointer
			lds	YH, 0x04D6		; 11DB 91D0 04D6
			st	Y+, r17			; 11DD 9319
			st	Y+, r18			; 11DE 9329
			sts	0x04D5, YL		; 11DF 93C0 04D5
			sts	0x04D6, YH		; 11E1 93D0 04D6
			rjmp	avr11CA		; 11E3 CFE6
;-----------------------------------------------------------------------
; Here for IM code C6 RET

avr11E4:	lds	YL, 0x04D5		; 11E4 91C0 04D5
			lds	YH, 0x04D6		; 11E6 91D0 04D6
			ld	r18, -Y			; 11E8 912A
			ld	r17, -Y			; 11E9 911A
			sts	0x04D5, YL		; 11EA 93C0 04D5
			sts	0x04D6, YH		; 11EC 93D0 04D6 Y = IM stack pointer
			mov	XL, r17			; 11EE 2FA1
			mov	XH, r18			; 11EF 2FB2
			ldi	ZH, 0x00		; 11F0 E0F0
			ldi	ZL, 0x93		; 11F1 E9E3
			ijmp				; 11F2 9409
;------------------------------------------------------------------------
;Here for IM code  C7 ON

avr11F3:	call	sub0B8B		; 11F3 940E 0B8B
			call	sub07D6		; 11F5 940E 07D6
			cp	r23, r16		; 11F7 1770
			brsh	avr11FF		; 11F8 F430
			mov	r16, r23		; 11F9 2F07
;-----
; 2.7 code
			clr		r17
;---------
			lsl	r16			; 11FA 0F00
;---------
;2.7 code
			rol	r17

;			ldi	r17, 0x00		; 11FB E010
;---------
			add	XL, r16		; 11FC 0FA0
			adc	XH, r17		; 11FD 1FB1
			rjmp	avr11CA		; 11FE CFCB
;---------
;2.7 code
avr11FF:	clr	r17
;---------
			lsl	r16			; 11FF 0F00
;----------
;2.7 code
			rol	r17

;			ldi	r17, 0x00		; 1200 E010
;-------------
			add	XL, r16		; 1201 0FA0
			adc	XH, r17		; 1202 1FB1
			ldi	ZH, 0x00		; 1203 E0F0
			ldi	ZL, 0x93		; 1204 E9E3
			ijmp				; 1205 9409

;-----------------------------------------------------------
; Here for IM code C8 unused
avr1206:	ldi	ZH, 0x00		; 1206 E0F0
			ldi	ZL, 0x93		; 1207 E9E3
			ijmp				; 1208 9409
;-----------------------------------------------------------
; Here for IM code C9 unused

avr1209:	ldi	ZH, 0x00		; 1209 E0F0
			ldi	ZL, 0x93		; 120A E9E3
			ijmp				; 120B 9409
;-----------------------------------------------------------
; Here for IM code CA unused
avr120C:	ldi	ZH, 0x00		; 120C E0F0
			ldi	ZL, 0x93		; 120D E9E3
			ijmp				; 120E 9409

;------------------------------------------------------------
; Here for IM code CB BREAK
avr120F:	lds	r16, 0x04D2		; 120F 9100 04D2
			ori	r16, 0x10		; 1211 6100
			sts	0x04D2, r16		; 1212 9300 04D2
			ldi	ZH, 0x00		; 1214 E0F0
			ldi	ZL, 0x93		; 1215 E9E3
			ijmp				; 1216 9409
;------------------------------------------------------------
; Here for IM code CC POKE

avr1217:	call	sub0B8B		; 1217 940E 0B8B
			mov	YL, r23		; 1219 2FC7
			mov	YH, r24		; 121A 2FD8
			call	sub0B8B		; 121B 940E 0B8B
			st	Y+, r23		; 121D 9379
			tst	r24			; 121E 2388
			breq	avr1221		; 121F F009
			st	Y, r24			; 1220 8388
avr1221:	ldi	ZH, 0x00		; 1221 E0F0
			ldi	ZL, 0x93		; 1222 E9E3
			ijmp				; 1223 9409

;-------------------------------------------------------------
; Here for IM code CD ROMPOKE

avr1224:	call	sub0B8B		; 1224 940E 0B8B get address
			mov	YL, r23			; 1226 2FC7
			mov	YH, r24			; 1227 2FD8
			call	sub0B8B		; 1228 940E 0B8B get value
			mov	r16, r23		; 122A 2F07
			push	XL			; 122B 93AF
			push	XH			; 122C 93BF
			mov	XL, YL			; 122D 2FAC
			mov	XH, YH			; 122E 2FBD
			call	sub07B3		; 122F 940E 07B3
			tst	r24				; 1231 2388	is it an integer ?
			breq	avr1236		; 1232 F019
			mov	r16, r24		; 1233 2F08
			call	sub07B3		; 1234 940E 07B3 save high too
avr1236:	pop	XH				; 1236 91BF
			pop	XL				; 1237 91AF
			ldi	ZH, 0x00		; 1238 E0F0
			ldi	ZL, 0x93		; 1239 E9E3
			ijmp				; 123A 9409
;----------------------------------------------------------
; Here for IM code CE unused

avr123B:	ldi	ZH, 0x00		; 123B E0F0
			ldi	ZL, 0x93		; 123C E9E3
			ijmp				; 123D 9409
;-----------------------------------------------------------
; Here for IM code CF unused

avr123E:	ldi	ZH, 0x00		; 123E E0F0
			ldi	ZL, 0x93		; 123F E9E3
			ijmp				; 1240 9409

;--------------------------------------------------------
;Here for IM Code  E0 LCDINIT
;

avr1241:	ldi	r16, 0x1B		; 1241 E10B
			call	sub25DA		; 1242 940E 25DA
			ldi	r16, 0x49		; 1244 E409
			call	sub25DA		; 1245 940E 25DA
			ldi	r16, 0x1B		; 1247 E10B
			call	sub25DA		; 1248 940E 25DA
			ldi	r16, 0x49		; 124A E409
			call	sub25DA		; 124B 940E 25DA
			ldi	ZH, 0x00		; 124D E0F0
			ldi	ZL, 0x93		; 124E E9E3
			ijmp				; 124F 9409
;---------------------------------------------------------
; Here for IM code E1 CLS

avr1250:	ldi	r16, 0x1B		; 1250 E10B
			call	sub25DA		; 1251 940E 25DA
			ldi	r16, 0x48		; 1253 E408
			call	sub25DA		; 1254 940E 25DA
			ldi	r16, 0x1B		; 1256 E10B
			call	sub25DA		; 1257 940E 25DA
			ldi	r16, 0x48		; 1259 E408
			call	sub25DA		; 125A 940E 25DA
			ldi	ZH, 0x00		; 125C E0F0
			ldi	ZL, 0x93		; 125D E9E3
			ijmp				; 125E 9409
;--------------------------------------------------------
; Here for IM code E2 LOCATE

avr125F:	ldi	r16, 0x1B		; 125F E10B
			call	sub25DA		; 1260 940E 25DA
			ldi	r16, 0x4C		; 1262 E40C
			call	sub25DA		; 1263 940E 25DA
			call	sub0B8B		; 1265 940E 0B8B
			mov	r16, r23		; 1267 2F07
			ldi	r17, 0x30		; 1268 E310
			add	r16, r17		; 1269 0F01
			call	sub25DA		; 126A 940E 25DA
			call	sub0B8B		; 126C 940E 0B8B
			mov	r16, r23		; 126E 2F07
			ldi	r17, 0x30		; 126F E310
			add	r16, r17		; 1270 0F01
			call	sub25DA		; 1271 940E 25DA
			ldi	ZH, 0x00		; 1273 E0F0
			ldi	ZL, 0x93		; 1274 E9E3
			ijmp				; 1275 9409
			
;---------------------------------------------------------
; Here for IM Code E3 PRINT

avr1276:	call	sub07D6		; 1276 940E 07D6
			cpi	r16, 0x18		; 1278 3108
			brne	avr1286		; 1279 F461
avr127A:	wdr					; 127A 95A8
			call	sub07D6		; 127B 940E 07D6
			cpi	r16, 0x00		; 127D 3000
			breq	avr128F		; 127E F081
			lds	r17, 0x009B		; 127F 9110 009B
			sbrc	r17, 7		; 1281 FD17
			rjmp	avr127A		; 1282 CFF7
			call	sub25DA		; 1283 940E 25DA
			rjmp	avr127A		; 1285 CFF4
avr1286:	cpi	r16, 0x19		; 1286 3109
			brne	avr1289		; 1287 F409
			rcall	sub1292		; 1288 D009
avr1289:	cpi	r16, 0x1A		; 1289 310A
			brne	avr128C		; 128A F409
			rcall	sub12A9		; 128B D01D
avr128C:	cpi	r16, 0x1B		; 128C 310B
			brne	avr128F		; 128D F409
			rcall	sub12ED		; 128E D05E
avr128F:	ldi	ZH, 0x00		; 128F E0F0
			ldi	ZL, 0x93		; 1290 E9E3
			ijmp				; 1291 9409

sub1292:	call	sub0B8B		; 1292 940E 0B8B
			mov	r16, r23		; 1294 2F07
			brtc	sub1298		; 1295 F416
			rjmp	avr12A4		; 1296 C00D
			ret					; 1297 9508

sub1298:	push	r16			; 1298 930F
			swap	r16			; 1299 9502
			andi	r16, 0x0F		; 129A 700F
			rcall	sub1306		; 129B D06A
			call	sub25DA		; 129C 940E 25DA
			pop	r16				; 129E 910F
			andi	r16, 0x0F	; 129F 700F
			rcall	sub1306		; 12A0 D065
			call	sub25DA		; 12A1 940E 25DA
			ret					; 12A3 9508

avr12A4:	mov	r16, r24		; 12A4 2F08
			rcall	sub1298		; 12A5 DFF2
			mov	r16, r23		; 12A6 2F07
			rcall	sub1298		; 12A7 DFF0
			ret					; 12A8 9508

sub12A9:	call	sub0B8B		; 12A9 940E 0B8B
			mov	r16, r23		; 12AB 2F07
			brtc	avr12AF		; 12AC F416
			rjmp	avr12C6		; 12AD C018
			ret					; 12AE 9508

avr12AF:	clr	r17				; 12AF 2711
			rcall	sub130F		; 12B0 D05E
			push	r13			; 12B1 92DF
			mov	r16, r14		; 12B2 2D0E
			andi	r16, 0x0F	; 12B3 700F
			rcall	sub1306		; 12B4 D051
			call	sub25DA		; 12B5 940E 25DA
			pop	r13				; 12B7 90DF
			push	r13			; 12B8 92DF
			mov	r16, r13		; 12B9 2D0D
			swap	r16			; 12BA 9502
			andi	r16, 0x0F	; 12BB 700F
			rcall	sub1306		; 12BC D049
			call	sub25DA		; 12BD 940E 25DA
			pop	r13				; 12BF 90DF
			mov	r16, r13		; 12C0 2D0D
			andi	r16, 0x0F	; 12C1 700F
			rcall	sub1306		; 12C2 D043
			call	sub25DA		; 12C3 940E 25DA
			ret					; 12C5 9508

avr12C6:	mov	r16, r23		; 12C6 2F07
			mov	r17, r24		; 12C7 2F18
			rcall	sub130F		; 12C8 D046
			push	r13			; 12C9 92DF
			push	r14			; 12CA 92EF
			mov	r16, r15		; 12CB 2D0F
			andi	r16, 0x0F	; 12CC 700F
			rcall	sub1306		; 12CD D038
			call	sub25DA		; 12CE 940E 25DA
			pop	r14				; 12D0 90EF
			push	r14			; 12D1 92EF
			mov	r16, r14		; 12D2 2D0E
			swap	r16			; 12D3 9502
			andi	r16, 0x0F	; 12D4 700F
			rcall	sub1306		; 12D5 D030
			call	sub25DA		; 12D6 940E 25DA
			pop	r14				; 12D8 90EF
			mov	r16, r14		; 12D9 2D0E
			andi	r16, 0x0F	; 12DA 700F
			rcall	sub1306		; 12DB D02A
			call	sub25DA		; 12DC 940E 25DA
			pop	r13				; 12DE 90DF
			push	r13			; 12DF 92DF
			mov	r16, r13		; 12E0 2D0D
			swap	r16			; 12E1 9502
			andi	r16, 0x0F	; 12E2 700F
			rcall	sub1306		; 12E3 D022
			call	sub25DA		; 12E4 940E 25DA
			pop	r13				; 12E6 90DF
			mov	r16, r13		; 12E7 2D0D
			andi	r16, 0x0F	; 12E8 700F
			rcall	sub1306		; 12E9 D01C
			call	sub25DA		; 12EA 940E 25DA
			ret					; 12EC 9508

sub12ED:	call	sub0B8B		; 12ED 940E 0B8B
			mov	r16, r23		; 12EF 2F07
			brtc	0x000013c2		; 12F0 F416
			rjmp	sub12f3		; 12F1 C00F
			ret					; 12F2 9508
; 2.7 changes

sub12F3:	mov		r16,r24		; 12F3 2F10
			rcall	0x000013c2		; 12F4 E028
avr12F5:	mov		r16,r23			; 12F5 1F11
			rcall	0x000013c2	; 12F6 F420
			ret		; 12F7 E301
			mov		r17, r16		; 12F8 940E 25DA
			ldi		r18, 0x08	; 12FA C003
avr12FB:	rol		r17		; 12FB E300
			brcc	0x000013CA	; 12FC 940E 25DA
avr12FE:	ldi		r16, 0x31			; 12FE 952A
			call	0x000026EA		; 12FF F7A9
			rjmp	0x000013CD					; 1300 9508


avr1301:	ldi		r16, 0x30		; 1301 2F08
			call	0x000026EA	; 1302 DFF0
			dec		r18		; 1303 2F07
			brne	0x000013C4		; 1304 DFEE
			ret					; 1305 9508

																																										
sub1306:	wdr					; 1306 95A8
			ldi	ZH, 0xC4		; 1307 ECF3
			ldi	ZL, 0x58		; 1308 EFE2
			add	ZL, r16			; 1309 0FE0
			brsh	avr130C		; 130A F408
			inc	ZH				; 130B 95F3
avr130C:	lpm					; 130C 95C8
			mov	r16, r0			; 130D 2D00
			ret					; 130E 9508
;-------------------------------------------------------------------------
;

sub130F:	ldi	r18, 0x10		; 130F E120
			clr	r15				; 1310 24FF
			clr	r14				; 1311 24EE
			clr	r13				; 1312 24DD
			clr	ZH				; 1313 27FF
avr1314:	lsl	r16				; 1314 0F00
			rol	r17				; 1315 1F11
			rol	r13				; 1316 1CDD
			rol	r14				; 1317 1CEE
			rol	r15				; 1318 1CFF
			dec	r18				; 1319 952A
			brne	avr131C		; 131A F409
			rjmp	avr1328		; 131B C00C
avr131C:	ldi	ZL, 0x10		; 131C E1E0
avr131D:	ld	r19, -Z			; 131D 9132
			subi	r19, 0xFD	; 131E 5F3D
			sbrc	r19, 3		; 131F FD33
			st	Z, r19			; 1320 8330
			ld	r19, Z			; 1321 8130
			subi	r19, 0xD0	; 1322 5D30
			sbrc	r19, 7		; 1323 FD37
			st	Z, r19			; 1324 8330
			cpi	ZL, 0x0D		; 1325 30ED
			brne	avr131D		; 1326 F7B1
			rjmp	avr1314		; 1327 CFEC
avr1328:	ret					; 1328 9508
;-------------------------------------------------------------------------
;Here for IM Code E4 CSON

avr1329:	ldi	r16, 0x1B		; 1329 E10B
			call	sub25DA		; 132A 940E 25DA
			ldi	r16, 0x4F		; 132C E40F
			call	sub25DA		; 132D 940E 25DA
			ldi	ZH, 0x00		; 132F E0F0
			ldi	ZL, 0x93		; 1330 E9E3
			ijmp				; 1331 9409

;--------------------------------------------------------------------------
;Here for IM Code E5 CS0FF

avr1332:	ldi	r16, 0x1B		; 1332 E10B
			call	sub25DA		; 1333 940E 25DA
			ldi	r16, 0x58		; 1335 E508
			call	sub25DA		; 1336 940E 25DA
			ldi	ZH, 0x00		; 1338 E0F0
			ldi	ZL, 0x93		; 1339 E9E3
			ijmp				; 133A 9409

;-----------------------------------------------------------------------
;Here for IM code E6 CONS

avr133B:	ldi	r16, 0x1B		; 133B E10B
			call	sub25DA		; 133C 940E 25DA
			ldi	r16, 0x43		; 133E E403
			call	sub25DA		; 133F 940E 25DA
			call	sub0B8B		; 1341 940E 0B8B
			mov	r16, r23		; 1343 2F07
			call	sub25DA		; 1344 940E 25DA
			ldi	ZH, 0x00		; 1346 E0F0
			ldi	ZL, 0x93		; 1347 E9E3
			ijmp				; 1348 9409

;-----------------------------------------------------------------------
; Here for IM code E7 BYTEOUT

avr1349:	call	sub0B8B		; 1349 940E 0B8B
			mov	r17, r23		; 134B 2F17
			call	sub0B8B		; 134C 940E 0B8B
			mov	r16, r23		; 134E 2F07

; command PORT Byte write
sub134F:			cpi	r17, 0x00		; 134F 3010
			breq	avr135C		; 1350 F059
			cpi	r17, 0x01		; 1351 3011
			breq	avr135D		; 1352 F051
			cpi	r17, 0x02		; 1353 3012
			breq	avr135E		; 1354 F049
			cpi	r17, 0x03		; 1355 3013
			breq	avr135F		; 1356 F041
			cpi	r17, 0x04		; 1357 3014
			breq	avr1360		; 1358 F039
			cpi	r17, 0x05		; 1359 3015
			breq	avr1361		; 135A F031
			rjmp	avr13BA		; 135B C05E
avr135C:	rjmp	avr1362		; 135C C005
avr135D:	rjmp	avr136A		; 135D C00C
avr135E:	rjmp	avr1372		; 135E C013
avr135F:	rjmp	avr1386		; 135F C026
avr1360:	rjmp	avr13B3		; 1360 C052
avr1361:	rjmp	avr13B9		; 1361 C057

avr1362:	lds	r17, 0x04EB		; 1362 9110 04EB
			cpi	r17, 0x00		; 1364 3010
			brne	avr1385		; 1365 F4F9
			out	PORTA, r16		; 1366 BB0B
			ser	r16				; 1367 EF0F
			out	DDRA, r16		; 1368 BB0A
			rjmp	avr13BA		; 1369 C050

avr136A:	lds	r17, 0x04EC		; 136A 9110 04EC
			cpi	r17, 0x00		; 136C 3010
			brne	avr1385		; 136D F4B9
			out	PORTB, r16		; 136E BB08
			ser	r16				; 136F EF0F
			out	DDRB, r16		; 1370 BB07
			rjmp	avr13BA		; 1371 C048

avr1372:	lds	r17, 0x04ED		; 1372 9110 04ED
			cpi	r17, 0x00		; 1374 3010
			breq	avr1377		; 1375 F009
			rjmp	avr13BA		; 1376 C043

avr1377:	ldi	r18, 0x00		; 1377 E020
			ldi	r19, 0x08		; 1378 E038
avr1379:	lsl	r16				; 1379 0F00
			brsh	avr137D		; 137A F410
			sec					; 137B 9408
			rjmp	avr137E		; 137C C001
avr137D:	clc					; 137D 9488
avr137E:	ror	r18				; 137E 9527
			dec	r19				; 137F 953A
			brne	avr1379		; 1380 F7C1
			out	PORTC, r18		; 1381 BB25
avr1382:	ser	r16				; 1382 EF0F
			out	DDRC, r16		; 1383 BB04
			rjmp	avr13BA		; 1384 C035

avr1385:	rjmp	avr13BA		; 1385 C034

avr1386:	lds	r17, 0x04EE		; 1386 9110 04EE
			cpi	r17, 0x00		; 1388 3010
			brne	avr13BA		; 1389 F581
			sbi	$02, 7			; 138A 9A17
			sbi	$02, 6			; 138B 9A16
			sbi	DDRD, 7			; 138C 9A8F
			sbi	DDRD, 6			; 138D 9A8E
			sbi	DDRD, 5			; 138E 9A8D
			lds	r17, 0x0064		; 138F 9110 0064
			ori	r17, 0x07		; 1391 6017
			sts	0x0064, r17		; 1392 9310 0064
			sbrc	r16, 0		; 1394 FD00
			sbi	$03, 7			; 1395 9A1F
			sbrs	r16, 0		; 1396 FF00
			cbi	$03, 7			; 1397 981F
			sbrc	r16, 1		; 1398 FD01
			sbi	$03, 6			; 1399 9A1E
			sbrs	r16, 1		; 139A FF01
			cbi	$03, 6			; 139B 981E
			sbrc	r16, 2		; 139C FD02
			sbi	PORTD, 7		; 139D 9A97
			sbrs	r16, 2		; 139E FF02
			cbi	PORTD, 7		; 139F 9897
			sbrc	r16, 3		; 13A0 FD03
			sbi	PORTD, 6		; 13A1 9A96
			sbrs	r16, 3		; 13A2 FF03
			cbi	PORTD, 6		; 13A3 9896
			sbrc	r16, 4		; 13A4 FD04
			sbi	PORTD, 5		; 13A5 9A95
			sbrs	r16, 4		; 13A6 FF04
			cbi	PORTD, 5		; 13A7 9895
			lds	r17, 0x0065		; 13A8 9110 0065
			andi	r17, 0xF8	; 13AA 7F18
			sbrc	r16, 5		; 13AB FD05
			ori	r17, 0x04		; 13AC 6014
			sbrc	r16, 6		; 13AD FD06
			ori	r17, 0x02		; 13AE 6012
			sbrc	r16, 7		; 13AF FD07
			ori	r17, 0x01		; 13B0 6011
			sts	0x0065, r17		; 13B1 9310 0065
avr13B3:	sts	0x0062, r16		; 13B3 9300 0062
			ser	r16				; 13B5 EF0F
			sts	0x0061, r16		; 13B6 9300 0061
			rjmp	avr13BA		; 13B8 C001
avr13B9:	rjmp	avr13BA		; 13B9 C000

avr13BA:	lds	r16, 0x04D2		; 13BA 9100 04D2
			sbrc	r16, 5		; 13BC FD05
avr13BD:	ret					; 13BD 9508
;-------------------------------------------------------------------------
			jmp	avr0093			; 13BE 940C 0093

;------------------------------------------------------------------------
; IM code  E8 unused
avr13C0:			jmp	avr0093			; 13C0 940C 0093
	
;-------------------------------------------------------
;IM Code  E9 WAIT
avr13C2:	lds	r16, 0x04DE		; 13C2 9100 04DE Get delay count
			cpi	r16, 0x00		; 13C4 3000 if not zero then wait
			brne	avr13D8		; 13C5 F491
			lds	r16, 0x04E3		; 13C6 9100 04E3 check for any motors in motion
			cpi	r16, 0xFF		; 13C8 3F0F
			brne	avr13D8		; 13C9 F471
			lds	r16, 0x04E4		; 13CA 9100 04E4
			cpi	r16, 0xFF		; 13CC 3F0F
			brne	avr13D8		; 13CD F451
			lds	r16, 0x04E5		; 13CE 9100 04E5
			cpi	r16, 0xFF		; 13D0 3F0F
			brne	avr13D8		; 13D1 F431
			lds	r16, 0x04E6		; 13D2 9100 04E6
			cpi	r16, 0xFF		; 13D4 3F0F
			brne	avr13D8		; 13D5 F411

			jmp	avr0093			; 13D6 940C 0093 ready return

avr13D8:	sbiw	XL, 0x01	; 13D8 9711 PC -1 if not ready
			jmp	avr0093			; 13D9 940C 0093
;-------------------------------------------------------------
; Here for IM Code EA STOP

avr13DB:	lds	r16, 0x04D2		; 13DB 9100 04D2
			ori	r16, 0x40		; 13DD 6400
			sts	0x04D2, r16		; 13DE 9300 04D2
			jmp	avr0093			; 13E0 940C 0093

;--------------------------------------------------------------
; Here for IM code EB  RUN

avr13E2:	lds	r16, 0x04D2		; 13E2 9100 04D2
			andi	r16, 0xBF		; 13E4 7B0F
			sts	0x04D2, r16		; 13E5 9300 04D2
			jmp	avr0093		; 13E7 940C 0093
;---------------------------------------------------------------
; Here for IM code EC ?



avr13E9:	call	sub07D6		; 13E9 940E 07D6
			lds	r17, 0x04E7		; 13EB 9110 04E7
			andi	r16, 0x3F		; 13ED 730F
avr13EE:	andi	r17, 0xC0		; 13EE 7C10
			or	r16, r17		; 13EF 2B01
			sts	0x04E7, r16		; 13F0 9300 04E7
			push	XH			; 13F2 93BF
			push	XL			; 13F3 93AF
avr13F4:	ldi	XH, 0x0F		; 13F4 E0BF
			ldi	XL, 0xB0		; 13F5 EBA0
			call	sub0819		; 13F6 940E 0819
			pop	XL			; 13F8 91AF
			pop	XH			; 13F9 91BF
			jmp	avr0093		; 13FA 940C 0093
;---------------------------------------------------------------
; Here for IM code ED SETPTP


avr13FC:		call	sub07D6		; 13FC 940E 07D6
				sts	0x04DA, r16		; 13FE 9300 04DA
				jmp	avr0093		; 1400 940C 0093

;-----------------------------------------------------------------
; Here for IM code EE FPWM


avr1402:	call	sub0B8B		; 1402 940E 0B8B
			mov	r17, r23		; 1404 2F17
			call	sub0B8B		; 1405 940E 0B8B
			mov	r18, r23		; 1407 2F27
			call	sub0B8B		; 1408 940E 0B8B
			mov	r16, r23		; 140A 2F07
			cpi	r18, 0x01		; 140B 3021
			breq	avr1416		; 140C F049
			cpi	r18, 0x02		; 140D 3022
			breq	avr1416		; 140E F039
			cpi	r18, 0x03		; 140F 3023
			breq	avr1416		; 1410 F029
			cpi	r18, 0x04		; 1411 3024
			breq	avr1416		; 1412 F019
			cpi	r18, 0x05		; 1413 3025
			breq	avr1416		; 1414 F009
			ldi	r18, 0x03		; 1415 E023
avr1416:	cpi	r17, 0x00		; 1416 3010
			breq	avr141D		; 1417 F029
			cpi	r17, 0x01		; 1418 3011
			breq	avr1431		; 1419 F0B9
			cpi	r17, 0x02		; 141A 3012
			breq	avr1445		; 141B F149
			rjmp	avr1459		; 141C C03C
avr141D:	sbi	$02, 3	; 141D 9A13
			lds	r17, 0x008B		; 141E 9110 008B
			tst	r16			; 1420 2300
			breq	avr1424		; 1421 F011
			ori	r17, 0x81		; 1422 6811
			rjmp	avr1425		; 1423 C001
avr1424:	andi	r17, 0x3F		; 1424 731F
avr1425:	sts	0x008B, r17		; 1425 9310 008B
			ldi	r17, 0x08		; 1427 E018
			or	r17, r18		; 1428 2B12
			sts	0x008A, r17		; 1429 9310 008A
			ldi	r17, 0x00		; 142B E010
			sts	0x0087, r17		; 142C 9310 0087
			sts	0x0086, r16		; 142E 9300 0086
			rjmp	avr1459		; 1430 C028
avr1431:	sbi	$02, 4	; 1431 9A14
			lds	r17, 0x008B		; 1432 9110 008B
			tst	r16			; 1434 2300
			breq	avr1438		; 1435 F011
			ori	r17, 0x21		; 1436 6211
			rjmp	avr1439		; 1437 C001
avr1438:	andi	r17, 0xCF		; 1438 7C1F
avr1439:	sts	0x008B, r17		; 1439 9310 008B
			ldi	r17, 0x08		; 143B E018
			or	r17, r18		; 143C 2B12
			sts	0x008A, r17		; 143D 9310 008A
			ldi	r17, 0x00		; 143F E010
			sts	0x0085, r17		; 1440 9310 0085
			sts	0x0084, r16		; 1442 9300 0084
			rjmp	avr1459		; 1444 C014
avr1445:	sbi	$02, 5	; 1445 9A15
			lds	r17, 0x008B		; 1446 9110 008B
			tst	r16			; 1448 2300
			breq	avr144C		; 1449 F011
			ori	r17, 0x09		; 144A 6019
			rjmp	avr144D		; 144B C001
avr144C:	andi	r17, 0xF3		; 144C 7F13
avr144D:	sts	0x008B, r17		; 144D 9310 008B
			ldi	r17, 0x08		; 144F E018
			or	r17, r18		; 1450 2B12
			sts	0x008A, r17		; 1451 9310 008A
			ldi	r17, 0x00		; 1453 E010
			sts	0x0083, r17		; 1454 9310 0083
			sts	0x0082, r16		; 1456 9300 0082
			rjmp	avr1459		; 1458 C000
avr1459:	jmp	avr0093		; 1459 940C 0093

;----------------------------------------------------------------------
; here for IM code D0 ASSIGN
;
avr145B:	call	sub07D6		; 145B 940E 07D6 get desination type
			sts	0x04E1, r16		; 145D 9300 04E1
			call	sub07D6		; 145F 940E 07D6 get destination address
			sts	0x04DF, r16		; 1461 9300 04DF
			ldi	r16, 0x01		; 1463 E001 
			sts	0x04E0, r16		; 1464 9300 04E0 set to 0x100
			lds	r16, 0x04E1		; 1466 9100 04E1
			cpi	r16, 0x1B		; 1468 310B
			brne	avr146E		; 1469 F421
			call	sub07D6		; 146A 940E 07D6
			sts	0x04E2, r16		; 146C 9300 04E2 if bit variable get bit mask
avr146E:	call	sub07D6		; 146E 940E 07D6
			sbiw	XL, 0x01	; 1470 9711
			andi	r16, 0xF0	; 1471 7F00
			cpi	r16, 0xF0		; 1472 3F00
avr1473:	breq	avr1485		; 1473 F089

sub1474:	call	sub0B8B		; 1474 940E 0B8B
			mov	r18, r23		; 1476 2F27
			mov	r19, r24		; 1477 2F38
avr1478:	call	sub07D6		; 1478 940E 07D6
			cpi	r16, 0x00		; 147A 3000
			breq	avr1483		; 147B F039
			mov	r20, r16		; 147C 2F40
			call	sub0B8B		; 147D 940E 0B8B
			call	sub1487		; 147F 940E 1487
			jmp	avr1478		; 1481 940C 1478
avr1483:	call	sub14CD		; 1483 940E 14CD save in variable
avr1485:	jmp	avr0093		; 1485 940C 0093
;-------------------------------------------------------------------------
; Maths routines
sub1487:	cpi	r20, 0x21		; 1487 3241 r18, r19 carry the result
			breq	avr149C		; 1488 F099
			cpi	r20, 0x22		; 1489 3242
			breq	avr149F		; 148A F0A1
			cpi	r20, 0x23		; 148B 3243
			breq	avr14A2		; 148C F0A9
			cpi	r20, 0x24		; 148D 3244
			breq	avr14A7		; 148E F0C1
			cpi	r20, 0x26		; 148F 3246
			breq	avr14AC		; 1490 F0D9
			cpi	r20, 0x27		; 1491 3247
			breq	avr14B3		; 1492 F101
			cpi	r20, 0x28		; 1493 3248
			breq	avr14B6		; 1494 F109
			cpi	r20, 0x2A		; 1495 324A
			breq	avr14B9		; 1496 F111
			cpi	r20, 0x2C		; 1497 324C
			breq	avr14BC		; 1498 F119
			cpi	r20, 0x2D		; 1499 324D
			breq	avr14C4		; 149A F149
			rjmp	avr14CC		; 149B C030

avr149C:	add	r18, r23		; 149C 0F27 + routine
			adc	r19, r24		; 149D 1F38
			ret					; 149E 9508

avr149F:	sub	r18, r23		; 149F 1B27 - routine
			sbc	r19, r24		; 14A0 0B38
			ret					; 14A1 9508

avr14A2:	mov	r16, r23		; 14A2 2F07 * routine
			mov	r17, r24		; 14A3 2F18
			call	sub02EE		; 14A4 940E 02EE multiply
			ret					; 14A6 9508

avr14A7:	mov	r20, r23		; 14A7 2F47 / routine
			mov	r21, r24		; 14A8 2F58
			call	sub02FD		; 14A9 940E 02FD divide
			ret					; 14AB 9508

avr14AC:	mov	r20, r23		; 14AC 2F47 % routine
			mov	r21, r24		; 14AD 2F58
			call	sub02FD		; 14AE 940E 02FD divide
			mov	r18, r16		; 14B0 2F20
			mov	r19, r17		; 14B1 2F31
			ret					; 14B2 9508

avr14B3:	and	r18, r23		; 14B3 2327 AND routine
			and	r19, r24		; 14B4 2338
			ret					; 14B5 9508

avr14B6:	or	r18, r23		; 14B6 2B27 OR routine
			or	r19, r24		; 14B7 2B38
			ret					; 14B8 9508

avr14B9:	eor	r18, r23		; 14B9 2727 XOR routine
			eor	r19, r24		; 14BA 2738
			ret					; 14BB 9508

avr14BC:	tst	r23				; 14BC 2377 << routine
			breq	avr14C3		; 14BD F029
			clc					; 14BE 9488
			rol	r18				; 14BF 1F22
			rol	r19				; 14C0 1F33
			dec	r23				; 14C1 957A
			rjmp	avr14BC		; 14C2 CFF9
avr14C3:	ret					; 14C3 9508

avr14C4:	tst	r23				; 14C4 2377 >> routine
			breq	avr14CB		; 14C5 F029
			clc					; 14C6 9488
			ror	r19				; 14C7 9537
			ror	r18				; 14C8 9527
			dec	r23				; 14C9 957A
			rjmp	avr14C4		; 14CA CFF9
avr14CB:	ret					; 14CB 9508

avr14CC:	ret					; 14CC 9508


;-------------------------------------------------------------------------
; store result from r18 and r19 to variable

sub14CD:	lds	YH, 0x04E0		; 14CD 91D0 04E0
			lds	YL, 0x04DF		; 14CF 91C0 04DF
			lds	r16, 0x04E1		; 14D1 9100 04E1
			cpi	r16, 0x15		; 14D3 3105 byte variable ?

			breq	avr14DA		; 14D4 F029
			cpi	r16, 0x16		; 14D5 3106 int variable ?
			breq	avr14DC		; 14D6 F029
			cpi	r16, 0x1B		; 14D7 310B bit variable ?
			breq	avr14DF		; 14D8 F031
			ret					; 14D9 9508

avr14DA:	st	Y, r18			; 14DA 8328 byte
			ret					; 14DB 9508

avr14DC:	st	Y+, r18			; 14DC 9329 int
			st	Y, r19			; 14DD 8338
			ret					; 14DE 9508

avr14DF:	ld	r16, Y			; 14DF 8108 bit
			lds	r17, 0x04E2		; 14E0 9110 04E2
			cpi	r18, 0x00		; 14E2 3020
			brne	sub14EA		; 14E3 F431
			cpi	r19, 0x00		; 14E4 3030
			brne	sub14EA		; 14E5 F421
			com	r17				; 14E6 9510
			and	r16, r17		; 14E7 2301
			st	Y, r16			; 14E8 8308
			ret					; 14E9 9508

sub14EA:	or	r16, r17		; 14EA 2B01
			st	Y, r16			; 14EB 8308
			ret					; 14EC 9508

;-------------------------------------------------------------------------
;Here for IM code D1 OUT
;
avr14ED:	call	sub0B8B		; 14ED 940E 0B8B
			mov	r17, r23		; 14EF 2F17
			cpi	r17, 0x64		; 14F0 3614
			brlo	avr14F2		; 14F1 F000
avr14F2:	call	sub0B8B		; 14F2 940E 0B8B
; Here for port write
sub14F4:	tst	r23			; 14F4 2377

			brne	avr14F8		; 14F5 F411
			jmp	avr16B0		; 14F6 940C 16B0

avr14F8:	cpi	r17, 0x00		; 14F8 3010
			brne	avr14FE		; 14F9 F421
			sbi	DDRA, 0	; 14FA 9AD0
			sbi	PORTA, 0	; 14FB 9AD8
			jmp	avr1866		; 14FC 940C 1866

avr14FE:	cpi	r17, 0x01		; 14FE 3011
			brne	avr1504		; 14FF F421
			sbi	DDRA, 1	; 1500 9AD1
			sbi	PORTA, 1	; 1501 9AD9
			jmp	avr1866		; 1502 940C 1866

avr1504:	cpi	r17, 0x02		; 1504 3012
			brne	avr150A		; 1505 F421
			sbi	DDRA, 2	; 1506 9AD2
			sbi	PORTA, 2	; 1507 9ADA
			jmp	avr1866		; 1508 940C 1866

avr150A:	cpi	r17, 0x03		; 150A 3013
			brne	avr1510		; 150B F421
			sbi	DDRA, 3	; 150C 9AD3
			sbi	PORTA, 3	; 150D 9ADB
			jmp	avr1866		; 150E 940C 1866

avr1510:	cpi	r17, 0x04		; 1510 3014
			brne	avr1516		; 1511 F421
			sbi	DDRA, 4	; 1512 9AD4
			sbi	PORTA, 4	; 1513 9ADC
			jmp	avr1866		; 1514 940C 1866

avr1516:	cpi	r17, 0x05		; 1516 3015
			brne	avr151C		; 1517 F421
			sbi	DDRA, 5	; 1518 9AD5
			sbi	PORTA, 5	; 1519 9ADD
			jmp	avr1866		; 151A 940C 1866

avr151C:	cpi	r17, 0x06		; 151C 3016
			brne	avr1522		; 151D F421
			sbi	DDRA, 6	; 151E 9AD6
			sbi	PORTA, 6	; 151F 9ADE
			jmp	avr1866		; 1520 940C 1866

avr1522:	cpi	r17, 0x07		; 1522 3017
			brne	avr1528		; 1523 F421
			sbi	DDRA, 7	; 1524 9AD7
			sbi	PORTA, 7	; 1525 9ADF
			jmp	avr1866		; 1526 940C 1866

avr1528:	cpi	r17, 0x08		; 1528 3018
avr1529:	brne	avr152E		; 1529 F421
		sbi	DDRB, 0	; 152A 9AB8
avr152B:	sbi	PORTB, 0	; 152B 9AC0
		jmp	avr1866		; 152C 940C 1866
avr152E:	cpi	r17, 0x09		; 152E 3019
		brne	avr1534		; 152F F421
		sbi	DDRB, 1	; 1530 9AB9
avr1531:	sbi	PORTB, 1	; 1531 9AC1
avr1532:	jmp	avr1866		; 1532 940C 1866
avr1534:	cpi	r17, 0x0A		; 1534 301A
		brne	avr153A		; 1535 F421
		sbi	DDRB, 2	; 1536 9ABA
avr1537:	sbi	PORTB, 2	; 1537 9AC2
		jmp	avr1866		; 1538 940C 1866
avr153A:	cpi	r17, 0x0B		; 153A 301B
avr153B:	brne	avr1540		; 153B F421
		sbi	DDRB, 3	; 153C 9ABB
		sbi	PORTB, 3	; 153D 9AC3
		jmp	avr1866		; 153E 940C 1866
avr1540:	cpi	r17, 0x0C		; 1540 301C
		brne	avr1546		; 1541 F421
avr1542:	sbi	DDRB, 4	; 1542 9ABC
		sbi	PORTB, 4	; 1543 9AC4
avr1544:	jmp	avr1866		; 1544 940C 1866
avr1546:	cpi	r17, 0x0D		; 1546 301D
		brne	avr154C		; 1547 F421
		sbi	DDRB, 5	; 1548 9ABD
		sbi	PORTB, 5	; 1549 9AC5
avr154A:	jmp	avr1866		; 154A 940C 1866
avr154C:	cpi	r17, 0x0E		; 154C 301E
		brne	avr1552		; 154D F421
		sbi	DDRB, 6	; 154E 9ABE
		sbi	PORTB, 6	; 154F 9AC6
		jmp	avr1866		; 1550 940C 1866
avr1552:	cpi	r17, 0x0F		; 1552 301F
		brne	avr1558		; 1553 F421
avr1554:	sbi	DDRB, 7	; 1554 9ABF
avr1555:	sbi	PORTB, 7	; 1555 9AC7
		jmp	avr1866		; 1556 940C 1866
avr1558:	cpi	r17, 0x10		; 1558 3110
		brne	avr155E		; 1559 F421
		sbi	DDRC, 7	; 155A 9AA7
		sbi	PORTC, 7	; 155B 9AAF
		jmp	avr1866		; 155C 940C 1866
avr155E:	cpi	r17, 0x11		; 155E 3111
avr155F:	brne	avr1564		; 155F F421
		sbi	DDRC, 6	; 1560 9AA6
avr1561:	sbi	PORTC, 6	; 1561 9AAE
		jmp	avr1866		; 1562 940C 1866
avr1564:	cpi	r17, 0x12		; 1564 3112
avr1565:	brne	avr156A		; 1565 F421
avr1566:	sbi	DDRC, 5	; 1566 9AA5
		sbi	PORTC, 5	; 1567 9AAD
avr1568:	jmp	avr1866		; 1568 940C 1866
avr156A:	cpi	r17, 0x13		; 156A 3113
		brne	avr1570		; 156B F421
		sbi	DDRC, 4	; 156C 9AA4
		sbi	PORTC, 4	; 156D 9AAC
		jmp	avr1866		; 156E 940C 1866
avr1570:	cpi	r17, 0x14		; 1570 3114
		brne	avr1576		; 1571 F421
		sbi	DDRC, 3	; 1572 9AA3
avr1573:	sbi	PORTC, 3	; 1573 9AAB
		jmp	avr1866		; 1574 940C 1866
avr1576:	cpi	r17, 0x15		; 1576 3115
avr1577:	brne	avr157C		; 1577 F421
		sbi	DDRC, 2	; 1578 9AA2
		sbi	PORTC, 2	; 1579 9AAA
		jmp	avr1866		; 157A 940C 1866
avr157C:	cpi	r17, 0x16		; 157C 3116
		brne	avr1582		; 157D F421
;-------------------------------------------------------------------------
sub157E:	sbi	DDRC, 1	; 157E 9AA1
		sbi	PORTC, 1	; 157F 9AA9
		jmp	avr1866		; 1580 940C 1866
avr1582:	cpi	r17, 0x17		; 1582 3117
		brne	avr1588		; 1583 F421
;-------------------------------------------------------------------------
sub1584:	sbi	DDRC, 0	; 1584 9AA0
avr1585:	sbi	PORTC, 0	; 1585 9AA8
		jmp	avr1866		; 1586 940C 1866
avr1588:	cpi	r17, 0x18		; 1588 3118
		brne	avr158E		; 1589 F421
		sbi	$02, 7	; 158A 9A17
		sbi	$03, 7	; 158B 9A1F
		jmp	avr1866		; 158C 940C 1866
avr158E:	cpi	r17, 0x19		; 158E 3119
		brne	avr1594		; 158F F421
avr1590:	sbi	$02, 6	; 1590 9A16
		sbi	$03, 6	; 1591 9A1E
		jmp	avr1866		; 1592 940C 1866
avr1594:	cpi	r17, 0x1A		; 1594 311A
		brne	avr159A		; 1595 F421
avr1596:	sbi	DDRD, 7	; 1596 9A8F
		sbi	PORTD, 7	; 1597 9A97
		jmp	avr1866		; 1598 940C 1866
avr159A:	cpi	r17, 0x1B		; 159A 311B
		brne	avr15A0		; 159B F421
		sbi	DDRD, 6	; 159C 9A8E
avr159D:	sbi	PORTD, 6	; 159D 9A96
		jmp	avr1866		; 159E 940C 1866
avr15A0:	cpi	r17, 0x1C		; 15A0 311C
		brne	avr15A6		; 15A1 F421
		sbi	DDRD, 5	; 15A2 9A8D
		sbi	PORTD, 5	; 15A3 9A95
avr15A4:	jmp	avr1866		; 15A4 940C 1866
avr15A6:	cpi	r17, 0x1D		; 15A6 311D
		brne	avr15B4		; 15A7 F461
		lds	r16, 0x0064		; 15A8 9100 0064
		ori	r16, 0x04		; 15AA 6004
avr15AB:	sts	0x0064, r16		; 15AB 9300 0064
avr15AD:	lds	r16, 0x0065		; 15AD 9100 0065
		ori	r16, 0x04		; 15AF 6004
		sts	0x0065, r16		; 15B0 9300 0065
		jmp	avr1866		; 15B2 940C 1866
avr15B4:	cpi	r17, 0x1E		; 15B4 311E
		brne	avr15C2		; 15B5 F461
avr15B6:	lds	r16, 0x0064		; 15B6 9100 0064
		ori	r16, 0x02		; 15B8 6002
		sts	0x0064, r16		; 15B9 9300 0064
		lds	r16, 0x0065		; 15BB 9100 0065
		ori	r16, 0x02		; 15BD 6002
		sts	0x0065, r16		; 15BE 9300 0065
		jmp	avr1866		; 15C0 940C 1866
avr15C2:	cpi	r17, 0x1F		; 15C2 311F
avr15C3:	brne	avr15D0		; 15C3 F461
		lds	r16, 0x0064		; 15C4 9100 0064
		ori	r16, 0x01		; 15C6 6001
		sts	0x0064, r16		; 15C7 9300 0064
		lds	r16, 0x0065		; 15C9 9100 0065
		ori	r16, 0x01		; 15CB 6001
		sts	0x0065, r16		; 15CC 9300 0065
		jmp	avr1866		; 15CE 940C 1866
avr15D0:	cpi	r17, 0x20		; 15D0 3210
avr15D1:	brne	avr15DE		; 15D1 F461
		lds	r16, 0x0061		; 15D2 9100 0061
		ori	r16, 0x01		; 15D4 6001
		sts	0x0061, r16		; 15D5 9300 0061
		lds	r16, 0x0062		; 15D7 9100 0062
		ori	r16, 0x01		; 15D9 6001
avr15DA:	sts	0x0062, r16		; 15DA 9300 0062
avr15DC:	jmp	avr1866		; 15DC 940C 1866
avr15DE:	cpi	r17, 0x21		; 15DE 3211
		brne	avr15EC		; 15DF F461
		lds	r16, 0x0061		; 15E0 9100 0061
avr15E2:	ori	r16, 0x02		; 15E2 6002
		sts	0x0061, r16		; 15E3 9300 0061
		lds	r16, 0x0062		; 15E5 9100 0062
		ori	r16, 0x02		; 15E7 6002
		sts	0x0062, r16		; 15E8 9300 0062
		jmp	avr1866		; 15EA 940C 1866
avr15EC:	cpi	r17, 0x22		; 15EC 3212
		brne	avr15FA		; 15ED F461
		lds	r16, 0x0061		; 15EE 9100 0061
avr15F0:	ori	r16, 0x04		; 15F0 6004
		sts	0x0061, r16		; 15F1 9300 0061
		lds	r16, 0x0062		; 15F3 9100 0062
		ori	r16, 0x04		; 15F5 6004
		sts	0x0062, r16		; 15F6 9300 0062
		jmp	avr1866		; 15F8 940C 1866
avr15FA:	cpi	r17, 0x23		; 15FA 3213
		brne	avr1608		; 15FB F461
		lds	r16, 0x0061		; 15FC 9100 0061
		ori	r16, 0x08		; 15FE 6008
		sts	0x0061, r16		; 15FF 9300 0061
		lds	r16, 0x0062		; 1601 9100 0062
		ori	r16, 0x08		; 1603 6008
		sts	0x0062, r16		; 1604 9300 0062
		jmp	avr1866		; 1606 940C 1866
avr1608:	cpi	r17, 0x24		; 1608 3214
		brne	avr1616		; 1609 F461
		lds	r16, 0x0061		; 160A 9100 0061
		ori	r16, 0x10		; 160C 6100
		sts	0x0061, r16		; 160D 9300 0061
avr160F:	lds	r16, 0x0062		; 160F 9100 0062
		ori	r16, 0x10		; 1611 6100
		sts	0x0062, r16		; 1612 9300 0062
		jmp	avr1866		; 1614 940C 1866
avr1616:	cpi	r17, 0x25		; 1616 3215
		brne	avr1624		; 1617 F461
		lds	r16, 0x0061		; 1618 9100 0061
		ori	r16, 0x20		; 161A 6200
		sts	0x0061, r16		; 161B 9300 0061
avr161D:	lds	r16, 0x0062		; 161D 9100 0062
avr161F:	ori	r16, 0x20		; 161F 6200
		sts	0x0062, r16		; 1620 9300 0062
		jmp	avr1866		; 1622 940C 1866
avr1624:	cpi	r17, 0x26		; 1624 3216
		brne	avr1632		; 1625 F461
avr1626:	lds	r16, 0x0061		; 1626 9100 0061
avr1628:	ori	r16, 0x40		; 1628 6400
		sts	0x0061, r16		; 1629 9300 0061
		lds	r16, 0x0062		; 162B 9100 0062
		ori	r16, 0x40		; 162D 6400
avr162E:	sts	0x0062, r16		; 162E 9300 0062
		jmp	avr1866		; 1630 940C 1866
avr1632:	cpi	r17, 0x27		; 1632 3217
		brne	avr1640		; 1633 F461
		lds	r16, 0x0061		; 1634 9100 0061
		ori	r16, 0x80		; 1636 6800
		sts	0x0061, r16		; 1637 9300 0061
		lds	r16, 0x0062		; 1639 9100 0062
		ori	r16, 0x80		; 163B 6800
avr163C:	sts	0x0062, r16		; 163C 9300 0062
		jmp	avr1866		; 163E 940C 1866
avr1640:	cpi	r17, 0x28		; 1640 3218
		brne	avr1646		; 1641 F421
		sbi	DDRD, 2	; 1642 9A8A
avr1643:	sbi	PORTD, 2	; 1643 9A92
		jmp	avr1866		; 1644 940C 1866
avr1646:	cpi	r17, 0x29		; 1646 3219
		brne	avr164C		; 1647 F421
		sbi	DDRD, 3	; 1648 9A8B
		sbi	PORTD, 3	; 1649 9A93
		jmp	avr1866		; 164A 940C 1866
avr164C:	cpi	r17, 0x2A		; 164C 321A
		brne	avr1652		; 164D F421
avr164E:	sbi	DDRD, 4	; 164E 9A8C
		sbi	PORTD, 4	; 164F 9A94
		jmp	avr1866		; 1650 940C 1866
avr1652:	cpi	r17, 0x2B		; 1652 321B
		brne	avr1658		; 1653 F421
avr1654:	sbi	$02, 0	; 1654 9A10
		sbi	$03, 0	; 1655 9A18
		jmp	avr1866		; 1656 940C 1866
avr1658:	cpi	r17, 0x2C		; 1658 321C
		brne	avr165E		; 1659 F421
		sbi	$02, 1	; 165A 9A11
avr165B:	sbi	$03, 1	; 165B 9A19
		jmp	avr1866		; 165C 940C 1866
avr165E:	cpi	r17, 0x2D		; 165E 321D
		brne	avr1664		; 165F F421
		sbi	$02, 2	; 1660 9A12
		sbi	$03, 2	; 1661 9A1A
avr1662:	jmp	avr1866		; 1662 940C 1866
avr1664:	cpi	r17, 0x2E		; 1664 321E
		brne	avr166A		; 1665 F421
		sbi	$02, 3	; 1666 9A13
		sbi	$03, 3	; 1667 9A1B
		jmp	avr1866		; 1668 940C 1866
avr166A:	cpi	r17, 0x2F		; 166A 321F
avr166B:	brne	avr1670		; 166B F421
		sbi	$02, 4	; 166C 9A14
		sbi	$03, 4	; 166D 9A1C
		jmp	avr1866		; 166E 940C 1866
avr1670:	cpi	r17, 0x30		; 1670 3310
		brne	avr1676		; 1671 F421
avr1672:	sbi	$02, 5	; 1672 9A15
		sbi	$03, 5	; 1673 9A1D
avr1674:	jmp	avr1866		; 1674 940C 1866
avr1676:	cpi	r17, 0x31		; 1676 3311
		brne	avr1684		; 1677 F461
		lds	r16, 0x0064		; 1678 9100 0064
avr167A:	ori	r16, 0x08		; 167A 6008
		sts	0x0064, r16		; 167B 9300 0064
		lds	r16, 0x0065		; 167D 9100 0065
		ori	r16, 0x08		; 167F 6008
		sts	0x0065, r16		; 1680 9300 0065
		jmp	avr1866		; 1682 940C 1866
avr1684:	cpi	r17, 0x32		; 1684 3312
		brne	avr1692		; 1685 F461
		lds	r16, 0x0064		; 1686 9100 0064
avr1688:	ori	r16, 0x10		; 1688 6100
		sts	0x0064, r16		; 1689 9300 0064
		lds	r16, 0x0065		; 168B 9100 0065
		ori	r16, 0x10		; 168D 6100
		sts	0x0065, r16		; 168E 9300 0065
		jmp	avr1866		; 1690 940C 1866
avr1692:	cpi	r17, 0x33		; 1692 3313
		brne	avr16A0		; 1693 F461
		lds	r16, 0x0064		; 1694 9100 0064
		ori	r16, 0x08		; 1696 6008
		sts	0x0064, r16		; 1697 9300 0064
		lds	r16, 0x0065		; 1699 9100 0065
		ori	r16, 0x08		; 169B 6008
		sts	0x0065, r16		; 169C 9300 0065
		jmp	avr1866		; 169E 940C 1866
avr16A0:	cpi	r17, 0x34		; 16A0 3314
		brne	avr16AE		; 16A1 F461
		lds	r16, 0x0064		; 16A2 9100 0064
		ori	r16, 0x10		; 16A4 6100
		sts	0x0064, r16		; 16A5 9300 0064
avr16A7:	lds	r16, 0x0065		; 16A7 9100 0065
		ori	r16, 0x10		; 16A9 6100
		sts	0x0065, r16		; 16AA 9300 0065
		jmp	avr1866		; 16AC 940C 1866
avr16AE:	jmp	avr1866		; 16AE 940C 1866
avr16B0:	cpi	r17, 0x00		; 16B0 3010
		brne	avr16B6		; 16B1 F421
		sbi	DDRA, 0	; 16B2 9AD0
		cbi	PORTA, 0	; 16B3 98D8
		jmp	avr1866		; 16B4 940C 1866
avr16B6:	cpi	r17, 0x01		; 16B6 3011
		brne	avr16BC		; 16B7 F421
		sbi	DDRA, 1	; 16B8 9AD1
		cbi	PORTA, 1	; 16B9 98D9
		jmp	avr1866		; 16BA 940C 1866
avr16BC:	cpi	r17, 0x02		; 16BC 3012
		brne	avr16C2		; 16BD F421
		sbi	DDRA, 2	; 16BE 9AD2
		cbi	PORTA, 2	; 16BF 98DA
		jmp	avr1866		; 16C0 940C 1866
avr16C2:	cpi	r17, 0x03		; 16C2 3013
avr16C3:	brne	avr16C8		; 16C3 F421
		sbi	DDRA, 3	; 16C4 9AD3
		cbi	PORTA, 3	; 16C5 98DB
		jmp	avr1866		; 16C6 940C 1866
avr16C8:	cpi	r17, 0x04		; 16C8 3014
		brne	avr16CE		; 16C9 F421
		sbi	DDRA, 4	; 16CA 9AD4
avr16CB:	cbi	PORTA, 4	; 16CB 98DC
		jmp	avr1866		; 16CC 940C 1866
avr16CE:	cpi	r17, 0x05		; 16CE 3015
		brne	avr16D4		; 16CF F421
		sbi	DDRA, 5	; 16D0 9AD5
		cbi	PORTA, 5	; 16D1 98DD
		jmp	avr1866		; 16D2 940C 1866
avr16D4:	cpi	r17, 0x06		; 16D4 3016
avr16D5:	brne	avr16DA		; 16D5 F421
		sbi	DDRA, 6	; 16D6 9AD6
		cbi	PORTA, 6	; 16D7 98DE
		jmp	avr1866		; 16D8 940C 1866
avr16DA:	cpi	r17, 0x07		; 16DA 3017
		brne	avr16E0		; 16DB F421
avr16DC:	sbi	DDRA, 7	; 16DC 9AD7
		cbi	PORTA, 7	; 16DD 98DF
		jmp	avr1866		; 16DE 940C 1866
avr16E0:	cpi	r17, 0x08		; 16E0 3018
		brne	avr16E6		; 16E1 F421
		sbi	DDRB, 0	; 16E2 9AB8
		cbi	PORTB, 0	; 16E3 98C0
		jmp	avr1866		; 16E4 940C 1866
avr16E6:	cpi	r17, 0x09		; 16E6 3019
		brne	avr16EC		; 16E7 F421
		sbi	DDRB, 1	; 16E8 9AB9
		cbi	PORTB, 1	; 16E9 98C1
		jmp	avr1866		; 16EA 940C 1866
avr16EC:	cpi	r17, 0x0A		; 16EC 301A
		brne	avr16F2		; 16ED F421
		sbi	DDRB, 2	; 16EE 9ABA
		cbi	PORTB, 2	; 16EF 98C2
		jmp	avr1866		; 16F0 940C 1866
avr16F2:	cpi	r17, 0x0B		; 16F2 301B
		brne	avr16F8		; 16F3 F421
		sbi	DDRB, 3	; 16F4 9ABB
		cbi	PORTB, 3	; 16F5 98C3
		jmp	avr1866		; 16F6 940C 1866
avr16F8:	cpi	r17, 0x0C		; 16F8 301C
		brne	avr16FE		; 16F9 F421
avr16FA:	sbi	DDRB, 4	; 16FA 9ABC
		cbi	PORTB, 4	; 16FB 98C4
		jmp	avr1866		; 16FC 940C 1866
avr16FE:	cpi	r17, 0x0D		; 16FE 301D
		brne	avr1704		; 16FF F421
		sbi	DDRB, 5	; 1700 9ABD
		cbi	PORTB, 5	; 1701 98C5
avr1702:	jmp	avr1866		; 1702 940C 1866
avr1704:	cpi	r17, 0x0E		; 1704 301E
avr1705:	brne	avr170A		; 1705 F421
		sbi	DDRB, 6	; 1706 9ABE
		cbi	PORTB, 6	; 1707 98C6
		jmp	avr1866		; 1708 940C 1866
avr170A:	cpi	r17, 0x0F		; 170A 301F
		brne	avr1710		; 170B F421
avr170C:	sbi	DDRB, 7	; 170C 9ABF
		cbi	PORTB, 7	; 170D 98C7
		jmp	avr1866		; 170E 940C 1866
avr1710:	cpi	r17, 0x10		; 1710 3110
		brne	avr1716		; 1711 F421
		sbi	DDRC, 7	; 1712 9AA7
avr1713:	cbi	PORTC, 7	; 1713 98AF
		jmp	avr1866		; 1714 940C 1866
avr1716:	cpi	r17, 0x11		; 1716 3111
		brne	avr171C		; 1717 F421
		sbi	DDRC, 6	; 1718 9AA6
		cbi	PORTC, 6	; 1719 98AE
		jmp	avr1866		; 171A 940C 1866
avr171C:	cpi	r17, 0x12		; 171C 3112
		brne	avr1722		; 171D F421
		sbi	DDRC, 5	; 171E 9AA5
		cbi	PORTC, 5	; 171F 98AD
		jmp	avr1866		; 1720 940C 1866
avr1722:	cpi	r17, 0x13		; 1722 3113
		brne	avr1728		; 1723 F421
		sbi	DDRC, 4	; 1724 9AA4
		cbi	PORTC, 4	; 1725 98AC
		jmp	avr1866		; 1726 940C 1866
avr1728:	cpi	r17, 0x14		; 1728 3114
		brne	avr172E		; 1729 F421
		sbi	DDRC, 3	; 172A 9AA3
		cbi	PORTC, 3	; 172B 98AB
		jmp	avr1866		; 172C 940C 1866
avr172E:	cpi	r17, 0x15		; 172E 3115
avr172F:	brne	avr1734		; 172F F421
		sbi	DDRC, 2	; 1730 9AA2
avr1731:	cbi	PORTC, 2	; 1731 98AA
		jmp	avr1866		; 1732 940C 1866
avr1734:	cpi	r17, 0x16		; 1734 3116
		brne	avr173A		; 1735 F421
		sbi	DDRC, 1	; 1736 9AA1
		cbi	PORTC, 1	; 1737 98A9
		jmp	avr1866		; 1738 940C 1866
avr173A:	cpi	r17, 0x17		; 173A 3117
		brne	avr1740		; 173B F421
avr173C:	sbi	DDRC, 0	; 173C 9AA0
		cbi	PORTC, 0	; 173D 98A8
		jmp	avr1866		; 173E 940C 1866
avr1740:	cpi	r17, 0x18		; 1740 3118
		brne	avr1746		; 1741 F421
		sbi	$02, 7	; 1742 9A17
avr1743:	cbi	$03, 7	; 1743 981F
		jmp	avr1866		; 1744 940C 1866
avr1746:	cpi	r17, 0x19		; 1746 3119
		brne	avr174C		; 1747 F421
		sbi	$02, 6	; 1748 9A16
		cbi	$03, 6	; 1749 981E
avr174A:	jmp	avr1866		; 174A 940C 1866
avr174C:	cpi	r17, 0x1A		; 174C 311A
		brne	avr1752		; 174D F421
		sbi	DDRD, 7	; 174E 9A8F
		cbi	PORTD, 7	; 174F 9897
		jmp	avr1866		; 1750 940C 1866
avr1752:	cpi	r17, 0x1B		; 1752 311B
avr1753:	brne	avr1758		; 1753 F421
		sbi	DDRD, 6	; 1754 9A8E
		cbi	PORTD, 6	; 1755 9896
		jmp	avr1866		; 1756 940C 1866
avr1758:	cpi	r17, 0x1C		; 1758 311C
		brne	avr175E		; 1759 F421
		sbi	DDRD, 5	; 175A 9A8D
		cbi	PORTD, 5	; 175B 9895
		jmp	avr1866		; 175C 940C 1866
avr175E:	cpi	r17, 0x1D		; 175E 311D
		brne	avr176C		; 175F F461
		lds	r16, 0x0064		; 1760 9100 0064
		ori	r16, 0x04		; 1762 6004
		sts	0x0064, r16		; 1763 9300 0064
		lds	r16, 0x0065		; 1765 9100 0065
		andi	r16, 0xFB		; 1767 7F0B
		sts	0x0065, r16		; 1768 9300 0065
		jmp	avr1866		; 176A 940C 1866
avr176C:	cpi	r17, 0x1E		; 176C 311E
		brne	avr177A		; 176D F461
		lds	r16, 0x0064		; 176E 9100 0064
		ori	r16, 0x02		; 1770 6002
		sts	0x0064, r16		; 1771 9300 0064
		lds	r16, 0x0065		; 1773 9100 0065
		andi	r16, 0xFD		; 1775 7F0D
		sts	0x0065, r16		; 1776 9300 0065
		jmp	avr1866		; 1778 940C 1866
avr177A:	cpi	r17, 0x1F		; 177A 311F
		brne	avr1788		; 177B F461
		lds	r16, 0x0064		; 177C 9100 0064
		ori	r16, 0x01		; 177E 6001
		sts	0x0064, r16		; 177F 9300 0064
		lds	r16, 0x0065		; 1781 9100 0065
		andi	r16, 0xFE		; 1783 7F0E
		sts	0x0065, r16		; 1784 9300 0065
		jmp	avr1866		; 1786 940C 1866
avr1788:	cpi	r17, 0x20		; 1788 3210
			brne	avr1796		; 1789 F461
			lds	r16, 0x0061		; 178A 9100 0061
			ori	r16, 0x01		; 178C 6001
			sts	0x0061, r16		; 178D 9300 0061
			lds	r16, 0x0062		; 178F 9100 0062
			andi	r16, 0xFE	; 1791 7F0E
			sts	0x0062, r16		; 1792 9300 0062
			jmp	avr1866			; 1794 940C 1866

avr1796:	cpi	r17, 0x21		; 1796 3211
			brne	avr17A4		; 1797 F461
			lds	r16, 0x0061		; 1798 9100 0061
			ori	r16, 0x02		; 179A 6002
			sts	0x0061, r16		; 179B 9300 0061
			lds	r16, 0x0062		; 179D 9100 0062
			andi	r16, 0xFD	; 179F 7F0D
			sts	0x0062, r16		; 17A0 9300 0062
			jmp	avr1866			; 17A2 940C 1866

avr17A4:	cpi	r17, 0x22		; 17A4 3212
			brne	avr17B2		; 17A5 F461
			lds	r16, 0x0061		; 17A6 9100 0061
			ori	r16, 0x04		; 17A8 6004
			sts	0x0061, r16		; 17A9 9300 0061
			lds	r16, 0x0062		; 17AB 9100 0062
			andi	r16, 0xFB	; 17AD 7F0B
			sts	0x0062, r16		; 17AE 9300 0062
			jmp	avr1866			; 17B0 940C 1866
		
avr17B2:	cpi	r17, 0x23		; 17B2 3213
			brne	avr17C0		; 17B3 F461
			lds	r16, 0x0061		; 17B4 9100 0061
			ori	r16, 0x08		; 17B6 6008
			sts	0x0061, r16		; 17B7 9300 0061
			lds	r16, 0x0062		; 17B9 9100 0062
			andi	r16, 0xF7	; 17BB 7F07
			sts	0x0062, r16		; 17BC 9300 0062
			jmp	avr1866			; 17BE 940C 1866

avr17C0:	cpi	r17, 0x24		; 17C0 3214
			brne	avr17CE		; 17C1 F461
			lds	r16, 0x0061		; 17C2 9100 0061
			ori	r16, 0x10		; 17C4 6100
			sts	0x0061, r16		; 17C5 9300 0061
			lds	r16, 0x0062		; 17C7 9100 0062
			andi	r16, 0xEF	; 17C9 7E0F
			sts	0x0062, r16		; 17CA 9300 0062
			jmp	avr1866			; 17CC 940C 1866

avr17CE:	cpi	r17, 0x25		; 17CE 3215
			brne	avr17DC		; 17CF F461
			lds	r16, 0x0061		; 17D0 9100 0061
			ori	r16, 0x20		; 17D2 6200
			sts	0x0061, r16		; 17D3 9300 0061
			lds	r16, 0x0062		; 17D5 9100 0062
			andi	r16, 0xDF	; 17D7 7D0F
			sts	0x0062, r16		; 17D8 9300 0062
			jmp	avr1866			; 17DA 940C 1866

avr17DC:	cpi	r17, 0x26		; 17DC 3216
			brne	avr17EA		; 17DD F461
			lds	r16, 0x0061		; 17DE 9100 0061
			ori	r16, 0x40		; 17E0 6400
			sts	0x0061, r16		; 17E1 9300 0061
			lds	r16, 0x0062		; 17E3 9100 0062
			andi	r16, 0xBF	; 17E5 7B0F
			sts	0x0062, r16		; 17E6 9300 0062
			jmp	avr1866			; 17E8 940C 1866
	
avr17EA:	cpi	r17, 0x27		; 17EA 3217
			brne	avr17F8		; 17EB F461
			lds	r16, 0x0061		; 17EC 9100 0061
			ori	r16, 0x80		; 17EE 6800
			sts	0x0061, r16		; 17EF 9300 0061
			lds	r16, 0x0062		; 17F1 9100 0062
			andi	r16, 0x7F	; 17F3 770F
			sts	0x0062, r16		; 17F4 9300 0062
			jmp	avr1866			; 17F6 940C 1866
	
avr17F8:	cpi	r17, 0x28		; 17F8 3218
			brne	avr17FE		; 17F9 F421
			sbi	DDRD, 2			; 17FA 9A8A
			cbi	PORTD, 2		; 17FB 9892
			jmp	avr1866			; 17FC 940C 1866

avr17FE:	cpi	r17, 0x29		; 17FE 3219
			brne	avr1804		; 17FF F421
			sbi	DDRD, 3			; 1800 9A8B
			cbi	PORTD, 3		; 1801 9893
			jmp	avr1866			; 1802 940C 1866

avr1804:	cpi	r17, 0x2A		; 1804 321A
			brne	avr180A		; 1805 F421
			sbi	DDRD, 4			; 1806 9A8C
			cbi	PORTD, 4		; 1807 9894
			jmp	avr1866			; 1808 940C 1866

avr180A:	cpi	r17, 0x2B		; 180A 321B
			brne	avr1810		; 180B F421
			sbi	$02, 0			; 180C 9A10
			cbi	$03, 0			; 180D 9818
			jmp	avr1866			; 180E 940C 1866
		
avr1810:	cpi	r17, 0x2C		; 1810 321C
			brne	avr1816		; 1811 F421
			sbi	$02, 1			; 1812 9A11
			cbi	$03, 1			; 1813 9819
			jmp	avr1866			; 1814 940C 1866

avr1816:	cpi	r17, 0x2D		; 1816 321D
			brne	avr181C		; 1817 F421
			sbi	$02, 2			; 1818 9A12
			cbi	$03, 2			; 1819 981A
			jmp	avr1866			; 181A 940C 1866

avr181C:	cpi	r17, 0x2E		; 181C 321E
			brne	avr1822		; 181D F421
			sbi	$02, 3			; 181E 9A13
			cbi	$03, 3			; 181F 981B
			jmp	avr1866			; 1820 940C 1866

avr1822:	cpi	r17, 0x2F		; 1822 321F
			brne	avr1828		; 1823 F421
			sbi	$02, 4			; 1824 9A14
			cbi	$03, 4			; 1825 981C
			jmp	avr1866			; 1826 940C 1866

avr1828:	cpi	r17, 0x30		; 1828 3310
			brne	avr182E		; 1829 F421
			sbi	$02, 5			; 182A 9A15
			cbi	$03, 5			; 182B 981D
			jmp	avr1866			; 182C 940C 1866

avr182E:	cpi	r17, 0x31		; 182E 3311
			brne	avr183C		; 182F F461
			lds	r16, 0x0064		; 1830 9100 0064
			ori	r16, 0x08		; 1832 6008
			sts	0x0064, r16		; 1833 9300 0064
			lds	r16, 0x0065		; 1835 9100 0065
			andi	r16, 0xF7	; 1837 7F07
			sts	0x0065, r16		; 1838 9300 0065
			jmp	avr1866			; 183A 940C 1866

avr183C:	cpi	r17, 0x32		; 183C 3312
			brne	avr184A		; 183D F461
			lds	r16, 0x0064		; 183E 9100 0064
			ori	r16, 0x10		; 1840 6100
			sts	0x0064, r16		; 1841 9300 0064
			lds	r16, 0x0065		; 1843 9100 0065
			andi	r16, 0xEF	; 1845 7E0F
			sts	0x0065, r16		; 1846 9300 0065
			jmp	avr1866			; 1848 940C 1866

avr184A:	cpi	r17, 0x33		; 184A 3313
			brne	avr1858		; 184B F461
			lds	r16, 0x0064		; 184C 9100 0064
			ori	r16, 0x08		; 184E 6008
			sts	0x0064, r16		; 184F 9300 0064
			lds	r16, 0x0065		; 1851 9100 0065
			andi	r16, 0xF7		; 1853 7F07
			sts	0x0065, r16		; 1854 9300 0065
			jmp	avr1866			; 1856 940C 1866

avr1858:	cpi	r17, 0x34		; 1858 3314
			brne	avr1866		; 1859 F461
			lds	r16, 0x0064		; 185A 9100 0064
			ori	r16, 0x10		; 185C 6100
			sts	0x0064, r16		; 185D 9300 0064
			lds	r16, 0x0065		; 185F 9100 0065
			andi	r16, 0xEF	; 1861 7E0F
			sts	0x0065, r16		; 1862 9300 0065
			jmp	avr1866			; 1864 940C 1866

avr1866:	lds	r16, 0x04D2		; 1866 9100 04D2 Was this a serial command
			sbrc	r16, 5		; 1868 FD05
			ret				; 1869 9508

			jmp	avr0093		; 186A 940C 0093
;----------------------------------------------------------------------
; Here for IM code D2 PULSE

avr186C:	call	sub0B8B		; 186C 940E 0B8B 
			mov	r17, r23		; 186E 2F17

			cpi	r17, 0x00		; 186F 3010 0 = Port A0
			brne	avr187C		; 1870 F459
			sbi	DDRA, 0			; 1871 9AD0
			in	r16, PORTA		; 1872 B30B
			ldi	r17, 0x01		; 1873 E011
			eor	r16, r17		; 1874 2701
			out	PORTA, r16		; 1875 BB0B
			rcall	sub1AC7		; 1876 D250
			eor	r16, r17		; 1877 2701
			out	PORTA, r16		; 1878 BB0B
			ldi	ZH, 0x00		; 1879 E0F0
			ldi	ZL, 0x93		; 187A E9E3
			ijmp				; 187B 9409

avr187C:	cpi	r17, 0x01		; 187C 3011 1 = Port A1
			brne	avr1889		; 187D F459
			sbi	DDRA, 1			; 187E 9AD1
			in	r16, PORTA		; 187F B30B
			ldi	r17, 0x02		; 1880 E012
			eor	r16, r17		; 1881 2701
			out	PORTA, r16		; 1882 BB0B
			rcall	sub1AC7		; 1883 D243
			eor	r16, r17		; 1884 2701
			out	PORTA, r16		; 1885 BB0B
			ldi	ZH, 0x00		; 1886 E0F0
			ldi	ZL, 0x93		; 1887 E9E3
			ijmp				; 1888 9409

avr1889:	cpi	r17, 0x02		; 1889 3012 2 = Port A2
			brne	avr1896		; 188A F459
			sbi	DDRA, 2			; 188B 9AD2
			in	r16, PORTA		; 188C B30B
			ldi	r17, 0x04		; 188D E014
			eor	r16, r17		; 188E 2701
			out	PORTA, r16		; 188F BB0B
			rcall	sub1AC7		; 1890 D236
			eor	r16, r17		; 1891 2701
			out	PORTA, r16		; 1892 BB0B
			ldi	ZH, 0x00		; 1893 E0F0
			ldi	ZL, 0x93		; 1894 E9E3
			ijmp				; 1895 9409

avr1896:	cpi	r17, 0x03		; 1896 3013 3 = Port A3
			brne	avr18A3		; 1897 F459
			sbi	DDRA, 3			; 1898 9AD3
			in	r16, PORTA		; 1899 B30B
			ldi	r17, 0x08		; 189A E018
			eor	r16, r17		; 189B 2701
			out	PORTA, r16		; 189C BB0B
			rcall	sub1AC7		; 189D D229
			eor	r16, r17		; 189E 2701
			out	PORTA, r16		; 189F BB0B
			ldi	ZH, 0x00		; 18A0 E0F0
			ldi	ZL, 0x93		; 18A1 E9E3
			ijmp				; 18A2 9409

avr18A3:	cpi	r17, 0x04		; 18A3 3014 4 = Port A4
			brne	avr18B0		; 18A4 F459
			sbi	DDRA, 4			; 18A5 9AD4
			in	r16, PORTA		; 18A6 B30B
			ldi	r17, 0x10		; 18A7 E110
			eor	r16, r17		; 18A8 2701
			out	PORTA, r16		; 18A9 BB0B
			rcall	sub1AC7		; 18AA D21C
			eor	r16, r17		; 18AB 2701
			out	PORTA, r16		; 18AC BB0B
			ldi	ZH, 0x00		; 18AD E0F0
			ldi	ZL, 0x93		; 18AE E9E3
			ijmp				; 18AF 9409

avr18B0:	cpi	r17, 0x05		; 18B0 3015 5 = Port A5
			brne	avr18BD		; 18B1 F459
			sbi	DDRA, 5			; 18B2 9AD5
			in	r16, PORTA		; 18B3 B30B
			ldi	r17, 0x20		; 18B4 E210
			eor	r16, r17		; 18B5 2701
			out	PORTA, r16		; 18B6 BB0B
			rcall	sub1AC7		; 18B7 D20F
			eor	r16, r17		; 18B8 2701
			out	PORTA, r16		; 18B9 BB0B
			ldi	ZH, 0x00		; 18BA E0F0
			ldi	ZL, 0x93		; 18BB E9E3
			ijmp				; 18BC 9409

avr18BD:	cpi	r17, 0x06		; 18BD 3016 6 = Port A6
			brne	avr18CA		; 18BE F459
			sbi	DDRA, 6			; 18BF 9AD6
			in	r16, PORTA		; 18C0 B30B
			ldi	r17, 0x40		; 18C1 E410
			eor	r16, r17		; 18C2 2701
			out	PORTA, r16		; 18C3 BB0B
			rcall	sub1AC7		; 18C4 D202
			eor	r16, r17		; 18C5 2701
			out	PORTA, r16		; 18C6 BB0B
			ldi	ZH, 0x00		; 18C7 E0F0
			ldi	ZL, 0x93		; 18C8 E9E3
			ijmp				; 18C9 9409

avr18CA:	cpi	r17, 0x07		; 18CA 3017 7 = Port A7
			brne	avr18D7		; 18CB F459
			sbi	DDRA, 7			; 18CC 9AD7
			in	r16, PORTA		; 18CD B30B
			ldi	r17, 0x80		; 18CE E810
			eor	r16, r17		; 18CF 2701
			out	PORTA, r16		; 18D0 BB0B
			rcall	sub1AC7		; 18D1 D1F5
			eor	r16, r17		; 18D2 2701
			out	PORTA, r16		; 18D3 BB0B
			ldi	ZH, 0x00		; 18D4 E0F0
			ldi	ZL, 0x93		; 18D5 E9E3
			ijmp				; 18D6 9409

avr18D7:	cpi	r17, 0x08		; 18D7 3018 8 = Port B0
			brne	avr18E4		; 18D8 F459
			sbi	DDRB, 0			; 18D9 9AB8
			in	r16, PORTB		; 18DA B308
			ldi	r17, 0x01		; 18DB E011
			eor	r16, r17		; 18DC 2701
			out	PORTB, r16		; 18DD BB08
			rcall	sub1AC7		; 18DE D1E8
			eor	r16, r17		; 18DF 2701
			out	PORTB, r16		; 18E0 BB08
			ldi	ZH, 0x00		; 18E1 E0F0
			ldi	ZL, 0x93		; 18E2 E9E3
			ijmp				; 18E3 9409

avr18E4:	cpi	r17, 0x09		; 18E4 3019 9 = Port B1
			brne	avr18F1		; 18E5 F459
			sbi	DDRB, 1			; 18E6 9AB9
			in	r16, PORTB		; 18E7 B308
			ldi	r17, 0x02		; 18E8 E012
			eor	r16, r17		; 18E9 2701
			out	PORTB, r16		; 18EA BB08
			rcall	sub1AC7		; 18EB D1DB
			eor	r16, r17		; 18EC 2701
			out	PORTB, r16		; 18ED BB08
			ldi	ZH, 0x00		; 18EE E0F0
			ldi	ZL, 0x93		; 18EF E9E3
			ijmp				; 18F0 9409

avr18F1:	cpi	r17, 0x0A		; 18F1 301A a = Port B2
			brne	avr18FE		; 18F2 F459
			sbi	DDRB, 2			; 18F3 9ABA
			in	r16, PORTB		; 18F4 B308
			ldi	r17, 0x04		; 18F5 E014
			eor	r16, r17		; 18F6 2701
			out	PORTB, r16		; 18F7 BB08
			rcall	sub1AC7		; 18F8 D1CE
			eor	r16, r17		; 18F9 2701
			out	PORTB, r16		; 18FA BB08
			ldi	ZH, 0x00		; 18FB E0F0
			ldi	ZL, 0x93		; 18FC E9E3
			ijmp				; 18FD 9409

avr18FE:	cpi	r17, 0x0B		; 18FE 301B B = Port B3
			brne	avr190B		; 18FF F459
			sbi	DDRB, 3			; 1900 9ABB
			in	r16, PORTB		; 1901 B308
			ldi	r17, 0x08		; 1902 E018
			eor	r16, r17		; 1903 2701
			out	PORTB, r16		; 1904 BB08
			rcall	sub1AC7		; 1905 D1C1
			eor	r16, r17		; 1906 2701
			out	PORTB, r16		; 1907 BB08
			ldi	ZH, 0x00		; 1908 E0F0
			ldi	ZL, 0x93		; 1909 E9E3
			ijmp				; 190A 9409
	
avr190B:	cpi	r17, 0x0C		; 190B 301C C = Port B4
			brne	avr1918		; 190C F459
			sbi	DDRB, 4			; 190D 9ABC
			in	r16, PORTB		; 190E B308
			ldi	r17, 0x10		; 190F E110
			eor	r16, r17		; 1910 2701
			out	PORTB, r16		; 1911 BB08
			rcall	sub1AC7		; 1912 D1B4
			eor	r16, r17		; 1913 2701
			out	PORTB, r16		; 1914 BB08
			ldi	ZH, 0x00		; 1915 E0F0
			ldi	ZL, 0x93		; 1916 E9E3
			ijmp				; 1917 9409

avr1918:	cpi	r17, 0x0D		; 1918 301D D = Port B5
			brne	avr1925		; 1919 F459
			sbi	DDRB, 5			; 191A 9ABD
			in	r16, PORTB		; 191B B308
			ldi	r17, 0x20		; 191C E210
			eor	r16, r17		; 191D 2701
			out	PORTB, r16		; 191E BB08
			rcall	sub1AC7		; 191F D1A7
			eor	r16, r17		; 1920 2701
			out	PORTB, r16		; 1921 BB08
			ldi	ZH, 0x00		; 1922 E0F0
			ldi	ZL, 0x93		; 1923 E9E3
			ijmp				; 1924 9409

avr1925:	cpi	r17, 0x0E		; 1925 301E E = Port B6
			brne	avr1932		; 1926 F459
			sbi	DDRB, 6			; 1927 9ABE
			in	r16, PORTB		; 1928 B308
			ldi	r17, 0x40		; 1929 E410
			eor	r16, r17		; 192A 2701
			out	PORTB, r16		; 192B BB08
			rcall	sub1AC7		; 192C D19A
			eor	r16, r17		; 192D 2701
			out	PORTB, r16		; 192E BB08
			ldi	ZH, 0x00		; 192F E0F0
			ldi	ZL, 0x93		; 1930 E9E3
			ijmp				; 1931 9409

avr1932:	cpi	r17, 0x0F		; 1932 301F F = Port B7
			brne	avr193F		; 1933 F459
			sbi	DDRB, 7			; 1934 9ABF
			in	r16, PORTB		; 1935 B308
			ldi	r17, 0x80		; 1936 E810
			eor	r16, r17		; 1937 2701
			out	PORTB, r16		; 1938 BB08
			rcall	sub1AC7		; 1939 D18D
			eor	r16, r17		; 193A 2701
			out	PORTB, r16		; 193B BB08
			ldi	ZH, 0x00		; 193C E0F0
			ldi	ZL, 0x93		; 193D E9E3
			ijmp				; 193E 9409

avr193F:	cpi	r17, 0x10		; 193F 3110 10 = Port C7
			brne	avr194C		; 1940 F459
			sbi	DDRC, 7			; 1941 9AA7
			in	r16, PORTC		; 1942 B305
			ldi	r17, 0x80		; 1943 E810
			eor	r16, r17		; 1944 2701
			out	PORTC, r16		; 1945 BB05
			rcall	sub1AC7		; 1946 D180
			eor	r16, r17		; 1947 2701
			out	PORTC, r16		; 1948 BB05
			ldi	ZH, 0x00		; 1949 E0F0
			ldi	ZL, 0x93		; 194A E9E3
			ijmp				; 194B 9409

avr194C:	cpi	r17, 0x11		; 194C 3111 11 = Port C6
			brne	avr1959		; 194D F459
			sbi	DDRC, 6			; 194E 9AA6
			in	r16, PORTC		; 194F B305
			ldi	r17, 0x40		; 1950 E410
			eor	r16, r17		; 1951 2701
			out	PORTC, r16		; 1952 BB05
			rcall	sub1AC7		; 1953 D173
			eor	r16, r17		; 1954 2701
			out	PORTC, r16		; 1955 BB05
			ldi	ZH, 0x00		; 1956 E0F0
			ldi	ZL, 0x93		; 1957 E9E3
			ijmp				; 1958 9409

avr1959:	cpi	r17, 0x12		; 1959 3112 12 = Port C5
			brne	avr1966		; 195A F459
			sbi	DDRC, 5			; 195B 9AA5
			in	r16, PORTC		; 195C B305
			ldi	r17, 0x20		; 195D E210
			eor	r16, r17		; 195E 2701
			out	PORTC, r16		; 195F BB05
			rcall	sub1AC7		; 1960 D166
			eor	r16, r17		; 1961 2701
			out	PORTC, r16		; 1962 BB05
			ldi	ZH, 0x00		; 1963 E0F0
			ldi	ZL, 0x93		; 1964 E9E3
			ijmp				; 1965 9409

avr1966:	cpi	r17, 0x13		; 1966 3113 13 = Port C4
			brne	avr1973		; 1967 F459
			sbi	DDRC, 4			; 1968 9AA4
			in	r16, PORTC		; 1969 B305
			ldi	r17, 0x10		; 196A E110
			eor	r16, r17		; 196B 2701
			out	PORTC, r16		; 196C BB05
			rcall	sub1AC7		; 196D D159
			eor	r16, r17		; 196E 2701
			out	PORTC, r16		; 196F BB05
			ldi	ZH, 0x00		; 1970 E0F0
			ldi	ZL, 0x93		; 1971 E9E3
			ijmp				; 1972 9409

avr1973:	cpi	r17, 0x14		; 1973 3114 14 = Port C3
			brne	avr1980		; 1974 F459
			sbi	DDRC, 3			; 1975 9AA3
			in	r16, PORTC		; 1976 B305
			ldi	r17, 0x08		; 1977 E018
			eor	r16, r17		; 1978 2701
			out	PORTC, r16		; 1979 BB05
			rcall	sub1AC7		; 197A D14C
			eor	r16, r17		; 197B 2701
			out	PORTC, r16		; 197C BB05
			ldi	ZH, 0x00		; 197D E0F0
			ldi	ZL, 0x93		; 197E E9E3
			ijmp				; 197F 9409

avr1980:	cpi	r17, 0x15		; 1980 3115 15= Port C2
			brne	avr198D		; 1981 F459
			sbi	DDRC, 2			; 1982 9AA2
			in	r16, PORTC		; 1983 B305
			ldi	r17, 0x04		; 1984 E014
			eor	r16, r17		; 1985 2701
			out	PORTC, r16		; 1986 BB05
			rcall	sub1AC7		; 1987 D13F
			eor	r16, r17		; 1988 2701
			out	PORTC, r16		; 1989 BB05
			ldi	ZH, 0x00		; 198A E0F0
			ldi	ZL, 0x93		; 198B E9E3
			ijmp				; 198C 9409

avr198D:	cpi	r17, 0x16		; 198D 3116 16= Port C1
			brne	avr199A		; 198E F459
			sbi	DDRC, 1			; 198F 9AA1
			in	r16, PORTC		; 1990 B305
			ldi	r17, 0x02		; 1991 E012
			eor	r16, r17		; 1992 2701
			out	PORTC, r16		; 1993 BB05
			rcall	sub1AC7		; 1994 D132
			eor	r16, r17		; 1995 2701
			out	PORTC, r16		; 1996 BB05
			ldi	ZH, 0x00		; 1997 E0F0
			ldi	ZL, 0x93		; 1998 E9E3
			ijmp				; 1999 9409

avr199A:	cpi	r17, 0x17		; 199A 3117 17= Port C0
			brne	avr19A7		; 199B F459
			sbi	DDRC, 0			; 199C 9AA0
			in	r16, PORTC		; 199D B305
			ldi	r17, 0x01		; 199E E011
			eor	r16, r17		; 199F 2701
			out	PORTC, r16		; 19A0 BB05
			rcall	sub1AC7		; 19A1 D125
			eor	r16, r17		; 19A2 2701
			out	PORTC, r16		; 19A3 BB05
			ldi	ZH, 0x00		; 19A4 E0F0
			ldi	ZL, 0x93		; 19A5 E9E3
			ijmp				; 19A6 9409

avr19A7:	cpi	r17, 0x18		; 19A7 3118 18 = Port E7
			brne	avr19B4		; 19A8 F459
			sbi	$02, 7			; 19A9 9A17
			in	r16, $03		; 19AA B103
			ldi	r17, 0x80		; 19AB E810
			eor	r16, r17		; 19AC 2701
			out	$03, r16		; 19AD B903
			rcall	sub1AC7		; 19AE D118
			eor	r16, r17		; 19AF 2701
			out	$03, r16		; 19B0 B903
			ldi	ZH, 0x00		; 19B1 E0F0
			ldi	ZL, 0x93		; 19B2 E9E3
			ijmp				; 19B3 9409

avr19B4:	cpi	r17, 0x19		; 19B4 3119 19 = Port E6
			brne	avr19C1		; 19B5 F459
			sbi	$02, 6			; 19B6 9A16
			in	r16, $03		; 19B7 B103
			ldi	r17, 0x40		; 19B8 E410
			eor	r16, r17		; 19B9 2701
			out	$03, r16		; 19BA B903
			rcall	sub1AC7		; 19BB D10B
			eor	r16, r17		; 19BC 2701
			out	$03, r16		; 19BD B903
			ldi	ZH, 0x00		; 19BE E0F0
			ldi	ZL, 0x93		; 19BF E9E3
			ijmp				; 19C0 9409

avr19C1:	cpi	r17, 0x1A		; 19C1 311A 1A= Port D7
			brne	avr19CE		; 19C2 F459
			sbi	DDRD, 7			; 19C3 9A8F
			in	r16, PORTD		; 19C4 B302
			ldi	r17, 0x80		; 19C5 E810
			eor	r16, r17		; 19C6 2701
			out	PORTD, r16		; 19C7 BB02
			rcall	sub1AC7		; 19C8 D0FE
			eor	r16, r17		; 19C9 2701
			out	PORTD, r16		; 19CA BB02
			ldi	ZH, 0x00		; 19CB E0F0
			ldi	ZL, 0x93		; 19CC E9E3
			ijmp				; 19CD 9409

avr19CE:	cpi	r17, 0x1B		; 19CE 311B 1B = Port E6
			brne	avr19DB		; 19CF F459
			sbi	$02, 6			; 19D0 9A16
			in	r16, $03		; 19D1 B103
			ldi	r17, 0x40		; 19D2 E410
			eor	r16, r17		; 19D3 2701
			out	$03, r16		; 19D4 B903
			rcall	sub1AC7		; 19D5 D0F1
			eor	r16, r17		; 19D6 2701
			out	$03, r16		; 19D7 B903
			ldi	ZH, 0x00		; 19D8 E0F0
			ldi	ZL, 0x93		; 19D9 E9E3
			ijmp				; 19DA 9409

avr19DB:	cpi	r17, 0x1C		; 19DB 311C  1C= Port E5
			brne	avr19E8		; 19DC F459
			sbi	$02, 5			; 19DD 9A15
			in	r16, $03		; 19DE B103
			ldi	r17, 0x20		; 19DF E210
			eor	r16, r17		; 19E0 2701
			out	$03, r16		; 19E1 B903
			rcall	sub1AC7		; 19E2 D0E4
			eor	r16, r17		; 19E3 2701
			out	$03, r16		; 19E4 B903
			ldi	ZH, 0x00		; 19E5 E0F0
			ldi	ZL, 0x93		; 19E6 E9E3
			ijmp				; 19E7 9409

avr19E8:	cpi	r17, 0x1D		; 19E8 311D 1D = Port G2
			brne	avr19FC		; 19E9 F491
			lds	r16, 0x0064		; 19EA 9100 0064
			ori	r16, 0x04		; 19EC 6004
			sts	0x0064, r16		; 19ED 9300 0064
			lds	r16, 0x0065		; 19EF 9100 0065
			ldi	r17, 0x04		; 19F1 E014
			eor	r16, r17		; 19F2 2701
			sts	0x0065, r16		; 19F3 9300 0065
			rcall	sub1AC7		; 19F5 D0D1
			eor	r16, r17		; 19F6 2701
			sts	0x0065, r16		; 19F7 9300 0065
			ldi	ZH, 0x00		; 19F9 E0F0
			ldi	ZL, 0x93		; 19FA E9E3
			ijmp				; 19FB 9409

avr19FC:	cpi	r17, 0x1E		; 19FC 311E 1E = Port G1
			brne	avr1A10		; 19FD F491
			lds	r16, 0x0064		; 19FE 9100 0064
			ori	r16, 0x02		; 1A00 6002
			sts	0x0064, r16		; 1A01 9300 0064
			lds	r16, 0x0065		; 1A03 9100 0065
			ldi	r17, 0x02		; 1A05 E012
			eor	r16, r17		; 1A06 2701
			sts	0x0065, r16		; 1A07 9300 0065
			rcall	sub1AC7		; 1A09 D0BD
			eor	r16, r17		; 1A0A 2701
			sts	0x0065, r16		; 1A0B 9300 0065
			ldi	ZH, 0x00		; 1A0D E0F0
			ldi	ZL, 0x93		; 1A0E E9E3
			ijmp				; 1A0F 9409

avr1A10:	cpi	r17, 0x1F		; 1A10 311F 1F = Port G0
			brne	avr1A24		; 1A11 F491
			lds	r16, 0x0064		; 1A12 9100 0064
			ori	r16, 0x01		; 1A14 6001
			sts	0x0064, r16		; 1A15 9300 0064
			lds	r16, 0x0065		; 1A17 9100 0065
			ldi	r17, 0x01		; 1A19 E011
			eor	r16, r17		; 1A1A 2701
			sts	0x0065, r16		; 1A1B 9300 0065
			rcall	sub1AC7		; 1A1D D0A9
			eor	r16, r17		; 1A1E 2701
			sts	0x0065, r16		; 1A1F 9300 0065
			ldi	ZH, 0x00		; 1A21 E0F0
			ldi	ZL, 0x93		; 1A22 E9E3
			ijmp				; 1A23 9409

avr1A24:	cpi	r17, 0x20		; 1A24 3210 20 = Port F0
			brne	avr1A38		; 1A25 F491
			lds	r16, 0x0061		; 1A26 9100 0061
			ori	r16, 0x01		; 1A28 6001
			sts	0x0061, r16		; 1A29 9300 0061
			lds	r16, 0x0062		; 1A2B 9100 0062
			ldi	r17, 0x01		; 1A2D E011
			eor	r16, r17		; 1A2E 2701
			sts	0x0062, r16		; 1A2F 9300 0062
			rcall	sub1AC7		; 1A31 D095
			eor	r16, r17		; 1A32 2701
			sts	0x0062, r16		; 1A33 9300 0062
			ldi	ZH, 0x00		; 1A35 E0F0
			ldi	ZL, 0x93		; 1A36 E9E3
			ijmp				; 1A37 9409

avr1A38:	cpi	r17, 0x21		; 1A38 3211 21 = Port F1
			brne	avr1A4C		; 1A39 F491
			lds	r16, 0x0061		; 1A3A 9100 0061
			ori	r16, 0x02		; 1A3C 6002
			sts	0x0061, r16		; 1A3D 9300 0061
			lds	r16, 0x0062		; 1A3F 9100 0062
			ldi	r17, 0x02		; 1A41 E012
			eor	r16, r17		; 1A42 2701
			sts	0x0062, r16		; 1A43 9300 0062
			rcall	sub1AC7		; 1A45 D081
			eor	r16, r17		; 1A46 2701
			sts	0x0062, r16		; 1A47 9300 0062
			ldi	ZH, 0x00		; 1A49 E0F0
			ldi	ZL, 0x93		; 1A4A E9E3
			ijmp				; 1A4B 9409

avr1A4C:	cpi	r17, 0x22		; 1A4C 3212 22 = Port F2
			brne	avr1A60		; 1A4D F491
			lds	r16, 0x0061		; 1A4E 9100 0061
			ori	r16, 0x04		; 1A50 6004
			sts	0x0061, r16		; 1A51 9300 0061
			lds	r16, 0x0062		; 1A53 9100 0062
			ldi	r17, 0x04		; 1A55 E014
			eor	r16, r17		; 1A56 2701
			sts	0x0062, r16		; 1A57 9300 0062
			rcall	sub1AC7		; 1A59 D06D
			eor	r16, r17		; 1A5A 2701
			sts	0x0062, r16		; 1A5B 9300 0062
			ldi	ZH, 0x00		; 1A5D E0F0
			ldi	ZL, 0x93		; 1A5E E9E3
			ijmp				; 1A5F 9409
	
avr1A60:	cpi	r17, 0x23		; 1A60 3213 23 = Port F3
			brne	avr1A74		; 1A61 F491
			lds	r16, 0x0061		; 1A62 9100 0061
			ori	r16, 0x08		; 1A64 6008
			sts	0x0061, r16		; 1A65 9300 0061
			lds	r16, 0x0062		; 1A67 9100 0062
			ldi	r17, 0x08		; 1A69 E018
			eor	r16, r17		; 1A6A 2701
			sts	0x0062, r16		; 1A6B 9300 0062
			rcall	sub1AC7		; 1A6D D059
			eor	r16, r17		; 1A6E 2701
			sts	0x0062, r16		; 1A6F 9300 0062
			ldi	ZH, 0x00		; 1A71 E0F0
			ldi	ZL, 0x93		; 1A72 E9E3
			ijmp				; 1A73 9409

avr1A74:	cpi	r17, 0x24		; 1A74 3214 24 = Port F4
			brne	avr1A88		; 1A75 F491
			lds	r16, 0x0061		; 1A76 9100 0061
			ori	r16, 0x10		; 1A78 6100
			sts	0x0061, r16		; 1A79 9300 0061
			lds	r16, 0x0062		; 1A7B 9100 0062
			ldi	r17, 0x10		; 1A7D E110
			eor	r16, r17		; 1A7E 2701
			sts	0x0062, r16		; 1A7F 9300 0062
			rcall	sub1AC7		; 1A81 D045
			eor	r16, r17		; 1A82 2701
			sts	0x0062, r16		; 1A83 9300 0062
			ldi	ZH, 0x00		; 1A85 E0F0
			ldi	ZL, 0x93		; 1A86 E9E3
			ijmp				; 1A87 9409

avr1A88:	cpi	r17, 0x25		; 1A88 3215 25 = Port F5
			brne	avr1A9C		; 1A89 F491
			lds	r16, 0x0061		; 1A8A 9100 0061
			ori	r16, 0x20		; 1A8C 6200
			sts	0x0061, r16		; 1A8D 9300 0061
			lds	r16, 0x0062		; 1A8F 9100 0062
			ldi	r17, 0x20		; 1A91 E210
			eor	r16, r17		; 1A92 2701
			sts	0x0062, r16		; 1A93 9300 0062
			rcall	sub1AC7		; 1A95 D031
			eor	r16, r17		; 1A96 2701
			sts	0x0062, r16		; 1A97 9300 0062
			ldi	ZH, 0x00		; 1A99 E0F0
			ldi	ZL, 0x93		; 1A9A E9E3
			ijmp				; 1A9B 9409

avr1A9C:	cpi	r17, 0x26		; 1A9C 3216 26 = Port F6
			brne	avr1AB0		; 1A9D F491
			lds	r16, 0x0061		; 1A9E 9100 0061
			ori	r16, 0x40		; 1AA0 6400
			sts	0x0061, r16		; 1AA1 9300 0061
			lds	r16, 0x0062		; 1AA3 9100 0062
			ldi	r17, 0x40		; 1AA5 E410
			eor	r16, r17		; 1AA6 2701
			sts	0x0062, r16		; 1AA7 9300 0062
			rcall	sub1AC7		; 1AA9 D01D
			eor	r16, r17		; 1AAA 2701
			sts	0x0062, r16		; 1AAB 9300 0062
			ldi	ZH, 0x00		; 1AAD E0F0
			ldi	ZL, 0x93		; 1AAE E9E3
			ijmp				; 1AAF 9409

avr1AB0:	cpi	r17, 0x27		; 1AB0 3217 27 = Port F7
			brne	avr1AC4		; 1AB1 F491
			lds	r16, 0x0061		; 1AB2 9100 0061
			ori	r16, 0x80		; 1AB4 6800
			sts	0x0061, r16		; 1AB5 9300 0061
			lds	r16, 0x0062		; 1AB7 9100 0062
			ldi	r17, 0x80		; 1AB9 E810
			eor	r16, r17		; 1ABA 2701
			sts	0x0062, r16		; 1ABB 9300 0062
			rcall	sub1AC7		; 1ABD D009
			eor	r16, r17		; 1ABE 2701
			sts	0x0062, r16		; 1ABF 9300 0062
			ldi	ZH, 0x00		; 1AC1 E0F0
			ldi	ZL, 0x93		; 1AC2 E9E3
			ijmp				; 1AC3 9409

avr1AC4:	ldi	ZH, 0x00		; 1AC4 E0F0
			ldi	ZL, 0x93		; 1AC5 E9E3
			ijmp				; 1AC6 9409
;-------------------------------------------------------------------------
; Delay for pulse routine

sub1AC7:	ldi	r18, 0x05		; 1AC7 E025
avr1AC8:	dec	r18			; 1AC8 952A
			brne	avr1AC8		; 1AC9 F7F1
			ret				; 1ACA 9508
;-------------------------------------------------------------------------
; Here for IM code D3 TOGGLE

avr1ACB:	call	sub0B8B		; 1ACB 940E 0B8B
			mov	r17, r23		; 1ACD 2F17

			cpi	r17, 0x00		; 1ACE 3010
			brne	avr1AD8		; 1ACF F441
			in	r16, PORTA		; 1AD0 B30B
			ldi	r18, 0x01		; 1AD1 E021
			eor	r16, r18		; 1AD2 2702
			out	PORTA, r16		; 1AD3 BB0B
			sbi	DDRA, 0			; 1AD4 9AD0
			ldi	ZH, 0x00		; 1AD5 E0F0
			ldi	ZL, 0x93		; 1AD6 E9E3
			ijmp				; 1AD7 9409

avr1AD8:	cpi	r17, 0x01		; 1AD8 3011
			brne	avr1AE2		; 1AD9 F441
			in	r16, PORTA		; 1ADA B30B
			ldi	r18, 0x02		; 1ADB E022
			eor	r16, r18		; 1ADC 2702
			out	PORTA, r16		; 1ADD BB0B
			sbi	DDRA, 1			; 1ADE 9AD1
			ldi	ZH, 0x00		; 1ADF E0F0
			ldi	ZL, 0x93		; 1AE0 E9E3
			ijmp				; 1AE1 9409

avr1AE2:	cpi	r17, 0x02		; 1AE2 3012
		brne	avr1AEC		; 1AE3 F441
		in	r16, PORTA		; 1AE4 B30B
		ldi	r18, 0x04		; 1AE5 E024
avr1AE6:	eor	r16, r18		; 1AE6 2702
		out	PORTA, r16		; 1AE7 BB0B
		sbi	DDRA, 2	; 1AE8 9AD2
		ldi	ZH, 0x00		; 1AE9 E0F0
		ldi	ZL, 0x93		; 1AEA E9E3
		ijmp				; 1AEB 9409
avr1AEC:	cpi	r17, 0x03		; 1AEC 3013
avr1AED:	brne	avr1AF6		; 1AED F441
		in	r16, PORTA		; 1AEE B30B
		ldi	r18, 0x08		; 1AEF E028
		eor	r16, r18		; 1AF0 2702
avr1AF1:	out	PORTA, r16		; 1AF1 BB0B
		sbi	DDRA, 3	; 1AF2 9AD3
		ldi	ZH, 0x00		; 1AF3 E0F0
		ldi	ZL, 0x93		; 1AF4 E9E3
		ijmp				; 1AF5 9409
avr1AF6:	cpi	r17, 0x04		; 1AF6 3014
		brne	avr1B00		; 1AF7 F441
		in	r16, PORTA		; 1AF8 B30B
		ldi	r18, 0x10		; 1AF9 E120
		eor	r16, r18		; 1AFA 2702
		out	PORTA, r16		; 1AFB BB0B
avr1AFC:	sbi	DDRA, 4	; 1AFC 9AD4
		ldi	ZH, 0x00		; 1AFD E0F0
		ldi	ZL, 0x93		; 1AFE E9E3
		ijmp				; 1AFF 9409
avr1B00:	cpi	r17, 0x05		; 1B00 3015
		brne	avr1B0A		; 1B01 F441
		in	r16, PORTA		; 1B02 B30B
		ldi	r18, 0x20		; 1B03 E220
avr1B04:	eor	r16, r18		; 1B04 2702
		out	PORTA, r16		; 1B05 BB0B
		sbi	DDRA, 5	; 1B06 9AD5
		ldi	ZH, 0x00		; 1B07 E0F0
		ldi	ZL, 0x93		; 1B08 E9E3
		ijmp				; 1B09 9409
avr1B0A:	cpi	r17, 0x06		; 1B0A 3016
		brne	avr1B14		; 1B0B F441
		in	r16, PORTA		; 1B0C B30B
		ldi	r18, 0x40		; 1B0D E420
		eor	r16, r18		; 1B0E 2702
avr1B0F:	out	PORTA, r16		; 1B0F BB0B
		sbi	DDRA, 6	; 1B10 9AD6
		ldi	ZH, 0x00		; 1B11 E0F0
		ldi	ZL, 0x93		; 1B12 E9E3
		ijmp				; 1B13 9409
avr1B14:	cpi	r17, 0x07		; 1B14 3017
		brne	avr1B1E		; 1B15 F441
		in	r16, PORTA		; 1B16 B30B
		ldi	r18, 0x80		; 1B17 E820
		eor	r16, r18		; 1B18 2702
		out	PORTA, r16		; 1B19 BB0B
		sbi	DDRA, 7	; 1B1A 9AD7
		ldi	ZH, 0x00		; 1B1B E0F0
avr1B1C:	ldi	ZL, 0x93		; 1B1C E9E3
		ijmp				; 1B1D 9409
avr1B1E:	cpi	r17, 0x08		; 1B1E 3018
		brne	avr1B28		; 1B1F F441
		in	r16, PORTB		; 1B20 B308
		ldi	r18, 0x01		; 1B21 E021
		eor	r16, r18		; 1B22 2702
		out	PORTB, r16		; 1B23 BB08
avr1B24:	sbi	DDRB, 0	; 1B24 9AB8
		ldi	ZH, 0x00		; 1B25 E0F0
		ldi	ZL, 0x93		; 1B26 E9E3
		ijmp				; 1B27 9409
avr1B28:	cpi	r17, 0x09		; 1B28 3019
		brne	avr1B32		; 1B29 F441
		in	r16, PORTB		; 1B2A B308
avr1B2B:	ldi	r18, 0x02		; 1B2B E022
		eor	r16, r18		; 1B2C 2702
		out	PORTB, r16		; 1B2D BB08
		sbi	DDRB, 1	; 1B2E 9AB9
avr1B2F:	ldi	ZH, 0x00		; 1B2F E0F0
		ldi	ZL, 0x93		; 1B30 E9E3
		ijmp				; 1B31 9409
avr1B32:	cpi	r17, 0x0A		; 1B32 301A
		brne	avr1B3C		; 1B33 F441
		in	r16, PORTB		; 1B34 B308
		ldi	r18, 0x04		; 1B35 E024
		eor	r16, r18		; 1B36 2702
		out	PORTB, r16		; 1B37 BB08
		sbi	DDRB, 2	; 1B38 9ABA
		ldi	ZH, 0x00		; 1B39 E0F0
avr1B3A:	ldi	ZL, 0x93		; 1B3A E9E3
		ijmp				; 1B3B 9409
avr1B3C:	cpi	r17, 0x0B		; 1B3C 301B
		brne	avr1B46		; 1B3D F441
		in	r16, PORTB		; 1B3E B308
		ldi	r18, 0x08		; 1B3F E028
		eor	r16, r18		; 1B40 2702
		out	PORTB, r16		; 1B41 BB08
avr1B42:	sbi	DDRB, 3	; 1B42 9ABB
		ldi	ZH, 0x00		; 1B43 E0F0
		ldi	ZL, 0x93		; 1B44 E9E3
		ijmp				; 1B45 9409
avr1B46:	cpi	r17, 0x0C		; 1B46 301C
		brne	avr1B50		; 1B47 F441
avr1B48:	in	r16, PORTB		; 1B48 B308
		ldi	r18, 0x10		; 1B49 E120
		eor	r16, r18		; 1B4A 2702
		out	PORTB, r16		; 1B4B BB08
		sbi	DDRB, 4	; 1B4C 9ABC
avr1B4D:	ldi	ZH, 0x00		; 1B4D E0F0
		ldi	ZL, 0x93		; 1B4E E9E3
		ijmp				; 1B4F 9409
avr1B50:	cpi	r17, 0x0D		; 1B50 301D
		brne	avr1B5A		; 1B51 F441
		in	r16, PORTB		; 1B52 B308
		ldi	r18, 0x20		; 1B53 E220
		eor	r16, r18		; 1B54 2702
		out	PORTB, r16		; 1B55 BB08
		sbi	DDRB, 5	; 1B56 9ABD
		ldi	ZH, 0x00		; 1B57 E0F0
		ldi	ZL, 0x93		; 1B58 E9E3
		ijmp				; 1B59 9409
avr1B5A:	cpi	r17, 0x0E		; 1B5A 301E
		brne	avr1B64		; 1B5B F441
		in	r16, PORTB		; 1B5C B308
		ldi	r18, 0x40		; 1B5D E420
		eor	r16, r18		; 1B5E 2702
		out	PORTB, r16		; 1B5F BB08
		sbi	DDRB, 6	; 1B60 9ABE
		ldi	ZH, 0x00		; 1B61 E0F0
avr1B62:	ldi	ZL, 0x93		; 1B62 E9E3
		ijmp				; 1B63 9409
avr1B64:	cpi	r17, 0x0F		; 1B64 301F
		brne	avr1B6E		; 1B65 F441
		in	r16, PORTB		; 1B66 B308
		ldi	r18, 0x80		; 1B67 E820
		eor	r16, r18		; 1B68 2702
avr1B69:	out	PORTB, r16		; 1B69 BB08
		sbi	DDRB, 7	; 1B6A 9ABF
		ldi	ZH, 0x00		; 1B6B E0F0
		ldi	ZL, 0x93		; 1B6C E9E3
avr1B6D:	ijmp				; 1B6D 9409
avr1B6E:	cpi	r17, 0x10		; 1B6E 3110
		brne	avr1B78		; 1B6F F441
		in	r16, PORTC		; 1B70 B305
		ldi	r18, 0x80		; 1B71 E820
		eor	r16, r18		; 1B72 2702
		out	PORTC, r16		; 1B73 BB05
		sbi	DDRC, 7	; 1B74 9AA7
		ldi	ZH, 0x00		; 1B75 E0F0
		ldi	ZL, 0x93		; 1B76 E9E3
		ijmp				; 1B77 9409
avr1B78:	cpi	r17, 0x11		; 1B78 3111
		brne	avr1B82		; 1B79 F441
		in	r16, PORTC		; 1B7A B305
		ldi	r18, 0x40		; 1B7B E420
		eor	r16, r18		; 1B7C 2702
		out	PORTC, r16		; 1B7D BB05
		sbi	DDRC, 6	; 1B7E 9AA6
		ldi	ZH, 0x00		; 1B7F E0F0
avr1B80:	ldi	ZL, 0x93		; 1B80 E9E3
		ijmp				; 1B81 9409
avr1B82:	cpi	r17, 0x12		; 1B82 3112
		brne	avr1B8C		; 1B83 F441
		in	r16, PORTC		; 1B84 B305
		ldi	r18, 0x20		; 1B85 E220
avr1B86:	eor	r16, r18		; 1B86 2702
		out	PORTC, r16		; 1B87 BB05
		sbi	DDRC, 5	; 1B88 9AA5
avr1B89:	ldi	ZH, 0x00		; 1B89 E0F0
		ldi	ZL, 0x93		; 1B8A E9E3
avr1B8B:	ijmp				; 1B8B 9409
avr1B8C:	cpi	r17, 0x13		; 1B8C 3113
		brne	avr1B96		; 1B8D F441
		in	r16, PORTC		; 1B8E B305
		ldi	r18, 0x10		; 1B8F E120
		eor	r16, r18		; 1B90 2702
		out	PORTC, r16		; 1B91 BB05
		sbi	DDRC, 4	; 1B92 9AA4
		ldi	ZH, 0x00		; 1B93 E0F0
		ldi	ZL, 0x93		; 1B94 E9E3
		ijmp				; 1B95 9409
avr1B96:	cpi	r17, 0x14		; 1B96 3114
		brne	avr1BA0		; 1B97 F441
avr1B98:	in	r16, PORTC		; 1B98 B305
		ldi	r18, 0x08		; 1B99 E028
		eor	r16, r18		; 1B9A 2702
		out	PORTC, r16		; 1B9B BB05
		sbi	DDRC, 3	; 1B9C 9AA3
		ldi	ZH, 0x00		; 1B9D E0F0
		ldi	ZL, 0x93		; 1B9E E9E3
		ijmp				; 1B9F 9409
avr1BA0:	cpi	r17, 0x15		; 1BA0 3115
		brne	avr1BAA		; 1BA1 F441
		in	r16, PORTC		; 1BA2 B305
		ldi	r18, 0x04		; 1BA3 E024
		eor	r16, r18		; 1BA4 2702
		out	PORTC, r16		; 1BA5 BB05
		sbi	DDRC, 2	; 1BA6 9AA2
avr1BA7:	ldi	ZH, 0x00		; 1BA7 E0F0
		ldi	ZL, 0x93		; 1BA8 E9E3
		ijmp				; 1BA9 9409
avr1BAA:	cpi	r17, 0x16		; 1BAA 3116
avr1BAB:	brne	avr1BB4		; 1BAB F441
		in	r16, PORTC		; 1BAC B305
		ldi	r18, 0x02		; 1BAD E022
		eor	r16, r18		; 1BAE 2702
		out	PORTC, r16		; 1BAF BB05
		sbi	DDRC, 1	; 1BB0 9AA1
		ldi	ZH, 0x00		; 1BB1 E0F0
		ldi	ZL, 0x93		; 1BB2 E9E3
		ijmp				; 1BB3 9409
avr1BB4:	cpi	r17, 0x17		; 1BB4 3117
		brne	avr1BBE		; 1BB5 F441
avr1BB6:	in	r16, PORTC		; 1BB6 B305
		ldi	r18, 0x01		; 1BB7 E021
		eor	r16, r18		; 1BB8 2702
		out	PORTC, r16		; 1BB9 BB05
		sbi	DDRC, 0	; 1BBA 9AA0
		ldi	ZH, 0x00		; 1BBB E0F0
		ldi	ZL, 0x93		; 1BBC E9E3
		ijmp				; 1BBD 9409
avr1BBE:	cpi	r17, 0x18		; 1BBE 3118
		brne	avr1BC8		; 1BBF F441
		in	r16, $03		; 1BC0 B103
		ldi	r18, 0x80		; 1BC1 E820
		eor	r16, r18		; 1BC2 2702
		out	$03, r16		; 1BC3 B903
avr1BC4:	sbi	$02, 7	; 1BC4 9A17
		ldi	ZH, 0x00		; 1BC5 E0F0
		ldi	ZL, 0x93		; 1BC6 E9E3
		ijmp				; 1BC7 9409
avr1BC8:	cpi	r17, 0x19		; 1BC8 3119
avr1BC9:	brne	avr1BD2		; 1BC9 F441
		in	r16, $03		; 1BCA B103
		ldi	r18, 0x40		; 1BCB E420
		eor	r16, r18		; 1BCC 2702
		out	$03, r16		; 1BCD B903
		sbi	$02, 6	; 1BCE 9A16
		ldi	ZH, 0x00		; 1BCF E0F0
		ldi	ZL, 0x93		; 1BD0 E9E3
		ijmp				; 1BD1 9409
avr1BD2:	cpi	r17, 0x1A		; 1BD2 311A
		brne	avr1BDC		; 1BD3 F441
		in	r16, PORTD		; 1BD4 B302
		ldi	r18, 0x80		; 1BD5 E820
avr1BD6:	eor	r16, r18		; 1BD6 2702
		out	PORTD, r16		; 1BD7 BB02
		sbi	DDRD, 7	; 1BD8 9A8F
		ldi	ZH, 0x00		; 1BD9 E0F0
		ldi	ZL, 0x93		; 1BDA E9E3
		ijmp				; 1BDB 9409
avr1BDC:	cpi	r17, 0x1B		; 1BDC 311B
		brne	avr1BE6		; 1BDD F441
avr1BDE:	in	r16, PORTD		; 1BDE B302
		ldi	r18, 0x40		; 1BDF E420
		eor	r16, r18		; 1BE0 2702
		out	PORTD, r16		; 1BE1 BB02
		sbi	DDRD, 6	; 1BE2 9A8E
		ldi	ZH, 0x00		; 1BE3 E0F0
		ldi	ZL, 0x93		; 1BE4 E9E3
avr1BE5:	ijmp				; 1BE5 9409
avr1BE6:	cpi	r17, 0x1C		; 1BE6 311C
		brne	avr1BF0		; 1BE7 F441
		in	r16, PORTD		; 1BE8 B302
avr1BE9:	ldi	r18, 0x20		; 1BE9 E220
		eor	r16, r18		; 1BEA 2702
		out	PORTD, r16		; 1BEB BB02
		sbi	DDRD, 5	; 1BEC 9A8D
		ldi	ZH, 0x00		; 1BED E0F0
		ldi	ZL, 0x93		; 1BEE E9E3
		ijmp				; 1BEF 9409
avr1BF0:	cpi	r17, 0x1D		; 1BF0 311D
		brne	avr1C00		; 1BF1 F471
		lds	r16, 0x0065		; 1BF2 9100 0065
avr1BF4:	ldi	r18, 0x04		; 1BF4 E024
		eor	r16, r18		; 1BF5 2702
		sts	0x0065, r16		; 1BF6 9300 0065
		lds	r17, 0x0064		; 1BF8 9110 0064
		ori	r17, 0x04		; 1BFA 6014
		sts	0x0064, r17		; 1BFB 9310 0064
		ldi	ZH, 0x00		; 1BFD E0F0
		ldi	ZL, 0x93		; 1BFE E9E3
		ijmp				; 1BFF 9409
avr1C00:	cpi	r17, 0x1E		; 1C00 311E
		brne	avr1C10		; 1C01 F471
avr1C02:	lds	r16, 0x0065		; 1C02 9100 0065
		ldi	r18, 0x02		; 1C04 E022
		eor	r16, r18		; 1C05 2702
		sts	0x0065, r16		; 1C06 9300 0065
		lds	r17, 0x0064		; 1C08 9110 0064
		ori	r17, 0x02		; 1C0A 6012
		sts	0x0064, r17		; 1C0B 9310 0064
		ldi	ZH, 0x00		; 1C0D E0F0
		ldi	ZL, 0x93		; 1C0E E9E3
		ijmp				; 1C0F 9409
avr1C10:	cpi	r17, 0x1F		; 1C10 311F
		brne	avr1C20		; 1C11 F471
		lds	r16, 0x0065		; 1C12 9100 0065
avr1C14:	ldi	r18, 0x01		; 1C14 E021
		eor	r16, r18		; 1C15 2702
		sts	0x0065, r16		; 1C16 9300 0065
		lds	r17, 0x0064		; 1C18 9110 0064
		ori	r17, 0x01		; 1C1A 6011
		sts	0x0064, r17		; 1C1B 9310 0064
		ldi	ZH, 0x00		; 1C1D E0F0
		ldi	ZL, 0x93		; 1C1E E9E3
		ijmp				; 1C1F 9409
avr1C20:	cpi	r17, 0x20		; 1C20 3210
		brne	avr1C30		; 1C21 F471
		lds	r16, 0x0062		; 1C22 9100 0062
		ldi	r18, 0x01		; 1C24 E021
		eor	r16, r18		; 1C25 2702
		sts	0x0062, r16		; 1C26 9300 0062
		lds	r17, 0x0061		; 1C28 9110 0061
		ori	r17, 0x01		; 1C2A 6011
		sts	0x0061, r17		; 1C2B 9310 0061
		ldi	ZH, 0x00		; 1C2D E0F0
		ldi	ZL, 0x93		; 1C2E E9E3
		ijmp				; 1C2F 9409
avr1C30:	cpi	r17, 0x21		; 1C30 3211
		brne	avr1C40		; 1C31 F471
avr1C32:	lds	r16, 0x0062		; 1C32 9100 0062
		ldi	r18, 0x02		; 1C34 E022
		eor	r16, r18		; 1C35 2702
		sts	0x0062, r16		; 1C36 9300 0062
		lds	r17, 0x0061		; 1C38 9110 0061
avr1C3A:	ori	r17, 0x02		; 1C3A 6012
		sts	0x0061, r17		; 1C3B 9310 0061
		ldi	ZH, 0x00		; 1C3D E0F0
		ldi	ZL, 0x93		; 1C3E E9E3
		ijmp				; 1C3F 9409
avr1C40:	cpi	r17, 0x22		; 1C40 3212
		brne	avr1C50		; 1C41 F471
		lds	r16, 0x0062		; 1C42 9100 0062
		ldi	r18, 0x04		; 1C44 E024
avr1C45:	eor	r16, r18		; 1C45 2702
		sts	0x0062, r16		; 1C46 9300 0062
		lds	r17, 0x0061		; 1C48 9110 0061
		ori	r17, 0x04		; 1C4A 6014
		sts	0x0061, r17		; 1C4B 9310 0061
		ldi	ZH, 0x00		; 1C4D E0F0
		ldi	ZL, 0x93		; 1C4E E9E3
		ijmp				; 1C4F 9409
avr1C50:	cpi	r17, 0x23		; 1C50 3213
		brne	avr1C60		; 1C51 F471
avr1C52:	lds	r16, 0x0062		; 1C52 9100 0062
		ldi	r18, 0x08		; 1C54 E028
		eor	r16, r18		; 1C55 2702
		sts	0x0062, r16		; 1C56 9300 0062
		lds	r17, 0x0061		; 1C58 9110 0061
avr1C5A:	ori	r17, 0x08		; 1C5A 6018
		sts	0x0061, r17		; 1C5B 9310 0061
		ldi	ZH, 0x00		; 1C5D E0F0
		ldi	ZL, 0x93		; 1C5E E9E3
		ijmp				; 1C5F 9409

avr1C60:	cpi	r17, 0x24		; 1C60 3214
			brne	avr1C70		; 1C61 F471
			lds	r16, 0x0062		; 1C62 9100 0062
			ldi	r18, 0x10		; 1C64 E120
			eor	r16, r18		; 1C65 2702
			sts	0x0062, r16		; 1C66 9300 0062
			lds	r17, 0x0061		; 1C68 9110 0061
			ori	r17, 0x10		; 1C6A 6110
			sts	0x0061, r17		; 1C6B 9310 0061
			ldi	ZH, 0x00		; 1C6D E0F0
			ldi	ZL, 0x93		; 1C6E E9E3
			ijmp				; 1C6F 9409

avr1C70:	cpi	r17, 0x25		; 1C70 3215
			brne	avr1C80		; 1C71 F471
			lds	r16, 0x0062		; 1C72 9100 0062
			ldi	r18, 0x20		; 1C74 E220
			eor	r16, r18		; 1C75 2702
			sts	0x0062, r16		; 1C76 9300 0062
			lds	r17, 0x0061		; 1C78 9110 0061
			ori	r17, 0x20		; 1C7A 6210
			sts	0x0061, r17		; 1C7B 9310 0061
			ldi	ZH, 0x00		; 1C7D E0F0
			ldi	ZL, 0x93		; 1C7E E9E3
			ijmp				; 1C7F 9409


avr1C80:	cpi	r17, 0x26		; 1C80 3216
			brne	avr1C90		; 1C81 F471
			lds	r16, 0x0062		; 1C82 9100 0062
			ldi	r18, 0x40		; 1C84 E420
			eor	r16, r18		; 1C85 2702
			sts	0x0062, r16		; 1C86 9300 0062
			lds	r17, 0x0061		; 1C88 9110 0061
			ori	r17, 0x40		; 1C8A 6410
			sts	0x0061, r17		; 1C8B 9310 0061
			ldi	ZH, 0x00		; 1C8D E0F0
			ldi	ZL, 0x93		; 1C8E E9E3
			ijmp				; 1C8F 9409


avr1C90:	cpi	r17, 0x27		; 1C90 3217
			brne	avr1CA0		; 1C91 F471
			lds	r16, 0x0062		; 1C92 9100 0062
			ldi	r18, 0x80		; 1C94 E820
			eor	r16, r18		; 1C95 2702
			sts	0x0062, r16		; 1C96 9300 0062
			lds	r17, 0x0061		; 1C98 9110 0061
			ori	r17, 0x80		; 1C9A 6810
			sts	0x0061, r17		; 1C9B 9310 0061
			ldi	ZH, 0x00		; 1C9D E0F0
			ldi	ZL, 0x93		; 1C9E E9E3
			ijmp				; 1C9F 9409


avr1CA0:	ldi	ZH, 0x00		; 1CA0 E0F0
			ldi	ZL, 0x93		; 1CA1 E9E3
			ijmp				; 1CA2 9409
;------------------------------------------------------------
;Here for IM code D4 DELAY

avr1CA3:	call	sub0B8B		; 1CA3 940E 0B8B  get delay in milliSec into r23 and r24
			clc					; 1CA5 9488 divide by 4 since delay is based on 4 millisec timer int
			ror	r24				; 1CA6 9587 shift right
			ror	r23				; 1CA7 9577
			clc					; 1CA8 9488
			ror	r24				; 1CA9 9587 shift right
			ror	r23				; 1CAA 9577
			sts	0x04DC, r23		; 1CAB 9370 04DC store low count
			sts	0x04DD, r24		; 1CAD 9380 04DD store high count
			ser	r16				; 1CAF EF0F
			sts	0x04DE, r16		; 1CB0 9300 04DE set counter busy flag
			ldi	ZH, 0x00		; 1CB2 E0F0
			ldi	ZL, 0x93		; 1CB3 E9E3
			ijmp				; 1CB4 9409

;-----------------------------------------------------------
; Here for IM Code D5 ERX

avr1CB5:	call	sub07D6				; 1CB5 940E 07D6
			ldi	ZH, high(avr1CF6 << 1)	; 1CB7 E3F9 Get baud rate table
			ldi	ZL, low(avr1CF6 << 1)	; 1CB8 EEEC
			add	ZL, r16					; 1CB9 0FE0
			brsh	avr1CBC				; 1CBA F408
			inc	ZH						; 1CBB 95F3
avr1CBC:	lpm							; 1CBC 95C8
			mov	r16, r0					; 1CBD 2D00
			in	r17, $09				; 1CBE B119
			cp	r17, r16				; 1CBF 1710
			breq	avr1CC2				; 1CC0 F009
			out	$09, r16				; 1CC1 B909 set baud rate if different
avr1CC2:	lds	r17, 0x0090				; 1CC2 9110 0090
			cp	r17, r16				; 1CC4 1710
			breq	avr1CC7+1			; 1CC5 F011
			ldi	r16, 0x00				; 1CC6 E000
avr1CC7:	sts	0x0090, r16				; 1CC7 9300 0090; this is weird
			sbis	$0B, 7				; 1CC9 9B5F
			rjmp	avr1CD6				; 1CCA C00B
			adiw	XL, 0x01			; 1CCB 9611
			call	sub07D6				; 1CCC 940E 07D6
avr1CCE:	ldi	YH, 0x01				; 1CCE E0D1
			mov	YL, r16					; 1CCF 2FC0
			in	r16, $0C				; 1CD0 B10C
			st	Y, r16					; 1CD1 8308
			adiw	XL, 0x02			; 1CD2 9612
			ldi	ZH, 0x00				; 1CD3 E0F0
			ldi	ZL, 0x93				; 1CD4 E9E3
			ijmp						; 1CD5 9409

avr1CD6:	adiw	XL, 0x02			; 1CD6 9612
			ldi	ZH, 0x12				; 1CD7 E1F1
			ldi	ZL, 0x92				; 1CD8 ECEA
			ijmp						; 1CD9 9409

;---------------------------------------------------------
; Here for IM code D6 ETX

avr1CDA:	call	sub07D6		; 1CDA 940E 07D6
			ldi	ZH, 0x3B		; 1CDC E3F9
			ldi	ZL, 0x80		; 1CDD EEEC
			add	ZL, r16		; 1CDE 0FE0
			brsh	avr1CE1		; 1CDF F408
			inc	ZH			; 1CE0 95F3
avr1CE1:	lpm				; 1CE1 95C8
			mov	r16, r0		; 1CE2 2D00
			in	r17, $09		; 1CE3 B119
			cp	r17, r16		; 1CE4 1710
			breq	avr1CE7		; 1CE5 F009
			out	$09, r16		; 1CE6 B909
avr1CE7:	lds	r17, 0x0090		; 1CE7 9110 0090
			cp	r17, r16		; 1CE9 1710
			breq	avr1CEC+1		; 1CEA F011 This is weird !!!!!
			ldi	r16, 0x00		; 1CEB E000
avr1CEC:	sts	0x0090, r16		; 1CEC 9300 0090
avr1CEE:	sbis	$0B, 5	; 1CEE 9B5D
			rjmp	avr1CEE		; 1CEF CFFE
			call	sub0B8B		; 1CF0 940E 0B8B
			out	$0C, r23		; 1CF2 B97C
			ldi	ZH, 0x00		; 1CF3 E0F0
			ldi	ZL, 0x93		; 1CF4 E9E3
			ijmp				; 1CF5 9409

;------------------------------------------------------------
;data table ERX and ETX serial baud rates
avr1CF6:

		.db  0xbf, 0x5f, 0x2f, 0x1f
		.db  0x17, 0x0f, 0x0B, 0x07
		.db  0x05, 0x03, 0x01, 0x00
/*
		1CF6 5FBF
		1CF7 1F2F
		1CF8 0F17
		iCF9 070B
		1CFA 0305
		1CFB 0001
*/

;-------------------------------------------------------------
; Here for IM Code D7

avr1CFC:	call	sub0B8B		; 1CFC 940E 0B8B get value
			brlo	avr1D03		; 1CFE F020
			mov		r16, r23	; 1CFF 2F07
			call	sub25DA		; 1D00 940E 25DA
			rjmp	avr1CFC		; 1D02 CFF9
avr1D03:	ldi	ZH, 0x00		; 1D03 E0F0
			ldi	ZL, 0x93		; 1D04 E9E3
			ijmp				; 1D05 9409

;-------------------------------------------------------------
; Here for IM code D8 unused

avr1D06:	jmp		avr0093		; 1D06 940C 0093

;-------------------------------------------------------------
;Here for IM code D8 SET zero offsets to internal EEPROM

avr1D08:	ldi		YH, 0x03		; 1D08 E0D3 
			ldi		YL, 0x40		; 1D09 E4C0
			ldi		r18, 0x06		; 1D0A E026 6 values (value = 0 means no change)
			call	sub22F9			; 1D0B 940E 22F9 get offset values and subtract 100
			push	XL				; 1D0D 93AF
			push	XH				; 1D0E 93BF
			ldi		YH, 0x03		; 1D0F E0D3
			ldi		YL, 0x40		; 1D10 E4C0
			ldi		XH, 0x0F		; 1D11 E0BF address in EEPROM
			ldi		XL, 0xE0		; 1D12 EEA0
			ldi		r18, 0x06		; 1D13 E026 store 6 values
avr1D14:	call	sub2304			; 1D14 940E 2304
			pop		XH				; 1D16 91BF
			pop		XL				; 1D17 91AF
			jmp		avr0093			; 1D18 940C 0093

;--------------------------------------------------------------
; Here for IM code DA MOTOR ON

avr1D1A:	call	sub0B8B		; 1D1A 940E 0B8B get value for servo number
			mov	r16, r23		; 1D1C 2F07
;-------------------------------------------------------------------------
; Here to turn on a servo
sub1D1D:	cpi		r16, 0x00		; 1D1D 3000 servo 0
			brne	avr1D22			; 1D1E F419
			ldi		r16, 0x01		; 1D1F E001
			sbi		DDRA, 0			; 1D20 9AD0 Port A0
			rjmp	avr1DCA			; 1D21 C0A8
avr1D22:	cpi		r16, 0x01		; 1D22 3001 servo 1
			brne	avr1D27			; 1D23 F419
			ldi		r16, 0x02		; 1D24 E002 Port A1
			sbi		DDRA, 1			; 1D25 9AD1
			rjmp	avr1DCA			; 1D26 C0A3
avr1D27:	cpi		r16, 0x02		; 1D27 3002 servo 2
			brne	avr1D2C			; 1D28 F419
			ldi		r16, 0x04		; 1D29 E004
			sbi		DDRA, 2			; 1D2A 9AD2 Port A2
			rjmp	avr1DCA			; 1D2B C09E
avr1D2C:	cpi		r16, 0x03		; 1D2C 3003 servo 3
			brne	avr1D31			; 1D2D F419
			ldi		r16, 0x08		; 1D2E E008 Port A3
			sbi		DDRA, 3			; 1D2F 9AD3
			rjmp	avr1DCA			; 1D30 C099
avr1D31:	cpi		r16, 0x04		; 1D31 3004 servo 4
			brne	avr1D36			; 1D32 F419
			ldi		r16, 0x10		; 1D33 E100
			sbi		DDRA, 4			; 1D34 9AD4 Port A4
			rjmp	avr1DCA			; 1D35 C094
avr1D36:	cpi		r16, 0x05		; 1D36 3005 servo 5
			brne	avr1D3B			; 1D37 F419
			ldi		r16, 0x20		; 1D38 E200
			sbi		DDRA, 5			; 1D39 9AD5 Port A5
			rjmp	avr1DCA			; 1D3A C08F
avr1D3B:	cpi		r16, 0x06		; 1D3B 3006 servo 6
			brne	avr1D40			; 1D3C F419
			ldi		r16, 0x40		; 1D3D E400
			sbi		DDRA, 6			; 1D3E 9AD6 Port A6
			rjmp	avr1DCA			; 1D3F C08A
avr1D40:	cpi		r16, 0x07		; 1D40 3007 servo 7
			brne	avr1D45			; 1D41 F419
			ldi		r16, 0x80		; 1D42 E800
			sbi		DDRA, 7			; 1D43 9AD7 Port A7
			rjmp	avr1DCA			; 1D44 C085
avr1D45:	cpi		r16, 0x08		; 1D45 3008 servo 8
			brne	avr1D4A			; 1D46 F419
			ldi		r16, 0x01		; 1D47 E001
			sbi		DDRB, 0			; 1D48 9AB8 Port B0
			rjmp	avr1DD0			; 1D49 C086
avr1D4A:	cpi		r16, 0x09		; 1D4A 3009 servo 9
			brne	avr1D4F			; 1D4B F419
			ldi		r16, 0x02		; 1D4C E002
			sbi		DDRB, 1			; 1D4D 9AB9 Port B1
			rjmp	avr1DD0			; 1D4E C081
avr1D4F:	cpi		r16, 0x0A		; 1D4F 300A servo 10
			brne	avr1D54			; 1D50 F419
			ldi		r16, 0x04		; 1D51 E004
			sbi		DDRB, 2			; 1D52 9ABA Port B2
			rjmp	avr1DD0			; 1D53 C07C
avr1D54:	cpi		r16, 0x0B		; 1D54 300B servo 11
			brne	avr1D59			; 1D55 F419
			ldi		r16, 0x08		; 1D56 E008
			sbi		DDRB, 3			; 1D57 9ABB
			rjmp	avr1DD0			; 1D58 C077
avr1D59:	cpi		r16, 0x0C		; 1D59 300C servo 12
			brne	avr1D5E			; 1D5A F419
			ldi		r16, 0x10		; 1D5B E100
			sbi		DDRB, 4			; 1D5C 9ABC
			rjmp	avr1DD0			; 1D5D C072
avr1D5E:	cpi		r16, 0x0D		; 1D5E 300D servo 13
			brne	avr1D63			; 1D5F F419
			ldi		r16, 0x20		; 1D60 E200
			sbi		DDRB, 5			; 1D61 9ABD
			rjmp	avr1DD0			; 1D62 C06D
avr1D63:	cpi		r16, 0x0E		; 1D63 300E servo 14
			brne	avr1D68			; 1D64 F419
			ldi		r16, 0x40		; 1D65 E400
			sbi		DDRB, 6			; 1D66 9ABE
			rjmp	avr1DD0			; 1D67 C068
avr1D68:	cpi		r16, 0x0F		; 1D68 300F servo 15
			brne	avr1D6D			; 1D69 F419
			ldi		r16, 0x80		; 1D6A E800
			sbi		DDRB, 7			; 1D6B 9ABF
			rjmp	avr1DD0			; 1D6C C063
avr1D6D:	cpi		r16, 0x10		; 1D6D 3100 Servo 16
			brne	avr1D72			; 1D6E F419
			ldi		r16, 0x01		; 1D6F E001
			sbi		DDRC, 7			; 1D70 9AA7 Port C7
			rjmp	avr1DD6			; 1D71 C064
avr1D72:	cpi		r16, 0x11		; 1D72 3101 servo 17
			brne	avr1D77			; 1D73 F419
			ldi		r16, 0x02		; 1D74 E002
			sbi		DDRC, 6			; 1D75 9AA6
			rjmp	avr1DD6			; 1D76 C05F
avr1D77:	cpi		r16, 0x12		; 1D77 3102 servo 18
			brne	avr1D7C			; 1D78 F419
			ldi		r16, 0x04		; 1D79 E004
			sbi		DDRC, 5			; 1D7A 9AA5
			rjmp	avr1DD6			; 1D7B C05A
avr1D7C:	cpi		r16, 0x13		; 1D7C 3103 servo 19
			brne	avr1D81			; 1D7D F419
			ldi		r16, 0x08		; 1D7E E008
			sbi		DDRC, 4			; 1D7F 9AA4
			rjmp	avr1DD6			; 1D80 C055
avr1D81:	cpi		r16, 0x14		; 1D81 3104 servo 20
			brne	avr1D86			; 1D82 F419
			ldi		r16, 0x10		; 1D83 E100
			sbi		DDRC, 3			; 1D84 9AA3
			rjmp	avr1DD6			; 1D85 C050
avr1D86:	cpi		r16, 0x15		; 1D86 3105 servo 21
			brne	avr1D8B			; 1D87 F419
			ldi		r16, 0x20		; 1D88 E200
			sbi		DDRC, 2			; 1D89 9AA2
			rjmp	avr1DD6			; 1D8A C04B
avr1D8B:	cpi		r16, 0x16		; 1D8B 3106 servo 22
			brne	avr1D90			; 1D8C F419
			ldi		r16, 0x40		; 1D8D E400
			sbi		DDRC, 1			; 1D8E 9AA1
			rjmp	avr1DD6			; 1D8F C046
avr1D90:	cpi		r16, 0x17		; 1D90 3107 servo 23
			brne	avr1D95			; 1D91 F419
			ldi		r16, 0x80		; 1D92 E800
			sbi		DDRC, 0			; 1D93 9AA0 Port C0
			rjmp	avr1DD6			; 1D94 C041
avr1D95:	cpi		r16, 0x18		; 1D95 3108 servo 24
			brne	avr1D9A			; 1D96 F419
			ldi		r16, 0x01		; 1D97 E001
			sbi		$02, 7			; 1D98 9A17 Port E7
			rjmp	avr1DDC			; 1D99 C042
avr1D9A:	cpi		r16, 0x19		; 1D9A 3109 servo 25
			brne	avr1D9F			; 1D9B F419
			ldi		r16, 0x02		; 1D9C E002
			sbi		$02, 6			; 1D9D 9A16 Port E6
			rjmp	avr1DDC			; 1D9E C03D
avr1D9F:	cpi		r16, 0x1A		; 1D9F 310A servo 26
			brne	avr1DA4			; 1DA0 F419
			ldi		r16, 0x04		; 1DA1 E004
			sbi		DDRD, 7			; 1DA2 9A8F port D7
			rjmp	avr1DDC			; 1DA3 C038
avr1DA4:	cpi		r16, 0x1B		; 1DA4 310B servo 27
			brne	avr1DA9			; 1DA5 F419
			ldi		r16, 0x08		; 1DA6 E008
			sbi		DDRD, 6			; 1DA7 9A8E port D6
			rjmp	avr1DDC			; 1DA8 C033
avr1DA9:	cpi		r16, 0x1C		; 1DA9 310C servo 28
			brne	avr1DAE			; 1DAA F419
			ldi		r16, 0x10		; 1DAB E100
			sbi		DDRD, 5			; 1DAC 9A8D port D5
			rjmp	avr1DDC			; 1DAD C02E
avr1DAE:	cpi		r16, 0x1D		; 1DAE 310D servo 29
			brne	avr1DB7			; 1DAF F439
			ldi		r16, 0x20		; 1DB0 E200
			lds		r18, 0x0064		; 1DB1 9120 0064 port G2
			ori		r18, 0x04		; 1DB3 6024
			sts		0x0064, r18		; 1DB4 9320 0064
			rjmp	avr1DDC			; 1DB6 C025
avr1DB7:	cpi		r16, 0x1E		; 1DB7 310E servo 30
			brne	avr1DC0			; 1DB8 F439
			ldi		r16, 0x40		; 1DB9 E400
			lds		r18, 0x0064		; 1DBA 9120 0064 port G1
			ori		r18, 0x02		; 1DBC 6022
			sts		0x0064, r18		; 1DBD 9320 0064
			rjmp	avr1DDC			; 1DBF C01C
avr1DC0:	cpi		r16, 0x1F		; 1DC0 310F servo 31
			brne	avr1DC9			; 1DC1 F439
			ldi		r16, 0x80		; 1DC2 E800
			lds		r18, 0x0064		; 1DC3 9120 0064
			ori		r18, 0x01		; 1DC5 6021
			sts		0x0064, r18		; 1DC6 9320 0064 Port G0
			rjmp	avr1DDC			; 1DC8 C013

avr1DC9:	rjmp	avr1DE2			; 1DC9 C018

avr1DCA:	lds		r17, 0x04EB		; 1DCA 9110 04EB servo enables G8A
			or		r16, r17		; 1DCC 2B01
			sts		0x04EB, r16		; 1DCD 9300 04EB
			rjmp	avr1DE2			; 1DCF C012
avr1DD0:	lds		r17, 0x04EC		; 1DD0 9110 04EC servo enables G8B
			or		r16, r17		; 1DD2 2B01
			sts		0x04EC, r16		; 1DD3 9300 04EC
			rjmp	avr1DE2			; 1DD5 C00C
avr1DD6:	lds		r17, 0x04ED		; 1DD6 9110 04ED servo enables G8C
			or		r16, r17		; 1DD8 2B01
			sts		0x04ED, r16		; 1DD9 9300 04ED
			rjmp	avr1DE2			; 1DDB C006
avr1DDC:	lds		r17, 0x04EE		; 1DDC 9110 04EE servo enables G8D
			or		r16, r17		; 1DDE 2B01
			sts		0x04EE, r16		; 1DDF 9300 04EE
			rjmp	avr1DE2			; 1DE1 C000

avr1DE2:	lds		r16, 0x04D2		; 1DE2 9100 04D2 was this a command
			sbrc	r16, 5			; 1DE4 FD05
			ret						; 1DE5 9508
			jmp		avr0093			; 1DE6 940C 0093


;------------------------------------------------------------------------
; Here for IM command DB MOTOR  OFF

avr1DE8:	call	sub0B8B			; 1DE8 940E 0B8B
			mov		r16, r23		; 1DEA 2F07
;-------------------------------------------------------------------------
; here to turn off a servo
sub1DEB:	cpi		r16, 0x00		; 1DEB 3000
			brne	avr1DEF			; 1DEC F411
			ldi		r16, 0x01		; 1DED E001
			rjmp	avr1E6C			; 1DEE C07D
avr1DEF:	cpi		r16, 0x01		; 1DEF 3001
		brne	avr1DF3		; 1DF0 F411
		ldi	r16, 0x02		; 1DF1 E002
avr1DF2:	rjmp	avr1E6C		; 1DF2 C079
avr1DF3:	cpi	r16, 0x02		; 1DF3 3002
		brne	avr1DF7		; 1DF4 F411
		ldi	r16, 0x04		; 1DF5 E004
		rjmp	avr1E6C		; 1DF6 C075
avr1DF7:	cpi	r16, 0x03		; 1DF7 3003
		brne	avr1DFB		; 1DF8 F411
		ldi	r16, 0x08		; 1DF9 E008
		rjmp	avr1E6C		; 1DFA C071
avr1DFB:	cpi	r16, 0x04		; 1DFB 3004
		brne	avr1DFF		; 1DFC F411
		ldi	r16, 0x10		; 1DFD E100
		rjmp	avr1E6C		; 1DFE C06D
avr1DFF:	cpi	r16, 0x05		; 1DFF 3005
		brne	avr1E03		; 1E00 F411
		ldi	r16, 0x20		; 1E01 E200
		rjmp	avr1E6C		; 1E02 C069
avr1E03:	cpi	r16, 0x06		; 1E03 3006
avr1E04:	brne	avr1E07		; 1E04 F411
		ldi	r16, 0x40		; 1E05 E400
		rjmp	avr1E6C		; 1E06 C065
avr1E07:	cpi	r16, 0x07		; 1E07 3007
		brne	avr1E0B		; 1E08 F411
		ldi	r16, 0x80		; 1E09 E800
		rjmp	avr1E6C		; 1E0A C061
avr1E0B:	cpi	r16, 0x08		; 1E0B 3008
avr1E0C:	brne	avr1E0F		; 1E0C F411
		ldi	r16, 0x01		; 1E0D E001
		rjmp	avr1E73		; 1E0E C064
avr1E0F:	cpi	r16, 0x09		; 1E0F 3009
		brne	avr1E13		; 1E10 F411
		ldi	r16, 0x02		; 1E11 E002
		rjmp	avr1E73		; 1E12 C060
avr1E13:	cpi	r16, 0x0A		; 1E13 300A
		brne	avr1E17		; 1E14 F411
		ldi	r16, 0x04		; 1E15 E004
		rjmp	avr1E73		; 1E16 C05C
avr1E17:	cpi	r16, 0x0B		; 1E17 300B
		brne	avr1E1B		; 1E18 F411
		ldi	r16, 0x08		; 1E19 E008
		rjmp	avr1E73		; 1E1A C058
avr1E1B:	cpi	r16, 0x0C		; 1E1B 300C
		brne	avr1E1F		; 1E1C F411
		ldi	r16, 0x10		; 1E1D E100
		rjmp	avr1E73		; 1E1E C054
avr1E1F:	cpi	r16, 0x0D		; 1E1F 300D
		brne	avr1E23		; 1E20 F411
		ldi	r16, 0x20		; 1E21 E200
avr1E22:	rjmp	avr1E73		; 1E22 C050
avr1E23:	cpi	r16, 0x0E		; 1E23 300E
		brne	avr1E27		; 1E24 F411
		ldi	r16, 0x40		; 1E25 E400
		rjmp	avr1E73		; 1E26 C04C
avr1E27:	cpi	r16, 0x0F		; 1E27 300F
		brne	avr1E2B		; 1E28 F411
		ldi	r16, 0x80		; 1E29 E800
avr1E2A:	rjmp	avr1E73		; 1E2A C048
avr1E2B:	cpi	r16, 0x10		; 1E2B 3100
		brne	avr1E2F		; 1E2C F411
		ldi	r16, 0x01		; 1E2D E001
		rjmp	avr1E7A		; 1E2E C04B
avr1E2F:	cpi	r16, 0x11		; 1E2F 3101
avr1E30:	brne	avr1E33		; 1E30 F411
		ldi	r16, 0x02		; 1E31 E002
		rjmp	avr1E7A		; 1E32 C047
avr1E33:	cpi	r16, 0x12		; 1E33 3102
		brne	avr1E37		; 1E34 F411
avr1E35:	ldi	r16, 0x04		; 1E35 E004
		rjmp	avr1E7A		; 1E36 C043
avr1E37:	cpi	r16, 0x13		; 1E37 3103
		brne	avr1E3B		; 1E38 F411
		ldi	r16, 0x08		; 1E39 E008
		rjmp	avr1E7A		; 1E3A C03F
avr1E3B:	cpi	r16, 0x14		; 1E3B 3104
		brne	avr1E3F		; 1E3C F411
		ldi	r16, 0x10		; 1E3D E100
		rjmp	avr1E7A		; 1E3E C03B
avr1E3F:	cpi	r16, 0x15		; 1E3F 3105
		brne	avr1E43		; 1E40 F411
		ldi	r16, 0x20		; 1E41 E200
avr1E42:	rjmp	avr1E7A		; 1E42 C037
avr1E43:	cpi	r16, 0x16		; 1E43 3106
		brne	avr1E47		; 1E44 F411
		ldi	r16, 0x40		; 1E45 E400
		rjmp	avr1E7A		; 1E46 C033
avr1E47:	cpi	r16, 0x17		; 1E47 3107
		brne	avr1E4B		; 1E48 F411
		ldi	r16, 0x80		; 1E49 E800
avr1E4A:	rjmp	avr1E7A		; 1E4A C02F
avr1E4B:	cpi	r16, 0x18		; 1E4B 3108
		brne	avr1E4F		; 1E4C F411
		ldi	r16, 0x01		; 1E4D E001
		rjmp	avr1E81		; 1E4E C032
avr1E4F:	cpi	r16, 0x19		; 1E4F 3109
		brne	avr1E53		; 1E50 F411
avr1E51:	ldi	r16, 0x02		; 1E51 E002
		rjmp	avr1E81		; 1E52 C02E
avr1E53:	cpi	r16, 0x1A		; 1E53 310A
		brne	avr1E57		; 1E54 F411
avr1E55:	ldi	r16, 0x04		; 1E55 E004
		rjmp	avr1E81		; 1E56 C02A
avr1E57:	cpi	r16, 0x1B		; 1E57 310B
		brne	avr1E5B		; 1E58 F411
		ldi	r16, 0x08		; 1E59 E008
		rjmp	avr1E81		; 1E5A C026
avr1E5B:	cpi	r16, 0x1C		; 1E5B 310C
		brne	avr1E5F		; 1E5C F411
		ldi	r16, 0x10		; 1E5D E100
		rjmp	avr1E81		; 1E5E C022
avr1E5F:	cpi	r16, 0x1D		; 1E5F 310D
avr1E60:	brne	avr1E63		; 1E60 F411
		ldi	r16, 0x20		; 1E61 E200
		rjmp	avr1E81		; 1E62 C01E
avr1E63:	cpi	r16, 0x1E		; 1E63 310E
		brne	avr1E67		; 1E64 F411
		ldi	r16, 0x40		; 1E65 E400
		rjmp	avr1E81		; 1E66 C01A
avr1E67:	cpi	r16, 0x1F		; 1E67 310F
avr1E68:	brne	avr1E6B		; 1E68 F411
		ldi	r16, 0x80		; 1E69 E800
		rjmp	avr1E81		; 1E6A C016
avr1E6B:	rjmp	avr1E88		; 1E6B C01C
avr1E6C:	lds	r17, 0x04EB		; 1E6C 9110 04EB
avr1E6E:	com	r16			; 1E6E 9500
			and	r16, r17		; 1E6F 2301
			sts	0x04EB, r16		; 1E70 9300 04EB
			rjmp	avr1E88		; 1E72 C015
avr1E73:	lds	r17, 0x04EC		; 1E73 9110 04EC
		com	r16			; 1E75 9500
		and	r16, r17		; 1E76 2301
		sts	0x04EC, r16		; 1E77 9300 04EC
		rjmp	avr1E88		; 1E79 C00E
avr1E7A:	lds	r17, 0x04ED		; 1E7A 9110 04ED
		com	r16			; 1E7C 9500
		and	r16, r17		; 1E7D 2301
		sts	0x04ED, r16		; 1E7E 9300 04ED
avr1E80:	rjmp	avr1E88		; 1E80 C007
avr1E81:	lds	r17, 0x04EE		; 1E81 9110 04EE
		com	r16			; 1E83 9500
		and	r16, r17		; 1E84 2301
		sts	0x04EE, r16		; 1E85 9300 04EE
		rjmp	avr1E88		; 1E87 C000
avr1E88:	lds	r16, 0x04D2		; 1E88 9100 04D2
			sbrc	r16, 5		; 1E8A FD05
			ret				; 1E8B 9508
			jmp	avr0093		; 1E8C 940C 0093

;--------------------------------------------------------
;Here for IM Code DC

avr1E8E:	lds		r16, 0x04E3		; 1E8E 9100 04E3 first 6 servos in motion ?
			andi	r16, 0x3F		; 1E90 730F
			cpi		r16, 0x3F		; 1E91 330F
			brne	avr1EB5			; 1E92 F511
avr1E93:	ldi		YH, 0x03		; 1E93 E0D3 Y = Desired position
			ldi		YL, 0x00		; 1E94 E0C0
			ldi		r16, 0x06		; 1E95 E006 6 values
			rcall	sub2298			; 1E96 D401 get next IM values into Y
			push	XH				; 1E97 93BF
			push	XL				; 1E98 93AF
			ldi		XH, 0x03		; 1E99 E0B3
			ldi		XL, 0x00		; 1E9A E0A0
			ldi		YH, 0x03		; 1E9B E0D3
			ldi		YL, 0x20		; 1E9C E2C0
			ldi		ZH, 0x04		; 1E9D E0F4
avr1E9E:	ldi		ZL, 0x00		; 1E9E E0E0
			ldi		r16, 0x06		; 1E9F E006 6 values
			rcall	sub22A4			; 1EA0 D403
			ldi		ZH, 0x04		; 1EA1 E0F4
			ldi		ZL, 0x00		; 1EA2 E0E0
			ldi		r16, 0x05		; 1EA3 E005
			rcall	sub22B3			; 1EA4 D40E
			pop		XL				; 1EA5 91AF
avr1EA6:	pop		XH				; 1EA6 91BF
			ldi		YH, 0x03		; 1EA7 E0D3
			ldi		YL, 0xC0		; 1EA8 ECC0
			ldi		ZH, 0x04		; 1EA9 E0F4
			ldi		ZL, 0x00		; 1EAA E0E0
			ldi		r16, 0x06		; 1EAB E006
avr1EAC:	rcall	sub22BF			; 1EAC D412
			lds		r16, 0x04E3		; 1EAD 9100 04E3
			andi	r16, 0xC0		; 1EAF 7C00
			sts		0x04E3, r16		; 1EB0 9300 04E3
			ldi		ZH, 0x00		; 1EB2 E0F0
			ldi		ZL, 0x93		; 1EB3 E9E3
			ijmp					; 1EB4 9409

avr1EB5:	sbiw	XL, 0x01		; 1EB5 9711
			ldi		ZH, 0x00		; 1EB6 E0F0
			ldi		ZL, 0x93		; 1EB7 E9E3
			ijmp					; 1EB8 9409

;------------------------------------------------------------------------
; Here for IM Code DD SPEED

avr1EB9:	call	sub0B8B			; 1EB9 940E 0B8B
			mov		r17, r23		; 1EBB 2F17
;-------------------------------------------------------------------------
; set servo speed
; speed is in r17
sub1EBC:	cpi		r17, 0x10		; 1EBC 3110
			brlo	avr1EBF			; 1EBD F008
			ldi		r17, 0x0F		; 1EBE E01F if > 15 then 15
avr1EBF:	tst		r17				; 1EBF 2311
			brne	avr1EC2			; 1EC0 F409
			ldi		r17, 0x01		; 1EC1 E011 Speed must be in range 1 to 15
avr1EC2:	sts		0x04D4, r17		; 1EC2 9310 04D4 put speed in location 0x4D4
			lds		r16, 0x04D2		; 1EC4 9100 04D2
			sbrc	r16, 5			; 1EC6 FD05
			ret						; 1EC7 9508 if bit 5 in 0x4D2 is set
			jmp		avr0093			; 1EC8 940C 0093 else done

;--------------------------------------------------------------------
; Here for IM Byte code DE PWM

avr1ECA:	call	sub0B8B		; 1ECA 940E 0B8B get next IM value PWM number
			mov	r17, r23		; 1ECC 2F17
			call	sub0B8B		; 1ECD 940E 0B8B get next IM value RATE
			mov	r16, r23		; 1ECF 2F07

sub1ED0:	cpi	r17, 0x00		; 1ED0 3010 PWM0 ?
			breq	avr1ED7		; 1ED1 F029
avr1ED2:	cpi	r17, 0x01		; 1ED2 3011 PWM1 ?
			breq	avr1EEA		; 1ED3 F0B1
			cpi	r17, 0x02		; 1ED4 3012 PWM2 ?
			breq	avr1EFD		; 1ED5 F139
			rjmp	avr1F10		; 1ED6 C039
avr1ED7:	sbi	$02, 3			; 1ED7 9A13 PWM0 set data direction
			lds	r17, 0x008B		; 1ED8 9110 008B get TCR3 bits
			tst	r16				; 1EDA 2300 if 0
avr1EDB:	breq	avr1EDE		; 1EDB F011
			ori	r17, 0x81		; 1EDC 6811 set bits 0 and 7
			rjmp	avr1EDF		; 1EDD C001
avr1EDE:	andi	r17, 0x3F	; 1EDE 731F clear bits 6 and 7
avr1EDF:	sts	0x008B, r17		; 1EDF 9310 008B store
			ldi	r17, 0x0B		; 1EE1 E01B  set 
			sts	0x008A, r17		; 1EE2 9310 008A
			ldi	r17, 0x00		; 1EE4 E010
			sts	0x0087, r17		; 1EE5 9310 0087
			sts	0x0086, r16		; 1EE7 9300 0086 set compare value
			rjmp	avr1F10		; 1EE9 C026
avr1EEA:	sbi	$02, 4			; 1EEA 9A14 PWM1 set data direction
			lds	r17, 0x008B		; 1EEB 9110 008B
			tst	r16				; 1EED 2300
			breq	avr1EF1		; 1EEE F011
			ori	r17, 0x21		; 1EEF 6211 set bits 0 and 5
			rjmp	avr1EF2		; 1EF0 C001
avr1EF1:	andi	r17, 0xCF	; 1EF1 7C1F clear bits 4 and 5
avr1EF2:	sts	0x008B, r17		; 1EF2 9310 008B
avr1EF4:	ldi	r17, 0x0B		; 1EF4 E01B
			sts	0x008A, r17		; 1EF5 9310 008A
			ldi	r17, 0x00		; 1EF7 E010
			sts	0x0085, r17		; 1EF8 9310 0085
avr1EFA:	sts	0x0084, r16		; 1EFA 9300 0084
			rjmp	avr1F10		; 1EFC C013
avr1EFD:	sbi	$02, 5			; 1EFD 9A15 PWM2 set data direction
			lds	r17, 0x008B		; 1EFE 9110 008B
			tst	r16				; 1F00 2300
			breq	avr1F04		; 1F01 F011
			ori	r17, 0x09		; 1F02 6019 set bits 0 and 3
			rjmp	avr1F05		; 1F03 C001
avr1F04:	andi	r17, 0xF3	; 1F04 7F13 clear bits 2 and 3
avr1F05:	sts	0x008B, r17		; 1F05 9310 008B
			ldi	r17, 0x0B		; 1F07 E01B
			sts	0x008A, r17		; 1F08 9310 008A
			ldi	r17, 0x00		; 1F0A E010
			sts	0x0083, r17		; 1F0B 9310 0083
			sts	0x0082, r16		; 1F0D 9300 0082
avr1F0F:	rjmp	avr1F10		; 1F0F C000
avr1F10:	lds	r16, 0x04D2		; 1F10 9100 04D2
			sbrc	r16, 5		; 1F12 FD05
			ret					; 1F13 9508
			jmp	avr0093			; 1F14 940C 0093
;------------------------------------------------------
; Here for IM code DF SERVO
; sets desired servo position in RAM 0x300 based on IM code

avr1F16:	ldi	ZH, 0x03		; 1F16 E0F3 Point to desired position
			ldi	ZL, 0x00		; 1F17 E0E0
			call	sub0B8B		; 1F18 940E 0B8B get the servo number
			mov	r17, r23		; 1F1A 2F17
			add	ZL, r23			; 1F1B 0FE7 point into RAM 0x300 + servo number
			brsh	avr1F1E		; 1F1C F408
			inc	ZH				; 1F1D 95F3
avr1F1E:	call	sub0B8B		; 1F1E 940E 0B8B get the value
			tst	r23				; 1F20 2377 is it null ?
			breq	avr1F25		; 1F21 F019
			st	Z, r23			; 1F22 8370 store the value
avr1F23:	call	sub1F30		; 1F23 940E 1F30 set the move speed
avr1F25:	jmp	avr0093			; 1F25 940C 0093
;-------------------------------------------------------------------------
; Sets desired servo position in RAM 0x300
; r17 = servo number, r16 = value
sub1F27:	ldi	ZH, 0x03		; 1F27 E0F3
			ldi	ZL, 0x00		; 1F28 E0E0
			add	ZL, r17			; 1F29 0FE1
			brsh	avr1F2C		; 1F2A F408
			inc	ZH				; 1F2B 95F3
avr1F2C:	st	Z, r16			; 1F2C 8300
			call	sub1F30		; 1F2D 940E 1F30
			ret					; 1F2F 9508
;-------------------------------------------------------------------------
; Sets the speed delta at 0x3C0 to Speed * 17
; r17 = servo number, 
sub1F30:	ldi	YH, 0x03		; 1F30 E0D3 point to ram 0x3C0 + servo number
			ldi	YL, 0xC0		; 1F31 ECC0
			add	YL, r17			; 1F32 0FC1
			brsh	avr1F35		; 1F33 F408
			inc	YH				; 1F34 95D3
avr1F35:	lds	r16, 0x04D4		; 1F35 9100 04D4 get speed
			ldi	r17, 0x00		; 1F37 E010
			ldi	r19, 0x11		; 1F38 E131
avr1F39:	add	r17, r19		; 1F39 0F13
			dec	r16				; 1F3A 950A
			brne	avr1F39		; 1F3B F7E9
			st	Y, r17			; 1F3C 8318 r17 = speed * 17
avr1F3D:	ret					; 1F3D 9508
;-------------------------------------------------------------------------
; Here for IM Code B0 MOVE

avr1F3E:	call	sub07D6			; 1F3E 940E 07D6 get first servo
			mov		r20, r16		; 1F40 2F40
			call	sub07D6			; 1F41 940E 07D6 get number of servos
			mov		r21, r16		; 1F43 2F50
			rcall	sub2310			; 1F44 D3CB are any of these servos busy ?
avr1F45:	brsh	avr1F6F			; 1F45 F548
			ldi		YH, 0x03		; 1F46 E0D3 *Y =  pointer to desired
			ldi		YL, 0x00		; 1F47 E0C0
			rcall	sub23CA			; 1F48 D481 *Y = Y + r20
			mov		r16, r21		; 1F49 2F05
			rcall	sub2298			; 1F4A D34D fill (Y + r20)++ with next bytes
avr1F4B:	lds		r16, 0x04D2		; 1F4B 9100 04D2 If PTP all on then set for all servos
			sbrs	r16, 7			; 1F4D FF07
			rjmp	avr1F51			; 1F4E C002
			ldi		r20, 0x00		; 1F4F E040 first servo = 0
			ldi		r21, 0x20		; 1F50 E250 all servos
avr1F51:	push	XH				; 1F51 93BF
			push	XL				; 1F52 93AF
			ldi		XH, 0x03		; 1F53 E0B3 *X = 300 desired position
			ldi		XL, 0x00		; 1F54 E0A0
			ldi		YH, 0x03		; 1F55 E0D3 *Y = 320 current position
			ldi		YL, 0x20		; 1F56 E2C0
			ldi		ZH, 0x04		; 1F57 E0F4 *Z = 400 mod(X - Y)
			ldi		ZL, 0x00		; 1F58 E0E0
			rcall	sub23A7			; 1F59 D44D add r20 to *X, *Y, *Z
			mov		r16, r21		; 1F5A 2F05
			rcall	sub22A4			; 1F5B D348  Z = mod (X - Y)
			ldi		ZH, 0x04		; 1F5C E0F4
			ldi		ZL, 0x00		; 1F5D E0E0
			rcall	sub23D4			; 1F5E D475  Z = Z + r20
			mov		r16, r21		; 1F5F 2F05
			dec		r16				; 1F60 950A
			rcall	sub22B3			; 1F61 D351 get largest move into 0x4DB
			pop		XL				; 1F62 91AF
			pop		XH				; 1F63 91BF
			ldi		YH, 0x03		; 1F64 E0D3 Y = speed delta
			ldi		YL, 0xC0		; 1F65 ECC0
			ldi		ZH, 0x04		; 1F66 E0F4 Z = dist to move
			ldi		ZL, 0x00		; 1F67 E0E0
			rcall	sub23BF			; 1F68 D456 Add r20 to both Y and Z
			mov		r16, r21		; 1F69 2F05 all servos
			rcall	sub22BF			; 1F6A D354 
			rcall	sub2331			; 1F6B D3C5 sets sync move in progress bits
			ldi		ZH, 0x00		; 1F6C E0F0
			ldi		ZL, 0x93		; 1F6D E9E3
			ijmp					; 1F6E 9409

; too busy come back later
avr1F6F:	sbiw	XL, 0x03		; 1F6F 9713 move instruction pointer back
			ldi		ZH, 0x00		; 1F70 E0F0
			ldi		ZL, 0x93		; 1F71 E9E3
			ijmp					; 1F72 9409
;------------------------------------------------
; Here for IM code B1 POS		Set a robot pose
avr1F73:	adiw	XL, 0x01		; 1F73 9611 skip next code
avr1F74:	call	sub07D6			; 1F74 940E 07D6 get next code
			mov		r21, r16		; 1F76 2F50
			rcall	sub23DE			; 1F77 D466 add code to X
			ldi		ZH, 0x00		; 1F78 E0F0
			ldi		ZL, 0x93		; 1F79 E9E3
			ijmp					; 1F7A 9409
;-------------------------------------------------
; Here for IM Code B2 MOVEPOS   Execute a Pose
avr1F7B:	call	sub07D6		; 1F7B 940E 07D6
avr1F7D:	mov	r20, r16		; 1F7D 2F40
			call	sub07D6		; 1F7E 940E 07D6
			mov	r21, r16		; 1F80 2F50
avr1F81:	push	XH			; 1F81 93BF
		push	XL			; 1F82 93AF
			mov	XL, r20		; 1F83 2FA4
		mov	XH, r21		; 1F84 2FB5
		adiw	XL, 0x01		; 1F85 9611
		call	sub07D6		; 1F86 940E 07D6
		mov	r20, r16		; 1F88 2F40
		call	sub07D6		; 1F89 940E 07D6
		mov	r21, r16		; 1F8B 2F50
		rcall	sub2310		; 1F8C D383
		brsh	avr1FC1		; 1F8D F598
avr1F8E:	ldi	YH, 0x03		; 1F8E E0D3
		ldi	YL, 0x00		; 1F8F E0C0
		rcall	sub23CA		; 1F90 D439
		mov	r16, r21		; 1F91 2F05
		rcall	sub2298		; 1F92 D305
		ldi	XH, 0x03		; 1F93 E0B3
		ldi	XL, 0x00		; 1F94 E0A0
		ldi	YH, 0x03		; 1F95 E0D3
avr1F96:	ldi	YL, 0x20		; 1F96 E2C0
		ldi	ZH, 0x04		; 1F97 E0F4
		ldi	ZL, 0x00		; 1F98 E0E0
		lds	r16, 0x04D2		; 1F99 9100 04D2
		sbrc	r16, 7		; 1F9B FD07
avr1F9C:	rjmp	avr1FA0		; 1F9C C003
		rcall	sub23A7		; 1F9D D409
		mov	r16, r21		; 1F9E 2F05
		rjmp	avr1FA1		; 1F9F C001
avr1FA0:	ldi	r16, 0x20		; 1FA0 E200
avr1FA1:	rcall	sub22A4		; 1FA1 D302
		ldi	ZH, 0x04		; 1FA2 E0F4
		ldi	ZL, 0x00		; 1FA3 E0E0
		lds	r16, 0x04D2		; 1FA4 9100 04D2
		sbrc	r16, 7		; 1FA6 FD07
		rjmp	avr1FAB		; 1FA7 C003
		rcall	sub23D4		; 1FA8 D42B
		mov	r16, r21		; 1FA9 2F05
		rjmp	avr1FAD		; 1FAA C002
avr1FAB:	ldi	r16, 0x20		; 1FAB E200
		dec	r16			; 1FAC 950A
avr1FAD:	rcall	sub22B3		; 1FAD D305
		ldi	YH, 0x03		; 1FAE E0D3
		ldi	YL, 0xC0		; 1FAF ECC0
		ldi	ZH, 0x04		; 1FB0 E0F4
avr1FB1:	ldi	ZL, 0x00		; 1FB1 E0E0
		lds	r16, 0x04D2		; 1FB2 9100 04D2
		sbrc	r16, 7		; 1FB4 FD07
avr1FB5:	rjmp	avr1FB9		; 1FB5 C003
		rcall	sub23BF		; 1FB6 D408
		mov	r16, r21		; 1FB7 2F05
		rjmp	avr1FBA		; 1FB8 C001
avr1FB9:	ldi	r16, 0x20		; 1FB9 E200
avr1FBA:	rcall	sub22BF		; 1FBA D304
		rcall	sub2331		; 1FBB D375
		pop	XL			; 1FBC 91AF
avr1FBD:	pop	XH			; 1FBD 91BF
		ldi	ZH, 0x00		; 1FBE E0F0
		ldi	ZL, 0x93		; 1FBF E9E3
		ijmp				; 1FC0 9409
avr1FC1:	pop	XL			; 1FC1 91AF
		pop	XH			; 1FC2 91BF
		sbiw	XL, 0x03		; 1FC3 9713
		ldi	ZH, 0x00		; 1FC4 E0F0
		ldi	ZL, 0x93		; 1FC5 E9E3
		ijmp				; 1FC6 9409
;---------------------------------------------------------------
; Here for IM code B3 ZERO
; store zero offsets in RAM at 0x340 and internal EEPROM at 0xFE0

avr1FC7:	call	sub07D6		; 1FC7 940E 07D6 get next value servo
			mov	r20, r16		; 1FC9 2F40
			call	sub07D6		; 1FCA 940E 07D6 get next value zero pos
			mov	r21, r16		; 1FCC 2F50
			ldi	YH, 0x03		; 1FCD E0D3
			ldi	YL, 0x40		; 1FCE E4C0
			rcall	sub23CA		; 1FCF D3FA Y = Y + r20
			mov	r18, r21		; 1FD0 2F25
			call	sub22F9		; 1FD1 940E 22F9 store zero offsets in RAM
			push	XL			; 1FD3 93AF
			push	XH			; 1FD4 93BF
			ldi	YH, 0x03		; 1FD5 E0D3
			ldi	YL, 0x40		; 1FD6 E4C0
sub1FD7:	ldi	XH, 0x0F		; 1FD7 E0BF
			ldi	XL, 0xE0		; 1FD8 EEA0
			rcall	sub23B3		; 1FD9 D3D9  X = X + r20 and Y = Y +r20 and Z = Z + r20
			mov	r18, r21		; 1FDA 2F25
			call	sub2304		; 1FDB 940E 2304
			pop	XH				; 1FDD 91BF
			pop	XL				; 1FDE 91AF
avr1FDF:	ldi	ZH, 0x00		; 1FDF E0F0
			ldi	ZL, 0x93		; 1FE0 E9E3
			ijmp				; 1FE1 9409

;---------------------------------------------------------------------------
; Here for IM code B4 DIR
; next 3 bytes are dir

avr1FE2:	call	sub07D6		; 1FE2 940E 07D6
			mov	r20, r16		; 1FE4 2F40
			call	sub07D6		; 1FE5 940E 07D6
			mov	r21, r16		; 1FE7 2F50
avr1FE8:	call	sub07D6		; 1FE8 940E 07D6
			mov	r22, r16		; 1FEA 2F60
			call	sub2360		; 1FEB 940E 2360
			ldi	ZH, 0x00		; 1FED E0F0
			ldi	ZL, 0x93		; 1FEE E9E3
			ijmp				; 1FEF 9409
;------------------------------------------------------------------------------
; Here for IM code b5 INIT
; save initial values in internal EEPROM

avr1FF0:	call	sub07D6		; 1FF0 940E 07D6 get next byte
			mov	r20, r16		; 1FF2 2F40
			call	sub07D6		; 1FF3 940E 07D6 get next byte
			mov	r21, r16		; 1FF5 2F50
			ldi	YH, 0x0F		; 1FF6 E0DF
			ldi	YL, 0xC0		; 1FF7 ECC0
			rcall	sub23CA		; 1FF8 D3D1 Y = Y + r20
			mov	r18, r21		; 1FF9 2F25
avr1FFA:	call	sub07D6		; 1FFA 940E 07D6 get and sve bytes in EEPROM if different
avr1FFC:	push	XH			; 1FFC 93BF
			push	XL			; 1FFD 93AF
			mov	XH, YH			; 1FFE 2FBD
			mov	XL, YL			; 1FFF 2FAC
			mov	r17, r16		; 2000 2F10
			call	sub0815		; 2001 940E 0815
			cp	r16, r17		; 2003 1701 save if different
			breq	avr2009		; 2004 F021
			mov	r16, r17		; 2005 2F01
			subi	XL, 0x01	; 2006 50A1
			call	sub0819		; 2007 940E 0819
avr2009:	mov	YH, XH			; 2009 2FDB
			mov	YL, XL			; 200A 2FCA
			pop	XL				; 200B 91AF
			pop	XH				; 200C 91BF
			dec	r18				; 200D 952A
			brne	avr1FFA		; 200E F759
			jmp	avr0093			; 200F 940C 0093
;--------------------------------------------------------------------------
;Here for IM code B6 SERVO CONTROL

avr2011:	call	sub07D6		; 2011 940E 07D6
			cpi	r16, 0x00		; 2013 3000 HIGH SPEED SET OFF
			breq	avr2028		; 2014 F099
			cpi	r16, 0x01		; 2015 3001 HIGH SPEED SET ON
			breq	avr202C		; 2016 F0A9
			cpi	r16, 0x02		; 2017 3002 AIMOTOR SET OFF
			breq	avr2030		; 2018 F0B9
			cpi	r16, 0x03		; 2019 3003 AIMOTOR SETON
			breq	avr2036		; 201A F0D9
			cpi	r16, 0x04		; 201B 3004 AIMOTOR INIT
			breq	avr203C		; 201C F0F9
			cpi	r16, 0x05		; 201D 3005 PTPALL OFF
			breq	avr2042		; 201E F119
			cpi	r16, 0x06		; 201F 3006 PTP ALL ON
			breq	avr2048		; 2020 F139
			cpi	r16, 0xFE		; 2021 3F0E seems to be disabled
			breq	avr2024		; 2022 F009
			rjmp	avr204E		; 2023 C02A
avr2024:	cpi	r16, 0xFF		; 2024 3F0F seems to be disabled
			breq	avr2027		; 2025 F009
			rjmp	avr2085		; 2026 C05E
avr2027:	rjmp	avr20BC		; 2027 C094

avr2028:	ldi	r16, 0x00		; 2028 E000 High Speed Off 0x4EF = 0 
			sts	0x04EF, r16		; 2029 9300 04EF
			rjmp	avr20BC		; 202B C090

avr202C:	ser	r16				; 202C EF0F High Speed O 0x4EF = 0xFF
			sts	0x04EF, r16		; 202D 9300 04EF
			rjmp	avr20BC		; 202F C08C

avr2030:	lds	r16, 0x04F0		; 2030 9100 04F0 AIMOTOR Off clear bit 7 in 0x4F0
			andi	r16, 0x7F	; 2032 770F
			sts	0x04F0, r16		; 2033 9300 04F0
			rjmp	avr20BC		; 2035 C086

avr2036:		lds	r16, 0x04F0		; 2036 9100 04F0 AIMOTOR on sets bit 7 in 0x4F0
			ori	r16, 0x80		; 2038 6800
			sts	0x04F0, r16		; 2039 9300 04F0
			rjmp	avr20BC		; 203B C080

avr203C:	ldi	r16, 0x0B		; 203C E00B AIMOTOR INIT sets baud rate on USART0
			out	$09, r16		; 203D B909
			ldi	r16, 0x00		; 203E E000
			sts	0x0090, r16		; 203F 9300 0090
			rjmp	avr20BC		; 2041 C07A

avr2042:	lds	r16, 0x04D2		; 2042 9100 04D2 PTP OFF clears bit 7 in 0x4D2
			andi	r16, 0x7F		; 2044 770F
			sts	0x04D2, r16		; 2045 9300 04D2
			rjmp	avr20BC		; 2047 C074

avr2048:	lds	r16, 0x04D2		; 2048 9100 04D2 PTP On sets bit 7 in 0x4D2
			ori	r16, 0x80		; 204A 6800 
			sts	0x04D2, r16		; 204B 9300 04D2
			rjmp	avr20BC		; 204D C06E

avr204E:call	sub0824		; 204E 940E 0824 close 2 wire interface
		ldi	r16, 0x00		; 2050 E000
		out	$0A, r16		; 2051 B90A
		ldi	r16, 0x00		; 2052 E000
		out	PORTA, r16		; 2053 BB0B
		out	PORTB, r16		; 2054 BB08
		out	PORTC, r16		; 2055 BB05
		out	$03, r16		; 2056 B903
		sts	0x0062, r16		; 2057 9300 0062
		sts	0x0065, r16		; 2059 9300 0065
		ldi	r16, 0x20		; 205B E200
		out	PORTD, r16		; 205C BB02
		ldi	r17, 0x03		; 205D E013
avr205E:		ser	r16			; 205E EF0F
		out	DDRA, r16		; 205F BB0A
		out	DDRB, r16		; 2060 BB07
		out	DDRC, r16		; 2061 BB04
		out	DDRD, r16		; 2062 BB01
		out	$02, r16		; 2063 B902
		sts	0x0061, r16		; 2064 9300 0061
		sts	0x0064, r16		; 2066 9300 0064
		call	sub0263		; 2068 940E 0263
		call	sub0263		; 206A 940E 0263
		ldi	r16, 0x00		; 206C E000
		out	DDRA, r16		; 206D BB0A
		out	DDRB, r16		; 206E BB07
		out	DDRC, r16		; 206F BB04
		out	DDRD, r16		; 2070 BB01
		out	$02, r16		; 2071 B902
		sts	0x0061, r16		; 2072 9300 0061
		sts	0x0064, r16		; 2074 9300 0064
		call	sub0263		; 2076 940E 0263
		dec	r17			; 2078 951A
		brne	avr205E		; 2079 F721
		call	sub02B6		; 207A 940E 02B6
		call	sub081D		; 207C 940E 081D Reopen 2 wire interface
		in	r16, $0A		; 207E B10A
		ori	r16, 0x18		; 207F 6108
		call	sub02C2		; 2080 940E 02C2
		call	sub02CD		; 2082 940E 02CD
		rjmp	avr20BC		; 2084 C037

avr2085:		call	sub0824		; 2085 940E 0824 Close 2 wire interface
		ldi	r16, 0x00		; 2087 E000
		out	$0A, r16		; 2088 B90A
		ser	r16			; 2089 EF0F
		out	DDRA, r16		; 208A BB0A
		out	DDRB, r16		; 208B BB07
		out	DDRC, r16		; 208C BB04
		out	DDRD, r16		; 208D BB01
		out	$02, r16		; 208E B902
		sts	0x0061, r16		; 208F 9300 0061
		sts	0x0064, r16		; 2091 9300 0064
		ldi	r17, 0x03		; 2093 E013
avr2094:		ser	r16			; 2094 EF0F
		out	PORTA, r16		; 2095 BB0B
		out	PORTB, r16		; 2096 BB08
		out	PORTC, r16		; 2097 BB05
		out	PORTD, r16		; 2098 BB02
		out	$03, r16		; 2099 B903
		sts	0x0062, r16		; 209A 9300 0062
		sts	0x0065, r16		; 209C 9300 0065
		call	sub0263		; 209E 940E 0263
		call	sub0263		; 20A0 940E 0263
		ldi	r16, 0x00		; 20A2 E000
		out	PORTA, r16		; 20A3 BB0B
		out	PORTB, r16		; 20A4 BB08
		out	PORTC, r16		; 20A5 BB05
		out	$03, r16		; 20A6 B903
		sts	0x0062, r16		; 20A7 9300 0062
		sts	0x0065, r16		; 20A9 9300 0065
		ldi	r16, 0x20		; 20AB E200
		out	PORTD, r16		; 20AC BB02
		call	sub0263		; 20AD 940E 0263
		dec	r17			; 20AF 951A
		brne	avr2094		; 20B0 F719
		call	sub02B6		; 20B1 940E 02B6
		call	sub081D		; 20B3 940E 081D Reopen 2 wire interface
		in	r16, $0A		; 20B5 B10A
		ori	r16, 0x18		; 20B6 6108
		call	sub02C2		; 20B7 940E 02C2
		call	sub02CD		; 20B9 940E 02CD
		rjmp	avr20BC		; 20BB C000

avr20BC:		jmp	avr0093		; 20BC 940C 0093

		ldi	ZH, 0x03		; 20BE E0F3
		ldi	ZL, 0x00		; 20BF E0E0
		ldi	YH, 0x03		; 20C0 E0D3
		ldi	YL, 0x20		; 20C1 E2C0
		ldi	r21, 0x00		; 20C2 E050
avr20C3:		wdr				; 20C3 95A8
		ldi	r16, 0x00		; 20C4 E000
		mov	r17, r21		; 20C5 2F15
		call	sub40A8		; 20C6 940E 40A8
		subi	r16, 0x1C		; 20C8 510C
		st	Z+, r16		; 20C9 9301
		st	Y+, r16		; 20CA 9309
		inc	r21			; 20CB 9553
		cpi	r21, 0x10		; 20CC 3150
		breq	avr20CF		; 20CD F009
		brne	avr20C3		; 20CE F7A1
avr20CF:		ret				; 20CF 9508
;-------------------------------------------------------------------------
; Here for IM code B7 AIMOTOR 
avr20D0:	call	sub0B8B		; 20D0 940E 0B8B get IM value
			mov	r16, r23		; 20D2 2F07
			cpi	r16, 0x00		; 20D3 3000
			brne	avr20D7		; 20D4 F411
			ldi	r16, 0x01		; 20D5 E001
			rjmp	avr2154		; 20D6 C07D
avr20D7:	cpi	r16, 0x01		; 20D7 3001
			brne	avr20DB		; 20D8 F411
			ldi	r16, 0x02		; 20D9 E002
			rjmp	avr2154		; 20DA C079
avr20DB:	cpi	r16, 0x02		; 20DB 3002
			brne	avr20DF		; 20DC F411
			ldi	r16, 0x04		; 20DD E004
			rjmp	avr2154		; 20DE C075
avr20DF:	cpi	r16, 0x03		; 20DF 3003
			brne	avr20E3		; 20E0 F411
			ldi	r16, 0x08		; 20E1 E008
			rjmp	avr2154		; 20E2 C071
avr20E3:	cpi	r16, 0x04		; 20E3 3004
			brne	avr20E7		; 20E4 F411
			ldi	r16, 0x10		; 20E5 E100
			rjmp	avr2154		; 20E6 C06D
avr20E7:	cpi	r16, 0x05		; 20E7 3005
			brne	avr20EB		; 20E8 F411
			ldi	r16, 0x20		; 20E9 E200
			rjmp	avr2154		; 20EA C069
avr20EB:	cpi	r16, 0x06		; 20EB 3006
			brne	avr20EF		; 20EC F411
			ldi	r16, 0x40		; 20ED E400
			rjmp	avr2154		; 20EE C065
avr20EF:	cpi	r16, 0x07		; 20EF 3007
			brne	avr20F3		; 20F0 F411
			ldi	r16, 0x80		; 20F1 E800
			rjmp	avr2154		; 20F2 C061
avr20F3:	cpi	r16, 0x08		; 20F3 3008
			brne	avr20F7		; 20F4 F411
			ldi	r16, 0x01		; 20F5 E001
			rjmp	avr215A		; 20F6 C063
avr20F7:	cpi	r16, 0x09		; 20F7 3009
			brne	avr20FB		; 20F8 F411
			ldi	r16, 0x02		; 20F9 E002
			rjmp	avr215A		; 20FA C05F
avr20FB:	cpi	r16, 0x0A		; 20FB 300A
			brne	avr20FF		; 20FC F411
			ldi	r16, 0x04		; 20FD E004
			rjmp	avr215A		; 20FE C05B
avr20FF:	cpi	r16, 0x0B		; 20FF 300B
			brne	avr2103		; 2100 F411
			ldi	r16, 0x08		; 2101 E008
			rjmp	avr215A		; 2102 C057
avr2103:	cpi	r16, 0x0C		; 2103 300C
			brne	avr2107		; 2104 F411
			ldi	r16, 0x10		; 2105 E100
			rjmp	avr215A		; 2106 C053
avr2107:	cpi	r16, 0x0D		; 2107 300D
			brne	avr210B		; 2108 F411
			ldi	r16, 0x20		; 2109 E200
			rjmp	avr215A		; 210A C04F
avr210B:	cpi	r16, 0x0E		; 210B 300E
			brne	avr210F		; 210C F411
			ldi	r16, 0x40		; 210D E400
			rjmp	avr215A		; 210E C04B
avr210F:	cpi	r16, 0x0F		; 210F 300F
			brne	avr2113		; 2110 F411
			ldi	r16, 0x80		; 2111 E800
			rjmp	avr215A		; 2112 C047
avr2113:	cpi	r16, 0x10		; 2113 3100
			brne	avr2117		; 2114 F411
			ldi	r16, 0x01		; 2115 E001
			rjmp	avr2160		; 2116 C049
avr2117:	cpi	r16, 0x11		; 2117 3101
			brne	avr211B		; 2118 F411
			ldi	r16, 0x02		; 2119 E002
			rjmp	avr2160		; 211A C045
avr211B:	cpi	r16, 0x12		; 211B 3102
			brne	avr211F		; 211C F411
			ldi	r16, 0x04		; 211D E004
			rjmp	avr2160		; 211E C041
avr211F:	cpi	r16, 0x13		; 211F 3103
			brne	avr2123		; 2120 F411
			ldi	r16, 0x08		; 2121 E008
			rjmp	avr2160		; 2122 C03D
avr2123:	cpi	r16, 0x14		; 2123 3104
			brne	avr2127		; 2124 F411
			ldi	r16, 0x10		; 2125 E100
			rjmp	avr2160		; 2126 C039
avr2127:	cpi	r16, 0x15		; 2127 3105
			brne	avr212B		; 2128 F411
			ldi	r16, 0x20		; 2129 E200
			rjmp	avr2160		; 212A C035
avr212B:	cpi	r16, 0x16		; 212B 3106
			brne	avr212F		; 212C F411
			ldi	r16, 0x40		; 212D E400
			rjmp	avr2160		; 212E C031
avr212F:	cpi	r16, 0x17		; 212F 3107
			brne	avr2133		; 2130 F411
			ldi	r16, 0x80		; 2131 E800
			rjmp	avr2160		; 2132 C02D
avr2133:	cpi	r16, 0x18		; 2133 3108
			brne	avr2137		; 2134 F411
			ldi	r16, 0x01		; 2135 E001
			rjmp	avr2166		; 2136 C02F
avr2137:	cpi	r16, 0x19		; 2137 3109
			brne	avr213B		; 2138 F411
			ldi	r16, 0x02		; 2139 E002
			rjmp	avr2166		; 213A C02B
avr213B:	cpi	r16, 0x1A		; 213B 310A
			brne	avr213F		; 213C F411
			ldi	r16, 0x04		; 213D E004
			rjmp	avr2166		; 213E C027
avr213F:	cpi	r16, 0x1B		; 213F 310B
			brne	avr2143		; 2140 F411
			ldi	r16, 0x08		; 2141 E008
			rjmp	avr2166		; 2142 C023
avr2143:	cpi	r16, 0x1C		; 2143 310C
			brne	avr2147		; 2144 F411
			ldi	r16, 0x10		; 2145 E100
			rjmp	avr2166		; 2146 C01F
avr2147:	cpi	r16, 0x1D		; 2147 310D
			brne	avr214B		; 2148 F411
			ldi	r16, 0x20		; 2149 E200
			rjmp	avr2166		; 214A C01B
avr214B:	cpi	r16, 0x1E		; 214B 310E
			brne	avr214F		; 214C F411
			ldi	r16, 0x40		; 214D E400
			rjmp	avr2166		; 214E C017
avr214F:	cpi	r16, 0x1F		; 214F 310F
			brne	avr2153		; 2150 F411
			ldi	r16, 0x80		; 2151 E800
			rjmp	avr2166		; 2152 C013
avr2153:	rjmp	avr216C		; 2153 C018


avr2154:	lds	r17, 0x04CA		; 2154 9110 04CA
			or	r16, r17		; 2156 2B01
			sts	0x04CA, r16		; 2157 9300 04CA
			rjmp	avr216C		; 2159 C012

avr215A:	lds	r17, 0x04CB		; 215A 9110 04CB
			or	r16, r17		; 215C 2B01
			sts	0x04CB, r16		; 215D 9300 04CB
			rjmp	avr216C		; 215F C00C

avr2160:	lds	r17, 0x04CC		; 2160 9110 04CC
			or	r16, r17		; 2162 2B01
			sts	0x04CC, r16		; 2163 9300 04CC
			rjmp	avr216C		; 2165 C006

avr2166:	lds	r17, 0x04CD		; 2166 9110 04CD
			or	r16, r17		; 2168 2B01
			sts	0x04CD, r16		; 2169 9300 04CD
			rjmp	avr216C		; 216B C000
avr216C: 	jmp	avr0093		; 216C 940C 0093
;-----------------------------------------------------------
;

avr216E:	call	sub0B8B		; 216E 940E 0B8B
			mov	r16, r23		; 2170 2F07
			cpi	r16, 0x00		; 2171 3000
			brne	avr2175		; 2172 F411
			ldi	r16, 0x01		; 2173 E001
			rjmp	avr21F2		; 2174 C07D
avr2175:		cpi	r16, 0x01		; 2175 3001
			brne	avr2179		; 2176 F411
			ldi	r16, 0x02		; 2177 E002
			rjmp	avr21F2		; 2178 C079
avr2179:		cpi	r16, 0x02		; 2179 3002
			brne	avr217D		; 217A F411
			ldi	r16, 0x04		; 217B E004
			rjmp	avr21F2		; 217C C075
avr217D:		cpi	r16, 0x03		; 217D 3003
			brne	avr2181		; 217E F411
			ldi	r16, 0x08		; 217F E008
			rjmp	avr21F2		; 2180 C071
avr2181:		cpi	r16, 0x04		; 2181 3004
			brne	avr2185		; 2182 F411
			ldi	r16, 0x10		; 2183 E100
			rjmp	avr21F2		; 2184 C06D
avr2185:		cpi	r16, 0x05		; 2185 3005
			brne	avr2189		; 2186 F411
			ldi	r16, 0x20		; 2187 E200
			rjmp	avr21F2		; 2188 C069
avr2189:		cpi	r16, 0x06		; 2189 3006
			brne	avr218D		; 218A F411
			ldi	r16, 0x40		; 218B E400
			rjmp	avr21F2		; 218C C065
avr218D:		cpi	r16, 0x07		; 218D 3007
			brne	avr2191		; 218E F411
			ldi	r16, 0x80		; 218F E800
			rjmp	avr21F2		; 2190 C061
avr2191:	cpi	r16, 0x08		; 2191 3008
			brne	avr2195		; 2192 F411
			ldi	r16, 0x01		; 2193 E001
			rjmp	avr21F9		; 2194 C064
avr2195:	cpi	r16, 0x09		; 2195 3009
			brne	avr2199		; 2196 F411
			ldi	r16, 0x02		; 2197 E002
			rjmp	avr21F9		; 2198 C060
avr2199:	cpi	r16, 0x0A		; 2199 300A
			brne	avr219D		; 219A F411
			ldi	r16, 0x04		; 219B E004
			rjmp	avr21F9		; 219C C05C
avr219D:		cpi	r16, 0x0B		; 219D 300B
		brne	avr21A1		; 219E F411
		ldi	r16, 0x08		; 219F E008
		rjmp	avr21F9		; 21A0 C058
avr21A1:		cpi	r16, 0x0C		; 21A1 300C
		brne	avr21A5		; 21A2 F411
		ldi	r16, 0x10		; 21A3 E100
		rjmp	avr21F9		; 21A4 C054
avr21A5:		cpi	r16, 0x0D		; 21A5 300D
		brne	avr21A9		; 21A6 F411
		ldi	r16, 0x20		; 21A7 E200
		rjmp	avr21F9		; 21A8 C050
avr21A9:		cpi	r16, 0x0E		; 21A9 300E
		brne	avr21AD		; 21AA F411
		ldi	r16, 0x40		; 21AB E400
		rjmp	avr21F9		; 21AC C04C
avr21AD:		cpi	r16, 0x0F		; 21AD 300F
		brne	avr21B1		; 21AE F411
		ldi	r16, 0x80		; 21AF E800
		rjmp	avr21F9		; 21B0 C048
avr21B1:		cpi	r16, 0x10		; 21B1 3100
		brne	avr21B5		; 21B2 F411
		ldi	r16, 0x01		; 21B3 E001
		rjmp	avr2200		; 21B4 C04B
avr21B5:		cpi	r16, 0x11		; 21B5 3101
		brne	avr21B9		; 21B6 F411
		ldi	r16, 0x02		; 21B7 E002
		rjmp	avr2200		; 21B8 C047
avr21B9:		cpi	r16, 0x12		; 21B9 3102
		brne	avr21BD		; 21BA F411
		ldi	r16, 0x04		; 21BB E004
		rjmp	avr2200		; 21BC C043
avr21BD:		cpi	r16, 0x13		; 21BD 3103
		brne	avr21C1		; 21BE F411
		ldi	r16, 0x08		; 21BF E008
		rjmp	avr2200		; 21C0 C03F
avr21C1:		cpi	r16, 0x14		; 21C1 3104
		brne	avr21C5		; 21C2 F411
		ldi	r16, 0x10		; 21C3 E100
		rjmp	avr2200		; 21C4 C03B
avr21C5:		cpi	r16, 0x15		; 21C5 3105
		brne	avr21C9		; 21C6 F411
		ldi	r16, 0x20		; 21C7 E200
		rjmp	avr2200		; 21C8 C037
avr21C9:		cpi	r16, 0x16		; 21C9 3106
		brne	avr21CD		; 21CA F411
		ldi	r16, 0x40		; 21CB E400
		rjmp	avr2200		; 21CC C033
avr21CD:		cpi	r16, 0x17		; 21CD 3107
		brne	avr21D1		; 21CE F411
		ldi	r16, 0x80		; 21CF E800
		rjmp	avr2200		; 21D0 C02F
avr21D1:		cpi	r16, 0x18		; 21D1 3108
		brne	avr21D5		; 21D2 F411
		ldi	r16, 0x01		; 21D3 E001
		rjmp	avr2207		; 21D4 C032
avr21D5:		cpi	r16, 0x19		; 21D5 3109
		brne	avr21D9		; 21D6 F411
		ldi	r16, 0x02		; 21D7 E002
		rjmp	avr2207		; 21D8 C02E
avr21D9:		cpi	r16, 0x1A		; 21D9 310A
		brne	avr21DD		; 21DA F411
		ldi	r16, 0x04		; 21DB E004
		rjmp	avr2207		; 21DC C02A
avr21DD:		cpi	r16, 0x1B		; 21DD 310B
		brne	avr21E1		; 21DE F411
		ldi	r16, 0x08		; 21DF E008
		rjmp	avr2207		; 21E0 C026
avr21E1:		cpi	r16, 0x1C		; 21E1 310C
		brne	avr21E5		; 21E2 F411
		ldi	r16, 0x10		; 21E3 E100
		rjmp	avr2207		; 21E4 C022
avr21E5:		cpi	r16, 0x1D		; 21E5 310D
		brne	avr21E9		; 21E6 F411
		ldi	r16, 0x20		; 21E7 E200
		rjmp	avr2207		; 21E8 C01E
avr21E9:		cpi	r16, 0x1E		; 21E9 310E
		brne	avr21ED		; 21EA F411
		ldi	r16, 0x40		; 21EB E400
		rjmp	avr2207		; 21EC C01A
avr21ED:		cpi	r16, 0x1F		; 21ED 310F
		brne	avr21F1		; 21EE F411
		ldi	r16, 0x80		; 21EF E800
		rjmp	avr2207		; 21F0 C016
avr21F1:rjmp	avr220E		; 21F1 C01C

avr21F2:lds	r17, 0x04CA		; 21F2 9110 04CA
		com	r16				; 21F4 9500
		and	r16, r17		; 21F5 2301
		sts	0x04CA, r16		; 21F6 9300 04CA
		rjmp	avr220E		; 21F8 C015

avr21F9:		lds	r17, 0x04CB		; 21F9 9110 04CB
		com	r16			; 21FB 9500
		and	r16, r17		; 21FC 2301
		sts	0x04CB, r16		; 21FD 9300 04CB
		rjmp	avr220E		; 21FF C00E

avr2200:		lds	r17, 0x04CC		; 2200 9110 04CC
		com	r16			; 2202 9500
		and	r16, r17		; 2203 2301
		sts	0x04CC, r16		; 2204 9300 04CC
		rjmp	avr220E		; 2206 C007

avr2207:		lds	r17, 0x04CD		; 2207 9110 04CD
		com	r16			; 2209 9500
		and	r16, r17		; 220A 2301
		sts	0x04CD, r16		; 220B 9300 04CD
		rjmp	avr220E		; 220D C000
avr220E:		jmp	avr0093		; 220E 940C 0093

;-------------------------------------------------------------
; IM code B9 GETMOTORSET
; get measured position and saves in desired and actual position
;
avr2210:	call	sub07D6		; 2210 940E 07D6 getnext IM code first servo number
			mov	r20, r16		; 2212 2F40
			call	sub07D6		; 2213 940E 07D6 get next IM code servo count
			mov	r21, r16		; 2215 2F50
			ldi	YH, 0x03		; 2216 E0D3
			ldi	YL, 0x00		; 2217 E0C0
			ldi	ZH, 0x03		; 2218 E0F3
			ldi	ZL, 0x20		; 2219 E2E0
			rcall	sub23BF		; 221A D1A4 Y = y +r20 and Z= Z+r20
avr221B:	push	r20			; 221B 934F
			push	r21			; 221C 935F
			call	sub07D6		; 221D 940E 07D6 get value
			cpi	r16, 0x00		; 221F 3000 is it zero ?
			breq	avr2233		; 2220 F091
			push	YH			; 2221 93DF no then
			push	YL			; 2222 93CF
			push	ZH			; 2223 93FF
			push	ZL			; 2224 93EF
			mov	r16, r20		; 2225 2F04
			call	sub45CD		; 2226 940E 45CD get current position
			mov	r16, YL			; 2228 2F0C
			pop	ZL				; 2229 91EF
			pop	ZH				; 222A 91FF
			pop	YL				; 222B 91CF
			pop	YH				; 222C 91DF
			cpi	r16, 0x0A		; 222D 300A
			brlo	avr2233		; 222E F020
			cpi	r16, 0xBF		; 222F 3B0F
			brsh	avr2233		; 2230 F410
			st	Y, r16			; 2231 8308 store in 0x300 + offset and 0x320 + offset
			st	Z, r16			; 2232 8300
avr2233:	adiw	YL, 0x01		; 2233 9621
			adiw	ZL, 0x01		; 2234 9631
			pop	r21			; 2235 915F
			pop	r20			; 2236 914F
			inc	r20			; 2237 9543
			dec	r21			; 2238 955A
			brne	avr221B		; 2239 F709
			jmp	avr0093		; 223A 940C 0093
;------	--------------------------------------------------------
; here for IM code      music

avr223c:	adiw	XL, 0x02		; 223C 9612
			sts		0x050F, XH		; 223D 93B0 050F
			sts		0x0510, XL		; 223F 93A0 0510
			sts		0x050D, XH		; 2241 93B0 050D
			sts		0x050E, XL		; 2243 93A0 050E
			sbiw	XL, 0x02		; 2245 9712
			call	sub093D			; 2246 940E 093D initialise timer 1
			ldi		r16, 0xC0		; 2248 EC00
			sts		0x050A, r16		; 2249 9300 050A
			call	sub0950			; 224B 940E 0950 sounder on
avr224D:	lds		r16, 0x050A		; 224D 9100 050A
			sbrs	r16, 7			; 224F FF07
			rjmp	avr2255			; 2250 C004
			lds		r16, 0x009B		; 2251 9100 009B
			sbrs	r16, 7			; 2253 FF07
			rjmp	avr224D			; 2254 CFF8
avr2255:	ldi		ZH, 0x12		; 2255 E1F1
			ldi		ZL, 0x92		; 2256 ECEA
			ijmp					; 2257 9409

;----------------------------------------------------------
; Here for IM Code BB


avr2258:	lds		r16, 0x050D		; 2258 9100 050D
			lds		r17, 0x050E		; 225A 9110 050E
			sts		0x050F, r16		; 225C 9300 050F
			sts		0x0510, r17		; 225E 9310 0510
			lds		r16, 0x050A		; 2260 9100 050A
			ori		r16, 0x80		; 2262 6800
			sts		0x050A, r16		; 2263 9300 050A
			call	sub0950			; 2265 940E 0950
			ldi		ZH, 0x00		; 2267 E0F0
			ldi		ZL, 0x93		; 2268 E9E3
			ijmp					; 2269 9409

;----------------------------------------------------------
;Here for IM code BC

avr226A:	call	sub0958			; 226A 940E 0958
			lds		r16, 0x050A		; 226C 9100 050A
			andi	r16, 0x7F		; 226E 770F
			sts		0x050A, r16		; 226F 9300 050A
			ldi		ZH, 0x00		; 2271 E0F0
			ldi		ZL, 0x93		; 2272 E9E3
			ijmp					; 2273 9409

;-----------------------------------------------------------
; Here for IM code BD

avr2274:	lds		r16, 0x050A		; 2274 9100 050A
			ori		r16, 0x20		; 2276 6200
			sts		0x050A, r16		; 2277 9300 050A
			ldi		ZH, 0x00		; 2279 E0F0
			ldi		ZL, 0x93		; 227A E9E3
			ijmp					; 227B 9409

;------------------------------------------------------------
; Here for IM code BE-

avr227C:	call	sub0958			; 227C 940E 0958
			lds		r16, 0x050D		; 227E 9100 050D
			lds		r17, 0x050E		; 2280 9110 050E
			sts		0x050F, r16		; 2282 9300 050F
			sts		0x0510, r17		; 2284 9310 0510
			lds		r16, 0x050A		; 2286 9100 050A
			ori		r16, 0xC0		; 2288 6C00
			sts		0x050A, r16		; 2289 9300 050A
			call	sub0950			; 228B 940E 0950
			ldi		ZH, 0x00		; 228D E0F0
			ldi		ZL, 0x93		; 228E E9E3
			ijmp					; 228F 9409

;-------------------------------------------------------------
;

avr2290:	call	sub0B8B			; 2290 940E 0B8B
			mov		r16, r23		; 2292 2F07
			sts		0x0505, r16		; 2293 9300 0505
			ldi		ZH, 0x00		; 2295 E0F0
			ldi		ZL, 0x93		; 2296 E9E3
			ijmp					; 2297 9409
;------------------------------------------------------------------------
; save next IM values in Y

sub2298:	mov		r17, r16		; 2298 2F10
avr2299:	call	sub07D6			; 2299 940E 07D6 get next IM value
			cpi		r16, 0x00		; 229B 3000 skip if 0
			breq	avr22A1			; 229C F021
			st		Y+, r16			; 229D 9309 store value
avr229E:	dec		r17				; 229E 951A
			brne	avr2299			; 229F F7C9
			rjmp	avr22A3			; 22A0 C002
avr22A1:	adiw	YL, 0x01		; 22A1 9621
			rjmp	avr229E			; 22A2 CFFB
avr22A3:	ret						; 22A3 9508
;-------------------------------------------------------------------------
; Z is how far to move
; r16 = count, X = , Y =  Z = 
sub22A4:	mov		r19, r16		; 22A4 2F30
avr22A5:	ld		r17, X+			; 22A5 911D
			ld		r18, Y+			; 22A6 9129
			cp		r17, r18		; 22A7 1712
			brsh	avr22AC			; 22A8 F418
			sub		r18, r17		; 22A9 1B21
			mov		r16, r18		; 22AA 2F02
			rjmp	avr22AE			; 22AB C002
avr22AC:	sub		r17, r18		; 22AC 1B12
			mov		r16, r17		; 22AD 2F01
avr22AE:	inc		r16				; 22AE 9503
			st		Z+, r16			; 22AF 9301
			dec		r19				; 22B0 953A
			brne	avr22A5			; 22B1 F799
			ret						; 22B2 9508
;------------------------------------------------------------------------
; get largest move into 0x4DB
sub22B3:	mov		r18, r16		; 22B3 2F20
			ld		r16, Z+			; 22B4 9101
avr22B5:	ld		r17, Z+			; 22B5 9111
			cp		r16, r17		; 22B6 1701
			brsh	avr22B9			; 22B7 F408
			mov		r16, r17		; 22B8 2F01
avr22B9:	dec		r18				; 22B9 952A
			brne	avr22B5			; 22BA F7D1
			inc		r16				; 22BB 9503
			sts		0x04DB, r16		; 22BC 9300 04DB
			ret						; 22BE 9508
;------------------------------------------------------------------------
; Set the speed deltas for PTP and non PTP modes

sub22BF:	push	r23				; 22BF 937F
			mov		r23, r16		; 22C0 2F70 r23 is count
			push	r16				; 22C1 930F
			push	r17				; 22C2 931F
			push	r18				; 22C3 932F
			push	r19				; 22C4 933F
			push	r20				; 22C5 934F
			push	r21				; 22C6 935F
			push	r22				; 22C7 936F
			lds		r16, 0x04DA		; 22C8 9100 04DA Test PTP ALL
			tst		r16				; 22CA 2300
			brne	avr22DA			; 22CB F471
avr22CC:	ldi		r16, 0x11		; 22CC E101 PTP ALL OFF
			ldi		r17, 0x00		; 22CD E010
			lds		r18, 0x04D4		; 22CE 9120 04D4 get speed
			ldi		r19, 0x00		; 22D0 E030
			call	sub02EE			; 22D1 940E 02EE multiply speed  by 17
			cpi		r18, 0x00		; 22D3 3020 if = 0 set to 1
			brne	avr22D6			; 22D4 F409
			ldi		r18, 0x01		; 22D5 E021
avr22D6:	st		Y+, r18			; 22D6 9329 save speed in speed deltas
			dec		r23				; 22D7 957A next servo
			brne	avr22CC			; 22D8 F799
			rjmp	avr22F0			; 22D9 C016
avr22DA:	ldi		r16, 0x11		; 22DA E101 PTP ALL ON
			ldi		r17, 0x00		; 22DB E010
			lds		r18, 0x04D4		; 22DC 9120 04D4 get speed
			ldi		r19, 0x00		; 22DE E030
			call	sub02EE			; 22DF 940E 02EE multiply speed by 17
			ld		r16, Z+			; 22E1 9101 get dist to move
			ldi		r17, 0x00		; 22E2 E010
			call	sub02EE			; 22E3 940E 02EE multiply dist to move by 17
			lds		r20, 0x04DB		; 22E5 9140 04DB
			ldi		r21, 0x00		; 22E7 E050
			call	sub02FD			; 22E8 940E 02FD divide dist to move by largest move
			cpi		r18, 0x00		; 22EA 3020 if 0 set to 1
			brne	avr22ED			; 22EB F409 
			ldi		r18, 0x01		; 22EC E021
avr22ED:	st		Y+, r18			; 22ED 9329 save speed delta
			dec		r23				; 22EE 957A
			brne	avr22DA			; 22EF F751
avr22F0:	pop		r22				; 22F0 916F
			pop		r21				; 22F1 915F
			pop		r20				; 22F2 914F
			pop		r19				; 22F3 913F
			pop		r18				; 22F4 912F
			pop		r17				; 22F5 911F
			pop		r16				; 22F6 910F
			pop		r23				; 22F7 917F
			ret						; 22F8 9508
;-------------------------------------------------------------------------
; store zero values as difference from 100 position

sub22F9:	call	sub07D6			; 22F9 940E 07D6 get value
			tst		r16				; 22FB 2300 skip if zero
			breq	avr2300			; 22FC F019
			subi	r16, 0x64		; 22FD 5604 subtract 64 and store
			st		Y+, r16			; 22FE 9309
			rjmp	avr2301			; 22FF C001
avr2300:	adiw	YL, 0x01		; 2300 9621
avr2301:	dec		r18				; 2301 952A
			brne	sub22F9			; 2302 F7B1
			ret						; 2303 9508
;-------------------------------------------------------------------------
; save in EEPROM values from RAM
sub2304:	ld		r17, Y+			; 2304 9119 get the offset from 0x340
			call	sub0815			; 2305 940E 0815 read next EEPROM
			cp		r16, r17		; 2307 1701 changed ?
			breq	avr230D			; 2308 F021
			mov		r16, r17		; 2309 2F01
			sbiw	XL, 0x01		; 230A 9711
			call	sub0819			; 230B 940E 0819 write if different
avr230D:	dec		r18				; 230D 952A
			brne	sub2304			; 230E F7A9
			ret						; 230F 9508
;-------------------------------------------------------------------------
;Command B0 uses this
; takes the bits from location 0x4E3 to 0x4E6 and translates into bytes from 0E00 to E1F
; returns carry if any are not FF
sub2310:	ldi		ZH, 0x0E		; 2310 E0FE Z = 0xE00
			ldi		ZL, 0x00		; 2311 E0E0
			ldi		YH, 0x04		; 2312 E0D4 Y = 0x4E3
			ldi		YL, 0xE3		; 2313 EEC3
			ldi		r17, 0x04		; 2314 E014 numer of bytes
avr2315:	ldi		r18, 0x08		; 2315 E028 8 bits in byte
			ld		r16, Y+			; 2316 9109 get value from 4E3
avr2317:	ror		r16				; 2317 9507 test bits
			brlo	avr231B			; 2318 F010
			ldi		r19, 0x00		; 2319 E030 bit 0 = 0 save 0
			rjmp	avr231C			; 231A C001
avr231B:	ser		r19				; 231B EF3F bit 0 = 1 save FF
avr231C:	st		Z+, r19			; 231C 9331 
			dec		r18				; 231D 952A
			brne	avr2317			; 231E F7C1
			dec		r17				; 231F 951A
			brne 	avr2315			; 2320 F7A1

; checks locations E00 up for count in r21, and offset in 20
; returns no carry if any are not FF, else returns carry

			mov		r17, r20		; 2321 2F14 17 offset
			mov		r18, r21		; 2322 2F25 r18 count 
			ldi		ZH, 0x0E		; 2323 E0FE z = 0xE00
			ldi		ZL, 0x00		; 2324 E0E0
			add		ZL, r17			; 2325 0FE1
			brsh	avr2328			; 2326 F408
			inc		ZH				; 2327 95F3
avr2328:	ld		r16, Z+			; 2328 9101
			cpi		r16, 0xFF		; 2329 3F0F
			brne	avr232F			; 232A F421
			dec		r18				; 232B 952A
			brne	avr2328			; 232C F7D9

			sec						; 232D 9408
			ret						; 232E 9508


avr232F:	clc						; 232F 9488
			ret						; 2330 9508
;-------------------------------------------------------------------------
; sets the sync move in progress for desired servos
sub2331:	ldi		ZH, 0x0E		; 2331 E0FE Temp buffer
			ldi		ZL, 0x00		; 2332 E0E0
			ldi		YH, 0x04		; 2333 E0D4 location of sync move in progress bits
			ldi		YL, 0xE3		; 2334 EEC3
			ldi		r17, 0x04		; 2335 E014
avr2336:	ldi		r18, 0x08		; 2336 E028 make array in 0xE00 buffer of byte corresponding to bits 
			ld		r16, Y+			; 2337 9109
avr2338:	ror		r16				; 2338 9507
			brlo	avr233C			; 2339 F010
			ldi		r19, 0x00		; 233A E030
			rjmp	avr233D			; 233B C001
avr233C:	ser		r19				; 233C EF3F
avr233D:	st		Z+, r19			; 233D 9331
			dec		r18				; 233E 952A
			brne	avr2338			; 233F F7C1
			dec		r17				; 2340 951A
			brne	avr2336			; 2341 F7A1

			mov		r17, r20		; 2342 2F14
			mov		r18, r21		; 2343 2F25
			ldi		ZH, 0x0E		; 2344 E0FE
			ldi		ZL, 0x00		; 2345 E0E0
			call	sub23D4			; 2346 940E 23D4 Z = Z + r20

avr2348:	ldi		r16, 0x00		; 2348 E000 clear the bits
			st		Z+, r16			; 2349 9301
			dec		r18				; 234A 952A
			brne	avr2348			; 234B F7E1

			ldi		ZH, 0x0E		; 234C E0FE save back into 0x4E3 to 0x4E7 again
			ldi		ZL, 0x00		; 234D E0E0
			ldi		YH, 0x04		; 234E E0D4
			ldi		YL, 0xE3		; 234F EEC3
			ldi		r18, 0x04		; 2350 E024
avr2351:	ldi		r20, 0x00		; 2351 E040
			ldi		r19, 0x08		; 2352 E038
avr2353:	ld		r16, Z+			; 2353 9101
			tst		r16				; 2354 2300
			brne	avr2358			; 2355 F411
			clc						; 2356 9488
			rjmp	avr2359			; 2357 C001
avr2358:	sec						; 2358 9408
avr2359:	ror		r20				; 2359 9547
			dec		r19				; 235A 953A
			brne	avr2353			; 235B F7B9
			st		Y+, r20			; 235C 9349
			dec		r18				; 235D 952A
			brne	avr2351			; 235E F791
			ret						; 235F 9508
;-------------------------------------------------------------------------
; Sets servo directions
; r20 = starting servo, r21 = count   , r22 = direction bits
sub2360:	ldi	ZH, 0x0E		; 2360 E0FE Buffer
			ldi	ZL, 0x00		; 2361 E0E0
			ldi	YH, 0x04		; 2362 E0D4 Direction bits
			ldi	YL, 0xE7		; 2363 EEC7
			ldi	r17, 0x04		; 2364 E014 4 bytes
avr2365:	ldi	r18, 0x08		; 2365 E028 8 bits
			ld	r16, Y+			; 2366 9109 get direction from RAM
avr2367:	ror	r16				; 2367 9507
			brlo	avr236B		; 2368 F010
			ldi	r19, 0x00		; 2369 E030
			rjmp	avr236C		; 236A C001
avr236B:	ser	r19				; 236B EF3F
avr236C:	st	Z+, r19			; 236C 9331 buffer (x) = 0 or FF depending on bit
			dec	r18				; 236D 952A
			brne	avr2367		; 236E F7C1
			dec	r17				; 236F 951A
			brne	avr2365		; 2370 F7A1

			mov	r17, r20		; 2371 2F14
			mov	r18, r21		; 2372 2F25
			ldi	ZH, 0x0E		; 2373 E0FE
			ldi	ZL, 0x00		; 2374 E0E0
			call	sub23D4		; 2375 940E 23D4 Z = Z + r20

avr2377:	ror	r22				; 2377 9567 set buffer based on direction bits
			brsh	avr237B		; 2378 F410
			ser	r16				; 2379 EF0F
			rjmp	avr237C		; 237A C001
avr237B:	ldi	r16, 0x00		; 237B E000
avr237C:	st	Z+, r16			; 237C 9301
			dec	r18				; 237D 952A
			brne	avr2377		; 237E F7C1

			ldi	ZH, 0x0E		; 237F E0FE save direction to RAM from buffer
			ldi	ZL, 0x00		; 2380 E0E0
			ldi	YH, 0x04		; 2381 E0D4
			ldi	YL, 0xE7		; 2382 EEC7
			ldi	r18, 0x04		; 2383 E024
avr2384:	ldi	r20, 0x00		; 2384 E040
			ldi	r19, 0x08		; 2385 E038
avr2386:	ld	r16, Z+			; 2386 9101
			tst	r16				; 2387 2300
			brne	avr238B		; 2388 F411
			clc					; 2389 9488
			rjmp	avr238C		; 238A C001
avr238B:	sec					; 238B 9408
avr238C:	ror	r20				; 238C 9547
			dec	r19				; 238D 953A
			brne	avr2386		; 238E F7B9
			st	Y+, r20			; 238F 9349
			dec	r18				; 2390 952A
			brne	avr2384		; 2391 F791
			push	XH			; 2392 93BF
			push	XL			; 2393 93AF

			ldi	YH, 0x04		; 2394 E0D4 save RAM to internal EEPROM
			ldi	YL, 0xE7		; 2395 EEC7
			ldi	XH, 0x0F		; 2396 E0BF
			ldi	XL, 0xB0		; 2397 EBA0
			ldi	r18, 0x04		; 2398 E024 write 4 bytes to EEPROM
avr2399:	call	sub0815		; 2399 940E 0815

			ld	r17, Y+			; 239B 9119
			cp	r16, r17		; 239C 1701
			breq	avr23A2		; 239D F021
			mov	r16, r17		; 239E 2F01
			subi	XL, 0x01	; 239F 50A1
			call	sub0819		; 23A0 940E 0819 write if different
avr23A2:	dec	r18				; 23A2 952A
			brne	avr2399		; 23A3 F7A9
			pop	XL				; 23A4 91AF
			pop	XH				; 23A5 91BF
			ret					; 23A6 9508
;-------------------------------------------------------------------------
; *X = *X + r20 and *Y = *Y + r20 and *Z = *Z + r20
sub23A7:	push	r20			; 23A7 934F
			push	r16			; 23A8 930F
			tst	r20				; 23A9 2344
			breq	avr23B0		; 23AA F029
avr23AB:	ld	r16, X+			; 23AB 910D
			ld	r16, Y+			; 23AC 9109
			ld	r16, Z+			; 23AD 9101
			dec	r20				; 23AE 954A
			brne	avr23AB		; 23AF F7D9
avr23B0:	pop	r16				; 23B0 910F
			pop	r20				; 23B1 914F
			ret					; 23B2 9508
;-------------------------------------------------------------------------
; *X = *X + r20 and *Y = *Y + r20 and *Z = *Z + r20
sub23B3:	push	r20			; 23B3 934F
			push	r16			; 23B4 930F
			tst	r20				; 23B5 2344
			breq	avr23BC		; 23B6 F029
avr23B7:	ld	r16, X+			; 23B7 910D
			ld	r16, Y+			; 23B8 9109
			ld	r16, Z+			; 23B9 9101
			dec	r20				; 23BA 954A
			brne	avr23B7		; 23BB F7D9
avr23BC:	pop	r16				; 23BC 910F
			pop	r20				; 23BD 914F
			ret					; 23BE 9508
;-------------------------------------------------------------------------
; *Y= *Y + r20 and *Z = *Z+r20
sub23BF:	push	r20			; 23BF 934F
			push	r16			; 23C0 930F
			tst	r20				; 23C1 2344
			breq	avr23C7		; 23C2 F021
avr23C3:	ld	r16, Y+			; 23C3 9109
			ld	r16, Z+			; 23C4 9101
			dec	r20				; 23C5 954A
			brne	avr23C3		; 23C6 F7E1
avr23C7:	pop	r16				; 23C7 910F
			pop	r20				; 23C8 914F
			ret					; 23C9 9508
;-------------------------------------------------------------------------
; *Y = *Y + r20
sub23CA:	push	r20			; 23CA 934F
			push	r16			; 23CB 930F
			tst	r20				; 23CC 2344
			breq	avr23D1		; 23CD F019
avr23CE:	ld	r16, Y+			; 23CE 9109
			dec	r20				; 23CF 954A
			brne	avr23CE		; 23D0 F7E9
avr23D1:	pop	r16				; 23D1 910F
			pop	r20				; 23D2 914F
			ret					; 23D3 9508
;-------------------------------------------------------------------------
; *Z = *Z + r20
sub23D4:	push	r20			; 23D4 934F
			push	r16			; 23D5 930F
			tst	r20				; 23D6 2344
			breq	avr23DB		; 23D7 F019
avr23D8:	ld	r16, Z+			; 23D8 9101
			dec	r20				; 23D9 954A
			brne	avr23D8		; 23DA F7E9
avr23DB:	pop	r16				; 23DB 910F
			pop	r20				; 23DC 914F
			ret					; 23DD 9508
;-------------------------------------------------------------------------
; *X = *X + r20
sub23DE:	push	r20			; 23DE 934F
			push	r16			; 23DF 930F
			tst	r20				; 23E0 2344
			breq	avr23E5		; 23E1 F019
avr23E2:	ld	r16, X+			; 23E2 910D
			dec	r20				; 23E3 954A
			brne	avr23E2		; 23E4 F7E9
avr23E5:	pop	r16				; 23E5 910F
			pop	r20				; 23E6 914F
			ret					; 23E7 9508
;-------------------------------------------------------------------------
; her for IM code A0 GYROSET

avr23E8:	call	sub07D6		; 23E8 940E 07D6 get value for first servo
			mov	r20, r16		; 23EA 2F40
			call	sub07D6		; 23EB 940E 07D6 get value for count
			mov	r21, r16		; 23ED 2F50
			ldi	YH, 0x05		; 23EE E0D5
			ldi	YL, 0x34		; 23EF E3C4
			rcall	sub23CA		; 23F0 DFD9 add r20 to Y
avr23F1:	push	r20			; 23F1 934F
			push	r21			; 23F2 935F
			call	sub07D6		; 23F3 940E 07D6 store subsequent values to RAM
			st	Y+, r16			; 23F5 9309
			pop	r21				; 23F6 915F
			pop	r20				; 23F7 914F
			inc	r20				; 23F8 9543
			dec	r21				; 23F9 955A
			brne	avr23F1		; 23FA F7B1

			ldi	r17, 0x20		; 23FB E210 for all locations
			ldi	YH, 0x05		; 23FC E0D5
			ldi	YL, 0x34		; 23FD E3C4
			clr	r18				; 23FE 2722
			sts	0x052F, r18		; 23FF 9320 052F clear 0x52F
avr2401:	ld	r16, Y			; 2401 8108
			push	r17			; 2402 931F
			mov	r17, r16		; 2403 2F10
			subi	r17, 0x0A		; 2404 501A
			brsh	avr2409		; 2405 F418
			ldi	r17, 0x00		; 2406 E010
			subi	r16, 0x00		; 2407 5000
			rjmp	avr240F		; 2408 C006
avr2409:	subi	r17, 0x0A		; 2409 501A
			brsh	avr240E		; 240A F418
			ldi	r17, 0x10		; 240B E110
			subi	r16, 0x0A		; 240C 500A
			rjmp	avr240F		; 240D C001
avr240E:	ldi	r17, 0x00		; 240E E010
avr240F:	st	Y+, r16		; 240F 9309
			cpi	r16, 0x01		; 2410 3001
			brne	avr2413		; 2411 F409
			ori	r18, 0x01		; 2412 6021
avr2413:	cpi	r16, 0x02		; 2413 3002
			brne	avr2416		; 2414 F409
			ori	r18, 0x02		; 2415 6022
avr2416:	cpi	r16, 0x03		; 2416 3003
			brne	avr2419		; 2417 F409
			ori	r18, 0x04		; 2418 6024
avr2419:	cpi	r16, 0x04		; 2419 3004
			brne	avr241C		; 241A F409
			ori	r18, 0x08		; 241B 6028
avr241C:	or	r18, r17		; 241C 2B21
			sts	0x052F, r18		; 241D 9320 052F
			pop	r17			; 241F 911F
			dec	r17			; 2420 951A
			brne	avr2401		; 2421 F6F9
			jmp	avr0093		; 2422 940C 0093
;----------------------------------------------
; Here for IM code A1 GYRODIR

avr2424:	call	sub07D6		; 2424 940E 07D6 get next value first port
			mov	r20, r16		; 2426 2F40
			call	sub07D6		; 2427 940E 07D6 get next value count
			mov	r21, r16		; 2429 2F50
			ldi	YH, 0x05		; 242A E0D5 point to Gyro direction table
			ldi	YL, 0x54		; 242B E5C4
			rcall	sub23CA		; 242C DF9D
avr242D:	push	r20			; 242D 934F
			push	r21			; 242E 935F
			call	sub07D6		; 242F 940E 07D6 store direction
			st	Y+, r16			; 2431 9309
			pop	r21				; 2432 915F
			pop	r20				; 2433 914F
			inc	r20				; 2434 9543
			dec	r21				; 2435 955A
			brne	avr242D		; 2436 F7B1
			jmp	avr0093			; 2437 940C 0093

;-------------------------------------------------
; Here for IM code A2 GYROSENSE

avr2439:call	sub07D6		; 2439 940E 07D6 get next byte first port
		mov	r20, r16		; 243B 2F40
		call	sub07D6		; 243C 940E 07D6 and next byte count
		mov	r21, r16		; 243E 2F50
		ldi	YH, 0x05		; 243F E0D5 point to Gyro sensitivity table
		ldi	YL, 0x94		; 2440 E9C4
		rcall	sub23CA		; 2441 DF88
avr2442:push	r20			; 2442 934F
		push	r21			; 2443 935F
		call	sub07D6		; 2444 940E 07D6 store sensitivity
		st	Y+, r16			; 2446 9309
		pop	r21				; 2447 915F
		pop	r20				; 2448 914F
		inc	r20				; 2449 9543
		dec	r21				; 244A 955A
		brne	avr2442		; 244B F7B1
		jmp	avr0093			; 244C 940C 0093

;-----------------------
; New 2.7 Code
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093
		jmp		avr0093

		call	sub07D6
		mov		r20, r16
		call	sub07D6
		mov		r21, r16
newc006:	push	r20
		push	r21
		call	sub07D6
		cpi		r16, 0x00
		breq	newc010
		cpi		r16, 0x01
		breq	newc002
		cpi		r16, 0x02
		breq	newc003
		cpi		r16, 0x03
		breq	newc004
newc002:	ldi		r16, 0x20
		rjmp	newc005
newc003:	ldi		r16, 0x40
		rjmp	newc005
newc004:	ldi		r16, 0x60
newc005: 	add	r20, r16
newc001:	push	YH
		push	YL
		mov		r16, r20
		call	0x0000046E3
		pop		YL
		pop		YH
newc010:		pop		r21
		pop		r20
		inc		r20
		dec		r21
		brne	newc006
		jmp		0x00000093

;-----------------------------------------------------
; Here for RCIN


avr244E:subi	r16, 0x64		; 244E 5604
		call	sub0E64		; 244F 940E 0E64
		ldi	r17, 0x05		; 2451 E015
		out	$25, r17		; 2452 BD15
		ldi	r17, 0x00		; 2453 E010
		out	$24, r17		; 2454 BD14
		in	r17, $36		; 2455 B716
		andi	r17, 0x40		; 2456 7410
		out	$36, r17		; 2457 BF16
		ldi	r17, 0x02		; 2458 E012
		out	$2E, r17		; 2459 BD1E
		cli				; 245A 94F8
		cpi	r16, 0x00		; 245B 3000
		breq	avr246C		; 245C F079
		cpi	r16, 0x01		; 245D 3001
		breq	avr246D		; 245E F071
		cpi	r16, 0x02		; 245F 3002
		breq	avr246E		; 2460 F069
		cpi	r16, 0x03		; 2461 3003
		breq	avr246F		; 2462 F061
		cpi	r16, 0x04		; 2463 3004
		breq	avr2470		; 2464 F059
		cpi	r16, 0x05		; 2465 3005
		breq	avr2471		; 2466 F051
		cpi	r16, 0x06		; 2467 3006
		breq	avr2472		; 2468 F049
		cpi	r16, 0x07		; 2469 3007
		breq	avr2473		; 246A F041
		rjmp	avr25CE		; 246B C162
avr246C:rjmp	avr2474		; 246C C007
avr246D:rjmp	avr249C		; 246D C02E
avr246E:rjmp	avr24C4		; 246E C055
avr246F:rjmp	avr24EC		; 246F C07C
avr2470:rjmp	avr2514		; 2470 C0A3
avr2471:rjmp	avr253C		; 2471 C0CA
avr2472:rjmp	avr2564		; 2472 C0F1
avr2473:rjmp	avr258C		; 2473 C118
avr2474:sbis	$00, 0	; 2474 9B00
		rjmp	avr2481		; 2475 C00B
		sei				; 2476 9478
		ldi	r17, 0x96		; 2477 E916
		out	$24, r17		; 2478 BD14
		in	r17, $36		; 2479 B716
		andi	r17, 0x40		; 247A 7410
		out	$36, r17		; 247B BF16
avr247C:wdr				; 247C 95A8
		in	r17, $36		; 247D B716
		sbrs	r17, 6		; 247E FF16
		rjmp	avr247C		; 247F CFFC
		cli				; 2480 94F8

avr2481:ldi	r17, 0x50		; 2481 E510
		out	$24, r17		; 2482 BD14
		in	r17, $36		; 2483 B716
		andi	r17, 0x40		; 2484 7410
		out	$36, r17		; 2485 BF16
avr2486:wdr				; 2486 95A8
		sbic	$00, 0	; 2487 9900
		rjmp	avr248D		; 2488 C004
		in	r17, $36		; 2489 B716
		sbrs	r17, 6		; 248A FF16
		rjmp	avr2486		; 248B CFFA
		rjmp	avr25CE		; 248C C141
avr248D:ldi	r17, 0xEB		; 248D EE1B
		out	$24, r17		; 248E BD14
		in	r17, $36		; 248F B716
		andi	r17, 0x40		; 2490 7410
		out	$36, r17		; 2491 BF16
		clr	r17			; 2492 2711
		out	$2D, r17		; 2493 BD1D
		out	$2C, r17		; 2494 BD1C

avr2495:wdr				; 2495 95A8
		sbis	$00, 0	; 2496 9B00
		rjmp	avr25BA		; 2497 C122
		in	r17, $36		; 2498 B716
		sbrs	r17, 6		; 2499 FF16
		rjmp	avr2495		; 249A CFFA
		rjmp	avr25CE		; 249B C132


avr249C:sbis	$00, 1	; 249C 9B01
		rjmp	avr24A9		; 249D C00B
		sei				; 249E 9478
		ldi	r17, 0x96		; 249F E916
		out	$24, r17		; 24A0 BD14
		in	r17, $36		; 24A1 B716
		andi	r17, 0x40		; 24A2 7410
		out	$36, r17		; 24A3 BF16
avr24A4:wdr				; 24A4 95A8
		in	r17, $36		; 24A5 B716
		sbrs	r17, 6		; 24A6 FF16
		rjmp	avr24A4		; 24A7 CFFC
		cli				; 24A8 94F8
avr24A9:ldi	r17, 0x50		; 24A9 E510
		out	$24, r17		; 24AA BD14
		in	r17, $36		; 24AB B716
		andi	r17, 0x40		; 24AC 7410
		out	$36, r17		; 24AD BF16
avr24AE:wdr				; 24AE 95A8
		sbic	$00, 1	; 24AF 9901
		rjmp	avr24B5		; 24B0 C004
		in	r17, $36		; 24B1 B716
		sbrs	r17, 6		; 24B2 FF16
		rjmp	avr24AE		; 24B3 CFFA
		rjmp	avr25CE		; 24B4 C119
avr24B5:ldi	r17, 0xEB		; 24B5 EE1B
		out	$24, r17		; 24B6 BD14
		in	r17, $36		; 24B7 B716
		andi	r17, 0x40		; 24B8 7410
		out	$36, r17		; 24B9 BF16
		clr	r17			; 24BA 2711
		out	$2D, r17		; 24BB BD1D
		out	$2C, r17		; 24BC BD1C
avr24BD:wdr				; 24BD 95A8
		sbis	$00, 1	; 24BE 9B01
		rjmp	avr25BA		; 24BF C0FA
		in	r17, $36		; 24C0 B716
		sbrs	r17, 6		; 24C1 FF16
		rjmp	avr24BD		; 24C2 CFFA
		rjmp	avr25CE		; 24C3 C10A

avr24C4:sbis	$00, 2	; 24C4 9B02
		rjmp	avr24D1		; 24C5 C00B
		sei				; 24C6 9478
		ldi	r17, 0x96		; 24C7 E916
		out	$24, r17		; 24C8 BD14
		in	r17, $36		; 24C9 B716
		andi	r17, 0x40		; 24CA 7410
		out	$36, r17		; 24CB BF16
avr24CC:wdr				; 24CC 95A8
		in	r17, $36		; 24CD B716
		sbrs	r17, 6		; 24CE FF16
		rjmp	avr24CC		; 24CF CFFC
		cli				; 24D0 94F8
avr24D1:ldi	r17, 0x50		; 24D1 E510
		out	$24, r17		; 24D2 BD14
		in	r17, $36		; 24D3 B716
		andi	r17, 0x40		; 24D4 7410
		out	$36, r17		; 24D5 BF16
avr24D6:wdr				; 24D6 95A8
		sbic	$00, 2	; 24D7 9902
		rjmp	avr24DD		; 24D8 C004
		in	r17, $36		; 24D9 B716
		sbrs	r17, 6		; 24DA FF16
		rjmp	avr24D6		; 24DB CFFA
		rjmp	avr25CE		; 24DC C0F1
avr24DD:ldi	r17, 0xEB		; 24DD EE1B
		out	$24, r17		; 24DE BD14
		in	r17, $36		; 24DF B716
		andi	r17, 0x40		; 24E0 7410
		out	$36, r17		; 24E1 BF16
		clr	r17			; 24E2 2711
		out	$2D, r17		; 24E3 BD1D
		out	$2C, r17		; 24E4 BD1C
avr24E5:wdr				; 24E5 95A8
		sbis	$00, 2	; 24E6 9B02
		rjmp	avr25BA		; 24E7 C0D2
		in	r17, $36		; 24E8 B716
		sbrs	r17, 6		; 24E9 FF16
		rjmp	avr24E5		; 24EA CFFA
		rjmp	avr25CE		; 24EB C0E2

avr24EC:sbis	$00, 3	; 24EC 9B03
		rjmp	avr24F9		; 24ED C00B
		sei				; 24EE 9478
		ldi	r17, 0x96		; 24EF E916
		out	$24, r17		; 24F0 BD14
		in	r17, $36		; 24F1 B716
		andi	r17, 0x40		; 24F2 7410
		out	$36, r17		; 24F3 BF16
avr24F4:wdr				; 24F4 95A8
		in	r17, $36		; 24F5 B716
		sbrs	r17, 6		; 24F6 FF16
		rjmp	avr24F4		; 24F7 CFFC
		cli				; 24F8 94F8
avr24F9:ldi	r17, 0x50		; 24F9 E510
		out	$24, r17		; 24FA BD14
		in	r17, $36		; 24FB B716
		andi	r17, 0x40		; 24FC 7410
		out	$36, r17		; 24FD BF16
avr24FE:wdr				; 24FE 95A8
		sbic	$00, 3	; 24FF 9903
		rjmp	avr2505		; 2500 C004
		in	r17, $36		; 2501 B716
		sbrs	r17, 6		; 2502 FF16
		rjmp	avr24FE		; 2503 CFFA
		rjmp	avr25CE		; 2504 C0C9
avr2505:ldi	r17, 0xEB		; 2505 EE1B
		out	$24, r17		; 2506 BD14
		in	r17, $36		; 2507 B716
		andi	r17, 0x40		; 2508 7410
		out	$36, r17		; 2509 BF16
		clr	r17			; 250A 2711
		out	$2D, r17		; 250B BD1D
		out	$2C, r17		; 250C BD1C
avr250D:wdr				; 250D 95A8
		sbis	$00, 3	; 250E 9B03
		rjmp	avr25BA		; 250F C0AA
		in	r17, $36		; 2510 B716
		sbrs	r17, 6		; 2511 FF16
		rjmp	avr250D		; 2512 CFFA
		rjmp	avr25CE		; 2513 C0BA

avr2514:sbis	$00, 4	; 2514 9B04
		rjmp	avr2521		; 2515 C00B
		sei				; 2516 9478
		ldi	r17, 0x96		; 2517 E916
		out	$24, r17		; 2518 BD14
		in	r17, $36		; 2519 B716
		andi	r17, 0x40		; 251A 7410
		out	$36, r17		; 251B BF16
avr251C:wdr				; 251C 95A8
		in	r17, $36		; 251D B716
		sbrs	r17, 6		; 251E FF16
		rjmp	avr251C		; 251F CFFC
		cli				; 2520 94F8
avr2521:ldi	r17, 0x50		; 2521 E510
		out	$24, r17		; 2522 BD14
		in	r17, $36		; 2523 B716
		andi	r17, 0x40		; 2524 7410
		out	$36, r17		; 2525 BF16
avr2526:wdr				; 2526 95A8
		sbic	$00, 4	; 2527 9904
		rjmp	avr252D		; 2528 C004
		in	r17, $36		; 2529 B716
		sbrs	r17, 6		; 252A FF16
		rjmp	avr2526		; 252B CFFA
		rjmp	avr25CE		; 252C C0A1
avr252D:ldi	r17, 0xEB		; 252D EE1B
		out	$24, r17		; 252E BD14
		in	r17, $36		; 252F B716
		andi	r17, 0x40		; 2530 7410
		out	$36, r17		; 2531 BF16
		clr	r17			; 2532 2711
		out	$2D, r17		; 2533 BD1D
		out	$2C, r17		; 2534 BD1C
avr2535:wdr				; 2535 95A8
		sbis	$00, 4	; 2536 9B04
		rjmp	avr25BA		; 2537 C082
		in	r17, $36		; 2538 B716
		sbrs	r17, 6		; 2539 FF16
		rjmp	avr2535		; 253A CFFA
		rjmp	avr25CE		; 253B C092

avr253C:sbis	$00, 5	; 253C 9B05
		rjmp	avr2549		; 253D C00B
		sei				; 253E 9478
		ldi	r17, 0x96		; 253F E916
		out	$24, r17		; 2540 BD14
		in	r17, $36		; 2541 B716
		andi	r17, 0x40		; 2542 7410
		out	$36, r17		; 2543 BF16
avr2544:wdr				; 2544 95A8
		in	r17, $36		; 2545 B716
		sbrs	r17, 6		; 2546 FF16
		rjmp	avr2544		; 2547 CFFC
		cli				; 2548 94F8
avr2549:ldi	r17, 0x50		; 2549 E510
		out	$24, r17		; 254A BD14
		in	r17, $36		; 254B B716
		andi	r17, 0x40		; 254C 7410
		out	$36, r17		; 254D BF16
avr254E:wdr				; 254E 95A8
		sbic	$00, 5	; 254F 9905
		rjmp	avr2555		; 2550 C004
		in	r17, $36		; 2551 B716
		sbrs	r17, 6		; 2552 FF16
		rjmp	avr254E		; 2553 CFFA
		rjmp	avr25CE		; 2554 C079
avr2555:ldi	r17, 0xEB		; 2555 EE1B
		out	$24, r17		; 2556 BD14
		in	r17, $36		; 2557 B716
		andi	r17, 0x40		; 2558 7410
		out	$36, r17		; 2559 BF16
		clr	r17			; 255A 2711
		out	$2D, r17		; 255B BD1D
		out	$2C, r17		; 255C BD1C
avr255D:wdr				; 255D 95A8
		sbis	$00, 5	; 255E 9B05
		rjmp	avr25BA		; 255F C05A
		in	r17, $36		; 2560 B716
		sbrs	r17, 6		; 2561 FF16
		rjmp	avr255D		; 2562 CFFA
		rjmp	avr25CE		; 2563 C06A

avr2564:sbis	$00, 6	; 2564 9B06
		rjmp	avr2571		; 2565 C00B
		sei				; 2566 9478
		ldi	r17, 0x96		; 2567 E916
		out	$24, r17		; 2568 BD14
		in	r17, $36		; 2569 B716
		andi	r17, 0x40		; 256A 7410
		out	$36, r17		; 256B BF16
avr256C:wdr				; 256C 95A8
		in	r17, $36		; 256D B716
		sbrs	r17, 6		; 256E FF16
		rjmp	avr256C		; 256F CFFC
		cli				; 2570 94F8
avr2571:ldi	r17, 0x50		; 2571 E510
		out	$24, r17		; 2572 BD14
		in	r17, $36		; 2573 B716
		andi	r17, 0x40		; 2574 7410
		out	$36, r17		; 2575 BF16
avr2576:wdr				; 2576 95A8
		sbic	$00, 6	; 2577 9906
		rjmp	avr257D		; 2578 C004
		in	r17, $36		; 2579 B716
		sbrs	r17, 6		; 257A FF16
		rjmp	avr2576		; 257B CFFA
		rjmp	avr25CE		; 257C C051
avr257D:ldi	r17, 0xEB		; 257D EE1B
		out	$24, r17		; 257E BD14
		in	r17, $36		; 257F B716
		andi	r17, 0x40		; 2580 7410
		out	$36, r17		; 2581 BF16
		clr	r17			; 2582 2711
		out	$2D, r17		; 2583 BD1D
		out	$2C, r17		; 2584 BD1C
avr2585:wdr				; 2585 95A8
		sbis	$00, 6	; 2586 9B06
		rjmp	avr25BA		; 2587 C032
		in	r17, $36		; 2588 B716
		sbrs	r17, 6		; 2589 FF16
		rjmp	avr2585		; 258A CFFA
		rjmp	avr25CE		; 258B C042

avr258C:sbis	$00, 7	; 258C 9B07
		rjmp	avr2599		; 258D C00B
		sei				; 258E 9478
		ldi	r17, 0x96		; 258F E916
		out	$24, r17		; 2590 BD14
		in	r17, $36		; 2591 B716
		andi	r17, 0x40		; 2592 7410
		out	$36, r17		; 2593 BF16
avr2594:wdr				; 2594 95A8
		in	r17, $36		; 2595 B716
		sbrs	r17, 6		; 2596 FF16
		rjmp	avr2594		; 2597 CFFC
		cli				; 2598 94F8
avr2599:ldi	r17, 0x50		; 2599 E510
		out	$24, r17		; 259A BD14
		in	r17, $36		; 259B B716
		andi	r17, 0x40		; 259C 7410
		out	$36, r17		; 259D BF16
avr259E:wdr				; 259E 95A8
		sbic	$00, 7	; 259F 9907
		rjmp	avr25A5		; 25A0 C004
		in	r17, $36		; 25A1 B716
		sbrs	r17, 6		; 25A2 FF16
		rjmp	avr259E		; 25A3 CFFA
		rjmp	avr25CE		; 25A4 C029
avr25A5:ldi	r17, 0xEB		; 25A5 EE1B
		out	$24, r17		; 25A6 BD14
		in	r17, $36		; 25A7 B716
		andi	r17, 0x40		; 25A8 7410
		out	$36, r17		; 25A9 BF16
		clr	r17			; 25AA 2711
		out	$2D, r17		; 25AB BD1D
		out	$2C, r17		; 25AC BD1C
avr25AD:wdr				; 25AD 95A8
		sbis	$00, 7	; 25AE 9B07
		rjmp	avr25BA		; 25AF C00A
		in	r17, $36		; 25B0 B716
		sbrs	r17, 6		; 25B1 FF16
		rjmp	avr25AD		; 25B2 CFFA
		rjmp	avr25CE		; 25B3 C01A
		in	r18, $2C		; 25B4 B52C
		in	r19, $2D		; 25B5 B53D
		in	r17, $36		; 25B6 B716
		sbrs	r17, 6		; 25B7 FF16
		rjmp	avr2495		; 25B8 CEDC
		rjmp	avr25CE		; 25B9 C014

avr25BA:in	r18, $2C		; 25BA B52C
		in	r19, $2D		; 25BB B53D
		ror	r19			; 25BC 9537
		ror	r18			; 25BD 9527
		ror	r19			; 25BE 9537
		ror	r18			; 25BF 9527
		andi	r19, 0x3F		; 25C0 733F
		cpi	r19, 0x00		; 25C1 3030
		brne	avr25C4		; 25C2 F409
		ldi	r18, 0x00		; 25C3 E020
avr25C4:cpi	r19, 0x02		; 25C4 3032
		brlo	avr25C7		; 25C5 F008
		ldi	r18, 0xB4		; 25C6 EB24
avr25C7:cpi	r18, 0xB4		; 25C7 3B24
		brlo	avr25CA		; 25C8 F008
		ldi	r18, 0xB4		; 25C9 EB24
avr25CA:clr	r19			; 25CA 2733
		ldi	r17, 0x0A		; 25CB E01A
		add	r18, r17		; 25CC 0F21
		rjmp	avr25D0		; 25CD C002


avr25CE:clr	r18			; 25CE 2722
		clr	r19			; 25CF 2733
avr25D0:sei				; 25D0 9478
		call	sub14CD		; 25D1 940E 14CD
		adiw	XL, 0x01		; 25D3 9611
		jmp	avr0093		; 25D4 940C 0093
;------------------------------------------------
; baud rates
; Data area for code at 0x25F5
avr25D6:
.db		0xFE, 0x7F, 0x54, 0x3F, 0x1F, 0x14, 0x09, 0x00
/*
		andi	ZH, 0xFE		; 25D6 7FFE
		cpi	r21, 0xF4		; 25D7 3F54
		cp	r1, r15		; 25D8 141F
		unknown			; 25D9 0009
*/		
;-----------------------------------------------
; LCD routine
; serial out on bit 2 of Port E

sub25da:wdr				; 25DA 95A8
		push	r17			; 25DB 931F
		push	r18			; 25DC 932F
		sbi	$03, 2	; 25DD 9A1A set bit 2 in Port E
		sbi	$02, 2	; 25DE 9A12 set direction out
		cli				; 25DF 94F8
		com	r16			; 25E0 9500 complement
		sec				; 25E1 9408 set carry
		ldi	r18, 0x0A		; 25E2 E02A 10 bits
avr25E3:ldi	r17, 0xFE		; 25E3 EF1E delay
avr25E4:dec	r17			; 25E4 951A
		nop				; 25E5 0000
		nop				; 25E6 0000
		nop				; 25E7 0000
		brne	avr25E4		; 25E8 F7D9
		brlo	avr25EB		; 25E9 F008
		sbi	$03, 2	; 25EA 9A1A set the bits
avr25EB:brsh	avr25ED		; 25EB F408
		cbi	$03, 2	; 25EC 981A
avr25ED:lsr	r16			; 25ED 9506
		dec	r18			; 25EE 952A
		brne	avr25E3		; 25EF F799
		sbi	$03, 2	; 25F0 9A1A
		sei				; 25F1 9478
		pop	r18			; 25F2 912F
		pop	r17			; 25F3 911F
		ret				; 25F4 9508
;-------------------------------------------------------------------------
; setup baud rate for ports
sub25F5:	ldi	ZH, high(avr25D6 << 1)	; 25F5 E4FB
			ldi	ZL, low(avr25D6 << 1)	; 25F6 EAEC
			add	ZL, r16		; 25F7 0FE0
			brsh	avr25FA		; 25F8 F408
			inc	ZH		; 25F9 95F3
avr25FA:	lpm	r16, Z		; 25FA 9104
			sts	0x04C4, r16	; 25FB 9300 04C4
			ret			; 25FD 9508
;-------------------------------------------------------------------------
sub25FE:	push	r16		; 25FE 930F
			lds	r16, 0x04D2	; 25FF 9100 04D2
			sbrc	r16, 1		; 2601 FD01
			rjmp	avr260A		; 2602 C007
			rjmp	avr260D		; 2603 C009


sub2604:	push	r16		; 2604 930F
			lds	r16, 0x04D2	; 2605 9100 04D2
			sbrc	r16, 1		; 2607 FD01
			rjmp	avr2610		; 2608 C007
			rjmp	avr2613		; 2609 C009

avr260A:	pop	r16		; 260A 910F
			jmp	sub2616		; 260B 940C 2616
avr260D:	pop	r16		; 260D 910F
			jmp	avr31FE		; 260E 940C 31FE

avr2610:	pop	r16		; 2610 910F
			jmp	avr29AB		; 2611 940C 29AB
avr2613:	pop	r16		; 2613 910F
			jmp	avr3753		; 2614 940C 3753


sub2616:cpi	r17, 0x00	; 2616 3010
		breq	avr2657		; 2617 F1F9
		cpi	r17, 0x01	; 2618 3011
		breq	avr2658		; 2619 F1F1
		cpi	r17, 0x02	; 261A 3012
		breq	avr2659		; 261B F1E9
		cpi	r17, 0x03	; 261C 3013
		breq	avr265A		; 261D F1E1
		cpi	r17, 0x04	; 261E 3014
		breq	avr265B		; 261F F1D9
		cpi	r17, 0x05	; 2620 3015
		breq	avr265C		; 2621 F1D1
		cpi	r17, 0x06	; 2622 3016
		breq	avr265D		; 2623 F1C9
		cpi	r17, 0x07	; 2624 3017
		breq	avr265E		; 2625 F1C1
		cpi	r17, 0x08	; 2626 3018
		breq	avr265F		; 2627 F1B9
		cpi	r17, 0x09	; 2628 3019
		breq	avr2660		; 2629 F1B1
		cpi	r17, 0x0A	; 262A 301A
		breq	avr2661		; 262B F1A9
		cpi	r17, 0x0B	; 262C 301B
		breq	avr2662		; 262D F1A1
		cpi	r17, 0x0C	; 262E 301C
		breq	avr2663		; 262F F199
		cpi	r17, 0x0D	; 2630 301D
		breq	avr2664		; 2631 F191
		cpi	r17, 0x0E	; 2632 301E
		breq	avr2665		; 2633 F189
		cpi	r17, 0x0F	; 2634 301F
		breq	avr2666		; 2635 F181
		cpi	r17, 0x10	; 2636 3110
		breq	avr2667		; 2637 F179
		cpi	r17, 0x11	; 2638 3111
		breq	avr2668		; 2639 F171
		cpi	r17, 0x12	; 263A 3112
		breq	avr2669		; 263B F169
		cpi	r17, 0x13	; 263C 3113
		breq	avr266A		; 263D F161
		cpi	r17, 0x14	; 263E 3114
		breq	avr266B		; 263F F159
		cpi	r17, 0x15	; 2640 3115
		breq	avr266C		; 2641 F151
		cpi	r17, 0x16	; 2642 3116
		breq	avr266D		; 2643 F149
		cpi	r17, 0x17	; 2644 3117
		breq	avr266E		; 2645 F141
		cpi	r17, 0x18	; 2646 3118
		breq	avr266F		; 2647 F139
		cpi	r17, 0x19	; 2648 3119
		breq	avr2670		; 2649 F131
		cpi	r17, 0x1A	; 264A 311A
		breq	avr2671		; 264B F129
		cpi	r17, 0x1B	; 264C 311B
		breq	avr2672		; 264D F121
		cpi	r17, 0x1C	; 264E 311C
		breq	avr2673		; 264F F119
		cpi	r17, 0x1D	; 2650 311D
		breq	avr2674		; 2651 F111
		cpi	r17, 0x1E	; 2652 311E
		breq	avr2675		; 2653 F109
		cpi	r17, 0x1F	; 2654 311F
		breq	avr2676		; 2655 F101
		ret			; 2656 9508
;-------------------------------------------------------------------------
avr2657:rjmp	avr2678		; 2657 C020
avr2658:rjmp	avr2690		; 2658 C037
avr2659:rjmp	avr26A8		; 2659 C04E
avr265A:rjmp	avr26C0		; 265A C065
avr265B:rjmp	avr26D8		; 265B C07C
avr265C:rjmp	avr26F0		; 265C C093
avr265D:rjmp	avr2708		; 265D C0AA
avr265E:rjmp	avr2720		; 265E C0C1
avr265F:rjmp	avr2738		; 265F C0D8
avr2660:rjmp	avr2750		; 2660 C0EF
avr2661:rjmp	avr2768		; 2661 C106
avr2662:rjmp	avr2780		; 2662 C11D
avr2663:rjmp	avr2798		; 2663 C134
avr2664:rjmp	avr27B0		; 2664 C14B
avr2665:rjmp	avr27C8		; 2665 C162
avr2666:rjmp	avr27E0		; 2666 C179
avr2667:rjmp	avr27F8		; 2667 C190
avr2668:rjmp	avr2810		; 2668 C1A7
avr2669:rjmp	avr2828		; 2669 C1BE
avr266A:rjmp	avr2840		; 266A C1D5
avr266B:rjmp	avr2858		; 266B C1EC
avr266C:rjmp	avr2870		; 266C C203
avr266D:rjmp	avr2888		; 266D C21A
avr266E:rjmp	avr28A0		; 266E C231
avr266F:rjmp	avr28B8		; 266F C248
avr2670:rjmp	avr28D0		; 2670 C25F
avr2671:rjmp	avr28E8		; 2671 C276
avr2672:rjmp	avr2900		; 2672 C28D
avr2673:rjmp	avr2918		; 2673 C2A4
avr2674:rjmp	avr2930		; 2674 C2BB
avr2675:rjmp	avr2959		; 2675 C2E3
avr2676:rjmp	avr2982		; 2676 C30B
		ret			; 2677 9508
;-------------------------------------------------------------------------
avr2678:wdr				; 2678 95A8
		push	r18			; 2679 932F
		sbi	PORTA, 0	; 267A 9AD8
		sbi	DDRA, 0	; 267B 9AD0
		com	r16			; 267C 9500
		sec				; 267D 9408
		ldi	r18, 0x0A		; 267E E02A
avr267F:lds	r17, 0x04C4		; 267F 9110 04C4
avr2681:dec	r17			; 2681 951A
		nop				; 2682 0000
		nop				; 2683 0000
		nop				; 2684 0000
		brne	avr2681		; 2685 F7D9
		brlo	avr2688		; 2686 F008
		sbi	PORTA, 0	; 2687 9AD8
avr2688:brsh	avr268A		; 2688 F408
		cbi	PORTA, 0	; 2689 98D8
avr268A:lsr	r16			; 268A 9506
		dec	r18			; 268B 952A
		brne	avr267F		; 268C F791
		sbi	PORTA, 0	; 268D 9AD8
		pop	r18			; 268E 912F
		ret				; 268F 9508
;-------------------------------------------------------------------------
avr2690:wdr				; 2690 95A8
		push	r18			; 2691 932F
		sbi	PORTA, 1	; 2692 9AD9
		sbi	DDRA, 1	; 2693 9AD1
		com	r16			; 2694 9500
		sec				; 2695 9408
		ldi	r18, 0x0A		; 2696 E02A
avr2697:lds	r17, 0x04C4		; 2697 9110 04C4
avr2699:dec	r17			; 2699 951A
		nop				; 269A 0000
		nop				; 269B 0000
		nop				; 269C 0000
		brne	avr2699		; 269D F7D9
		brlo	avr26A0		; 269E F008
		sbi	PORTA, 1	; 269F 9AD9
avr26A0:brsh	avr26A2		; 26A0 F408
		cbi	PORTA, 1	; 26A1 98D9
avr26A2:lsr	r16			; 26A2 9506
		dec	r18			; 26A3 952A
		brne	avr2697		; 26A4 F791
		sbi	PORTA, 1	; 26A5 9AD9
		pop	r18			; 26A6 912F
		ret				; 26A7 9508
;-------------------------------------------------------------------------
avr26A8:wdr				; 26A8 95A8
		push	r18			; 26A9 932F
		sbi	PORTA, 2	; 26AA 9ADA
		sbi	DDRA, 2	; 26AB 9AD2
		com	r16			; 26AC 9500
		sec				; 26AD 9408
		ldi	r18, 0x0A		; 26AE E02A
avr26AF:lds	r17, 0x04C4		; 26AF 9110 04C4
avr26B1:dec	r17			; 26B1 951A
		nop				; 26B2 0000
		nop				; 26B3 0000
		nop				; 26B4 0000
		brne	avr26B1		; 26B5 F7D9
		brlo	avr26B8		; 26B6 F008
		sbi	PORTA, 2	; 26B7 9ADA
avr26B8:brsh	avr26BA		; 26B8 F408
		cbi	PORTA, 2	; 26B9 98DA
avr26BA:lsr	r16			; 26BA 9506
		dec	r18			; 26BB 952A
		brne	avr26AF		; 26BC F791
		sbi	PORTA, 2	; 26BD 9ADA
		pop	r18			; 26BE 912F
		ret				; 26BF 9508
;-------------------------------------------------------------------------
avr26C0:wdr				; 26C0 95A8
		push	r18			; 26C1 932F
		sbi	PORTA, 3	; 26C2 9ADB
		sbi	DDRA, 3	; 26C3 9AD3
		com	r16			; 26C4 9500
		sec				; 26C5 9408
		ldi	r18, 0x0A		; 26C6 E02A
avr26C7:lds	r17, 0x04C4		; 26C7 9110 04C4
avr26C9:dec	r17			; 26C9 951A
		nop				; 26CA 0000
		nop				; 26CB 0000
		nop				; 26CC 0000
		brne	avr26C9		; 26CD F7D9
		brlo	avr26D0		; 26CE F008
		sbi	PORTA, 3	; 26CF 9ADB
avr26D0:brsh	avr26D2		; 26D0 F408
		cbi	PORTA, 3	; 26D1 98DB
avr26D2:lsr	r16			; 26D2 9506
		dec	r18			; 26D3 952A
		brne	avr26C7		; 26D4 F791
		sbi	PORTA, 3	; 26D5 9ADB
		pop	r18			; 26D6 912F
		ret				; 26D7 9508
;-------------------------------------------------------------------------
avr26D8:wdr				; 26D8 95A8
		push	r18			; 26D9 932F
		sbi	PORTA, 4	; 26DA 9ADC
		sbi	DDRA, 4	; 26DB 9AD4
		com	r16			; 26DC 9500
		sec				; 26DD 9408
		ldi	r18, 0x0A		; 26DE E02A
avr26DF:lds	r17, 0x04C4		; 26DF 9110 04C4
avr26E1:dec	r17			; 26E1 951A
		nop				; 26E2 0000
		nop				; 26E3 0000
		nop				; 26E4 0000
		brne	avr26E1		; 26E5 F7D9
		brlo	avr26E8		; 26E6 F008
		sbi	PORTA, 4	; 26E7 9ADC
avr26E8:brsh	avr26EA		; 26E8 F408
		cbi	PORTA, 4	; 26E9 98DC
avr26EA:lsr	r16			; 26EA 9506
		dec	r18			; 26EB 952A
		brne	avr26DF		; 26EC F791
		sbi	PORTA, 4	; 26ED 9ADC
		pop	r18			; 26EE 912F
		ret				; 26EF 9508
;-------------------------------------------------------------------------
avr26F0:wdr				; 26F0 95A8
		push	r18			; 26F1 932F
		sbi	PORTA, 5	; 26F2 9ADD
		sbi	DDRA, 5	; 26F3 9AD5
		com	r16			; 26F4 9500
		sec				; 26F5 9408
		ldi	r18, 0x0A		; 26F6 E02A
avr26F7:lds	r17, 0x04C4		; 26F7 9110 04C4
avr26F9:dec	r17			; 26F9 951A
		nop				; 26FA 0000
		nop				; 26FB 0000
		nop				; 26FC 0000
		brne	avr26F9		; 26FD F7D9
		brlo	avr2700		; 26FE F008
		sbi	PORTA, 5	; 26FF 9ADD
avr2700:brsh	avr2702		; 2700 F408
		cbi	PORTA, 5	; 2701 98DD
avr2702:lsr	r16			; 2702 9506
		dec	r18			; 2703 952A
		brne	avr26F7		; 2704 F791
		sbi	PORTA, 5	; 2705 9ADD
		pop	r18			; 2706 912F
		ret				; 2707 9508
;-------------------------------------------------------------------------
avr2708:wdr				; 2708 95A8
		push	r18			; 2709 932F
		sbi	PORTA, 6	; 270A 9ADE
		sbi	DDRA, 6	; 270B 9AD6
		com	r16			; 270C 9500
		sec				; 270D 9408
		ldi	r18, 0x0A		; 270E E02A
avr270F:lds	r17, 0x04C4		; 270F 9110 04C4
avr2711:dec	r17			; 2711 951A
		nop				; 2712 0000
		nop				; 2713 0000
		nop				; 2714 0000
		brne	avr2711		; 2715 F7D9
		brlo	avr2718		; 2716 F008
		sbi	PORTA, 6	; 2717 9ADE
avr2718:brsh	avr271A		; 2718 F408
		cbi	PORTA, 6	; 2719 98DE
avr271A:lsr	r16			; 271A 9506
		dec	r18			; 271B 952A
		brne	avr270F		; 271C F791
		sbi	PORTA, 6	; 271D 9ADE
		pop	r18			; 271E 912F
		ret				; 271F 9508
;-------------------------------------------------------------------------
avr2720:wdr				; 2720 95A8
		push	r18			; 2721 932F
		sbi	PORTA, 7	; 2722 9ADF
		sbi	DDRA, 7	; 2723 9AD7
		com	r16			; 2724 9500
		sec				; 2725 9408
		ldi	r18, 0x0A		; 2726 E02A
avr2727:lds	r17, 0x04C4		; 2727 9110 04C4
avr2729:dec	r17			; 2729 951A
		nop				; 272A 0000
		nop				; 272B 0000
		nop				; 272C 0000
		brne	avr2729		; 272D F7D9
		brlo	avr2730		; 272E F008
		sbi	PORTA, 7	; 272F 9ADF
avr2730:brsh	avr2732		; 2730 F408
		cbi	PORTA, 7	; 2731 98DF
avr2732:lsr	r16			; 2732 9506
		dec	r18			; 2733 952A
		brne	avr2727		; 2734 F791
		sbi	PORTA, 7	; 2735 9ADF
		pop	r18			; 2736 912F
		ret				; 2737 9508
;-------------------------------------------------------------------------
avr2738:wdr				; 2738 95A8
		push	r18			; 2739 932F
		sbi	PORTB, 0	; 273A 9AC0
		sbi	DDRB, 0	; 273B 9AB8
		com	r16			; 273C 9500
		sec				; 273D 9408
		ldi	r18, 0x0A		; 273E E02A
avr273F:lds	r17, 0x04C4		; 273F 9110 04C4
avr2741:dec	r17			; 2741 951A
		nop				; 2742 0000
		nop				; 2743 0000
		nop				; 2744 0000
		brne	avr2741		; 2745 F7D9
		brlo	avr2748		; 2746 F008
		sbi	PORTB, 0	; 2747 9AC0
avr2748:brsh	avr274A		; 2748 F408
		cbi	PORTB, 0	; 2749 98C0
avr274A:lsr	r16			; 274A 9506
		dec	r18			; 274B 952A
		brne	avr273F		; 274C F791
		sbi	PORTB, 0	; 274D 9AC0
		pop	r18			; 274E 912F
		ret				; 274F 9508
;-------------------------------------------------------------------------
avr2750:wdr				; 2750 95A8
		push	r18			; 2751 932F
		sbi	PORTB, 1	; 2752 9AC1
		sbi	DDRB, 1	; 2753 9AB9
		com	r16			; 2754 9500
		sec				; 2755 9408
		ldi	r18, 0x0A		; 2756 E02A
avr2757:lds	r17, 0x04C4		; 2757 9110 04C4
avr2759:dec	r17			; 2759 951A
		nop				; 275A 0000
		nop				; 275B 0000
		nop				; 275C 0000
		brne	avr2759		; 275D F7D9
		brlo	avr2760		; 275E F008
		sbi	PORTB, 1	; 275F 9AC1
avr2760:brsh	avr2762		; 2760 F408
		cbi	PORTB, 1	; 2761 98C1
avr2762:lsr	r16			; 2762 9506
		dec	r18			; 2763 952A
		brne	avr2757		; 2764 F791
		sbi	PORTB, 1	; 2765 9AC1
		pop	r18			; 2766 912F
		ret				; 2767 9508
;-------------------------------------------------------------------------
avr2768:wdr				; 2768 95A8
		push	r18			; 2769 932F
		sbi	PORTB, 2	; 276A 9AC2
		sbi	DDRB, 2	; 276B 9ABA
		com	r16			; 276C 9500
		sec				; 276D 9408
		ldi	r18, 0x0A		; 276E E02A
avr276F:lds	r17, 0x04C4		; 276F 9110 04C4
avr2771:dec	r17			; 2771 951A
		nop				; 2772 0000
		nop				; 2773 0000
		nop				; 2774 0000
		brne	avr2771		; 2775 F7D9
		brlo	avr2778		; 2776 F008
		sbi	PORTB, 2	; 2777 9AC2
avr2778:brsh	avr277A		; 2778 F408
		cbi	PORTB, 2	; 2779 98C2
avr277A:lsr	r16			; 277A 9506
		dec	r18			; 277B 952A
		brne	avr276F		; 277C F791
		sbi	PORTB, 2	; 277D 9AC2
		pop	r18			; 277E 912F
		ret				; 277F 9508
;-------------------------------------------------------------------------
avr2780:wdr				; 2780 95A8
		push	r18			; 2781 932F
		sbi	PORTB, 3	; 2782 9AC3
		sbi	DDRB, 3	; 2783 9ABB
		com	r16			; 2784 9500
		sec				; 2785 9408
		ldi	r18, 0x0A		; 2786 E02A
avr2787:lds	r17, 0x04C4		; 2787 9110 04C4
avr2789:dec	r17			; 2789 951A
		nop				; 278A 0000
		nop				; 278B 0000
		nop				; 278C 0000
		brne	avr2789		; 278D F7D9
		brlo	avr2790		; 278E F008
		sbi	PORTB, 3	; 278F 9AC3
avr2790:brsh	avr2792		; 2790 F408
		cbi	PORTB, 3	; 2791 98C3
avr2792:lsr	r16			; 2792 9506
		dec	r18			; 2793 952A
		brne	avr2787		; 2794 F791
		sbi	PORTB, 3	; 2795 9AC3
		pop	r18			; 2796 912F
		ret				; 2797 9508
;-------------------------------------------------------------------------
avr2798:wdr				; 2798 95A8
		push	r18			; 2799 932F
		sbi	PORTB, 4	; 279A 9AC4
		sbi	DDRB, 4	; 279B 9ABC
		com	r16			; 279C 9500
		sec				; 279D 9408
		ldi	r18, 0x0A		; 279E E02A
avr279F:lds	r17, 0x04C4		; 279F 9110 04C4
avr27A1:dec	r17			; 27A1 951A
		nop				; 27A2 0000
		nop				; 27A3 0000
		nop				; 27A4 0000
		brne	avr27A1		; 27A5 F7D9
		brlo	avr27A8		; 27A6 F008
		sbi	PORTB, 4	; 27A7 9AC4
avr27A8:brsh	avr27AA		; 27A8 F408
		cbi	PORTB, 4	; 27A9 98C4
avr27AA:lsr	r16			; 27AA 9506
		dec	r18			; 27AB 952A
		brne	avr279F		; 27AC F791
		sbi	PORTB, 4	; 27AD 9AC4
		pop	r18			; 27AE 912F
		ret				; 27AF 9508
;-------------------------------------------------------------------------
avr27B0:wdr				; 27B0 95A8
		push	r18			; 27B1 932F
		sbi	PORTB, 5	; 27B2 9AC5
		sbi	DDRB, 5	; 27B3 9ABD
		com	r16			; 27B4 9500
		sec				; 27B5 9408
		ldi	r18, 0x0A		; 27B6 E02A
avr27B7:lds	r17, 0x04C4		; 27B7 9110 04C4
avr27B9:dec	r17			; 27B9 951A
		nop				; 27BA 0000
		nop				; 27BB 0000
		nop				; 27BC 0000
		brne	avr27B9		; 27BD F7D9
		brlo	avr27C0		; 27BE F008
		sbi	PORTB, 5	; 27BF 9AC5
avr27C0:brsh	avr27C2		; 27C0 F408
		cbi	PORTB, 5	; 27C1 98C5
avr27C2:lsr	r16			; 27C2 9506
		dec	r18			; 27C3 952A
		brne	avr27B7		; 27C4 F791
		sbi	PORTB, 5	; 27C5 9AC5
		pop	r18			; 27C6 912F
		ret				; 27C7 9508
;-------------------------------------------------------------------------
avr27C8:wdr				; 27C8 95A8
		push	r18			; 27C9 932F
		sbi	PORTB, 6	; 27CA 9AC6
		sbi	DDRB, 6	; 27CB 9ABE
		com	r16			; 27CC 9500
		sec				; 27CD 9408
		ldi	r18, 0x0A		; 27CE E02A
avr27CF:lds	r17, 0x04C4		; 27CF 9110 04C4
avr27D1:dec	r17			; 27D1 951A
		nop				; 27D2 0000
		nop				; 27D3 0000
		nop				; 27D4 0000
		brne	avr27D1		; 27D5 F7D9
		brlo	avr27D8		; 27D6 F008
		sbi	PORTB, 6	; 27D7 9AC6
avr27D8:brsh	avr27DA		; 27D8 F408
		cbi	PORTB, 6	; 27D9 98C6
avr27DA:lsr	r16			; 27DA 9506
		dec	r18			; 27DB 952A
		brne	avr27CF		; 27DC F791
		sbi	PORTB, 6	; 27DD 9AC6
		pop	r18			; 27DE 912F
		ret				; 27DF 9508
;-------------------------------------------------------------------------
avr27E0:wdr				; 27E0 95A8
		push	r18			; 27E1 932F
		sbi	PORTB, 7	; 27E2 9AC7
		sbi	DDRB, 7	; 27E3 9ABF
		com	r16			; 27E4 9500
		sec				; 27E5 9408
		ldi	r18, 0x0A		; 27E6 E02A
avr27E7:lds	r17, 0x04C4		; 27E7 9110 04C4
avr27E9:dec	r17			; 27E9 951A
		nop				; 27EA 0000
		nop				; 27EB 0000
		nop				; 27EC 0000
		brne	avr27E9		; 27ED F7D9
		brlo	avr27F0		; 27EE F008
		sbi	PORTB, 7	; 27EF 9AC7
avr27F0:brsh	avr27F2		; 27F0 F408
		cbi	PORTB, 7	; 27F1 98C7
avr27F2:lsr	r16			; 27F2 9506
		dec	r18			; 27F3 952A
		brne	avr27E7		; 27F4 F791
		sbi	PORTB, 7	; 27F5 9AC7
		pop	r18			; 27F6 912F
		ret				; 27F7 9508
;-------------------------------------------------------------------------
avr27F8:wdr				; 27F8 95A8
		push	r18			; 27F9 932F
		sbi	PORTC, 7	; 27FA 9AAF
		sbi	DDRC, 7	; 27FB 9AA7
		com	r16			; 27FC 9500
		sec				; 27FD 9408
		ldi	r18, 0x0A		; 27FE E02A
avr27FF:lds	r17, 0x04C4		; 27FF 9110 04C4
avr2801:dec	r17			; 2801 951A
		nop				; 2802 0000
		nop				; 2803 0000
		nop				; 2804 0000
		brne	avr2801		; 2805 F7D9
		brlo	avr2808		; 2806 F008
		sbi	PORTC, 7	; 2807 9AAF
avr2808:brsh	avr280A		; 2808 F408
		cbi	PORTC, 7	; 2809 98AF
avr280A:lsr	r16			; 280A 9506
		dec	r18			; 280B 952A
		brne	avr27FF		; 280C F791
		sbi	PORTC, 7	; 280D 9AAF
		pop	r18			; 280E 912F
		ret				; 280F 9508
;-------------------------------------------------------------------------
avr2810:wdr				; 2810 95A8
		push	r18			; 2811 932F
		sbi	PORTC, 6	; 2812 9AAE
		sbi	DDRC, 6	; 2813 9AA6
		com	r16			; 2814 9500
		sec				; 2815 9408
		ldi	r18, 0x0A		; 2816 E02A
avr2817:lds	r17, 0x04C4		; 2817 9110 04C4
avr2819:dec	r17			; 2819 951A
		nop				; 281A 0000
		nop				; 281B 0000
		nop				; 281C 0000
		brne	avr2819		; 281D F7D9
		brlo	avr2820		; 281E F008
		sbi	PORTC, 6	; 281F 9AAE
avr2820:brsh	avr2822		; 2820 F408
		cbi	PORTC, 6	; 2821 98AE
avr2822:lsr	r16			; 2822 9506
		dec	r18			; 2823 952A
		brne	avr2817		; 2824 F791
		sbi	PORTC, 6	; 2825 9AAE
		pop	r18			; 2826 912F
		ret				; 2827 9508
;-------------------------------------------------------------------------
avr2828:wdr				; 2828 95A8
		push	r18			; 2829 932F
		sbi	PORTC, 5	; 282A 9AAD
		sbi	DDRC, 5	; 282B 9AA5
		com	r16			; 282C 9500
		sec				; 282D 9408
		ldi	r18, 0x0A		; 282E E02A
avr282F:lds	r17, 0x04C4		; 282F 9110 04C4
avr2831:dec	r17			; 2831 951A
		nop				; 2832 0000
		nop				; 2833 0000
		nop				; 2834 0000
		brne	avr2831		; 2835 F7D9
		brlo	avr2838		; 2836 F008
		sbi	PORTC, 5	; 2837 9AAD
avr2838:brsh	avr283A		; 2838 F408
		cbi	PORTC, 5	; 2839 98AD
avr283A:lsr	r16			; 283A 9506
		dec	r18			; 283B 952A
		brne	avr282F		; 283C F791
		sbi	PORTC, 5	; 283D 9AAD
		pop	r18			; 283E 912F
		ret				; 283F 9508
;-------------------------------------------------------------------------
avr2840:wdr				; 2840 95A8
		push	r18			; 2841 932F
		sbi	PORTC, 4	; 2842 9AAC
		sbi	DDRC, 4	; 2843 9AA4
		com	r16			; 2844 9500
		sec				; 2845 9408
		ldi	r18, 0x0A		; 2846 E02A
avr2847:lds	r17, 0x04C4		; 2847 9110 04C4
avr2849:dec	r17			; 2849 951A
		nop				; 284A 0000
		nop				; 284B 0000
		nop				; 284C 0000
		brne	avr2849		; 284D F7D9
		brlo	avr2850		; 284E F008
		sbi	PORTC, 4	; 284F 9AAC
avr2850:brsh	avr2852		; 2850 F408
		cbi	PORTC, 4	; 2851 98AC
avr2852:lsr	r16			; 2852 9506
		dec	r18			; 2853 952A
		brne	avr2847		; 2854 F791
		sbi	PORTC, 4	; 2855 9AAC
		pop	r18			; 2856 912F
		ret				; 2857 9508
;-------------------------------------------------------------------------
avr2858:wdr				; 2858 95A8
		push	r18			; 2859 932F
		sbi	PORTC, 3	; 285A 9AAB
		sbi	DDRC, 3	; 285B 9AA3
		com	r16			; 285C 9500
		sec				; 285D 9408
		ldi	r18, 0x0A		; 285E E02A
avr285F:lds	r17, 0x04C4		; 285F 9110 04C4
avr2861:dec	r17			; 2861 951A
		nop				; 2862 0000
		nop				; 2863 0000
		nop				; 2864 0000
		brne	avr2861		; 2865 F7D9
		brlo	avr2868		; 2866 F008
		sbi	PORTC, 3	; 2867 9AAB
avr2868:brsh	avr286A		; 2868 F408
		cbi	PORTC, 3	; 2869 98AB
avr286A:lsr	r16			; 286A 9506
		dec	r18			; 286B 952A
		brne	avr285F		; 286C F791
		sbi	PORTC, 3	; 286D 9AAB
		pop	r18			; 286E 912F
		ret				; 286F 9508
;-------------------------------------------------------------------------
avr2870:wdr				; 2870 95A8
		push	r18			; 2871 932F
		sbi	PORTC, 2	; 2872 9AAA
		sbi	DDRC, 2	; 2873 9AA2
		com	r16			; 2874 9500
		sec				; 2875 9408
		ldi	r18, 0x0A		; 2876 E02A
avr2877:lds	r17, 0x04C4		; 2877 9110 04C4
avr2879:dec	r17			; 2879 951A
		nop				; 287A 0000
		nop				; 287B 0000
		nop				; 287C 0000
		brne	avr2879		; 287D F7D9
		brlo	avr2880		; 287E F008
		sbi	PORTC, 2	; 287F 9AAA
avr2880:brsh	avr2882		; 2880 F408
		cbi	PORTC, 2	; 2881 98AA
avr2882:lsr	r16			; 2882 9506
		dec	r18			; 2883 952A
		brne	avr2877		; 2884 F791
		sbi	PORTC, 2	; 2885 9AAA
		pop	r18			; 2886 912F
		ret				; 2887 9508
;-------------------------------------------------------------------------
avr2888:wdr				; 2888 95A8
		push	r18			; 2889 932F
		sbi	PORTC, 1	; 288A 9AA9
		sbi	DDRC, 1	; 288B 9AA1
		com	r16			; 288C 9500
		sec				; 288D 9408
		ldi	r18, 0x0A		; 288E E02A
avr288F:lds	r17, 0x04C4		; 288F 9110 04C4
avr2891:dec	r17			; 2891 951A
		nop				; 2892 0000
		nop				; 2893 0000
		nop				; 2894 0000
		brne	avr2891		; 2895 F7D9
		brlo	avr2898		; 2896 F008
		sbi	PORTC, 1	; 2897 9AA9
avr2898:brsh	avr289A		; 2898 F408
		cbi	PORTC, 1	; 2899 98A9
avr289A:lsr	r16			; 289A 9506
		dec	r18			; 289B 952A
		brne	avr288F		; 289C F791
		sbi	PORTC, 1	; 289D 9AA9
		pop	r18			; 289E 912F
		ret				; 289F 9508
;-------------------------------------------------------------------------
avr28A0:wdr				; 28A0 95A8
		push	r18			; 28A1 932F
		sbi	PORTC, 0	; 28A2 9AA8
		sbi	DDRC, 0	; 28A3 9AA0
		com	r16			; 28A4 9500
		sec				; 28A5 9408
		ldi	r18, 0x0A		; 28A6 E02A
avr28A7:lds	r17, 0x04C4		; 28A7 9110 04C4
avr28A9:dec	r17			; 28A9 951A
		nop				; 28AA 0000
		nop				; 28AB 0000
		nop				; 28AC 0000
		brne	avr28A9		; 28AD F7D9
		brlo	avr28B0		; 28AE F008
		sbi	PORTC, 0	; 28AF 9AA8
avr28B0:brsh	avr28B2		; 28B0 F408
		cbi	PORTC, 0	; 28B1 98A8
avr28B2:lsr	r16			; 28B2 9506
		dec	r18			; 28B3 952A
		brne	avr28A7		; 28B4 F791
		sbi	PORTC, 0	; 28B5 9AA8
		pop	r18			; 28B6 912F
		ret				; 28B7 9508
;-------------------------------------------------------------------------
avr28B8:wdr				; 28B8 95A8
		push	r18			; 28B9 932F
		sbi	$03, 7	; 28BA 9A1F
		sbi	$02, 7	; 28BB 9A17
		com	r16			; 28BC 9500
		sec				; 28BD 9408
		ldi	r18, 0x0A		; 28BE E02A
avr28BF:lds	r17, 0x04C4		; 28BF 9110 04C4
avr28C1:dec	r17			; 28C1 951A
		nop				; 28C2 0000
		nop				; 28C3 0000
		nop				; 28C4 0000
		brne	avr28C1		; 28C5 F7D9
		brlo	avr28C8		; 28C6 F008
		sbi	$03, 7	; 28C7 9A1F
avr28C8:brsh	avr28CA		; 28C8 F408
		cbi	$03, 7	; 28C9 981F
avr28CA:lsr	r16			; 28CA 9506
		dec	r18			; 28CB 952A
		brne	avr28BF		; 28CC F791
		sbi	$03, 7	; 28CD 9A1F
		pop	r18			; 28CE 912F
		ret				; 28CF 9508
;-------------------------------------------------------------------------
avr28D0:wdr				; 28D0 95A8
		push	r18			; 28D1 932F
		sbi	$03, 6	; 28D2 9A1E
		sbi	$02, 6	; 28D3 9A16
		com	r16			; 28D4 9500
		sec				; 28D5 9408
		ldi	r18, 0x0A		; 28D6 E02A
avr28D7:lds	r17, 0x04C4		; 28D7 9110 04C4
avr28D9:dec	r17			; 28D9 951A
		nop				; 28DA 0000
		nop				; 28DB 0000
		nop				; 28DC 0000
		brne	avr28D9		; 28DD F7D9
		brlo	avr28E0		; 28DE F008
		sbi	$03, 6	; 28DF 9A1E
avr28E0:brsh	avr28E2		; 28E0 F408
		cbi	$03, 6	; 28E1 981E
avr28E2:lsr	r16			; 28E2 9506
		dec	r18			; 28E3 952A
		brne	avr28D7		; 28E4 F791
		sbi	$03, 6	; 28E5 9A1E
		pop	r18			; 28E6 912F
		ret				; 28E7 9508
;-------------------------------------------------------------------------
avr28E8:wdr				; 28E8 95A8
		push	r18			; 28E9 932F
		sbi	PORTD, 7	; 28EA 9A97
		sbi	DDRD, 7	; 28EB 9A8F
		com	r16			; 28EC 9500
		sec				; 28ED 9408
		ldi	r18, 0x0A		; 28EE E02A
avr28EF:lds	r17, 0x04C4		; 28EF 9110 04C4
avr28F1:dec	r17			; 28F1 951A
		nop				; 28F2 0000
		nop				; 28F3 0000
		nop				; 28F4 0000
		brne	avr28F1		; 28F5 F7D9
		brlo	avr28F8		; 28F6 F008
		sbi	PORTD, 7	; 28F7 9A97
avr28F8:brsh	avr28FA		; 28F8 F408
		cbi	PORTD, 7	; 28F9 9897
avr28FA:lsr	r16			; 28FA 9506
		dec	r18			; 28FB 952A
		brne	avr28EF		; 28FC F791
		sbi	PORTD, 7	; 28FD 9A97
		pop	r18			; 28FE 912F
		ret				; 28FF 9508
;-------------------------------------------------------------------------
avr2900:wdr				; 2900 95A8
		push	r18			; 2901 932F
		sbi	PORTD, 6	; 2902 9A96
		sbi	DDRD, 6	; 2903 9A8E
		com	r16			; 2904 9500
		sec				; 2905 9408
		ldi	r18, 0x0A		; 2906 E02A
avr2907:lds	r17, 0x04C4		; 2907 9110 04C4
avr2909:dec	r17			; 2909 951A
		nop				; 290A 0000
		nop				; 290B 0000
		nop				; 290C 0000
		brne	avr2909		; 290D F7D9
		brlo	avr2910		; 290E F008
		sbi	PORTD, 6	; 290F 9A96
avr2910:brsh	avr2912		; 2910 F408
		cbi	PORTD, 6	; 2911 9896
avr2912:lsr	r16			; 2912 9506
		dec	r18			; 2913 952A
		brne	avr2907		; 2914 F791
		sbi	PORTD, 6	; 2915 9A96
		pop	r18			; 2916 912F
		ret				; 2917 9508
;-------------------------------------------------------------------------
avr2918:wdr				; 2918 95A8
		push	r18			; 2919 932F
		sbi	PORTD, 5	; 291A 9A95
		sbi	DDRD, 5	; 291B 9A8D
		com	r16			; 291C 9500
		sec				; 291D 9408
		ldi	r18, 0x0A		; 291E E02A
avr291F:lds	r17, 0x04C4		; 291F 9110 04C4
avr2921:dec	r17			; 2921 951A
		nop				; 2922 0000
		nop				; 2923 0000
		nop				; 2924 0000
		brne	avr2921		; 2925 F7D9
		brlo	avr2928		; 2926 F008
		sbi	PORTD, 5	; 2927 9A95
avr2928:brsh	avr292A		; 2928 F408
		cbi	PORTD, 5	; 2929 9895
avr292A:lsr	r16			; 292A 9506
		dec	r18			; 292B 952A
		brne	avr291F		; 292C F791
		sbi	PORTD, 5	; 292D 9A95
		pop	r18			; 292E 912F
		ret				; 292F 9508
;-------------------------------------------------------------------------
avr2930:wdr				; 2930 95A8
		push	r18			; 2931 932F
		push	r19			; 2932 933F
		push	r20			; 2933 934F
		lds	r19, 0x0065		; 2934 9130 0065
		ori	r19, 0x04		; 2936 6034
		sts	0x0065, r19		; 2937 9330 0065
		lds	r20, 0x0064		; 2939 9140 0064
		ori	r20, 0x04		; 293B 6044
		sts	0x0064, r20		; 293C 9340 0064
		mov	r20, r19		; 293E 2F43
		andi	r20, 0xFB		; 293F 7F4B
		com	r16			; 2940 9500
		sec				; 2941 9408
		ldi	r18, 0x0A		; 2942 E02A
avr2943:lds	r17, 0x04C4		; 2943 9110 04C4
avr2945:dec	r17			; 2945 951A
		nop				; 2946 0000
		nop				; 2947 0000
		nop				; 2948 0000
		brne	avr2945		; 2949 F7D9
		brlo	avr294D		; 294A F010
		sts	0x0065, r19		; 294B 9330 0065
avr294D:brsh	avr2950		; 294D F410
		sts	0x0065, r20		; 294E 9340 0065
avr2950:lsr	r16			; 2950 9506
		dec	r18			; 2951 952A
		brne	avr2943		; 2952 F781
		sts	0x0065, r19		; 2953 9330 0065
		pop	r20			; 2955 914F
		pop	r19			; 2956 913F
		pop	r18			; 2957 912F
		ret				; 2958 9508
;-------------------------------------------------------------------------
avr2959:wdr				; 2959 95A8
		push	r18			; 295A 932F
		push	r19			; 295B 933F
		push	r20			; 295C 934F
		lds	r19, 0x0065		; 295D 9130 0065
		ori	r19, 0x02		; 295F 6032
		sts	0x0065, r19		; 2960 9330 0065
		lds	r20, 0x0064		; 2962 9140 0064
		ori	r20, 0x02		; 2964 6042
		sts	0x0064, r20		; 2965 9340 0064
		mov	r20, r19		; 2967 2F43
		andi	r20, 0xFD		; 2968 7F4D
		com	r16			; 2969 9500
		sec				; 296A 9408
		ldi	r18, 0x0A		; 296B E02A
avr296C:lds	r17, 0x04C4		; 296C 9110 04C4
avr296E:dec	r17			; 296E 951A
		nop				; 296F 0000
		nop				; 2970 0000
		nop				; 2971 0000
		brne	avr296E		; 2972 F7D9
		brlo	avr2976		; 2973 F010
		sts	0x0065, r19		; 2974 9330 0065
avr2976:brsh	avr2979		; 2976 F410
		sts	0x0065, r20		; 2977 9340 0065
avr2979:lsr	r16			; 2979 9506
		dec	r18			; 297A 952A
		brne	avr296C		; 297B F781
		sts	0x0065, r19		; 297C 9330 0065
		pop	r20			; 297E 914F
		pop	r19			; 297F 913F
		pop	r18			; 2980 912F
		ret				; 2981 9508
;-------------------------------------------------------------------------
avr2982:wdr				; 2982 95A8
		push	r18			; 2983 932F
		push	r19			; 2984 933F
		push	r20			; 2985 934F
		lds	r19, 0x0065		; 2986 9130 0065
		ori	r19, 0x01		; 2988 6031
		sts	0x0065, r19		; 2989 9330 0065
		lds	r20, 0x0064		; 298B 9140 0064
		ori	r20, 0x01		; 298D 6041
		sts	0x0064, r20		; 298E 9340 0064
		mov	r20, r19		; 2990 2F43
		andi	r20, 0xFE		; 2991 7F4E
		com	r16			; 2992 9500
		sec				; 2993 9408
		ldi	r18, 0x0A		; 2994 E02A
avr2995:lds	r17, 0x04C4		; 2995 9110 04C4
avr2997:dec	r17			; 2997 951A
		nop				; 2998 0000
		nop				; 2999 0000
		nop				; 299A 0000
		brne	avr2997		; 299B F7D9
		brlo	avr299F		; 299C F010
		sts	0x0065, r19		; 299D 9330 0065
avr299F:brsh	avr29A2		; 299F F410
		sts	0x0065, r20		; 29A0 9340 0065
avr29A2:lsr	r16			; 29A2 9506
		dec	r18			; 29A3 952A
		brne	avr2995		; 29A4 F781
		sts	0x0065, r19		; 29A5 9330 0065
		pop	r20			; 29A7 914F
		pop	r19			; 29A8 913F
		pop	r18			; 29A9 912F
		ret				; 29AA 9508
;-------------------------------------------------------------------------
avr29AB:wdr				; 29AB 95A8
		cpi	r17, 0x00		; 29AC 3010
		breq	avr29ED		; 29AD F1F9
		cpi	r17, 0x01		; 29AE 3011
		breq	avr29EE		; 29AF F1F1
		cpi	r17, 0x02		; 29B0 3012
		breq	avr29EF		; 29B1 F1E9
		cpi	r17, 0x03		; 29B2 3013
		breq	avr29F0		; 29B3 F1E1
		cpi	r17, 0x04		; 29B4 3014
		breq	avr29F1		; 29B5 F1D9
		cpi	r17, 0x05		; 29B6 3015
		breq	avr29F2		; 29B7 F1D1
		cpi	r17, 0x06		; 29B8 3016
		breq	avr29F3		; 29B9 F1C9
		cpi	r17, 0x07		; 29BA 3017
		breq	avr29F4		; 29BB F1C1
		cpi	r17, 0x08		; 29BC 3018
		breq	avr29F5		; 29BD F1B9
		cpi	r17, 0x09		; 29BE 3019
		breq	avr29F6		; 29BF F1B1
		cpi	r17, 0x0A		; 29C0 301A
		breq	avr29F7		; 29C1 F1A9
		cpi	r17, 0x0B		; 29C2 301B
		breq	avr29F8		; 29C3 F1A1
		cpi	r17, 0x0C		; 29C4 301C
		breq	avr29F9		; 29C5 F199
		cpi	r17, 0x0D		; 29C6 301D
		breq	avr29FA		; 29C7 F191
		cpi	r17, 0x0E		; 29C8 301E
		breq	avr29FB		; 29C9 F189
		cpi	r17, 0x0F		; 29CA 301F
		breq	avr29FC		; 29CB F181
		cpi	r17, 0x10		; 29CC 3110
		breq	avr29FD		; 29CD F179
		cpi	r17, 0x11		; 29CE 3111
		breq	avr29FE		; 29CF F171
		cpi	r17, 0x12		; 29D0 3112
		breq	avr29FF		; 29D1 F169
		cpi	r17, 0x13		; 29D2 3113
		breq	avr2A00		; 29D3 F161
		cpi	r17, 0x14		; 29D4 3114
		breq	avr2A01		; 29D5 F159
		cpi	r17, 0x15		; 29D6 3115
		breq	avr2A02		; 29D7 F151
		cpi	r17, 0x16		; 29D8 3116
		breq	avr2A03		; 29D9 F149
		cpi	r17, 0x17		; 29DA 3117
		breq	avr2A04		; 29DB F141
		cpi	r17, 0x18		; 29DC 3118
		breq	avr2A05		; 29DD F139
		cpi	r17, 0x19		; 29DE 3119
		breq	avr2A06		; 29DF F131
		cpi	r17, 0x1A		; 29E0 311A
		breq	avr2A07		; 29E1 F129
		cpi	r17, 0x1B		; 29E2 311B
		breq	avr2A08		; 29E3 F121
		cpi	r17, 0x1C		; 29E4 311C
		breq	avr2A09		; 29E5 F119
		cpi	r17, 0x1D		; 29E6 311D
		breq	avr2A0A		; 29E7 F111
		cpi	r17, 0x1E		; 29E8 311E
		breq	avr2A0B		; 29E9 F109
		cpi	r17, 0x1F		; 29EA 311F
		breq	avr2A0C		; 29EB F101
		ret				; 29EC 9508
;-------------------------------------------------------------------------
avr29ED:rjmp	avr2A0E		; 29ED C020
avr29EE:rjmp	avr2A4B		; 29EE C05C
avr29EF:rjmp	avr2A88		; 29EF C098
avr29F0:rjmp	avr2AC5		; 29F0 C0D4
avr29F1:rjmp	avr2B02		; 29F1 C110
avr29F2:rjmp	avr2B3F		; 29F2 C14C
avr29F3:rjmp	avr2B7C		; 29F3 C188
avr29F4:rjmp	avr2BB9		; 29F4 C1C4
avr29F5:rjmp	avr2BF6		; 29F5 C200
avr29F6:rjmp	avr2C33		; 29F6 C23C
avr29F7:rjmp	avr2C70		; 29F7 C278
avr29F8:rjmp	avr2CAD		; 29F8 C2B4
avr29F9:rjmp	avr2CEA		; 29F9 C2F0
avr29FA:rjmp	avr2D27		; 29FA C32C
avr29FB:rjmp	avr2D64		; 29FB C368
avr29FC:rjmp	avr2DA1		; 29FC C3A4
avr29FD:rjmp	avr2DDE		; 29FD C3E0
avr29FE:rjmp	avr2E1B		; 29FE C41C
avr29FF:rjmp	avr2E58		; 29FF C458
avr2A00:rjmp	avr2E95		; 2A00 C494
avr2A01:rjmp	avr2ED2		; 2A01 C4D0
avr2A02:rjmp	avr2F0F		; 2A02 C50C
avr2A03:rjmp	avr2F4C		; 2A03 C548
avr2A04:rjmp	avr2F89		; 2A04 C584
avr2A05:rjmp	avr2FC6		; 2A05 C5C0
avr2A06:rjmp	avr3003		; 2A06 C5FC
avr2A07:rjmp	avr3040		; 2A07 C638
avr2A08:rjmp	avr307D		; 2A08 C674
avr2A09:rjmp	avr30BA		; 2A09 C6B0
avr2A0A:rjmp	avr30F7		; 2A0A C6EC
avr2A0B:rjmp	avr3142		; 2A0B C736
avr2A0C:rjmp	avr318D		; 2A0C C780
		ret				; 2A0D 9508
;-------------------------------------------------------------------------
avr2A0E:nop				; 2A0E 0000
		push	r18			; 2A0F 932F
		cbi	DDRA, 0	; 2A10 98D0
		sbis	PINA, 0	; 2A11 9BC8
		rjmp	avr31D8		; 2A12 C7C5
		nop				; 2A13 0000
		rcall	sub31F4		; 2A14 D7DF
avr2A15:wdr				; 2A15 95A8
		sbis	PINA, 0	; 2A16 9BC8
		rjmp	avr2A1C		; 2A17 C004
		in	r16, $36		; 2A18 B706
		sbrs	r16, 2		; 2A19 FF02
		rjmp	avr2A15		; 2A1A CFFA
		rjmp	avr31DC		; 2A1B C7C0
avr2A1C:nop				; 2A1C 0000
		lds	r17, 0x04C4		; 2A1D 9110 04C4
		lsr	r17			; 2A1F 9516
avr2A20:dec	r17			; 2A20 951A
		nop				; 2A21 0000
		nop				; 2A22 0000
		nop				; 2A23 0000
		brne	avr2A20		; 2A24 F7D9
		sbic	PINA, 0	; 2A25 99C8
		rjmp	avr31E0		; 2A26 C7B9
		nop				; 2A27 0000
		lds	r17, 0x04C4		; 2A28 9110 04C4
		dec	r17			; 2A2A 951A
avr2A2B:dec	r17			; 2A2B 951A
		nop				; 2A2C 0000
		nop				; 2A2D 0000
		nop				; 2A2E 0000
		brne	avr2A2B		; 2A2F F7D9
		nop				; 2A30 0000
		clr	r16			; 2A31 2700
		ldi	r18, 0x08		; 2A32 E028
avr2A33:nop				; 2A33 0000
		nop				; 2A34 0000
		sec				; 2A35 9408
		sbic	PINA, 0	; 2A36 99C8
		rjmp	avr2A39		; 2A37 C001
		clc				; 2A38 9488
avr2A39:ror	r16			; 2A39 9507
		nop				; 2A3A 0000
		lds	r17, 0x04C4		; 2A3B 9110 04C4
		dec	r17			; 2A3D 951A
avr2A3E:dec	r17			; 2A3E 951A
		nop				; 2A3F 0000
		nop				; 2A40 0000
		nop				; 2A41 0000
		brne	avr2A3E		; 2A42 F7D9
		nop				; 2A43 0000
		nop				; 2A44 0000
		dec	r18			; 2A45 952A
		brne	avr2A33		; 2A46 F761
		sbis	PINA, 0	; 2A47 9BC8
		rjmp	avr31E4		; 2A48 C79B
		nop				; 2A49 0000
		rjmp	avr31EE		; 2A4A C7A3

avr2A4B:nop				; 2A4B 0000
		push	r18			; 2A4C 932F
		cbi	DDRA, 1	; 2A4D 98D1
		sbis	PINA, 1	; 2A4E 9BC9
		rjmp	avr31D8		; 2A4F C788
		nop				; 2A50 0000
		rcall	sub31F4		; 2A51 D7A2
avr2A52:wdr				; 2A52 95A8
		sbis	PINA, 1	; 2A53 9BC9
		rjmp	avr2A59		; 2A54 C004
		in	r16, $36		; 2A55 B706
		sbrs	r16, 2		; 2A56 FF02
		rjmp	avr2A52		; 2A57 CFFA
		rjmp	avr31DC		; 2A58 C783
avr2A59:nop				; 2A59 0000
		lds	r17, 0x04C4		; 2A5A 9110 04C4
		lsr	r17			; 2A5C 9516
avr2A5D:dec	r17			; 2A5D 951A
		nop				; 2A5E 0000
		nop				; 2A5F 0000
		nop				; 2A60 0000
		brne	avr2A5D		; 2A61 F7D9
		sbic	PINA, 1	; 2A62 99C9
		rjmp	avr31E0		; 2A63 C77C
		nop				; 2A64 0000
		lds	r17, 0x04C4		; 2A65 9110 04C4
		dec	r17			; 2A67 951A
avr2A68:dec	r17			; 2A68 951A
		nop				; 2A69 0000
		nop				; 2A6A 0000
		nop				; 2A6B 0000
		brne	avr2A68		; 2A6C F7D9
		nop				; 2A6D 0000
		clr	r16			; 2A6E 2700
		ldi	r18, 0x08		; 2A6F E028
avr2A70:nop				; 2A70 0000
		nop				; 2A71 0000
		sec				; 2A72 9408
		sbic	PINA, 1	; 2A73 99C9
		rjmp	avr2A76		; 2A74 C001
		clc				; 2A75 9488
avr2A76:ror	r16			; 2A76 9507
		nop				; 2A77 0000
		lds	r17, 0x04C4		; 2A78 9110 04C4
		dec	r17			; 2A7A 951A
avr2A7B:dec	r17			; 2A7B 951A
		nop				; 2A7C 0000
		nop				; 2A7D 0000
		nop				; 2A7E 0000
		brne	avr2A7B		; 2A7F F7D9
		nop				; 2A80 0000
		nop				; 2A81 0000
		dec	r18			; 2A82 952A
		brne	avr2A70		; 2A83 F761
		sbis	PINA, 1	; 2A84 9BC9
		rjmp	avr31E4		; 2A85 C75E
		nop				; 2A86 0000
		rjmp	avr31EE		; 2A87 C766

avr2A88:nop				; 2A88 0000
		push	r18			; 2A89 932F
		cbi	DDRA, 2	; 2A8A 98D2
		sbis	PINA, 2	; 2A8B 9BCA
		rjmp	avr31D8		; 2A8C C74B
		nop				; 2A8D 0000
		rcall	sub31F4		; 2A8E D765
avr2A8F:wdr				; 2A8F 95A8
		sbis	PINA, 2	; 2A90 9BCA
		rjmp	avr2A96		; 2A91 C004
		in	r16, $36		; 2A92 B706
		sbrs	r16, 2		; 2A93 FF02
		rjmp	avr2A8F		; 2A94 CFFA
		rjmp	avr31DC		; 2A95 C746
avr2A96:nop				; 2A96 0000
		lds	r17, 0x04C4		; 2A97 9110 04C4
		lsr	r17			; 2A99 9516
avr2A9A:dec	r17			; 2A9A 951A
		nop				; 2A9B 0000
		nop				; 2A9C 0000
		nop				; 2A9D 0000
		brne	avr2A9A		; 2A9E F7D9
		sbic	PINA, 2	; 2A9F 99CA
		rjmp	avr31E0		; 2AA0 C73F
		nop				; 2AA1 0000
		lds	r17, 0x04C4		; 2AA2 9110 04C4
		dec	r17			; 2AA4 951A
avr2AA5:dec	r17			; 2AA5 951A
		nop				; 2AA6 0000
		nop				; 2AA7 0000
		nop				; 2AA8 0000
		brne	avr2AA5		; 2AA9 F7D9
		nop				; 2AAA 0000
		clr	r16			; 2AAB 2700
		ldi	r18, 0x08		; 2AAC E028
avr2AAD:nop				; 2AAD 0000
		nop				; 2AAE 0000
		sec				; 2AAF 9408
		sbic	PINA, 2	; 2AB0 99CA
		rjmp	avr2AB3		; 2AB1 C001
		clc				; 2AB2 9488
avr2AB3:ror	r16			; 2AB3 9507
		nop				; 2AB4 0000
		lds	r17, 0x04C4		; 2AB5 9110 04C4
		dec	r17			; 2AB7 951A
avr2AB8:dec	r17			; 2AB8 951A
		nop				; 2AB9 0000
		nop				; 2ABA 0000
		nop				; 2ABB 0000
		brne	avr2AB8		; 2ABC F7D9
		nop				; 2ABD 0000
		nop				; 2ABE 0000
		dec	r18			; 2ABF 952A
		brne	avr2AAD		; 2AC0 F761
		sbis	PINA, 2	; 2AC1 9BCA
		rjmp	avr31E4		; 2AC2 C721
		nop				; 2AC3 0000
		rjmp	avr31EE		; 2AC4 C729

avr2AC5:nop				; 2AC5 0000
		push	r18			; 2AC6 932F
		cbi	DDRA, 3	; 2AC7 98D3
		sbis	PINA, 3	; 2AC8 9BCB
		rjmp	avr31D8		; 2AC9 C70E
		nop				; 2ACA 0000
		rcall	sub31F4		; 2ACB D728
avr2ACC:wdr				; 2ACC 95A8
		sbis	PINA, 3	; 2ACD 9BCB
		rjmp	avr2AD3		; 2ACE C004
		in	r16, $36		; 2ACF B706
		sbrs	r16, 2		; 2AD0 FF02
		rjmp	avr2ACC		; 2AD1 CFFA
		rjmp	avr31DC		; 2AD2 C709
avr2AD3:nop				; 2AD3 0000
		lds	r17, 0x04C4		; 2AD4 9110 04C4
		lsr	r17			; 2AD6 9516
avr2AD7:dec	r17			; 2AD7 951A
		nop				; 2AD8 0000
		nop				; 2AD9 0000
		nop				; 2ADA 0000
		brne	avr2AD7		; 2ADB F7D9
		sbic	PINA, 3	; 2ADC 99CB
		rjmp	avr31E0		; 2ADD C702
		nop				; 2ADE 0000
		lds	r17, 0x04C4		; 2ADF 9110 04C4
		dec	r17			; 2AE1 951A
avr2AE2:dec	r17			; 2AE2 951A
		nop				; 2AE3 0000
		nop				; 2AE4 0000
		nop				; 2AE5 0000
		brne	avr2AE2		; 2AE6 F7D9
		nop				; 2AE7 0000
		clr	r16			; 2AE8 2700
		ldi	r18, 0x08		; 2AE9 E028
avr2AEA:nop				; 2AEA 0000
		nop				; 2AEB 0000
		sec				; 2AEC 9408
		sbic	PINA, 3	; 2AED 99CB
		rjmp	avr2AF0		; 2AEE C001
		clc				; 2AEF 9488
avr2AF0:ror	r16			; 2AF0 9507
		nop				; 2AF1 0000
		lds	r17, 0x04C4		; 2AF2 9110 04C4
		dec	r17			; 2AF4 951A
avr2AF5:dec	r17			; 2AF5 951A
		nop				; 2AF6 0000
		nop				; 2AF7 0000
		nop				; 2AF8 0000
		brne	avr2AF5		; 2AF9 F7D9
		nop				; 2AFA 0000
		nop				; 2AFB 0000
		dec	r18			; 2AFC 952A
		brne	avr2AEA		; 2AFD F761
		sbis	PINA, 3	; 2AFE 9BCB
		rjmp	avr31E4		; 2AFF C6E4
		nop				; 2B00 0000
		rjmp	avr31EE		; 2B01 C6EC

avr2B02:nop				; 2B02 0000
		push	r18			; 2B03 932F
		cbi	DDRA, 4	; 2B04 98D4
		sbis	PINA, 4	; 2B05 9BCC
		rjmp	avr31D8		; 2B06 C6D1
		nop				; 2B07 0000
		rcall	sub31F4		; 2B08 D6EB
avr2B09:wdr				; 2B09 95A8
		sbis	PINA, 4	; 2B0A 9BCC
		rjmp	avr2B10		; 2B0B C004
		in	r16, $36		; 2B0C B706
		sbrs	r16, 2		; 2B0D FF02
		rjmp	avr2B09		; 2B0E CFFA
		rjmp	avr31DC		; 2B0F C6CC
avr2B10:nop				; 2B10 0000
		lds	r17, 0x04C4		; 2B11 9110 04C4
		lsr	r17			; 2B13 9516
avr2B14:dec	r17			; 2B14 951A
		nop				; 2B15 0000
		nop				; 2B16 0000
		nop				; 2B17 0000
		brne	avr2B14		; 2B18 F7D9
		sbic	PINA, 4	; 2B19 99CC
		rjmp	avr31E0		; 2B1A C6C5
		nop				; 2B1B 0000
		lds	r17, 0x04C4		; 2B1C 9110 04C4
		dec	r17			; 2B1E 951A
avr2B1F:dec	r17			; 2B1F 951A
		nop				; 2B20 0000
		nop				; 2B21 0000
		nop				; 2B22 0000
		brne	avr2B1F		; 2B23 F7D9
		nop				; 2B24 0000
		clr	r16			; 2B25 2700
		ldi	r18, 0x08		; 2B26 E028
avr2B27:nop				; 2B27 0000
		nop				; 2B28 0000
		sec				; 2B29 9408
		sbic	PINA, 4	; 2B2A 99CC
		rjmp	avr2B2D		; 2B2B C001
		clc				; 2B2C 9488
avr2B2D:ror	r16			; 2B2D 9507
		nop				; 2B2E 0000
		lds	r17, 0x04C4		; 2B2F 9110 04C4
		dec	r17			; 2B31 951A
avr2B32:dec	r17			; 2B32 951A
		nop				; 2B33 0000
		nop				; 2B34 0000
		nop				; 2B35 0000
		brne	avr2B32		; 2B36 F7D9
		nop				; 2B37 0000
		nop				; 2B38 0000
		dec	r18			; 2B39 952A
		brne	avr2B27		; 2B3A F761
		sbis	PINA, 4	; 2B3B 9BCC
		rjmp	avr31E4		; 2B3C C6A7
		nop				; 2B3D 0000
		rjmp	avr31EE		; 2B3E C6AF

avr2B3F:nop				; 2B3F 0000
		push	r18			; 2B40 932F
		cbi	DDRA, 5	; 2B41 98D5
		sbis	PINA, 5	; 2B42 9BCD
		rjmp	avr31D8		; 2B43 C694
		nop				; 2B44 0000
		rcall	sub31F4		; 2B45 D6AE
avr2B46:wdr				; 2B46 95A8
		sbis	PINA, 5	; 2B47 9BCD
		rjmp	avr2B4D		; 2B48 C004
		in	r16, $36		; 2B49 B706
		sbrs	r16, 2		; 2B4A FF02
		rjmp	avr2B46		; 2B4B CFFA
		rjmp	avr31DC		; 2B4C C68F
avr2B4D:nop				; 2B4D 0000
		lds	r17, 0x04C4		; 2B4E 9110 04C4
		lsr	r17			; 2B50 9516
avr2B51:dec	r17			; 2B51 951A
		nop				; 2B52 0000
		nop				; 2B53 0000
		nop				; 2B54 0000
		brne	avr2B51		; 2B55 F7D9
		sbic	PINA, 5	; 2B56 99CD
		rjmp	avr31E0		; 2B57 C688
		nop				; 2B58 0000
		lds	r17, 0x04C4		; 2B59 9110 04C4
		dec	r17			; 2B5B 951A
avr2B5C:dec	r17			; 2B5C 951A
		nop				; 2B5D 0000
		nop				; 2B5E 0000
		nop				; 2B5F 0000
		brne	avr2B5C		; 2B60 F7D9
		nop				; 2B61 0000
		clr	r16			; 2B62 2700
		ldi	r18, 0x08		; 2B63 E028
avr2B64:nop				; 2B64 0000
		nop				; 2B65 0000
		sec				; 2B66 9408
		sbic	PINA, 5	; 2B67 99CD
		rjmp	avr2B6A		; 2B68 C001
		clc				; 2B69 9488
avr2B6A:ror	r16			; 2B6A 9507
		nop				; 2B6B 0000
		lds	r17, 0x04C4		; 2B6C 9110 04C4
		dec	r17			; 2B6E 951A
avr2B6F:dec	r17			; 2B6F 951A
		nop				; 2B70 0000
		nop				; 2B71 0000
		nop				; 2B72 0000
		brne	avr2B6F		; 2B73 F7D9
		nop				; 2B74 0000
		nop				; 2B75 0000
		dec	r18			; 2B76 952A
		brne	avr2B64		; 2B77 F761
		sbis	PINA, 5	; 2B78 9BCD
		rjmp	avr31E4		; 2B79 C66A
		nop				; 2B7A 0000
		rjmp	avr31EE		; 2B7B C672

avr2B7C:nop				; 2B7C 0000
		push	r18			; 2B7D 932F
		cbi	DDRA, 6	; 2B7E 98D6
		sbis	PINA, 6	; 2B7F 9BCE
		rjmp	avr31D8		; 2B80 C657
		nop				; 2B81 0000
		rcall	sub31F4		; 2B82 D671
avr2B83:wdr				; 2B83 95A8
		sbis	PINA, 6	; 2B84 9BCE
		rjmp	avr2B8A		; 2B85 C004
		in	r16, $36		; 2B86 B706
		sbrs	r16, 2		; 2B87 FF02
		rjmp	avr2B83		; 2B88 CFFA
		rjmp	avr31DC		; 2B89 C652
avr2B8A:nop				; 2B8A 0000
		lds	r17, 0x04C4		; 2B8B 9110 04C4
		lsr	r17			; 2B8D 9516
avr2B8E:dec	r17			; 2B8E 951A
		nop				; 2B8F 0000
		nop				; 2B90 0000
		nop				; 2B91 0000
		brne	avr2B8E		; 2B92 F7D9
		sbic	PINA, 6	; 2B93 99CE
		rjmp	avr31E0		; 2B94 C64B
		nop				; 2B95 0000
		lds	r17, 0x04C4		; 2B96 9110 04C4
		dec	r17			; 2B98 951A
avr2B99:dec	r17			; 2B99 951A
		nop				; 2B9A 0000
		nop				; 2B9B 0000
		nop				; 2B9C 0000
		brne	avr2B99		; 2B9D F7D9
		nop				; 2B9E 0000
		clr	r16			; 2B9F 2700
		ldi	r18, 0x08		; 2BA0 E028
avr2BA1:nop				; 2BA1 0000
		nop				; 2BA2 0000
		sec				; 2BA3 9408
		sbic	PINA, 6	; 2BA4 99CE
		rjmp	avr2BA7		; 2BA5 C001
		clc				; 2BA6 9488
avr2BA7:ror	r16			; 2BA7 9507
		nop				; 2BA8 0000
		lds	r17, 0x04C4		; 2BA9 9110 04C4
		dec	r17			; 2BAB 951A
avr2BAC:		dec	r17			; 2BAC 951A
		nop				; 2BAD 0000
		nop				; 2BAE 0000
		nop				; 2BAF 0000
		brne	avr2BAC		; 2BB0 F7D9
		nop				; 2BB1 0000
		nop				; 2BB2 0000
		dec	r18			; 2BB3 952A
		brne	avr2BA1		; 2BB4 F761
		sbis	PINA, 6	; 2BB5 9BCE
		rjmp	avr31E4		; 2BB6 C62D
		nop				; 2BB7 0000
		rjmp	avr31EE		; 2BB8 C635

avr2BB9:nop				; 2BB9 0000
		push	r18			; 2BBA 932F
		cbi	DDRA, 7	; 2BBB 98D7
		sbis	PINA, 7	; 2BBC 9BCF
		rjmp	avr31D8		; 2BBD C61A
		nop				; 2BBE 0000
		rcall	sub31F4		; 2BBF D634
avr2BC0:wdr				; 2BC0 95A8
		sbis	PINA, 7	; 2BC1 9BCF
		rjmp	avr2BC7		; 2BC2 C004
		in	r16, $36		; 2BC3 B706
		sbrs	r16, 2		; 2BC4 FF02
		rjmp	avr2BC0		; 2BC5 CFFA
		rjmp	avr31DC		; 2BC6 C615
avr2BC7:nop				; 2BC7 0000
		lds	r17, 0x04C4		; 2BC8 9110 04C4
		lsr	r17			; 2BCA 9516
avr2BCB:dec	r17			; 2BCB 951A
		nop				; 2BCC 0000
		nop				; 2BCD 0000
		nop				; 2BCE 0000
		brne	avr2BCB		; 2BCF F7D9
		sbic	PINA, 7	; 2BD0 99CF
		rjmp	avr31E0		; 2BD1 C60E
		nop				; 2BD2 0000
		lds	r17, 0x04C4		; 2BD3 9110 04C4
		dec	r17			; 2BD5 951A
avr2BD6:dec	r17			; 2BD6 951A
		nop				; 2BD7 0000
		nop				; 2BD8 0000
		nop				; 2BD9 0000
		brne	avr2BD6		; 2BDA F7D9
		nop				; 2BDB 0000
		clr	r16			; 2BDC 2700
		ldi	r18, 0x08		; 2BDD E028
avr2BDE:nop				; 2BDE 0000
		nop				; 2BDF 0000
		sec				; 2BE0 9408
		sbic	PINA, 7	; 2BE1 99CF
		rjmp	avr2BE4		; 2BE2 C001
		clc				; 2BE3 9488
avr2BE4:ror	r16			; 2BE4 9507
		nop				; 2BE5 0000
		lds	r17, 0x04C4		; 2BE6 9110 04C4
		dec	r17			; 2BE8 951A
avr2BE9:dec	r17			; 2BE9 951A
		nop				; 2BEA 0000
		nop				; 2BEB 0000
		nop				; 2BEC 0000
		brne	avr2BE9		; 2BED F7D9
		nop				; 2BEE 0000
		nop				; 2BEF 0000
		dec	r18			; 2BF0 952A
		brne	avr2BDE		; 2BF1 F761
		sbis	PINA, 7	; 2BF2 9BCF
		rjmp	avr31E4		; 2BF3 C5F0
		nop				; 2BF4 0000
		rjmp	avr31EE		; 2BF5 C5F8

avr2BF6:nop				; 2BF6 0000
		push	r18			; 2BF7 932F
		cbi	DDRB, 0	; 2BF8 98B8
		sbis	PINB, 0	; 2BF9 9BB0
		rjmp	avr31D8		; 2BFA C5DD
		nop				; 2BFB 0000
		rcall	sub31F4		; 2BFC D5F7
avr2BFD:wdr				; 2BFD 95A8
		sbis	PINB, 0	; 2BFE 9BB0
		rjmp	avr2C04		; 2BFF C004
		in	r16, $36		; 2C00 B706
		sbrs	r16, 2		; 2C01 FF02
		rjmp	avr2BFD		; 2C02 CFFA
		rjmp	avr31DC		; 2C03 C5D8
avr2C04:nop				; 2C04 0000
		lds	r17, 0x04C4		; 2C05 9110 04C4
		lsr	r17			; 2C07 9516
avr2C08:dec	r17			; 2C08 951A
		nop				; 2C09 0000
		nop				; 2C0A 0000
		nop				; 2C0B 0000
		brne	avr2C08		; 2C0C F7D9
		sbic	PINB, 0	; 2C0D 99B0
		rjmp	avr31E0		; 2C0E C5D1
		nop				; 2C0F 0000
		lds	r17, 0x04C4		; 2C10 9110 04C4
		dec	r17			; 2C12 951A
avr2C13:dec	r17			; 2C13 951A
		nop				; 2C14 0000
		nop				; 2C15 0000
		nop				; 2C16 0000
		brne	avr2C13		; 2C17 F7D9
		nop				; 2C18 0000
		clr	r16			; 2C19 2700
		ldi	r18, 0x08		; 2C1A E028
avr2C1B:nop				; 2C1B 0000
		nop				; 2C1C 0000
		sec				; 2C1D 9408
		sbic	PINB, 0	; 2C1E 99B0
		rjmp	avr2C21		; 2C1F C001
		clc				; 2C20 9488
avr2C21:ror	r16			; 2C21 9507
		nop				; 2C22 0000
		lds	r17, 0x04C4		; 2C23 9110 04C4
		dec	r17			; 2C25 951A
avr2C26:dec	r17			; 2C26 951A
		nop				; 2C27 0000
		nop				; 2C28 0000
		nop				; 2C29 0000
		brne	avr2C26		; 2C2A F7D9
		nop				; 2C2B 0000
		nop				; 2C2C 0000
		dec	r18			; 2C2D 952A
		brne	avr2C1B		; 2C2E F761
		sbis	PINB, 0	; 2C2F 9BB0
		rjmp	avr31E4		; 2C30 C5B3
		nop				; 2C31 0000
		rjmp	avr31EE		; 2C32 C5BB

avr2C33:nop				; 2C33 0000
		push	r18			; 2C34 932F
		cbi	DDRB, 1	; 2C35 98B9
		sbis	PINB, 1	; 2C36 9BB1
		rjmp	avr31D8		; 2C37 C5A0
		nop				; 2C38 0000
		rcall	sub31F4		; 2C39 D5BA
avr2C3A:wdr				; 2C3A 95A8
		sbis	PINB, 1	; 2C3B 9BB1
		rjmp	avr2C41		; 2C3C C004
		in	r16, $36		; 2C3D B706
		sbrs	r16, 2		; 2C3E FF02
		rjmp	avr2C3A		; 2C3F CFFA
		rjmp	avr31DC		; 2C40 C59B
avr2C41:nop				; 2C41 0000
		lds	r17, 0x04C4		; 2C42 9110 04C4
		lsr	r17			; 2C44 9516
avr2C45:dec	r17			; 2C45 951A
		nop				; 2C46 0000
		nop				; 2C47 0000
		nop				; 2C48 0000
		brne	avr2C45		; 2C49 F7D9
		sbic	PINB, 1	; 2C4A 99B1
		rjmp	avr31E0		; 2C4B C594
		nop				; 2C4C 0000
		lds	r17, 0x04C4		; 2C4D 9110 04C4
		dec	r17			; 2C4F 951A
avr2C50:dec	r17			; 2C50 951A
		nop				; 2C51 0000
		nop				; 2C52 0000
		nop				; 2C53 0000
		brne	avr2C50		; 2C54 F7D9
		nop				; 2C55 0000
		clr	r16			; 2C56 2700
		ldi	r18, 0x08		; 2C57 E028
avr2C58:nop				; 2C58 0000
		nop				; 2C59 0000
		sec				; 2C5A 9408
		sbic	PINB, 1	; 2C5B 99B1
		rjmp	avr2C5E		; 2C5C C001
		clc				; 2C5D 9488
avr2C5E:ror	r16			; 2C5E 9507
		nop				; 2C5F 0000
		lds	r17, 0x04C4		; 2C60 9110 04C4
		dec	r17			; 2C62 951A
avr2C63:dec	r17			; 2C63 951A
		nop				; 2C64 0000
		nop				; 2C65 0000
		nop				; 2C66 0000
		brne	avr2C63		; 2C67 F7D9
		nop				; 2C68 0000
		nop				; 2C69 0000
		dec	r18			; 2C6A 952A
		brne	avr2C58		; 2C6B F761
		sbis	PINB, 1	; 2C6C 9BB1
		rjmp	avr31E4		; 2C6D C576
		nop				; 2C6E 0000
		rjmp	avr31EE		; 2C6F C57E

avr2C70:nop				; 2C70 0000
		push	r18			; 2C71 932F
		cbi	DDRB, 2	; 2C72 98BA
		sbis	PINB, 2	; 2C73 9BB2
		rjmp	avr31D8		; 2C74 C563
		nop				; 2C75 0000
		rcall	sub31F4		; 2C76 D57D
avr2C77:wdr				; 2C77 95A8
		sbis	PINB, 2	; 2C78 9BB2
		rjmp	avr2C7E		; 2C79 C004
		in	r16, $36		; 2C7A B706
		sbrs	r16, 2		; 2C7B FF02
		rjmp	avr2C77		; 2C7C CFFA
		rjmp	avr31DC		; 2C7D C55E
avr2C7E:nop				; 2C7E 0000
		lds	r17, 0x04C4		; 2C7F 9110 04C4
		lsr	r17			; 2C81 9516
avr2C82:dec	r17			; 2C82 951A
		nop				; 2C83 0000
		nop				; 2C84 0000
		nop				; 2C85 0000
		brne	avr2C82		; 2C86 F7D9
		sbic	PINB, 2	; 2C87 99B2
		rjmp	avr31E0		; 2C88 C557
		nop				; 2C89 0000
		lds	r17, 0x04C4		; 2C8A 9110 04C4
		dec	r17			; 2C8C 951A
avr2C8D:dec	r17			; 2C8D 951A
		nop				; 2C8E 0000
		nop				; 2C8F 0000
		nop				; 2C90 0000
		brne	avr2C8D		; 2C91 F7D9
		nop				; 2C92 0000
		clr	r16			; 2C93 2700
		ldi	r18, 0x08		; 2C94 E028
avr2C95:nop				; 2C95 0000
		nop				; 2C96 0000
		sec				; 2C97 9408
		sbic	PINB, 2	; 2C98 99B2
		rjmp	avr2C9B		; 2C99 C001
		clc				; 2C9A 9488
avr2C9B:ror	r16			; 2C9B 9507
		nop				; 2C9C 0000
		lds	r17, 0x04C4		; 2C9D 9110 04C4
		dec	r17			; 2C9F 951A
avr2CA0:dec	r17			; 2CA0 951A
		nop				; 2CA1 0000
		nop				; 2CA2 0000
		nop				; 2CA3 0000
		brne	avr2CA0		; 2CA4 F7D9
		nop				; 2CA5 0000
		nop				; 2CA6 0000
		dec	r18			; 2CA7 952A
		brne	avr2C95		; 2CA8 F761
		sbis	PINB, 2	; 2CA9 9BB2
		rjmp	avr31E4		; 2CAA C539
		nop				; 2CAB 0000
		rjmp	avr31EE		; 2CAC C541

avr2CAD:nop				; 2CAD 0000
		push	r18			; 2CAE 932F
		cbi	DDRB, 3	; 2CAF 98BB
		sbis	PINB, 3	; 2CB0 9BB3
		rjmp	avr31D8		; 2CB1 C526
		nop				; 2CB2 0000
		rcall	sub31F4		; 2CB3 D540
avr2CB4:wdr				; 2CB4 95A8
		sbis	PINB, 3	; 2CB5 9BB3
		rjmp	avr2CBB		; 2CB6 C004
		in	r16, $36		; 2CB7 B706
		sbrs	r16, 2		; 2CB8 FF02
		rjmp	avr2CB4		; 2CB9 CFFA
		rjmp	avr31DC		; 2CBA C521
avr2CBB:nop				; 2CBB 0000
		lds	r17, 0x04C4		; 2CBC 9110 04C4
		lsr	r17			; 2CBE 9516
avr2CBF:dec	r17			; 2CBF 951A
		nop				; 2CC0 0000
		nop				; 2CC1 0000
		nop				; 2CC2 0000
		brne	avr2CBF		; 2CC3 F7D9
		sbic	PINB, 3	; 2CC4 99B3
		rjmp	avr31E0		; 2CC5 C51A
		nop				; 2CC6 0000
		lds	r17, 0x04C4		; 2CC7 9110 04C4
		dec	r17			; 2CC9 951A
avr2CCA:dec	r17			; 2CCA 951A
		nop				; 2CCB 0000
		nop				; 2CCC 0000
		nop				; 2CCD 0000
		brne	avr2CCA		; 2CCE F7D9
		nop				; 2CCF 0000
		clr	r16			; 2CD0 2700
		ldi	r18, 0x08		; 2CD1 E028
avr2CD2:nop				; 2CD2 0000
		nop				; 2CD3 0000
		sec				; 2CD4 9408
		sbic	PINB, 3	; 2CD5 99B3
		rjmp	avr2CD8		; 2CD6 C001
		clc				; 2CD7 9488
avr2CD8:ror	r16			; 2CD8 9507
		nop				; 2CD9 0000
		lds	r17, 0x04C4		; 2CDA 9110 04C4
		dec	r17			; 2CDC 951A
avr2CDD:dec	r17			; 2CDD 951A
		nop				; 2CDE 0000
		nop				; 2CDF 0000
		nop				; 2CE0 0000
		brne	avr2CDD		; 2CE1 F7D9
		nop				; 2CE2 0000
		nop				; 2CE3 0000
		dec	r18			; 2CE4 952A
		brne	avr2CD2		; 2CE5 F761
		sbis	PINB, 3	; 2CE6 9BB3
		rjmp	avr31E4		; 2CE7 C4FC
		nop				; 2CE8 0000
		rjmp	avr31EE		; 2CE9 C504

avr2CEA:nop				; 2CEA 0000
		push	r18			; 2CEB 932F
		cbi	DDRB, 4	; 2CEC 98BC
		sbis	PINB, 4	; 2CED 9BB4
		rjmp	avr31D8		; 2CEE C4E9
		nop				; 2CEF 0000
		rcall	sub31F4		; 2CF0 D503
avr2CF1:wdr				; 2CF1 95A8
		sbis	PINB, 4	; 2CF2 9BB4
		rjmp	avr2CF8		; 2CF3 C004
		in	r16, $36		; 2CF4 B706
		sbrs	r16, 2		; 2CF5 FF02
		rjmp	avr2CF1		; 2CF6 CFFA
		rjmp	avr31DC		; 2CF7 C4E4
avr2CF8:nop				; 2CF8 0000
		lds	r17, 0x04C4		; 2CF9 9110 04C4
		lsr	r17			; 2CFB 9516
avr2CFC:dec	r17			; 2CFC 951A
		nop				; 2CFD 0000
		nop				; 2CFE 0000
		nop				; 2CFF 0000
		brne	avr2CFC		; 2D00 F7D9
		sbic	PINB, 4	; 2D01 99B4
		rjmp	avr31E0		; 2D02 C4DD
		nop				; 2D03 0000
		lds	r17, 0x04C4		; 2D04 9110 04C4
		dec	r17			; 2D06 951A
avr2D07:dec	r17			; 2D07 951A
		nop				; 2D08 0000
		nop				; 2D09 0000
		nop				; 2D0A 0000
		brne	avr2D07		; 2D0B F7D9
		nop				; 2D0C 0000
		clr	r16			; 2D0D 2700
		ldi	r18, 0x08		; 2D0E E028
avr2D0F:nop				; 2D0F 0000
		nop				; 2D10 0000
		sec				; 2D11 9408
		sbic	PINB, 4	; 2D12 99B4
		rjmp	avr2D15		; 2D13 C001
		clc				; 2D14 9488
avr2D15:ror	r16			; 2D15 9507
		nop				; 2D16 0000
		lds	r17, 0x04C4		; 2D17 9110 04C4
		dec	r17			; 2D19 951A
avr2D1A:dec	r17			; 2D1A 951A
		nop				; 2D1B 0000
		nop				; 2D1C 0000
		nop				; 2D1D 0000
		brne	avr2D1A		; 2D1E F7D9
		nop				; 2D1F 0000
		nop				; 2D20 0000
		dec	r18			; 2D21 952A
		brne	avr2D0F		; 2D22 F761
		sbis	PINB, 4	; 2D23 9BB4
		rjmp	avr31E4		; 2D24 C4BF
		nop				; 2D25 0000
		rjmp	avr31EE		; 2D26 C4C7

avr2D27:nop				; 2D27 0000
		push	r18			; 2D28 932F
		cbi	DDRB, 5	; 2D29 98BD
		sbis	PINB, 5	; 2D2A 9BB5
		rjmp	avr31D8		; 2D2B C4AC
		nop				; 2D2C 0000
		rcall	sub31F4		; 2D2D D4C6
avr2D2E:wdr				; 2D2E 95A8
		sbis	PINB, 5	; 2D2F 9BB5
		rjmp	avr2D35		; 2D30 C004
		in	r16, $36		; 2D31 B706
		sbrs	r16, 2		; 2D32 FF02
		rjmp	avr2D2E		; 2D33 CFFA
		rjmp	avr31DC		; 2D34 C4A7
avr2D35:nop				; 2D35 0000
		lds	r17, 0x04C4		; 2D36 9110 04C4
		lsr	r17			; 2D38 9516
avr2D39:dec	r17			; 2D39 951A
		nop				; 2D3A 0000
		nop				; 2D3B 0000
		nop				; 2D3C 0000
		brne	avr2D39		; 2D3D F7D9
		sbic	PINB, 5	; 2D3E 99B5
		rjmp	avr31E0		; 2D3F C4A0
		nop				; 2D40 0000
		lds	r17, 0x04C4		; 2D41 9110 04C4
		dec	r17			; 2D43 951A
avr2D44:dec	r17			; 2D44 951A
		nop				; 2D45 0000
		nop				; 2D46 0000
		nop				; 2D47 0000
		brne	avr2D44		; 2D48 F7D9
		nop				; 2D49 0000
		clr	r16			; 2D4A 2700
		ldi	r18, 0x08		; 2D4B E028
avr2D4C:nop				; 2D4C 0000
		nop				; 2D4D 0000
		sec				; 2D4E 9408
		sbic	PINB, 5	; 2D4F 99B5
		rjmp	avr2D52		; 2D50 C001
		clc				; 2D51 9488
avr2D52:ror	r16			; 2D52 9507
		nop				; 2D53 0000
		lds	r17, 0x04C4		; 2D54 9110 04C4
		dec	r17			; 2D56 951A
avr2D57:dec	r17			; 2D57 951A
		nop				; 2D58 0000
		nop				; 2D59 0000
		nop				; 2D5A 0000
		brne	avr2D57		; 2D5B F7D9
		nop				; 2D5C 0000
		nop				; 2D5D 0000
		dec	r18			; 2D5E 952A
		brne	avr2D4C		; 2D5F F761
		sbis	PINB, 5	; 2D60 9BB5
		rjmp	avr31E4		; 2D61 C482
		nop				; 2D62 0000
		rjmp	avr31EE		; 2D63 C48A

avr2D64:nop				; 2D64 0000
		push	r18			; 2D65 932F
		cbi	DDRB, 6	; 2D66 98BE
		sbis	PINB, 6	; 2D67 9BB6
		rjmp	avr31D8		; 2D68 C46F
		nop				; 2D69 0000
		rcall	sub31F4		; 2D6A D489
avr2D6B:wdr				; 2D6B 95A8
		sbis	PINB, 6	; 2D6C 9BB6
		rjmp	avr2D72		; 2D6D C004
		in	r16, $36		; 2D6E B706
		sbrs	r16, 2		; 2D6F FF02
		rjmp	avr2D6B		; 2D70 CFFA
		rjmp	avr31DC		; 2D71 C46A
avr2D72:nop				; 2D72 0000
		lds	r17, 0x04C4		; 2D73 9110 04C4
		lsr	r17			; 2D75 9516
avr2D76:dec	r17			; 2D76 951A
		nop				; 2D77 0000
		nop				; 2D78 0000
		nop				; 2D79 0000
		brne	avr2D76		; 2D7A F7D9
		sbic	PINB, 6	; 2D7B 99B6
		rjmp	avr31E0		; 2D7C C463
		nop				; 2D7D 0000
		lds	r17, 0x04C4		; 2D7E 9110 04C4
		dec	r17			; 2D80 951A
avr2D81:dec	r17			; 2D81 951A
		nop				; 2D82 0000
		nop				; 2D83 0000
		nop				; 2D84 0000
		brne	avr2D81		; 2D85 F7D9
		nop				; 2D86 0000
		clr	r16			; 2D87 2700
		ldi	r18, 0x08		; 2D88 E028
avr2D89:nop				; 2D89 0000
		nop				; 2D8A 0000
		sec				; 2D8B 9408
		sbic	PINB, 6	; 2D8C 99B6
		rjmp	avr2D8F		; 2D8D C001
		clc				; 2D8E 9488
avr2D8F:ror	r16			; 2D8F 9507
		nop				; 2D90 0000
		lds	r17, 0x04C4		; 2D91 9110 04C4
		dec	r17			; 2D93 951A
avr2D94:dec	r17			; 2D94 951A
		nop				; 2D95 0000
		nop				; 2D96 0000
		nop				; 2D97 0000
		brne	avr2D94		; 2D98 F7D9
		nop				; 2D99 0000
		nop				; 2D9A 0000
		dec	r18			; 2D9B 952A
		brne	avr2D89		; 2D9C F761
		sbis	PINB, 6	; 2D9D 9BB6
		rjmp	avr31E4		; 2D9E C445
		nop				; 2D9F 0000
		rjmp	avr31EE		; 2DA0 C44D

avr2DA1:nop				; 2DA1 0000
		push	r18			; 2DA2 932F
		cbi	DDRB, 7	; 2DA3 98BF
		sbis	PINB, 7	; 2DA4 9BB7
		rjmp	avr31D8		; 2DA5 C432
		nop				; 2DA6 0000
		rcall	sub31F4		; 2DA7 D44C
avr2DA8:wdr				; 2DA8 95A8
		sbis	PINB, 7	; 2DA9 9BB7
		rjmp	avr2DAF		; 2DAA C004
		in	r16, $36		; 2DAB B706
		sbrs	r16, 2		; 2DAC FF02
		rjmp	avr2DA8		; 2DAD CFFA
		rjmp	avr31DC		; 2DAE C42D
avr2DAF:nop				; 2DAF 0000
		lds	r17, 0x04C4		; 2DB0 9110 04C4
		lsr	r17			; 2DB2 9516
avr2DB3:dec	r17			; 2DB3 951A
		nop				; 2DB4 0000
		nop				; 2DB5 0000
		nop				; 2DB6 0000
		brne	avr2DB3		; 2DB7 F7D9
		sbic	PINB, 7	; 2DB8 99B7
		rjmp	avr31E0		; 2DB9 C426
		nop				; 2DBA 0000
		lds	r17, 0x04C4		; 2DBB 9110 04C4
		dec	r17			; 2DBD 951A
avr2DBE:dec	r17			; 2DBE 951A
		nop				; 2DBF 0000
		nop				; 2DC0 0000
		nop				; 2DC1 0000
		brne	avr2DBE		; 2DC2 F7D9
		nop				; 2DC3 0000
		clr	r16			; 2DC4 2700
		ldi	r18, 0x08		; 2DC5 E028
avr2DC6:nop				; 2DC6 0000
		nop				; 2DC7 0000
		sec				; 2DC8 9408
		sbic	PINB, 7	; 2DC9 99B7
		rjmp	avr2DCC		; 2DCA C001
		clc				; 2DCB 9488
avr2DCC:ror	r16			; 2DCC 9507
		nop				; 2DCD 0000
		lds	r17, 0x04C4		; 2DCE 9110 04C4
		dec	r17			; 2DD0 951A
avr2DD1:dec	r17			; 2DD1 951A
		nop				; 2DD2 0000
		nop				; 2DD3 0000
		nop				; 2DD4 0000
		brne	avr2DD1		; 2DD5 F7D9
		nop				; 2DD6 0000
		nop				; 2DD7 0000
		dec	r18			; 2DD8 952A
		brne	avr2DC6		; 2DD9 F761
		sbis	PINB, 7	; 2DDA 9BB7
		rjmp	avr31E4		; 2DDB C408
		nop				; 2DDC 0000
		rjmp	avr31EE		; 2DDD C410

avr2DDE:nop				; 2DDE 0000
		push	r18			; 2DDF 932F
		cbi	DDRC, 7	; 2DE0 98A7
		sbis	PINC, 7	; 2DE1 9B9F
		rjmp	avr31D8		; 2DE2 C3F5
		nop				; 2DE3 0000
		rcall	sub31F4		; 2DE4 D40F
avr2DE5:wdr				; 2DE5 95A8
		sbis	PINC, 7	; 2DE6 9B9F
		rjmp	avr2DEC		; 2DE7 C004
		in	r16, $36		; 2DE8 B706
		sbrs	r16, 2		; 2DE9 FF02
		rjmp	avr2DE5		; 2DEA CFFA
		rjmp	avr31DC		; 2DEB C3F0
avr2DEC:nop				; 2DEC 0000
		lds	r17, 0x04C4		; 2DED 9110 04C4
		lsr	r17			; 2DEF 9516
avr2DF0:dec	r17			; 2DF0 951A
		nop				; 2DF1 0000
		nop				; 2DF2 0000
		nop				; 2DF3 0000
		brne	avr2DF0		; 2DF4 F7D9
		sbic	PINC, 7	; 2DF5 999F
		rjmp	avr31E0		; 2DF6 C3E9
		nop				; 2DF7 0000
		lds	r17, 0x04C4		; 2DF8 9110 04C4
		dec	r17			; 2DFA 951A
avr2DFB:dec	r17			; 2DFB 951A
		nop				; 2DFC 0000
		nop				; 2DFD 0000
		nop				; 2DFE 0000
		brne	avr2DFB		; 2DFF F7D9
		nop				; 2E00 0000
		clr	r16			; 2E01 2700
		ldi	r18, 0x08		; 2E02 E028
avr2E03:nop				; 2E03 0000
		nop				; 2E04 0000
		sec				; 2E05 9408
		sbic	PINC, 7	; 2E06 999F
		rjmp	avr2E09		; 2E07 C001
		clc				; 2E08 9488
avr2E09:ror	r16			; 2E09 9507
		nop				; 2E0A 0000
		lds	r17, 0x04C4		; 2E0B 9110 04C4
		dec	r17			; 2E0D 951A
avr2E0E:dec	r17			; 2E0E 951A
		nop				; 2E0F 0000
		nop				; 2E10 0000
		nop				; 2E11 0000
		brne	avr2E0E		; 2E12 F7D9
		nop				; 2E13 0000
		nop				; 2E14 0000
		dec	r18			; 2E15 952A
		brne	avr2E03		; 2E16 F761
		sbis	PINC, 7	; 2E17 9B9F
		rjmp	avr31E4		; 2E18 C3CB
		nop				; 2E19 0000
		rjmp	avr31EE		; 2E1A C3D3

avr2E1B:nop				; 2E1B 0000
		push	r18			; 2E1C 932F
		cbi	DDRC, 6	; 2E1D 98A6
		sbis	PINC, 6	; 2E1E 9B9E
		rjmp	avr31D8		; 2E1F C3B8
		nop				; 2E20 0000
		rcall	sub31F4		; 2E21 D3D2
avr2E22:wdr				; 2E22 95A8
		sbis	PINC, 6	; 2E23 9B9E
		rjmp	avr2E29		; 2E24 C004
		in	r16, $36		; 2E25 B706
		sbrs	r16, 2		; 2E26 FF02
		rjmp	avr2E22		; 2E27 CFFA
		rjmp	avr31DC		; 2E28 C3B3
avr2E29:nop				; 2E29 0000
		lds	r17, 0x04C4		; 2E2A 9110 04C4
		lsr	r17			; 2E2C 9516
avr2E2D:dec r17			; 2E2D 951A
		nop				; 2E2E 0000
		nop				; 2E2F 0000
		nop				; 2E30 0000
		brne	avr2E2D		; 2E31 F7D9
		sbic	PINC, 6	; 2E32 999E
		rjmp	avr31E0		; 2E33 C3AC
		nop				; 2E34 0000
		lds	r17, 0x04C4		; 2E35 9110 04C4
		dec	r17			; 2E37 951A
avr2E38:dec	r17			; 2E38 951A
		nop				; 2E39 0000
		nop				; 2E3A 0000
		nop				; 2E3B 0000
		brne	avr2E38		; 2E3C F7D9
		nop				; 2E3D 0000
		clr	r16			; 2E3E 2700
		ldi	r18, 0x08		; 2E3F E028
avr2E40:nop				; 2E40 0000
		nop				; 2E41 0000
		sec				; 2E42 9408
		sbic	PINC, 6	; 2E43 999E
		rjmp	avr2E46		; 2E44 C001
		clc				; 2E45 9488
avr2E46:ror	r16			; 2E46 9507
		nop				; 2E47 0000
		lds	r17, 0x04C4		; 2E48 9110 04C4
		dec	r17			; 2E4A 951A
avr2E4B:dec	r17			; 2E4B 951A
		nop				; 2E4C 0000
		nop				; 2E4D 0000
		nop				; 2E4E 0000
		brne	avr2E4B		; 2E4F F7D9
		nop				; 2E50 0000
		nop				; 2E51 0000
		dec	r18			; 2E52 952A
		brne	avr2E40		; 2E53 F761
		sbis	PINC, 6	; 2E54 9B9E
		rjmp	avr31E4		; 2E55 C38E
		nop				; 2E56 0000
		rjmp	avr31EE		; 2E57 C396

avr2E58:nop				; 2E58 0000
		push	r18			; 2E59 932F
		cbi	DDRC, 5	; 2E5A 98A5
		sbis	PINC, 5	; 2E5B 9B9D
		rjmp	avr31D8		; 2E5C C37B
		nop				; 2E5D 0000
		rcall	sub31F4		; 2E5E D395
avr2E5F:wdr				; 2E5F 95A8
		sbis	PINC, 5	; 2E60 9B9D
		rjmp	avr2E66		; 2E61 C004
		in	r16, $36		; 2E62 B706
		sbrs	r16, 2		; 2E63 FF02
		rjmp	avr2E5F		; 2E64 CFFA
		rjmp	avr31DC		; 2E65 C376
avr2E66:nop				; 2E66 0000
		lds	r17, 0x04C4		; 2E67 9110 04C4
		lsr	r17			; 2E69 9516
avr2E6A:dec	r17			; 2E6A 951A
		nop				; 2E6B 0000
		nop				; 2E6C 0000
		nop				; 2E6D 0000
		brne	avr2E6A		; 2E6E F7D9
		sbic	PINC, 5	; 2E6F 999D
		rjmp	avr31E0		; 2E70 C36F
		nop				; 2E71 0000
		lds	r17, 0x04C4		; 2E72 9110 04C4
		dec	r17			; 2E74 951A
avr2E75:dec	r17			; 2E75 951A
		nop				; 2E76 0000
		nop				; 2E77 0000
		nop				; 2E78 0000
		brne	avr2E75		; 2E79 F7D9
		nop				; 2E7A 0000
		clr	r16			; 2E7B 2700
		ldi	r18, 0x08		; 2E7C E028
avr2E7D:nop				; 2E7D 0000
		nop				; 2E7E 0000
		sec				; 2E7F 9408
		sbic	PINC, 5	; 2E80 999D
		rjmp	avr2E83		; 2E81 C001
		clc				; 2E82 9488
avr2E83:ror	r16			; 2E83 9507
		nop				; 2E84 0000
		lds	r17, 0x04C4		; 2E85 9110 04C4
		dec	r17			; 2E87 951A
avr2E88:dec	r17			; 2E88 951A
		nop				; 2E89 0000
		nop				; 2E8A 0000
		nop				; 2E8B 0000
		brne	avr2E88		; 2E8C F7D9
		nop				; 2E8D 0000
		nop				; 2E8E 0000
		dec	r18			; 2E8F 952A
		brne	avr2E7D		; 2E90 F761
		sbis	PINC, 5	; 2E91 9B9D
		rjmp	avr31E4		; 2E92 C351
		nop				; 2E93 0000
		rjmp	avr31EE		; 2E94 C359

avr2E95:nop				; 2E95 0000
		push	r18			; 2E96 932F
		cbi	DDRC, 4	; 2E97 98A4
		sbis	PINC, 4	; 2E98 9B9C
		rjmp	avr31D8		; 2E99 C33E
		nop				; 2E9A 0000
		rcall	sub31F4		; 2E9B D358
avr2E9C:wdr				; 2E9C 95A8
		sbis	PINC, 4	; 2E9D 9B9C
		rjmp	avr2EA3		; 2E9E C004
		in	r16, $36		; 2E9F B706
		sbrs	r16, 2		; 2EA0 FF02
		rjmp	avr2E9C		; 2EA1 CFFA
		rjmp	avr31DC		; 2EA2 C339
avr2EA3:nop				; 2EA3 0000
		lds	r17, 0x04C4		; 2EA4 9110 04C4
		lsr	r17			; 2EA6 9516
avr2EA7:dec	r17			; 2EA7 951A
		nop				; 2EA8 0000
		nop				; 2EA9 0000
		nop				; 2EAA 0000
		brne	avr2EA7		; 2EAB F7D9
		sbic	PINC, 4	; 2EAC 999C
		rjmp	avr31E0		; 2EAD C332
		nop				; 2EAE 0000
		lds	r17, 0x04C4		; 2EAF 9110 04C4
		dec	r17			; 2EB1 951A
avr2EB2:dec	r17			; 2EB2 951A
		nop				; 2EB3 0000
		nop				; 2EB4 0000
		nop				; 2EB5 0000
		brne	avr2EB2		; 2EB6 F7D9
		nop				; 2EB7 0000
		clr	r16			; 2EB8 2700
		ldi	r18, 0x08		; 2EB9 E028
avr2EBA:nop				; 2EBA 0000
		nop				; 2EBB 0000
		sec				; 2EBC 9408
		sbic	PINC, 4	; 2EBD 999C
		rjmp	avr2EC0		; 2EBE C001
		clc				; 2EBF 9488
avr2EC0:ror	r16			; 2EC0 9507
		nop				; 2EC1 0000
		lds	r17, 0x04C4		; 2EC2 9110 04C4
		dec	r17			; 2EC4 951A
avr2EC5:dec	r17			; 2EC5 951A
		nop				; 2EC6 0000
		nop				; 2EC7 0000
		nop				; 2EC8 0000
		brne	avr2EC5		; 2EC9 F7D9
		nop				; 2ECA 0000
		nop				; 2ECB 0000
		dec	r18			; 2ECC 952A
		brne	avr2EBA		; 2ECD F761
		sbis	PINC, 4	; 2ECE 9B9C
		rjmp	avr31E4		; 2ECF C314
		nop				; 2ED0 0000
		rjmp	avr31EE		; 2ED1 C31C

avr2ED2:nop				; 2ED2 0000
		push	r18			; 2ED3 932F
		cbi	DDRC, 3	; 2ED4 98A3
		sbis	PINC, 3	; 2ED5 9B9B
		rjmp	avr31D8		; 2ED6 C301
		nop				; 2ED7 0000
		rcall	sub31F4		; 2ED8 D31B
avr2ED9:wdr				; 2ED9 95A8
		sbis	PINC, 3	; 2EDA 9B9B
		rjmp	avr2EE0		; 2EDB C004
		in	r16, $36		; 2EDC B706
		sbrs	r16, 2		; 2EDD FF02
		rjmp	avr2ED9		; 2EDE CFFA
		rjmp	avr31DC		; 2EDF C2FC
avr2EE0:nop				; 2EE0 0000
		lds	r17, 0x04C4		; 2EE1 9110 04C4
		lsr	r17			; 2EE3 9516
avr2EE4:dec	r17			; 2EE4 951A
		nop				; 2EE5 0000
		nop				; 2EE6 0000
		nop				; 2EE7 0000
		brne	avr2EE4		; 2EE8 F7D9
		sbic	PINC, 3	; 2EE9 999B
		rjmp	avr31E0		; 2EEA C2F5
		nop				; 2EEB 0000
		lds	r17, 0x04C4		; 2EEC 9110 04C4
		dec	r17			; 2EEE 951A
avr2EEF:dec	r17			; 2EEF 951A
		nop				; 2EF0 0000
		nop				; 2EF1 0000
		nop				; 2EF2 0000
		brne	avr2EEF		; 2EF3 F7D9
		nop				; 2EF4 0000
		clr	r16			; 2EF5 2700
		ldi	r18, 0x08		; 2EF6 E028
avr2EF7:nop				; 2EF7 0000
		nop				; 2EF8 0000
		sec				; 2EF9 9408
		sbic	PINC, 3	; 2EFA 999B
		rjmp	avr2EFD		; 2EFB C001
		clc				; 2EFC 9488
avr2EFD:ror	r16			; 2EFD 9507
		nop				; 2EFE 0000
		lds	r17, 0x04C4		; 2EFF 9110 04C4
		dec	r17			; 2F01 951A
avr2F02:dec	r17			; 2F02 951A
		nop				; 2F03 0000
		nop				; 2F04 0000
		nop				; 2F05 0000
		brne	avr2F02		; 2F06 F7D9
		nop				; 2F07 0000
		nop				; 2F08 0000
		dec	r18			; 2F09 952A
		brne	avr2EF7		; 2F0A F761
		sbis	PINC, 3	; 2F0B 9B9B
		rjmp	avr31E4		; 2F0C C2D7
		nop				; 2F0D 0000
		rjmp	avr31EE		; 2F0E C2DF

avr2F0F:nop				; 2F0F 0000
		push	r18			; 2F10 932F
		cbi	DDRC, 2	; 2F11 98A2
		sbis	PINC, 2	; 2F12 9B9A
		rjmp	avr31D8		; 2F13 C2C4
		nop				; 2F14 0000
		rcall	sub31F4		; 2F15 D2DE
avr2F16:wdr				; 2F16 95A8
		sbis	PINC, 2	; 2F17 9B9A
		rjmp	avr2F1D		; 2F18 C004
		in	r16, $36		; 2F19 B706
		sbrs	r16, 2		; 2F1A FF02
		rjmp	avr2F16		; 2F1B CFFA
		rjmp	avr31DC		; 2F1C C2BF
avr2F1D:nop				; 2F1D 0000
		lds	r17, 0x04C4		; 2F1E 9110 04C4
		lsr	r17			; 2F20 9516
avr2F21:dec	r17			; 2F21 951A
		nop				; 2F22 0000
		nop				; 2F23 0000
		nop				; 2F24 0000
		brne	avr2F21		; 2F25 F7D9
		sbic	PINC, 2	; 2F26 999A
		rjmp	avr31E0		; 2F27 C2B8
		nop				; 2F28 0000
		lds	r17, 0x04C4		; 2F29 9110 04C4
		dec	r17			; 2F2B 951A
avr2F2C:dec	r17			; 2F2C 951A
		nop				; 2F2D 0000
		nop				; 2F2E 0000
		nop				; 2F2F 0000
		brne	avr2F2C		; 2F30 F7D9
		nop				; 2F31 0000
		clr	r16			; 2F32 2700
		ldi	r18, 0x08		; 2F33 E028
avr2F34:nop				; 2F34 0000
		nop				; 2F35 0000
		sec				; 2F36 9408
		sbic	PINC, 2	; 2F37 999A
		rjmp	avr2F3A		; 2F38 C001
		clc				; 2F39 9488
avr2F3A:ror	r16			; 2F3A 9507
		nop				; 2F3B 0000
		lds	r17, 0x04C4		; 2F3C 9110 04C4
		dec	r17			; 2F3E 951A
avr2F3F:dec	r17			; 2F3F 951A
		nop				; 2F40 0000
		nop				; 2F41 0000
		nop				; 2F42 0000
		brne	avr2F3F		; 2F43 F7D9
		nop				; 2F44 0000
		nop				; 2F45 0000
		dec	r18			; 2F46 952A
		brne	avr2F34		; 2F47 F761
		sbis	PINC, 2	; 2F48 9B9A
		rjmp	avr31E4		; 2F49 C29A
		nop				; 2F4A 0000
		rjmp	avr31EE		; 2F4B C2A2

avr2F4C:nop				; 2F4C 0000
		push	r18			; 2F4D 932F
		cbi	DDRC, 1	; 2F4E 98A1
		sbis	PINC, 1	; 2F4F 9B99
		rjmp	avr31D8		; 2F50 C287
		nop				; 2F51 0000
		rcall	sub31F4		; 2F52 D2A1
avr2F53:wdr				; 2F53 95A8
		sbis	PINC, 1	; 2F54 9B99
		rjmp	avr2F5A		; 2F55 C004
		in	r16, $36		; 2F56 B706
		sbrs	r16, 2		; 2F57 FF02
		rjmp	avr2F53		; 2F58 CFFA
		rjmp	avr31DC		; 2F59 C282
avr2F5A:nop				; 2F5A 0000
		lds	r17, 0x04C4		; 2F5B 9110 04C4
		lsr	r17			; 2F5D 9516
avr2F5E:dec	r17			; 2F5E 951A
		nop				; 2F5F 0000
		nop				; 2F60 0000
		nop				; 2F61 0000
		brne	avr2F5E		; 2F62 F7D9
		sbic	PINC, 1	; 2F63 9999
		rjmp	avr31E0		; 2F64 C27B
		nop				; 2F65 0000
		lds	r17, 0x04C4		; 2F66 9110 04C4
		dec	r17			; 2F68 951A
avr2F69:dec	r17			; 2F69 951A
		nop				; 2F6A 0000
		nop				; 2F6B 0000
		nop				; 2F6C 0000
		brne	avr2F69		; 2F6D F7D9
		nop				; 2F6E 0000
		clr	r16			; 2F6F 2700
		ldi	r18, 0x08		; 2F70 E028
avr2F71:nop				; 2F71 0000
		nop				; 2F72 0000
		sec				; 2F73 9408
		sbic	PINC, 1	; 2F74 9999
		rjmp	avr2F77		; 2F75 C001
		clc				; 2F76 9488
avr2F77:ror	r16			; 2F77 9507
		nop				; 2F78 0000
		lds	r17, 0x04C4		; 2F79 9110 04C4
		dec	r17			; 2F7B 951A
avr2F7C:dec	r17			; 2F7C 951A
		nop				; 2F7D 0000
		nop				; 2F7E 0000
		nop				; 2F7F 0000
		brne	avr2F7C		; 2F80 F7D9
		nop				; 2F81 0000
		nop				; 2F82 0000
		dec	r18			; 2F83 952A
		brne	avr2F71		; 2F84 F761
		sbis	PINC, 1	; 2F85 9B99
		rjmp	avr31E4		; 2F86 C25D
		nop				; 2F87 0000
		rjmp	avr31EE		; 2F88 C265

avr2F89:nop				; 2F89 0000
		push	r18			; 2F8A 932F
		cbi	DDRC, 0	; 2F8B 98A0
		sbis	PINC, 0	; 2F8C 9B98
		rjmp	avr31D8		; 2F8D C24A
		nop				; 2F8E 0000
		rcall	sub31F4		; 2F8F D264
avr2F90:wdr				; 2F90 95A8
		sbis	PINC, 0	; 2F91 9B98
		rjmp	avr2F97		; 2F92 C004
		in	r16, $36		; 2F93 B706
		sbrs	r16, 2		; 2F94 FF02
		rjmp	avr2F90		; 2F95 CFFA
		rjmp	avr31DC		; 2F96 C245
avr2F97:nop				; 2F97 0000
		lds	r17, 0x04C4		; 2F98 9110 04C4
		lsr	r17			; 2F9A 9516
avr2F9B:dec	r17			; 2F9B 951A
		nop				; 2F9C 0000
		nop				; 2F9D 0000
		nop				; 2F9E 0000
		brne	avr2F9B		; 2F9F F7D9
		sbic	PINC, 0	; 2FA0 9998
		rjmp	avr31E0		; 2FA1 C23E
		nop				; 2FA2 0000
		lds	r17, 0x04C4		; 2FA3 9110 04C4
		dec	r17			; 2FA5 951A
avr2FA6:dec	r17			; 2FA6 951A
		nop				; 2FA7 0000
		nop				; 2FA8 0000
		nop				; 2FA9 0000
		brne	avr2FA6		; 2FAA F7D9
		nop				; 2FAB 0000
		clr	r16			; 2FAC 2700
		ldi	r18, 0x08		; 2FAD E028
avr2FAE:nop				; 2FAE 0000
		nop				; 2FAF 0000
		sec				; 2FB0 9408
		sbic	PINC, 0	; 2FB1 9998
		rjmp	avr2FB4		; 2FB2 C001
		clc				; 2FB3 9488
avr2FB4:ror	r16			; 2FB4 9507
		nop				; 2FB5 0000
		lds	r17, 0x04C4		; 2FB6 9110 04C4
		dec	r17			; 2FB8 951A
avr2FB9:dec	r17			; 2FB9 951A
		nop				; 2FBA 0000
		nop				; 2FBB 0000
		nop				; 2FBC 0000
		brne	avr2FB9		; 2FBD F7D9
		nop				; 2FBE 0000
		nop				; 2FBF 0000
		dec	r18			; 2FC0 952A
		brne	avr2FAE		; 2FC1 F761
		sbis	PINC, 0	; 2FC2 9B98
		rjmp	avr31E4		; 2FC3 C220
		nop				; 2FC4 0000
		rjmp	avr31EE		; 2FC5 C228

avr2FC6:nop				; 2FC6 0000
		push	r18			; 2FC7 932F
		cbi	$02, 7	; 2FC8 9817
		sbis	$01, 7	; 2FC9 9B0F
		rjmp	avr31D8		; 2FCA C20D
		nop				; 2FCB 0000
		rcall	sub31F4		; 2FCC D227
avr2FCD:wdr				; 2FCD 95A8
		sbis	$01, 7	; 2FCE 9B0F
		rjmp	avr2FD4		; 2FCF C004
		in	r16, $36		; 2FD0 B706
		sbrs	r16, 2		; 2FD1 FF02
		rjmp	avr2FCD		; 2FD2 CFFA
		rjmp	avr31DC		; 2FD3 C208
avr2FD4:nop				; 2FD4 0000
		lds	r17, 0x04C4		; 2FD5 9110 04C4
		lsr	r17			; 2FD7 9516
avr2FD8:dec	r17			; 2FD8 951A
		nop				; 2FD9 0000
		nop				; 2FDA 0000
		nop				; 2FDB 0000
		brne	avr2FD8		; 2FDC F7D9
		sbic	$01, 7	; 2FDD 990F
		rjmp	avr31E0		; 2FDE C201
		nop				; 2FDF 0000
		lds	r17, 0x04C4		; 2FE0 9110 04C4
		dec	r17			; 2FE2 951A
avr2FE3:dec	r17			; 2FE3 951A
		nop				; 2FE4 0000
		nop				; 2FE5 0000
		nop				; 2FE6 0000
		brne	avr2FE3		; 2FE7 F7D9
		nop				; 2FE8 0000
		clr	r16			; 2FE9 2700
		ldi	r18, 0x08		; 2FEA E028
avr2FEB:nop				; 2FEB 0000
		nop				; 2FEC 0000
		sec				; 2FED 9408
		sbic	$01, 7	; 2FEE 990F
		rjmp	avr2FF1		; 2FEF C001
		clc				; 2FF0 9488
avr2FF1:ror	r16			; 2FF1 9507
		nop				; 2FF2 0000
		lds	r17, 0x04C4		; 2FF3 9110 04C4
		dec	r17			; 2FF5 951A
avr2FF6:dec	r17			; 2FF6 951A
		nop				; 2FF7 0000
		nop				; 2FF8 0000
		nop				; 2FF9 0000
		brne	avr2FF6		; 2FFA F7D9
		nop				; 2FFB 0000
		nop				; 2FFC 0000
		dec	r18			; 2FFD 952A
		brne	avr2FEB		; 2FFE F761
		sbis	$01, 7	; 2FFF 9B0F
		rjmp	avr31E4		; 3000 C1E3
		nop				; 3001 0000
		rjmp	avr31EE		; 3002 C1EB

avr3003:nop				; 3003 0000
		push	r18			; 3004 932F
		cbi	$02, 6	; 3005 9816
		sbis	$01, 6	; 3006 9B0E
		rjmp	avr31D8		; 3007 C1D0
		nop				; 3008 0000
		rcall	sub31F4		; 3009 D1EA
avr300A:wdr				; 300A 95A8
		sbis	$01, 6	; 300B 9B0E
		rjmp	avr3011		; 300C C004
		in	r16, $36		; 300D B706
		sbrs	r16, 2		; 300E FF02
		rjmp	avr300A		; 300F CFFA
		rjmp	avr31DC		; 3010 C1CB
avr3011:nop				; 3011 0000
		lds	r17, 0x04C4		; 3012 9110 04C4
		lsr	r17			; 3014 9516
avr3015:dec	r17			; 3015 951A
		nop				; 3016 0000
		nop				; 3017 0000
		nop				; 3018 0000
		brne	avr3015		; 3019 F7D9
		sbic	$01, 6	; 301A 990E
		rjmp	avr31E0		; 301B C1C4
		nop				; 301C 0000
		lds	r17, 0x04C4		; 301D 9110 04C4
		dec	r17			; 301F 951A
avr3020:dec	r17			; 3020 951A
		nop				; 3021 0000
		nop				; 3022 0000
		nop				; 3023 0000
		brne	avr3020		; 3024 F7D9
		nop				; 3025 0000
		clr	r16			; 3026 2700
		ldi	r18, 0x08		; 3027 E028
avr3028:nop				; 3028 0000
		nop				; 3029 0000
		sec				; 302A 9408
		sbic	$01, 6	; 302B 990E
		rjmp	avr302E		; 302C C001
		clc				; 302D 9488
avr302E:ror	r16			; 302E 9507
		nop				; 302F 0000
		lds	r17, 0x04C4		; 3030 9110 04C4
		dec	r17			; 3032 951A
avr3033:dec	r17			; 3033 951A
		nop				; 3034 0000
		nop				; 3035 0000
		nop				; 3036 0000
		brne	avr3033		; 3037 F7D9
		nop				; 3038 0000
		nop				; 3039 0000
		dec	r18			; 303A 952A
		brne	avr3028		; 303B F761
		sbis	$01, 6	; 303C 9B0E
		rjmp	avr31E4		; 303D C1A6
		nop				; 303E 0000
		rjmp	avr31EE		; 303F C1AE

avr3040:nop				; 3040 0000
		push	r18			; 3041 932F
		cbi	DDRD, 7	; 3042 988F
		sbis	PIND, 7	; 3043 9B87
		rjmp	avr31D8		; 3044 C193
		nop				; 3045 0000
		rcall	sub31F4		; 3046 D1AD
avr3047:wdr				; 3047 95A8
		sbis	PIND, 7	; 3048 9B87
		rjmp	avr304E		; 3049 C004
		in	r16, $36		; 304A B706
		sbrs	r16, 2		; 304B FF02
		rjmp	avr3047		; 304C CFFA
		rjmp	avr31DC		; 304D C18E
avr304E:nop				; 304E 0000
		lds	r17, 0x04C4		; 304F 9110 04C4
		lsr	r17			; 3051 9516
avr3052:dec	r17			; 3052 951A
		nop				; 3053 0000
		nop				; 3054 0000
		nop				; 3055 0000
		brne	avr3052		; 3056 F7D9
		sbic	PIND, 7	; 3057 9987
		rjmp	avr31E0		; 3058 C187
		nop				; 3059 0000
		lds	r17, 0x04C4		; 305A 9110 04C4
		dec	r17			; 305C 951A
avr305D:dec	r17			; 305D 951A
		nop				; 305E 0000
		nop				; 305F 0000
		nop				; 3060 0000
		brne	avr305D		; 3061 F7D9
		nop				; 3062 0000
		clr	r16			; 3063 2700
		ldi	r18, 0x08		; 3064 E028
avr3065:nop				; 3065 0000
		nop				; 3066 0000
		sec				; 3067 9408
		sbic	PIND, 7	; 3068 9987
		rjmp	avr306B		; 3069 C001
		clc				; 306A 9488
avr306B:ror	r16			; 306B 9507
		nop				; 306C 0000
		lds	r17, 0x04C4		; 306D 9110 04C4
		dec	r17			; 306F 951A
avr3070:dec	r17			; 3070 951A
		nop				; 3071 0000
		nop				; 3072 0000
		nop				; 3073 0000
		brne	avr3070		; 3074 F7D9
		nop				; 3075 0000
		nop				; 3076 0000
		dec	r18			; 3077 952A
		brne	avr3065		; 3078 F761
		sbis	PIND, 7	; 3079 9B87
		rjmp	avr31E4		; 307A C169
		nop				; 307B 0000
		rjmp	avr31EE		; 307C C171

avr307D:nop				; 307D 0000
		push	r18			; 307E 932F
		cbi	DDRD, 6	; 307F 988E
		sbis	PIND, 6	; 3080 9B86
		rjmp	avr31D8		; 3081 C156
		nop				; 3082 0000
		rcall	sub31F4		; 3083 D170
avr3084:wdr				; 3084 95A8
		sbis	PIND, 6	; 3085 9B86
		rjmp	avr308B		; 3086 C004
		in	r16, $36		; 3087 B706
		sbrs	r16, 2		; 3088 FF02
		rjmp	avr3084		; 3089 CFFA
		rjmp	avr31DC		; 308A C151
avr308B:nop				; 308B 0000
		lds	r17, 0x04C4		; 308C 9110 04C4
		lsr	r17			; 308E 9516
avr308F:dec	r17			; 308F 951A
		nop				; 3090 0000
		nop				; 3091 0000
		nop				; 3092 0000
		brne	avr308F		; 3093 F7D9
		sbic	PIND, 6	; 3094 9986
		rjmp	avr31E0		; 3095 C14A
		nop				; 3096 0000
		lds	r17, 0x04C4		; 3097 9110 04C4
		dec	r17			; 3099 951A
avr309A:dec	r17			; 309A 951A
		nop				; 309B 0000
		nop				; 309C 0000
		nop				; 309D 0000
		brne	avr309A		; 309E F7D9
		nop				; 309F 0000
		clr	r16			; 30A0 2700
		ldi	r18, 0x08		; 30A1 E028
avr30A2:nop				; 30A2 0000
		nop				; 30A3 0000
		sec				; 30A4 9408
		sbic	PIND, 6	; 30A5 9986
		rjmp	avr30A8		; 30A6 C001
		clc				; 30A7 9488
avr30A8:ror	r16			; 30A8 9507
		nop				; 30A9 0000
		lds	r17, 0x04C4		; 30AA 9110 04C4
		dec	r17			; 30AC 951A
avr30AD:dec	r17			; 30AD 951A
		nop				; 30AE 0000
		nop				; 30AF 0000
		nop				; 30B0 0000
		brne	avr30AD		; 30B1 F7D9
		nop				; 30B2 0000
		nop				; 30B3 0000
		dec	r18			; 30B4 952A
		brne	avr30A2		; 30B5 F761
		sbis	PIND, 6	; 30B6 9B86
		rjmp	avr31E4		; 30B7 C12C
		nop				; 30B8 0000
		rjmp	avr31EE		; 30B9 C134

avr30BA:nop				; 30BA 0000
		push	r18			; 30BB 932F
		cbi	DDRD, 5	; 30BC 988D
		sbis	PIND, 5	; 30BD 9B85
		rjmp	avr31D8		; 30BE C119
		nop				; 30BF 0000
		rcall	sub31F4		; 30C0 D133
avr30C1:wdr				; 30C1 95A8
		sbis	PIND, 5	; 30C2 9B85
		rjmp	avr30C8		; 30C3 C004
		in	r16, $36		; 30C4 B706
		sbrs	r16, 2		; 30C5 FF02
		rjmp	avr30C1		; 30C6 CFFA
		rjmp	avr31DC		; 30C7 C114
avr30C8:nop				; 30C8 0000
		lds	r17, 0x04C4		; 30C9 9110 04C4
		lsr	r17			; 30CB 9516
avr30CC:dec	r17			; 30CC 951A
		nop				; 30CD 0000
		nop				; 30CE 0000
		nop				; 30CF 0000
		brne	avr30CC		; 30D0 F7D9
		sbic	PIND, 5	; 30D1 9985
		rjmp	avr31E0		; 30D2 C10D
		nop				; 30D3 0000
		lds	r17, 0x04C4		; 30D4 9110 04C4
		dec	r17			; 30D6 951A
avr30D7:dec	r17			; 30D7 951A
		nop				; 30D8 0000
		nop				; 30D9 0000
		nop				; 30DA 0000
		brne	avr30D7		; 30DB F7D9
		nop				; 30DC 0000
		clr	r16			; 30DD 2700
		ldi	r18, 0x08		; 30DE E028
avr30DF:nop				; 30DF 0000
		nop				; 30E0 0000
		sec				; 30E1 9408
		sbic	PIND, 5	; 30E2 9985
		rjmp	avr30E5		; 30E3 C001
		clc				; 30E4 9488
avr30E5:ror	r16			; 30E5 9507
		nop				; 30E6 0000
		lds	r17, 0x04C4		; 30E7 9110 04C4
		dec	r17			; 30E9 951A
avr30EA:dec	r17			; 30EA 951A
		nop				; 30EB 0000
		nop				; 30EC 0000
		nop				; 30ED 0000
		brne	avr30EA		; 30EE F7D9
		nop				; 30EF 0000
		nop				; 30F0 0000
		dec	r18			; 30F1 952A
		brne	avr30DF		; 30F2 F761
		sbis	PIND, 5	; 30F3 9B85
		rjmp	avr31E4		; 30F4 C0EF
		nop				; 30F5 0000
		rjmp	avr31EE		; 30F6 C0F7

avr30F7:nop				; 30F7 0000
		push	r18			; 30F8 932F
		lds	r18, 0x0064		; 30F9 9120 0064
		andi	r18, 0xFB		; 30FB 7F2B
		sts	0x0064, r18		; 30FC 9320 0064
		nop				; 30FE 0000
		lds	r18, 0x0063		; 30FF 9120 0063
		sbrs	r18, 2		; 3101 FF22
		rjmp	avr31D8		; 3102 C0D5
		nop				; 3103 0000
		rcall	sub31F4		; 3104 D0EF
avr3105:wdr				; 3105 95A8
		lds	r18, 0x0063		; 3106 9120 0063
		sbrs	r18, 2		; 3108 FF22
		rjmp	avr310E		; 3109 C004
		in	r16, $36		; 310A B706
		sbrs	r16, 2		; 310B FF02
		rjmp	avr3105		; 310C CFF8
		rjmp	avr31DC		; 310D C0CE
avr310E:nop				; 310E 0000
		lds	r17, 0x04C4		; 310F 9110 04C4
		lsr	r17			; 3111 9516
avr3112:dec	r17			; 3112 951A
		nop				; 3113 0000
		nop				; 3114 0000
		nop				; 3115 0000
		brne	avr3112		; 3116 F7D9
		lds	r18, 0x0063		; 3117 9120 0063
		sbrc	r18, 2		; 3119 FD22
		rjmp	avr31E0		; 311A C0C5
		push	r19			; 311B 933F
		lds	r17, 0x04C4		; 311C 9110 04C4
		dec	r17			; 311E 951A
avr311F:dec	r17			; 311F 951A
		nop				; 3120 0000
		nop				; 3121 0000
		nop				; 3122 0000
		brne	avr311F		; 3123 F7D9
		nop				; 3124 0000
		clr	r16			; 3125 2700
		ldi	r18, 0x08		; 3126 E028
avr3127:sec				; 3127 9408
		lds	r19, 0x0063		; 3128 9130 0063
		sbrc	r19, 2		; 312A FD32
		rjmp	avr312D		; 312B C001
		clc				; 312C 9488
avr312D:ror	r16			; 312D 9507
		nop				; 312E 0000
		lds	r17, 0x04C4		; 312F 9110 04C4
		dec	r17			; 3131 951A
avr3132:dec	r17			; 3132 951A
		nop				; 3133 0000
		nop				; 3134 0000
		nop				; 3135 0000
		brne	avr3132		; 3136 F7D9
		nop				; 3137 0000
		nop				; 3138 0000
		dec	r18			; 3139 952A
		brne	avr3127		; 313A F761
		pop	r19			; 313B 913F
		lds	r18, 0x0063		; 313C 9120 0063
		sbrs	r18, 2		; 313E FF22
		rjmp	avr31E4		; 313F C0A4
		nop				; 3140 0000
		rjmp	avr31EE		; 3141 C0AC

avr3142:nop				; 3142 0000
		push	r18			; 3143 932F
		lds	r18, 0x0064		; 3144 9120 0064
		andi	r18, 0xFD		; 3146 7F2D
		sts	0x0064, r18		; 3147 9320 0064
		nop				; 3149 0000
		lds	r18, 0x0063		; 314A 9120 0063
		sbrs	r18, 1		; 314C FF21
		rjmp	avr31D8		; 314D C08A
		nop				; 314E 0000
		rcall	sub31F4		; 314F D0A4
avr3150:wdr				; 3150 95A8
		lds	r18, 0x0063		; 3151 9120 0063
		sbrs	r18, 1		; 3153 FF21
		rjmp	avr3159		; 3154 C004
		in	r16, $36		; 3155 B706
		sbrs	r16, 2		; 3156 FF02
		rjmp	avr3150		; 3157 CFF8
		rjmp	avr31DC		; 3158 C083
avr3159:nop				; 3159 0000
		lds	r17, 0x04C4		; 315A 9110 04C4
		lsr	r17			; 315C 9516
avr315D:dec	r17			; 315D 951A
		nop				; 315E 0000
		nop				; 315F 0000
		nop				; 3160 0000
		brne	avr315D		; 3161 F7D9
		lds	r18, 0x0063		; 3162 9120 0063
		sbrc	r18, 1		; 3164 FD21
		rjmp	avr31E0		; 3165 C07A
		push	r19			; 3166 933F
		lds	r17, 0x04C4		; 3167 9110 04C4
		dec	r17			; 3169 951A
avr316A:dec	r17			; 316A 951A
		nop				; 316B 0000
		nop				; 316C 0000
		nop				; 316D 0000
		brne	avr316A		; 316E F7D9
		nop				; 316F 0000
		clr	r16			; 3170 2700
		ldi	r18, 0x08		; 3171 E028
avr3172:sec				; 3172 9408
		lds	r19, 0x0063		; 3173 9130 0063
		sbrc	r19, 1		; 3175 FD31
		rjmp	avr3178		; 3176 C001
		clc				; 3177 9488
avr3178:ror	r16			; 3178 9507
		nop				; 3179 0000
		lds	r17, 0x04C4		; 317A 9110 04C4
		dec	r17			; 317C 951A
avr317D:dec	r17			; 317D 951A
		nop				; 317E 0000
		nop				; 317F 0000
		nop				; 3180 0000
		brne	avr317D		; 3181 F7D9
		nop				; 3182 0000
		nop				; 3183 0000
		dec	r18			; 3184 952A
		brne	avr3172		; 3185 F761
		pop	r19			; 3186 913F
		lds	r18, 0x0063		; 3187 9120 0063
		sbrs	r18, 1		; 3189 FF21
		rjmp	avr31E4		; 318A C059
		nop				; 318B 0000
		rjmp	avr31EE		; 318C C061

avr318D:nop				; 318D 0000
		push	r18			; 318E 932F
		lds	r18, 0x0064		; 318F 9120 0064
		andi	r18, 0xFE		; 3191 7F2E
		sts	0x0064, r18		; 3192 9320 0064
		nop				; 3194 0000
		lds	r18, 0x0063		; 3195 9120 0063
		sbrs	r18, 0		; 3197 FF20
		rjmp	avr31D8		; 3198 C03F
		nop				; 3199 0000
		rcall	sub31F4		; 319A D059
avr319B:wdr				; 319B 95A8
		lds	r18, 0x0063		; 319C 9120 0063
		sbrs	r18, 0		; 319E FF20
		rjmp	avr31A4		; 319F C004
		in	r16, $36		; 31A0 B706
		sbrs	r16, 2		; 31A1 FF02
		rjmp	avr319B		; 31A2 CFF8
		rjmp	avr31DC		; 31A3 C038
avr31A4:nop				; 31A4 0000
		lds	r17, 0x04C4		; 31A5 9110 04C4
		lsr	r17			; 31A7 9516
avr31A8:dec	r17			; 31A8 951A
		nop				; 31A9 0000
		nop				; 31AA 0000
		nop				; 31AB 0000
		brne	avr31A8		; 31AC F7D9
		lds	r18, 0x0063		; 31AD 9120 0063
		sbrc	r18, 0		; 31AF FD20
		rjmp	avr31E0		; 31B0 C02F
		push	r19			; 31B1 933F
		lds	r17, 0x04C4		; 31B2 9110 04C4
		dec	r17			; 31B4 951A
avr31B5:dec	r17			; 31B5 951A
		nop				; 31B6 0000
		nop				; 31B7 0000
		nop				; 31B8 0000
		brne	avr31B5		; 31B9 F7D9
		nop				; 31BA 0000
		clr	r16			; 31BB 2700
		ldi	r18, 0x08		; 31BC E028
avr31BD:sec				; 31BD 9408
		lds	r19, 0x0063		; 31BE 9130 0063
		sbrc	r19, 0		; 31C0 FD30
		rjmp	avr31C3		; 31C1 C001
		clc				; 31C2 9488
avr31C3:ror	r16			; 31C3 9507
		nop				; 31C4 0000
		lds	r17, 0x04C4		; 31C5 9110 04C4
		dec	r17			; 31C7 951A
avr31C8:dec	r17			; 31C8 951A
		nop				; 31C9 0000
		nop				; 31CA 0000
		nop				; 31CB 0000
		brne	avr31C8		; 31CC F7D9
		nop				; 31CD 0000
		nop				; 31CE 0000
		dec	r18			; 31CF 952A
		brne	avr31BD		; 31D0 F761
		pop	r19			; 31D1 913F
		lds	r18, 0x0063		; 31D2 9120 0063
		sbrs	r18, 0		; 31D4 FF20
		rjmp	avr31E4		; 31D5 C00E
		nop				; 31D6 0000
		rjmp	avr31EE		; 31D7 C016

avr31D8:lds	r16, 0x04C3		; 31D8 9100 04C3
		ori	r16, 0x80		; 31DA 6800
		rjmp	avr31E8		; 31DB C00C

avr31DC:lds	r16, 0x04C3		; 31DC 9100 04C3
		ori	r16, 0x40		; 31DE 6400
		rjmp	avr31E8		; 31DF C008

avr31E0:lds	r16, 0x04C3		; 31E0 9100 04C3
		ori	r16, 0x20		; 31E2 6200
		rjmp	avr31E8		; 31E3 C004

avr31E4:lds	r16, 0x04C3		; 31E4 9100 04C3
		ori	r16, 0x10		; 31E6 6100
		rjmp	avr31E8		; 31E7 C000

avr31E8:sts	0x04C3, r16		; 31E8 9300 04C3
		pop	r18			; 31EA 912F
		sec				; 31EB 9408
		ldi	r16, 0x00		; 31EC E000
		ret				; 31ED 9508
;-------------------------------------------------------------------------
avr31EE:clr	r17			; 31EE 2711
		sts	0x04C3, r17		; 31EF 9310 04C3
		pop	r18			; 31F1 912F
		clc				; 31F2 9488
		ret				; 31F3 9508
;-------------------------------------------------------------------------
sub31F4:ldi	r16, 0x02		; 31F4 E002
		out	$2E, r16		; 31F5 BD0E
		in	r16, $36		; 31F6 B706
		andi	r16, 0x04		; 31F7 7004
		out	$36, r16		; 31F8 BF06
		ldi	r16, 0x27		; 31F9 E207
		out	$2D, r16		; 31FA BD0D
		ldi	r16, 0x10		; 31FB E100
		out	$2C, r16		; 31FC BD0C
		ret				; 31FD 9508
;-------------------------------------------------------------------------
avr31FE:cpi	r17, 0x00		; 31FE 3010
		breq	avr323F		; 31FF F1F9
		cpi	r17, 0x01		; 3200 3011
		breq	avr3240		; 3201 F1F1
		cpi	r17, 0x02		; 3202 3012
		breq	avr3241		; 3203 F1E9
		cpi	r17, 0x03		; 3204 3013
		breq	avr3242		; 3205 F1E1
		cpi	r17, 0x04		; 3206 3014
		breq	avr3243		; 3207 F1D9
		cpi	r17, 0x05		; 3208 3015
		breq	avr3244		; 3209 F1D1
		cpi	r17, 0x06		; 320A 3016
		breq	avr3245		; 320B F1C9
		cpi	r17, 0x07		; 320C 3017
		breq	avr3246		; 320D F1C1
		cpi	r17, 0x08		; 320E 3018
		breq	avr3247		; 320F F1B9
		cpi	r17, 0x09		; 3210 3019
		breq	avr3248		; 3211 F1B1
		cpi	r17, 0x0A		; 3212 301A
		breq	avr3249		; 3213 F1A9
		cpi	r17, 0x0B		; 3214 301B
		breq	avr324A		; 3215 F1A1
		cpi	r17, 0x0C		; 3216 301C
		breq	avr324B		; 3217 F199
		cpi	r17, 0x0D		; 3218 301D
		breq	avr324C		; 3219 F191
		cpi	r17, 0x0E		; 321A 301E
		breq	avr324D		; 321B F189
		cpi	r17, 0x0F		; 321C 301F
		breq	avr324E		; 321D F181
		cpi	r17, 0x10		; 321E 3110
		breq	avr324F		; 321F F179
		cpi	r17, 0x11		; 3220 3111
		breq	avr3250		; 3221 F171
		cpi	r17, 0x12		; 3222 3112
		breq	avr3251		; 3223 F169
		cpi	r17, 0x13		; 3224 3113
		breq	avr3252		; 3225 F161
		cpi	r17, 0x14		; 3226 3114
		breq	avr3253		; 3227 F159
		cpi	r17, 0x15		; 3228 3115
		breq	avr3254		; 3229 F151
		cpi	r17, 0x16		; 322A 3116
		breq	avr3255		; 322B F149
		cpi	r17, 0x17		; 322C 3117
		breq	avr3256		; 322D F141
		cpi	r17, 0x18		; 322E 3118
		breq	avr3257		; 322F F139
		cpi	r17, 0x19		; 3230 3119
		breq	avr3258		; 3231 F131
		cpi	r17, 0x1A		; 3232 311A
		breq	avr3259		; 3233 F129
		cpi	r17, 0x1B		; 3234 311B
		breq	avr325A		; 3235 F121
		cpi	r17, 0x1C		; 3236 311C
		breq	avr325B		; 3237 F119
		cpi	r17, 0x1D		; 3238 311D
		breq	avr325C		; 3239 F111
		cpi	r17, 0x1E		; 323A 311E
		breq	avr325D		; 323B F109
		cpi	r17, 0x1F		; 323C 311F
		breq	avr325E		; 323D F101
		ret				; 323E 9508
;-------------------------------------------------------------------------
avr323F:rjmp	avr3260		; 323F C020
avr3240:rjmp	avr3286		; 3240 C045
avr3241:rjmp	avr32AC		; 3241 C06A
avr3242:rjmp	avr32D2		; 3242 C08F
avr3243:rjmp	avr32F8		; 3243 C0B4
avr3244:rjmp	avr331E		; 3244 C0D9
avr3245:rjmp	avr3344		; 3245 C0FE
avr3246:rjmp	avr336A		; 3246 C123
avr3247:rjmp	avr3390		; 3247 C148
avr3248:rjmp	avr33B6		; 3248 C16D
avr3249:rjmp	avr33DC		; 3249 C192
avr324A:rjmp	avr3402		; 324A C1B7
avr324B:rjmp	avr3428		; 324B C1DC
avr324C:rjmp	avr344E		; 324C C201
avr324D:rjmp	avr3474		; 324D C226
avr324E:rjmp	avr349A		; 324E C24B
avr324F:rjmp	avr34C0		; 324F C270
avr3250:rjmp	avr34E6		; 3250 C295
avr3251:rjmp	avr350C		; 3251 C2BA
avr3252:rjmp	avr3532		; 3252 C2DF
avr3253:rjmp	avr3558		; 3253 C304
avr3254:rjmp	avr357E		; 3254 C329
avr3255:rjmp	avr35A4		; 3255 C34E
avr3256:rjmp	avr35CA		; 3256 C373
avr3257:rjmp	avr35F0		; 3257 C398
avr3258:rjmp	avr3616		; 3258 C3BD
avr3259:rjmp	avr363C		; 3259 C3E2
avr325A:rjmp	avr3662		; 325A C407
avr325B:rjmp	avr3688		; 325B C42C
avr325C:rjmp	avr36AE		; 325C C451
avr325D:rjmp	avr36E5		; 325D C487
avr325E:rjmp	avr371C		; 325E C4BD
		ret				; 325F 9508
;-------------------------------------------------------------------------
avr3260:wdr				; 3260 95A8
		push	r18			; 3261 932F
		cbi	PORTA, 0	; 3262 98D8
		sbi	DDRA, 0	; 3263 9AD0
		com	r16			; 3264 9500
		sec				; 3265 9408
		ldi	r18, 0x0A		; 3266 E02A
avr3267:lds	r17, 0x04C4		; 3267 9110 04C4
avr3269:dec	r17			; 3269 951A
		nop				; 326A 0000
		nop				; 326B 0000
		nop				; 326C 0000
		brne	avr3269		; 326D F7D9
		brlo	avr3270		; 326E F008
		cbi	PORTA, 0	; 326F 98D8
avr3270:brsh	avr3272		; 3270 F408
		sbi	PORTA, 0	; 3271 9AD8
avr3272:lsr	r16			; 3272 9506
		dec	r18			; 3273 952A
		brne	avr3267		; 3274 F791
		cbi	PORTA, 0	; 3275 98D8
		lds	r17, 0x04C4		; 3276 9110 04C4
avr3278:dec	r17			; 3278 951A
		nop				; 3279 0000
		nop				; 327A 0000
		nop				; 327B 0000
		brne	avr3278		; 327C F7D9
		lds	r17, 0x04C4		; 327D 9110 04C4
avr327F:dec	r17			; 327F 951A
		nop				; 3280 0000
		nop				; 3281 0000
		nop				; 3282 0000
		brne	avr327F		; 3283 F7D9
		pop	r18			; 3284 912F
		ret				; 3285 9508
;-------------------------------------------------------------------------
avr3286:wdr				; 3286 95A8
		push	r18			; 3287 932F
		cbi	PORTA, 1	; 3288 98D9
		sbi	DDRA, 1	; 3289 9AD1
		com	r16			; 328A 9500
		sec				; 328B 9408
		ldi	r18, 0x0A		; 328C E02A
avr328D:lds	r17, 0x04C4		; 328D 9110 04C4
avr328F:dec	r17			; 328F 951A
		nop				; 3290 0000
		nop				; 3291 0000
		nop				; 3292 0000
		brne	avr328F		; 3293 F7D9
		brlo	avr3296		; 3294 F008
		cbi	PORTA, 1	; 3295 98D9
avr3296:brsh	avr3298		; 3296 F408
		sbi	PORTA, 1	; 3297 9AD9
avr3298:lsr	r16			; 3298 9506
		dec	r18			; 3299 952A
		brne	avr328D		; 329A F791
		cbi	PORTA, 1	; 329B 98D9
		lds	r17, 0x04C4		; 329C 9110 04C4
avr329E:dec	r17			; 329E 951A
		nop				; 329F 0000
		nop				; 32A0 0000
		nop				; 32A1 0000
		brne	avr329E		; 32A2 F7D9
		lds	r17, 0x04C4		; 32A3 9110 04C4
avr32A5:dec	r17			; 32A5 951A
		nop				; 32A6 0000
		nop				; 32A7 0000
		nop				; 32A8 0000
		brne	avr32A5		; 32A9 F7D9
		pop	r18			; 32AA 912F
		ret				; 32AB 9508
;-------------------------------------------------------------------------
avr32AC:wdr				; 32AC 95A8
		push	r18			; 32AD 932F
		cbi	PORTA, 2	; 32AE 98DA
		sbi	DDRA, 2	; 32AF 9AD2
		com	r16			; 32B0 9500
		sec				; 32B1 9408
		ldi	r18, 0x0A		; 32B2 E02A
avr32B3:lds	r17, 0x04C4		; 32B3 9110 04C4
avr32B5:dec	r17			; 32B5 951A
		nop				; 32B6 0000
		nop				; 32B7 0000
		nop				; 32B8 0000
		brne	avr32B5		; 32B9 F7D9
		brlo	avr32BC		; 32BA F008
		cbi	PORTA, 2	; 32BB 98DA
avr32BC:brsh	avr32BE		; 32BC F408
		sbi	PORTA, 2	; 32BD 9ADA
avr32BE:lsr	r16			; 32BE 9506
		dec	r18			; 32BF 952A
		brne	avr32B3		; 32C0 F791
		cbi	PORTA, 2	; 32C1 98DA
		lds	r17, 0x04C4		; 32C2 9110 04C4
avr32C4:dec	r17			; 32C4 951A
		nop				; 32C5 0000
		nop				; 32C6 0000
		nop				; 32C7 0000
		brne	avr32C4		; 32C8 F7D9
		lds	r17, 0x04C4		; 32C9 9110 04C4
avr32CB:dec	r17			; 32CB 951A
		nop				; 32CC 0000
		nop				; 32CD 0000
		nop				; 32CE 0000
		brne	avr32CB		; 32CF F7D9
		pop	r18			; 32D0 912F
		ret				; 32D1 9508
;-------------------------------------------------------------------------
avr32D2:wdr				; 32D2 95A8
		push	r18			; 32D3 932F
		cbi	PORTA, 3	; 32D4 98DB
		sbi	DDRA, 3	; 32D5 9AD3
		com	r16			; 32D6 9500
		sec				; 32D7 9408
		ldi	r18, 0x0A		; 32D8 E02A
avr32D9:lds	r17, 0x04C4		; 32D9 9110 04C4
avr32DB:dec	r17			; 32DB 951A
		nop				; 32DC 0000
		nop				; 32DD 0000
		nop				; 32DE 0000
		brne	avr32DB		; 32DF F7D9
		brlo	avr32E2		; 32E0 F008
		cbi	PORTA, 3	; 32E1 98DB
avr32E2:brsh	avr32E4		; 32E2 F408
		sbi	PORTA, 3	; 32E3 9ADB
avr32E4:lsr	r16			; 32E4 9506
		dec	r18			; 32E5 952A
		brne	avr32D9		; 32E6 F791
		cbi	PORTA, 3	; 32E7 98DB
		lds	r17, 0x04C4		; 32E8 9110 04C4
avr32EA:dec	r17			; 32EA 951A
		nop				; 32EB 0000
		nop				; 32EC 0000
		nop				; 32ED 0000
		brne	avr32EA		; 32EE F7D9
		lds	r17, 0x04C4		; 32EF 9110 04C4
avr32F1:dec	r17			; 32F1 951A
		nop				; 32F2 0000
		nop				; 32F3 0000
		nop				; 32F4 0000
		brne	avr32F1		; 32F5 F7D9
		pop	r18			; 32F6 912F
		ret				; 32F7 9508
;-------------------------------------------------------------------------
avr32F8:wdr				; 32F8 95A8
		push	r18			; 32F9 932F
		cbi	PORTA, 4	; 32FA 98DC
		sbi	DDRA, 4	; 32FB 9AD4
		com	r16			; 32FC 9500
		sec				; 32FD 9408
		ldi	r18, 0x0A		; 32FE E02A
avr32FF:lds	r17, 0x04C4		; 32FF 9110 04C4
avr3301:dec	r17			; 3301 951A
		nop				; 3302 0000
		nop				; 3303 0000
		nop				; 3304 0000
		brne	avr3301		; 3305 F7D9
		brlo	avr3308		; 3306 F008
		cbi	PORTA, 4	; 3307 98DC
avr3308:brsh	avr330A		; 3308 F408
		sbi	PORTA, 4	; 3309 9ADC
avr330A:lsr	r16			; 330A 9506
		dec	r18			; 330B 952A
		brne	avr32FF		; 330C F791
		cbi	PORTA, 4	; 330D 98DC
		lds	r17, 0x04C4		; 330E 9110 04C4
avr3310:dec	r17			; 3310 951A
		nop				; 3311 0000
		nop				; 3312 0000
		nop				; 3313 0000
		brne	avr3310		; 3314 F7D9
		lds	r17, 0x04C4		; 3315 9110 04C4
avr3317:dec	r17			; 3317 951A
		nop				; 3318 0000
		nop				; 3319 0000
		nop				; 331A 0000
		brne	avr3317		; 331B F7D9
		pop	r18			; 331C 912F
		ret				; 331D 9508
;-------------------------------------------------------------------------
avr331E:wdr				; 331E 95A8
		push	r18			; 331F 932F
		cbi	PORTA, 5	; 3320 98DD
		sbi	DDRA, 5	; 3321 9AD5
		com	r16			; 3322 9500
		sec				; 3323 9408
		ldi	r18, 0x0A		; 3324 E02A
avr3325:lds	r17, 0x04C4		; 3325 9110 04C4
avr3327:dec	r17			; 3327 951A
		nop				; 3328 0000
		nop				; 3329 0000
		nop				; 332A 0000
		brne	avr3327		; 332B F7D9
		brlo	avr332E		; 332C F008
		cbi	PORTA, 5	; 332D 98DD
avr332E:brsh	avr3330		; 332E F408
		sbi	PORTA, 5	; 332F 9ADD
avr3330:lsr	r16			; 3330 9506
		dec	r18			; 3331 952A
		brne	avr3325		; 3332 F791
		cbi	PORTA, 5	; 3333 98DD
		lds	r17, 0x04C4		; 3334 9110 04C4
avr3336:dec	r17			; 3336 951A
		nop				; 3337 0000
		nop				; 3338 0000
		nop				; 3339 0000
		brne	avr3336		; 333A F7D9
		lds	r17, 0x04C4		; 333B 9110 04C4
avr333D:dec	r17			; 333D 951A
		nop				; 333E 0000
		nop				; 333F 0000
		nop				; 3340 0000
		brne	avr333D		; 3341 F7D9
		pop	r18			; 3342 912F
		ret				; 3343 9508
;-------------------------------------------------------------------------
avr3344:wdr				; 3344 95A8
		push	r18			; 3345 932F
		cbi	PORTA, 6	; 3346 98DE
		sbi	DDRA, 6	; 3347 9AD6
		com	r16			; 3348 9500
		sec				; 3349 9408
		ldi	r18, 0x0A		; 334A E02A
avr334B:lds	r17, 0x04C4		; 334B 9110 04C4
avr334D:dec	r17			; 334D 951A
		nop				; 334E 0000
		nop				; 334F 0000
		nop				; 3350 0000
		brne	avr334D		; 3351 F7D9
		brlo	avr3354		; 3352 F008
		cbi	PORTA, 6	; 3353 98DE
avr3354:brsh	avr3356		; 3354 F408
		sbi	PORTA, 6	; 3355 9ADE
avr3356:lsr	r16			; 3356 9506
		dec	r18			; 3357 952A
		brne	avr334B		; 3358 F791
		cbi	PORTA, 6	; 3359 98DE
		lds	r17, 0x04C4		; 335A 9110 04C4
avr335C:dec	r17			; 335C 951A
		nop				; 335D 0000
		nop				; 335E 0000
		nop				; 335F 0000
		brne	avr335C		; 3360 F7D9
		lds	r17, 0x04C4		; 3361 9110 04C4
avr3363:dec	r17			; 3363 951A
		nop				; 3364 0000
		nop				; 3365 0000
		nop				; 3366 0000
		brne	avr3363		; 3367 F7D9
		pop	r18			; 3368 912F
		ret				; 3369 9508
;-------------------------------------------------------------------------
avr336A:wdr				; 336A 95A8
		push	r18			; 336B 932F
		cbi	PORTA, 7	; 336C 98DF
		sbi	DDRA, 7	; 336D 9AD7
		com	r16			; 336E 9500
		sec				; 336F 9408
		ldi	r18, 0x0A		; 3370 E02A
avr3371:lds	r17, 0x04C4		; 3371 9110 04C4
avr3373:dec	r17			; 3373 951A
		nop				; 3374 0000
		nop				; 3375 0000
		nop				; 3376 0000
		brne	avr3373		; 3377 F7D9
		brlo	avr337A		; 3378 F008
		cbi	PORTA, 7	; 3379 98DF
avr337A:brsh	avr337C		; 337A F408
		sbi	PORTA, 7	; 337B 9ADF
avr337C:lsr	r16			; 337C 9506
		dec	r18			; 337D 952A
		brne	avr3371		; 337E F791
		cbi	PORTA, 7	; 337F 98DF
		lds	r17, 0x04C4		; 3380 9110 04C4
avr3382:dec	r17			; 3382 951A
		nop				; 3383 0000
		nop				; 3384 0000
		nop				; 3385 0000
		brne	avr3382		; 3386 F7D9
		lds	r17, 0x04C4		; 3387 9110 04C4
avr3389:dec	r17			; 3389 951A
		nop				; 338A 0000
		nop				; 338B 0000
		nop				; 338C 0000
		brne	avr3389		; 338D F7D9
		pop	r18			; 338E 912F
		ret				; 338F 9508
;-------------------------------------------------------------------------
avr3390:wdr				; 3390 95A8
		push	r18			; 3391 932F
		cbi	PORTB, 0	; 3392 98C0
		sbi	DDRB, 0	; 3393 9AB8
		com	r16			; 3394 9500
		sec				; 3395 9408
		ldi	r18, 0x0A		; 3396 E02A
avr3397:lds	r17, 0x04C4		; 3397 9110 04C4
avr3399:dec	r17			; 3399 951A
		nop				; 339A 0000
		nop				; 339B 0000
		nop				; 339C 0000
		brne	avr3399		; 339D F7D9
		brlo	avr33A0		; 339E F008
		cbi	PORTB, 0	; 339F 98C0
avr33A0:brsh	avr33A2		; 33A0 F408
		sbi	PORTB, 0	; 33A1 9AC0
avr33A2:lsr	r16			; 33A2 9506
		dec	r18			; 33A3 952A
		brne	avr3397		; 33A4 F791
		cbi	PORTB, 0	; 33A5 98C0
		lds	r17, 0x04C4		; 33A6 9110 04C4
avr33A8:dec	r17			; 33A8 951A
		nop				; 33A9 0000
		nop				; 33AA 0000
		nop				; 33AB 0000
		brne	avr33A8		; 33AC F7D9
		lds	r17, 0x04C4		; 33AD 9110 04C4
avr33AF:dec	r17			; 33AF 951A
		nop				; 33B0 0000
		nop				; 33B1 0000
		nop				; 33B2 0000
		brne	avr33AF		; 33B3 F7D9
		pop	r18			; 33B4 912F
		ret				; 33B5 9508
;-------------------------------------------------------------------------
avr33B6:wdr				; 33B6 95A8
		push	r18			; 33B7 932F
		cbi	PORTB, 1	; 33B8 98C1
		sbi	DDRB, 1	; 33B9 9AB9
		com	r16			; 33BA 9500
		sec				; 33BB 9408
		ldi	r18, 0x0A		; 33BC E02A
avr33BD:		lds	r17, 0x04C4		; 33BD 9110 04C4
avr33BF:dec	r17			; 33BF 951A
		nop				; 33C0 0000
		nop				; 33C1 0000
		nop				; 33C2 0000
		brne	avr33BF		; 33C3 F7D9
		brlo	avr33C6		; 33C4 F008
		cbi	PORTB, 1	; 33C5 98C1
avr33C6:brsh	avr33C8		; 33C6 F408
		sbi	PORTB, 1	; 33C7 9AC1
avr33C8:lsr	r16			; 33C8 9506
		dec	r18			; 33C9 952A
		brne	avr33BD		; 33CA F791
		cbi	PORTB, 1	; 33CB 98C1
		lds	r17, 0x04C4		; 33CC 9110 04C4
avr33CE:dec	r17			; 33CE 951A
		nop				; 33CF 0000
		nop				; 33D0 0000
		nop				; 33D1 0000
		brne	avr33CE		; 33D2 F7D9
		lds	r17, 0x04C4		; 33D3 9110 04C4
avr33D5:dec	r17			; 33D5 951A
		nop				; 33D6 0000
		nop				; 33D7 0000
		nop				; 33D8 0000
		brne	avr33D5		; 33D9 F7D9
		pop	r18			; 33DA 912F
		ret				; 33DB 9508
;-------------------------------------------------------------------------
avr33DC:wdr				; 33DC 95A8
		push	r18			; 33DD 932F
		cbi	PORTB, 2	; 33DE 98C2
		sbi	DDRB, 2	; 33DF 9ABA
		com	r16			; 33E0 9500
		sec				; 33E1 9408
		ldi	r18, 0x0A		; 33E2 E02A
avr33E3:lds	r17, 0x04C4		; 33E3 9110 04C4
avr33E5:dec	r17			; 33E5 951A
		nop				; 33E6 0000
		nop				; 33E7 0000
		nop				; 33E8 0000
		brne	avr33E5		; 33E9 F7D9
		brlo	avr33EC		; 33EA F008
		cbi	PORTB, 2	; 33EB 98C2
avr33EC:brsh	avr33EE		; 33EC F408
		sbi	PORTB, 2	; 33ED 9AC2
avr33EE:lsr	r16			; 33EE 9506
		dec	r18			; 33EF 952A
		brne	avr33E3		; 33F0 F791
		cbi	PORTB, 2	; 33F1 98C2
		lds	r17, 0x04C4		; 33F2 9110 04C4
avr33F4:dec	r17			; 33F4 951A
		nop				; 33F5 0000
		nop				; 33F6 0000
		nop				; 33F7 0000
		brne	avr33F4		; 33F8 F7D9
		lds	r17, 0x04C4		; 33F9 9110 04C4
avr33FB:dec	r17			; 33FB 951A
		nop				; 33FC 0000
		nop				; 33FD 0000
		nop				; 33FE 0000
		brne	avr33FB		; 33FF F7D9
		pop	r18			; 3400 912F
		ret				; 3401 9508
;-------------------------------------------------------------------------
avr3402:wdr				; 3402 95A8
		push	r18			; 3403 932F
		cbi	PORTB, 3	; 3404 98C3
		sbi	DDRB, 3	; 3405 9ABB
		com	r16			; 3406 9500
		sec				; 3407 9408
		ldi	r18, 0x0A		; 3408 E02A
avr3409:lds	r17, 0x04C4		; 3409 9110 04C4
avr340B:dec	r17			; 340B 951A
		nop				; 340C 0000
		nop				; 340D 0000
		nop				; 340E 0000
		brne	avr340B		; 340F F7D9
		brlo	avr3412		; 3410 F008
		cbi	PORTB, 3	; 3411 98C3
avr3412:brsh	avr3414		; 3412 F408
		sbi	PORTB, 3	; 3413 9AC3
avr3414:lsr	r16			; 3414 9506
		dec	r18			; 3415 952A
		brne	avr3409		; 3416 F791
		cbi	PORTB, 3	; 3417 98C3
		lds	r17, 0x04C4		; 3418 9110 04C4
avr341A:	dec	r17			; 341A 951A
		nop				; 341B 0000
		nop				; 341C 0000
		nop				; 341D 0000
		brne	avr341A		; 341E F7D9
		lds	r17, 0x04C4		; 341F 9110 04C4
avr3421:dec	r17			; 3421 951A
		nop				; 3422 0000
		nop				; 3423 0000
		nop				; 3424 0000
		brne	avr3421		; 3425 F7D9
		pop	r18			; 3426 912F
		ret				; 3427 9508
;-------------------------------------------------------------------------
avr3428:wdr				; 3428 95A8
		push	r18			; 3429 932F
		cbi	PORTB, 4	; 342A 98C4
		sbi	DDRB, 4	; 342B 9ABC
		com	r16			; 342C 9500
		sec				; 342D 9408
		ldi	r18, 0x0A		; 342E E02A
avr342F:lds	r17, 0x04C4		; 342F 9110 04C4
avr3431:dec	r17			; 3431 951A
		nop				; 3432 0000
		nop				; 3433 0000
		nop				; 3434 0000
		brne	avr3431		; 3435 F7D9
		brlo	avr3438		; 3436 F008
		cbi	PORTB, 4	; 3437 98C4
avr3438:brsh	avr343A		; 3438 F408
		sbi	PORTB, 4	; 3439 9AC4
avr343A:lsr	r16			; 343A 9506
		dec	r18			; 343B 952A
		brne	avr342F		; 343C F791
		cbi	PORTB, 4	; 343D 98C4
		lds	r17, 0x04C4		; 343E 9110 04C4
avr3440:dec	r17			; 3440 951A
		nop				; 3441 0000
		nop				; 3442 0000
		nop				; 3443 0000
		brne	avr3440		; 3444 F7D9
		lds	r17, 0x04C4		; 3445 9110 04C4
avr3447:dec	r17			; 3447 951A
		nop				; 3448 0000
		nop				; 3449 0000
		nop				; 344A 0000
		brne	avr3447		; 344B F7D9
		pop	r18			; 344C 912F
		ret				; 344D 9508
;-------------------------------------------------------------------------
avr344E:wdr				; 344E 95A8
		push	r18			; 344F 932F
		cbi	PORTB, 5	; 3450 98C5
		sbi	DDRB, 5	; 3451 9ABD
		com	r16			; 3452 9500
		sec				; 3453 9408
		ldi	r18, 0x0A		; 3454 E02A
avr3455:lds	r17, 0x04C4		; 3455 9110 04C4
avr3457:dec	r17			; 3457 951A
		nop				; 3458 0000
		nop				; 3459 0000
		nop				; 345A 0000
		brne	avr3457		; 345B F7D9
		brlo	avr345E		; 345C F008
		cbi	PORTB, 5	; 345D 98C5
avr345E:brsh	avr3460		; 345E F408
		sbi	PORTB, 5	; 345F 9AC5
avr3460:lsr	r16			; 3460 9506
		dec	r18			; 3461 952A
		brne	avr3455		; 3462 F791
		cbi	PORTB, 5	; 3463 98C5
		lds	r17, 0x04C4		; 3464 9110 04C4
avr3466:dec	r17			; 3466 951A
		nop				; 3467 0000
		nop				; 3468 0000
		nop				; 3469 0000
		brne	avr3466		; 346A F7D9
		lds	r17, 0x04C4		; 346B 9110 04C4
avr346D:dec	r17			; 346D 951A
		nop				; 346E 0000
		nop				; 346F 0000
		nop				; 3470 0000
		brne	avr346D		; 3471 F7D9
		pop	r18			; 3472 912F
		ret				; 3473 9508
;-------------------------------------------------------------------------
avr3474:wdr				; 3474 95A8
		push	r18			; 3475 932F
		cbi	PORTB, 6	; 3476 98C6
		sbi	DDRB, 6	; 3477 9ABE
		com	r16			; 3478 9500
		sec				; 3479 9408
		ldi	r18, 0x0A		; 347A E02A
avr347B:lds	r17, 0x04C4		; 347B 9110 04C4
avr347D:dec	r17			; 347D 951A
		nop				; 347E 0000
		nop				; 347F 0000
		nop				; 3480 0000
		brne	avr347D		; 3481 F7D9
		brlo	avr3484		; 3482 F008
		cbi	PORTB, 6	; 3483 98C6
avr3484:brsh	avr3486		; 3484 F408
		sbi	PORTB, 6	; 3485 9AC6
avr3486:lsr	r16			; 3486 9506
		dec	r18			; 3487 952A
		brne	avr347B		; 3488 F791
		cbi	PORTB, 6	; 3489 98C6
		lds	r17, 0x04C4		; 348A 9110 04C4
avr348C:dec	r17			; 348C 951A
		nop				; 348D 0000
		nop				; 348E 0000
		nop				; 348F 0000
		brne	avr348C		; 3490 F7D9
		lds	r17, 0x04C4		; 3491 9110 04C4
avr3493:dec	r17			; 3493 951A
		nop				; 3494 0000
		nop				; 3495 0000
		nop				; 3496 0000
		brne	avr3493		; 3497 F7D9
		pop	r18			; 3498 912F
		ret				; 3499 9508
;-------------------------------------------------------------------------
avr349A:wdr				; 349A 95A8
		push	r18			; 349B 932F
		cbi	PORTB, 7	; 349C 98C7
		sbi	DDRB, 7	; 349D 9ABF
		com	r16			; 349E 9500
		sec				; 349F 9408
		ldi	r18, 0x0A		; 34A0 E02A
avr34A1:lds	r17, 0x04C4		; 34A1 9110 04C4
avr34A3:dec	r17			; 34A3 951A
		nop				; 34A4 0000
		nop				; 34A5 0000
		nop				; 34A6 0000
		brne	avr34A3		; 34A7 F7D9
		brlo	avr34AA		; 34A8 F008
		cbi	PORTB, 7	; 34A9 98C7
avr34AA:brsh	avr34AC		; 34AA F408
		sbi	PORTB, 7	; 34AB 9AC7
avr34Ac:lsr	r16			; 34AC 9506
		dec	r18			; 34AD 952A
		brne	avr34A1		; 34AE F791
		cbi	PORTB, 7	; 34AF 98C7
		lds	r17, 0x04C4		; 34B0 9110 04C4
avr34B2:dec	r17			; 34B2 951A
		nop				; 34B3 0000
		nop				; 34B4 0000
		nop				; 34B5 0000
		brne	avr34B2		; 34B6 F7D9
		lds	r17, 0x04C4		; 34B7 9110 04C4
avr34B9:dec	r17			; 34B9 951A
		nop				; 34BA 0000
		nop				; 34BB 0000
		nop				; 34BC 0000
		brne	avr34B9		; 34BD F7D9
		pop	r18			; 34BE 912F
		ret				; 34BF 9508
;-------------------------------------------------------------------------
avr34C0:wdr				; 34C0 95A8
		push	r18			; 34C1 932F
		cbi	PORTC, 7	; 34C2 98AF
		sbi	DDRC, 7	; 34C3 9AA7
		com	r16			; 34C4 9500
		sec				; 34C5 9408
		ldi	r18, 0x0A		; 34C6 E02A
avr34C7:lds	r17, 0x04C4		; 34C7 9110 04C4
avr34C9:dec	r17			; 34C9 951A
		nop				; 34CA 0000
		nop				; 34CB 0000
		nop				; 34CC 0000
		brne	avr34C9		; 34CD F7D9
		brlo	avr34D0		; 34CE F008
		cbi	PORTC, 7	; 34CF 98AF
avr34D0:brsh	avr34D2		; 34D0 F408
		sbi	PORTC, 7	; 34D1 9AAF
avr34D2:lsr	r16			; 34D2 9506
		dec	r18			; 34D3 952A
		brne	avr34C7		; 34D4 F791
		cbi	PORTC, 7	; 34D5 98AF
		lds	r17, 0x04C4		; 34D6 9110 04C4
avr34D8:dec	r17			; 34D8 951A
		nop				; 34D9 0000
		nop				; 34DA 0000
		nop				; 34DB 0000
		brne	avr34D8		; 34DC F7D9
		lds	r17, 0x04C4		; 34DD 9110 04C4
avr34DF:dec	r17			; 34DF 951A
		nop				; 34E0 0000
		nop				; 34E1 0000
		nop				; 34E2 0000
		brne	avr34DF		; 34E3 F7D9
		pop	r18			; 34E4 912F
		ret				; 34E5 9508
;-------------------------------------------------------------------------
avr34E6:wdr				; 34E6 95A8
		push	r18			; 34E7 932F
		cbi	PORTC, 6	; 34E8 98AE
		sbi	DDRC, 6	; 34E9 9AA6
		com	r16			; 34EA 9500
		sec				; 34EB 9408
		ldi	r18, 0x0A		; 34EC E02A
avr34ED:lds	r17, 0x04C4		; 34ED 9110 04C4
avr34EF:dec	r17			; 34EF 951A
		nop				; 34F0 0000
		nop				; 34F1 0000
		nop				; 34F2 0000
		brne	avr34EF		; 34F3 F7D9
		brlo	avr34F6		; 34F4 F008
		cbi	PORTC, 6	; 34F5 98AE
avr34F6:brsh	avr34F8		; 34F6 F408
		sbi	PORTC, 6	; 34F7 9AAE
avr34F8:lsr	r16			; 34F8 9506
		dec	r18			; 34F9 952A
		brne	avr34ED		; 34FA F791
		cbi	PORTC, 6	; 34FB 98AE
		lds	r17, 0x04C4		; 34FC 9110 04C4
avr34FE:dec	r17			; 34FE 951A
		nop				; 34FF 0000
		nop				; 3500 0000
		nop				; 3501 0000
		brne	avr34FE		; 3502 F7D9
		lds	r17, 0x04C4		; 3503 9110 04C4
avr3505:dec	r17			; 3505 951A
		nop				; 3506 0000
		nop				; 3507 0000
		nop				; 3508 0000
		brne	avr3505		; 3509 F7D9
		pop	r18			; 350A 912F
		ret				; 350B 9508
;-------------------------------------------------------------------------
avr350C:wdr				; 350C 95A8
		push	r18			; 350D 932F
		cbi	PORTC, 5	; 350E 98AD
		sbi	DDRC, 5	; 350F 9AA5
		com	r16			; 3510 9500
		sec				; 3511 9408
		ldi	r18, 0x0A		; 3512 E02A
avr3513:lds	r17, 0x04C4		; 3513 9110 04C4
avr3515:dec	r17			; 3515 951A
		nop				; 3516 0000
		nop				; 3517 0000
		nop				; 3518 0000
		brne	avr3515		; 3519 F7D9
		brlo	avr351C		; 351A F008
		cbi	PORTC, 5	; 351B 98AD
avr351C:brsh	avr351E		; 351C F408
		sbi	PORTC, 5	; 351D 9AAD
avr351E:lsr	r16			; 351E 9506
		dec	r18			; 351F 952A
		brne	avr3513		; 3520 F791
		cbi	PORTC, 5	; 3521 98AD
		lds	r17, 0x04C4		; 3522 9110 04C4
avr3524:dec	r17			; 3524 951A
		nop				; 3525 0000
		nop				; 3526 0000
		nop				; 3527 0000
		brne	avr3524		; 3528 F7D9
		lds	r17, 0x04C4		; 3529 9110 04C4
avr352B:dec	r17			; 352B 951A
		nop				; 352C 0000
		nop				; 352D 0000
		nop				; 352E 0000
		brne	avr352B		; 352F F7D9
		pop	r18			; 3530 912F
		ret				; 3531 9508
;-------------------------------------------------------------------------
avr3532:wdr				; 3532 95A8
		push	r18			; 3533 932F
		cbi	PORTC, 4	; 3534 98AC
		sbi	DDRC, 4	; 3535 9AA4
		com	r16			; 3536 9500
		sec				; 3537 9408
		ldi	r18, 0x0A		; 3538 E02A
avr3539:lds	r17, 0x04C4		; 3539 9110 04C4
avr353B:dec	r17			; 353B 951A
		nop				; 353C 0000
		nop				; 353D 0000
		nop				; 353E 0000
		brne	avr353B		; 353F F7D9
		brlo	avr3542		; 3540 F008
		cbi	PORTC, 4	; 3541 98AC
avr3542:brsh	avr3544		; 3542 F408
		sbi	PORTC, 4	; 3543 9AAC
avr3544:lsr	r16			; 3544 9506
		dec	r18			; 3545 952A
		brne	avr3539		; 3546 F791
		cbi	PORTC, 4	; 3547 98AC
		lds	r17, 0x04C4		; 3548 9110 04C4
avr354A:dec	r17			; 354A 951A
		nop				; 354B 0000
		nop				; 354C 0000
		nop				; 354D 0000
		brne	avr354A		; 354E F7D9
		lds	r17, 0x04C4		; 354F 9110 04C4
avr3551:dec	r17			; 3551 951A
		nop				; 3552 0000
		nop				; 3553 0000
		nop				; 3554 0000
		brne	avr3551		; 3555 F7D9
		pop	r18			; 3556 912F
		ret				; 3557 9508
;-------------------------------------------------------------------------
avr3558:wdr				; 3558 95A8
		push	r18			; 3559 932F
		cbi	PORTC, 3	; 355A 98AB
		sbi	DDRC, 3	; 355B 9AA3
		com	r16			; 355C 9500
		sec				; 355D 9408
		ldi	r18, 0x0A		; 355E E02A
avr355F:lds	r17, 0x04C4		; 355F 9110 04C4
avr3561:dec	r17			; 3561 951A
		nop				; 3562 0000
		nop				; 3563 0000
		nop				; 3564 0000
		brne	avr3561		; 3565 F7D9
		brlo	avr3568		; 3566 F008
		cbi	PORTC, 3	; 3567 98AB
avr3568:brsh	avr356A		; 3568 F408
		sbi	PORTC, 3	; 3569 9AAB
avr356A:lsr	r16			; 356A 9506
		dec	r18			; 356B 952A
		brne	avr355F		; 356C F791
		cbi	PORTC, 3	; 356D 98AB
		lds	r17, 0x04C4		; 356E 9110 04C4
avr3570:dec	r17			; 3570 951A
		nop				; 3571 0000
		nop				; 3572 0000
		nop				; 3573 0000
		brne	avr3570		; 3574 F7D9
		lds	r17, 0x04C4		; 3575 9110 04C4
avr3577:dec	r17			; 3577 951A
		nop				; 3578 0000
		nop				; 3579 0000
		nop				; 357A 0000
		brne	avr3577		; 357B F7D9
		pop	r18			; 357C 912F
		ret				; 357D 9508
;-------------------------------------------------------------------------
avr357E:wdr				; 357E 95A8
		push	r18			; 357F 932F
		cbi	PORTC, 2	; 3580 98AA
		sbi	DDRC, 2	; 3581 9AA2
		com	r16			; 3582 9500
		sec				; 3583 9408
		ldi	r18, 0x0A		; 3584 E02A
avr3585:lds	r17, 0x04C4		; 3585 9110 04C4
avr3587:dec	r17			; 3587 951A
		nop				; 3588 0000
		nop				; 3589 0000
		nop				; 358A 0000
		brne	avr3587		; 358B F7D9
		brlo	avr358E		; 358C F008
		cbi	PORTC, 2	; 358D 98AA
avr358E:brsh	avr3590		; 358E F408
		sbi	PORTC, 2	; 358F 9AAA
avr3590:lsr	r16			; 3590 9506
		dec	r18			; 3591 952A
		brne	avr3585		; 3592 F791
		cbi	PORTC, 2	; 3593 98AA
		lds	r17, 0x04C4		; 3594 9110 04C4
avr3596:dec	r17			; 3596 951A
		nop				; 3597 0000
		nop				; 3598 0000
		nop				; 3599 0000
		brne	avr3596		; 359A F7D9
		lds	r17, 0x04C4		; 359B 9110 04C4
avr359D:dec	r17			; 359D 951A
		nop				; 359E 0000
		nop				; 359F 0000
		nop				; 35A0 0000
		brne	avr359D		; 35A1 F7D9
		pop	r18			; 35A2 912F
		ret				; 35A3 9508
;-------------------------------------------------------------------------
avr35A4:wdr				; 35A4 95A8
		push	r18			; 35A5 932F
		cbi	PORTC, 1	; 35A6 98A9
		sbi	DDRC, 1	; 35A7 9AA1
		com	r16			; 35A8 9500
		sec				; 35A9 9408
		ldi	r18, 0x0A		; 35AA E02A
avr35AB:lds	r17, 0x04C4		; 35AB 9110 04C4
avr35AD:dec	r17			; 35AD 951A
		nop				; 35AE 0000
		nop				; 35AF 0000
		nop				; 35B0 0000
		brne	avr35AD		; 35B1 F7D9
		brlo	avr35B4		; 35B2 F008
		cbi	PORTC, 1	; 35B3 98A9
avr35B4:brsh	avr35B6		; 35B4 F408
		sbi	PORTC, 1	; 35B5 9AA9
avr35B6:lsr	r16			; 35B6 9506
		dec	r18			; 35B7 952A
		brne	avr35AB		; 35B8 F791
		cbi	PORTC, 1	; 35B9 98A9
		lds	r17, 0x04C4		; 35BA 9110 04C4
avr35BC:dec	r17			; 35BC 951A
		nop				; 35BD 0000
		nop				; 35BE 0000
		nop				; 35BF 0000
		brne	avr35BC		; 35C0 F7D9
		lds	r17, 0x04C4		; 35C1 9110 04C4
avr35C3:dec	r17			; 35C3 951A
		nop				; 35C4 0000
		nop				; 35C5 0000
		nop				; 35C6 0000
		brne	avr35C3		; 35C7 F7D9
		pop	r18			; 35C8 912F
		ret				; 35C9 9508
;-------------------------------------------------------------------------
avr35CA:wdr				; 35CA 95A8
		push	r18			; 35CB 932F
		cbi	PORTC, 0	; 35CC 98A8
		sbi	DDRC, 0	; 35CD 9AA0
		com	r16			; 35CE 9500
		sec				; 35CF 9408
		ldi	r18, 0x0A		; 35D0 E02A
avr35D1:lds	r17, 0x04C4		; 35D1 9110 04C4
avr35D3:dec	r17			; 35D3 951A
		nop				; 35D4 0000
		nop				; 35D5 0000
		nop				; 35D6 0000
		brne	avr35D3		; 35D7 F7D9
		brlo	avr35DA		; 35D8 F008
		cbi	PORTC, 0	; 35D9 98A8
avr35DA:brsh	avr35DC		; 35DA F408
		sbi	PORTC, 0	; 35DB 9AA8
avr35DC:lsr	r16			; 35DC 9506
		dec	r18			; 35DD 952A
		brne	avr35D1		; 35DE F791
		cbi	PORTC, 0	; 35DF 98A8
		lds	r17, 0x04C4		; 35E0 9110 04C4
avr35E2:dec	r17			; 35E2 951A
		nop				; 35E3 0000
		nop				; 35E4 0000
		nop				; 35E5 0000
		brne	avr35E2		; 35E6 F7D9
		lds	r17, 0x04C4		; 35E7 9110 04C4
avr35E9:dec	r17			; 35E9 951A
		nop				; 35EA 0000
		nop				; 35EB 0000
		nop				; 35EC 0000
		brne	avr35E9		; 35ED F7D9
		pop	r18			; 35EE 912F
		ret				; 35EF 9508
;-------------------------------------------------------------------------
avr35F0:wdr				; 35F0 95A8
		push	r18			; 35F1 932F
		cbi	$03, 7	; 35F2 981F
		sbi	$02, 7	; 35F3 9A17
		com	r16			; 35F4 9500
		sec				; 35F5 9408
		ldi	r18, 0x0A		; 35F6 E02A
avr35F7:lds	r17, 0x04C4		; 35F7 9110 04C4
avr35F9:dec	r17			; 35F9 951A
		nop				; 35FA 0000
		nop				; 35FB 0000
		nop				; 35FC 0000
		brne	avr35F9		; 35FD F7D9
		brlo	avr3600		; 35FE F008
		cbi	$03, 7	; 35FF 981F
avr3600:brsh	avr3602		; 3600 F408
		sbi	$03, 7	; 3601 9A1F
avr3602:lsr	r16			; 3602 9506
		dec	r18			; 3603 952A
		brne	avr35F7		; 3604 F791
		cbi	$03, 7	; 3605 981F
		lds	r17, 0x04C4		; 3606 9110 04C4
avr3608:dec	r17			; 3608 951A
		nop				; 3609 0000
		nop				; 360A 0000
		nop				; 360B 0000
		brne	avr3608		; 360C F7D9
		lds	r17, 0x04C4		; 360D 9110 04C4
avr360F:dec	r17			; 360F 951A
		nop				; 3610 0000
		nop				; 3611 0000
		nop				; 3612 0000
		brne	avr360F		; 3613 F7D9
		pop	r18			; 3614 912F
		ret				; 3615 9508
;-------------------------------------------------------------------------
avr3616:wdr				; 3616 95A8
		push	r18			; 3617 932F
		cbi	$03, 6	; 3618 981E
		sbi	$02, 6	; 3619 9A16
		com	r16			; 361A 9500
		sec				; 361B 9408
		ldi	r18, 0x0A		; 361C E02A
avr361D:lds	r17, 0x04C4		; 361D 9110 04C4
avr361F:dec	r17			; 361F 951A
		nop				; 3620 0000
		nop				; 3621 0000
		nop				; 3622 0000
		brne	avr361F		; 3623 F7D9
		brlo	avr3626		; 3624 F008
		cbi	$03, 6	; 3625 981E
avr3626:brsh	avr3628		; 3626 F408
		sbi	$03, 6	; 3627 9A1E
avr3628:lsr	r16			; 3628 9506
		dec	r18			; 3629 952A
		brne	avr361D		; 362A F791
		cbi	$03, 6	; 362B 981E
		lds	r17, 0x04C4		; 362C 9110 04C4
avr362E:dec	r17			; 362E 951A
		nop				; 362F 0000
		nop				; 3630 0000
		nop				; 3631 0000
		brne	avr362E		; 3632 F7D9
		lds	r17, 0x04C4		; 3633 9110 04C4
avr3635:dec	r17			; 3635 951A
		nop				; 3636 0000
		nop				; 3637 0000
		nop				; 3638 0000
		brne	avr3635		; 3639 F7D9
		pop	r18			; 363A 912F
		ret				; 363B 9508
;-------------------------------------------------------------------------
avr363C:wdr				; 363C 95A8
		push	r18			; 363D 932F
		cbi	PORTD, 7	; 363E 9897
		sbi	DDRD, 7	; 363F 9A8F
		com	r16			; 3640 9500
		sec				; 3641 9408
		ldi	r18, 0x0A		; 3642 E02A
avr3643:lds	r17, 0x04C4		; 3643 9110 04C4
avr3645:dec	r17			; 3645 951A
		nop				; 3646 0000
		nop				; 3647 0000
		nop				; 3648 0000
		brne	avr3645		; 3649 F7D9
		brlo	avr364C		; 364A F008
		cbi	PORTD, 7	; 364B 9897
avr364C:brsh	avr364E		; 364C F408
		sbi	PORTD, 7	; 364D 9A97
avr364E:lsr	r16			; 364E 9506
		dec	r18			; 364F 952A
		brne	avr3643		; 3650 F791
		cbi	PORTD, 7	; 3651 9897
		lds	r17, 0x04C4		; 3652 9110 04C4
avr3654:dec	r17			; 3654 951A
		nop				; 3655 0000
		nop				; 3656 0000
		nop				; 3657 0000
		brne	avr3654		; 3658 F7D9
		lds	r17, 0x04C4		; 3659 9110 04C4
avr365B:dec	r17			; 365B 951A
		nop				; 365C 0000
		nop				; 365D 0000
		nop				; 365E 0000
		brne	avr365B		; 365F F7D9
		pop	r18			; 3660 912F
		ret				; 3661 9508
;-------------------------------------------------------------------------
avr3662:wdr				; 3662 95A8
		push	r18			; 3663 932F
		cbi	PORTD, 6	; 3664 9896
		sbi	DDRD, 6	; 3665 9A8E
		com	r16			; 3666 9500
		sec				; 3667 9408
		ldi	r18, 0x0A		; 3668 E02A
avr3669:lds	r17, 0x04C4		; 3669 9110 04C4
avr366B:dec	r17			; 366B 951A
		nop				; 366C 0000
		nop				; 366D 0000
		nop				; 366E 0000
		brne	avr366B		; 366F F7D9
		brlo	avr3672		; 3670 F008
		cbi	PORTD, 6	; 3671 9896
avr3672:brsh	avr3674		; 3672 F408
		sbi	PORTD, 6	; 3673 9A96
avr3674:lsr	r16			; 3674 9506
		dec	r18			; 3675 952A
		brne	avr3669		; 3676 F791
		cbi	PORTD, 6	; 3677 9896
		lds	r17, 0x04C4		; 3678 9110 04C4
avr367A:dec	r17			; 367A 951A
		nop				; 367B 0000
		nop				; 367C 0000
		nop				; 367D 0000
		brne	avr367A		; 367E F7D9
		lds	r17, 0x04C4		; 367F 9110 04C4
avr3681:dec	r17			; 3681 951A
		nop				; 3682 0000
		nop				; 3683 0000
		nop				; 3684 0000
		brne	avr3681		; 3685 F7D9
		pop	r18			; 3686 912F
		ret				; 3687 9508
;-------------------------------------------------------------------------
avr3688:wdr				; 3688 95A8
		push	r18			; 3689 932F
		cbi	PORTD, 5	; 368A 9895
		sbi	DDRD, 5	; 368B 9A8D
		com	r16			; 368C 9500
		sec				; 368D 9408
		ldi	r18, 0x0A		; 368E E02A
avr368F:lds	r17, 0x04C4		; 368F 9110 04C4
avr3691:dec	r17			; 3691 951A
		nop				; 3692 0000
		nop				; 3693 0000
		nop				; 3694 0000
		brne	avr3691		; 3695 F7D9
		brlo	avr3698		; 3696 F008
		cbi	PORTD, 5	; 3697 9895
avr3698:brsh	avr369A		; 3698 F408
		sbi	PORTD, 5	; 3699 9A95
avr369A:lsr	r16			; 369A 9506
		dec	r18			; 369B 952A
		brne	avr368F		; 369C F791
		cbi	PORTD, 5	; 369D 9895
		lds	r17, 0x04C4		; 369E 9110 04C4
avr36A0:dec	r17			; 36A0 951A
		nop				; 36A1 0000
		nop				; 36A2 0000
		nop				; 36A3 0000
		brne	avr36A0		; 36A4 F7D9
		lds	r17, 0x04C4		; 36A5 9110 04C4
avr36A7:dec	r17			; 36A7 951A
		nop				; 36A8 0000
		nop				; 36A9 0000
		nop				; 36AA 0000
		brne	avr36A7		; 36AB F7D9
		pop	r18			; 36AC 912F
		ret				; 36AD 9508
;-------------------------------------------------------------------------
avr36AE:wdr				; 36AE 95A8
		push	r18			; 36AF 932F
		push	r19			; 36B0 933F
		push	r20			; 36B1 934F
		lds	r19, 0x0065		; 36B2 9130 0065
		andi	r19, 0xFB		; 36B4 7F3B
		sts	0x0065, r19		; 36B5 9330 0065
		lds	r20, 0x0064		; 36B7 9140 0064
		ori	r20, 0x04		; 36B9 6044
		sts	0x0064, r20		; 36BA 9340 0064
		mov	r20, r19		; 36BC 2F43
		ori	r20, 0x04		; 36BD 6044
		com	r16			; 36BE 9500
		sec				; 36BF 9408
		ldi	r18, 0x0A		; 36C0 E02A
avr36C1:lds	r17, 0x04C4		; 36C1 9110 04C4
avr36C3:dec	r17			; 36C3 951A
		nop				; 36C4 0000
		nop				; 36C5 0000
		nop				; 36C6 0000
		brne	avr36C3		; 36C7 F7D9
		brlo	avr36CB		; 36C8 F010
		sts	0x0065, r19		; 36C9 9330 0065
avr36CB:brsh	avr36CE		; 36CB F410
		sts	0x0065, r20		; 36CC 9340 0065
avr36CE:lsr	r16			; 36CE 9506
		dec	r18			; 36CF 952A
		brne	avr36C1		; 36D0 F781
		sts	0x0065, r19		; 36D1 9330 0065
		lds	r17, 0x04C4		; 36D3 9110 04C4
avr36D5:dec	r17			; 36D5 951A
		nop				; 36D6 0000
		nop				; 36D7 0000
		nop				; 36D8 0000
		brne	avr36D5		; 36D9 F7D9
		lds	r17, 0x04C4		; 36DA 9110 04C4
avr36DC:dec	r17			; 36DC 951A
		nop				; 36DD 0000
		nop				; 36DE 0000
		nop				; 36DF 0000
		brne	avr36DC		; 36E0 F7D9
		pop	r20			; 36E1 914F
		pop	r19			; 36E2 913F
		pop	r18			; 36E3 912F
		ret				; 36E4 9508
;-------------------------------------------------------------------------
avr36E5:	wdr				; 36E5 95A8
		push	r18			; 36E6 932F
		push	r19			; 36E7 933F
		push	r20			; 36E8 934F
		lds	r19, 0x0065		; 36E9 9130 0065
		andi	r19, 0xFD		; 36EB 7F3D
		sts	0x0065, r19		; 36EC 9330 0065
		lds	r20, 0x0064		; 36EE 9140 0064
		ori	r20, 0x02		; 36F0 6042
		sts	0x0064, r20		; 36F1 9340 0064
		mov	r20, r19		; 36F3 2F43
		ori	r20, 0x02		; 36F4 6042
		com	r16			; 36F5 9500
		sec				; 36F6 9408
		ldi	r18, 0x0A		; 36F7 E02A
avr36F8:lds	r17, 0x04C4		; 36F8 9110 04C4
avr36FA:dec	r17			; 36FA 951A
		nop				; 36FB 0000
		nop				; 36FC 0000
		nop				; 36FD 0000
		brne	avr36FA		; 36FE F7D9
		brlo	avr3702		; 36FF F010
		sts	0x0065, r19		; 3700 9330 0065
avr3702:brsh	avr3705		; 3702 F410
		sts	0x0065, r20		; 3703 9340 0065
avr3705:lsr	r16			; 3705 9506
		dec	r18			; 3706 952A
		brne	avr36F8		; 3707 F781
		sts	0x0065, r19		; 3708 9330 0065
		lds	r17, 0x04C4		; 370A 9110 04C4
avr370C:dec	r17			; 370C 951A
		nop				; 370D 0000
		nop				; 370E 0000
		nop				; 370F 0000
		brne	avr370C		; 3710 F7D9
		lds	r17, 0x04C4		; 3711 9110 04C4
avr3713:dec	r17			; 3713 951A
		nop				; 3714 0000
		nop				; 3715 0000
		nop				; 3716 0000
		brne	avr3713		; 3717 F7D9
		pop	r20			; 3718 914F
		pop	r19			; 3719 913F
		pop	r18			; 371A 912F
		ret				; 371B 9508
;-------------------------------------------------------------------------
avr371C:wdr				; 371C 95A8
		push	r18			; 371D 932F
		push	r19			; 371E 933F
		push	r20			; 371F 934F
		lds	r19, 0x0065		; 3720 9130 0065
		andi	r19, 0xFE		; 3722 7F3E
		sts	0x0065, r19		; 3723 9330 0065
		lds	r20, 0x0064		; 3725 9140 0064
		ori	r20, 0x01		; 3727 6041
		sts	0x0064, r20		; 3728 9340 0064
		mov	r20, r19		; 372A 2F43
		ori	r20, 0x01		; 372B 6041
		com	r16			; 372C 9500
		sec				; 372D 9408
		ldi	r18, 0x0A		; 372E E02A
avr372F:lds	r17, 0x04C4		; 372F 9110 04C4
avr3731:dec	r17			; 3731 951A
		nop				; 3732 0000
		nop				; 3733 0000
		nop				; 3734 0000
		brne	avr3731		; 3735 F7D9
		brlo	avr3739		; 3736 F010
		sts	0x0065, r19		; 3737 9330 0065
avr3739:brsh	avr373C		; 3739 F410
		sts	0x0065, r20		; 373A 9340 0065
avr373C:lsr	r16			; 373C 9506
		dec	r18			; 373D 952A
		brne	avr372F		; 373E F781
		sts	0x0065, r19		; 373F 9330 0065
		lds	r17, 0x04C4		; 3741 9110 04C4
avr3743:dec	r17			; 3743 951A
		nop				; 3744 0000
		nop				; 3745 0000
		nop				; 3746 0000
		brne	avr3743		; 3747 F7D9
		lds	r17, 0x04C4		; 3748 9110 04C4
avr374A:dec	r17			; 374A 951A
		nop				; 374B 0000
		nop				; 374C 0000
		nop				; 374D 0000
		brne	avr374A		; 374E F7D9
		pop	r20			; 374F 914F
		pop	r19			; 3750 913F
		pop	r18			; 3751 912F
		ret				; 3752 9508
;-------------------------------------------------------------------------
avr3753:wdr				; 3753 95A8
		cpi	r17, 0x00		; 3754 3010
		breq	avr3795		; 3755 F1F9
		cpi	r17, 0x01		; 3756 3011
		breq	avr3796		; 3757 F1F1
		cpi	r17, 0x02		; 3758 3012
		breq	avr3797		; 3759 F1E9
		cpi	r17, 0x03		; 375A 3013
		breq	avr3798		; 375B F1E1
		cpi	r17, 0x04		; 375C 3014
		breq	avr3799		; 375D F1D9
		cpi	r17, 0x05		; 375E 3015
		breq	avr379A		; 375F F1D1
		cpi	r17, 0x06		; 3760 3016
		breq	avr379B		; 3761 F1C9
		cpi	r17, 0x07		; 3762 3017
		breq	avr379C		; 3763 F1C1
		cpi	r17, 0x08		; 3764 3018
		breq	avr379D		; 3765 F1B9
		cpi	r17, 0x09		; 3766 3019
		breq	avr379E		; 3767 F1B1
		cpi	r17, 0x0A		; 3768 301A
		breq	avr379F		; 3769 F1A9
		cpi	r17, 0x0B		; 376A 301B
		breq	avr37A0		; 376B F1A1
		cpi	r17, 0x0C		; 376C 301C
		breq	avr37A1		; 376D F199
		cpi	r17, 0x0D		; 376E 301D
		breq	avr37A2		; 376F F191
		cpi	r17, 0x0E		; 3770 301E
		breq	avr37A3		; 3771 F189
		cpi	r17, 0x0F		; 3772 301F
		breq	avr37A4		; 3773 F181
		cpi	r17, 0x10		; 3774 3110
		breq	avr37A5		; 3775 F179
		cpi	r17, 0x11		; 3776 3111
		breq	avr37A6		; 3777 F171
		cpi	r17, 0x12		; 3778 3112
		breq	avr37A7		; 3779 F169
		cpi	r17, 0x13		; 377A 3113
		breq	avr37A8		; 377B F161
		cpi	r17, 0x14		; 377C 3114
		breq	avr37A9		; 377D F159
		cpi	r17, 0x15		; 377E 3115
		breq	avr37AA		; 377F F151
		cpi	r17, 0x16		; 3780 3116
		breq	avr37AB		; 3781 F149
		cpi	r17, 0x17		; 3782 3117
		breq	avr37AC		; 3783 F141
		cpi	r17, 0x18		; 3784 3118
		breq	avr37AD		; 3785 F139
		cpi	r17, 0x19		; 3786 3119
		breq	avr37AE		; 3787 F131
		cpi	r17, 0x1A		; 3788 311A
		breq	avr37AF		; 3789 F129
		cpi	r17, 0x1B		; 378A 311B
		breq	avr37B0		; 378B F121
		cpi	r17, 0x1C		; 378C 311C
		breq	avr37B1		; 378D F119
		cpi	r17, 0x1D		; 378E 311D
		breq	avr37B2		; 378F F111
		cpi	r17, 0x1E		; 3790 311E
		breq	avr37B3		; 3791 F109
		cpi	r17, 0x1F		; 3792 311F
		breq	avr37B4		; 3793 F101
		ret				; 3794 9508
;-------------------------------------------------------------------------
avr3795:rjmp	avr37B6		; 3795 C020
avr3796:rjmp	avr37F5		; 3796 C05E
avr3797:rjmp	avr3834		; 3797 C09C
avr3798:rjmp	avr3872		; 3798 C0D9
avr3799:rjmp	avr38B0		; 3799 C116
avr379A:rjmp	avr38EE		; 379A C153
avr379B:rjmp	avr392C		; 379B C190
avr379C:rjmp	avr396A		; 379C C1CD
avr379D:rjmp	avr39A8		; 379D C20A
avr379E:rjmp	avr39E6		; 379E C247
avr379F:rjmp	avr3A24		; 379F C284
avr37A0:rjmp	avr3A62		; 37A0 C2C1
avr37A1:rjmp	avr3AA0		; 37A1 C2FE
avr37A2:rjmp	avr3ADE		; 37A2 C33B
avr37A3:rjmp	avr3B1C		; 37A3 C378
avr37A4:rjmp	avr3B5A		; 37A4 C3B5
avr37A5:rjmp	avr3B98		; 37A5 C3F2
avr37A6:rjmp	avr3BD6		; 37A6 C42F
avr37A7:rjmp	avr3C14		; 37A7 C46C
avr37A8:rjmp	avr3C52		; 37A8 C4A9
avr37A9:rjmp	avr3C90		; 37A9 C4E6
avr37AA:rjmp	avr3CCE		; 37AA C523
avr37AB:rjmp	avr3D0C		; 37AB C560
avr37AC:rjmp	avr3D4A		; 37AC C59D
avr37AD:rjmp	avr3D88		; 37AD C5DA
avr37AE:rjmp	avr3DC6		; 37AE C617
avr37AF:rjmp	avr3E04		; 37AF C654
avr37B0:rjmp	avr3E42		; 37B0 C691
avr37B1:rjmp	avr3E80		; 37B1 C6CE
avr37B2:rjmp	avr3EBE		; 37B2 C70B
avr37B3:rjmp	avr3F0F		; 37B3 C75B
avr37B4:rjmp	avr3F60		; 37B4 C7AB
		ret				; 37B5 9508
;-------------------------------------------------------------------------
avr37B6:nop				; 37B6 0000
		push	r18			; 37B7 932F
		cbi	DDRA, 0	; 37B8 98D0
		sbi	PORTA, 0	; 37B9 9AD8
		sbic	PINA, 0	; 37BA 99C8
		rjmp	avr3FB1		; 37BB C7F5
		nop				; 37BC 0000
		call	sub3FCD		; 37BD 940E 3FCD
avr37BF:wdr				; 37BF 95A8
		sbic	PINA, 0	; 37C0 99C8
		rjmp	avr37C6		; 37C1 C004
		in	r16, $36		; 37C2 B706
		sbrs	r16, 2		; 37C3 FF02
		rjmp	avr37BF		; 37C4 CFFA
		rjmp	avr3FB5		; 37C5 C7EF
avr37C6:nop				; 37C6 0000
		lds	r17, 0x04C4		; 37C7 9110 04C4
		lsr	r17			; 37C9 9516
avr37CA:dec	r17			; 37CA 951A
		nop				; 37CB 0000
		nop				; 37CC 0000
		nop				; 37CD 0000
		brne	avr37CA		; 37CE F7D9
		sbis	PINA, 0	; 37CF 9BC8
		rjmp	avr3FB9		; 37D0 C7E8
		nop				; 37D1 0000
		lds	r17, 0x04C4		; 37D2 9110 04C4
		dec	r17			; 37D4 951A
avr37D5:dec	r17			; 37D5 951A
		nop				; 37D6 0000
		nop				; 37D7 0000
		nop				; 37D8 0000
		brne	avr37D5		; 37D9 F7D9
		nop				; 37DA 0000
		clr	r16			; 37DB 2700
		ldi	r18, 0x08		; 37DC E028
avr37DD:nop				; 37DD 0000
		nop				; 37DE 0000
		sec				; 37DF 9408
		sbis	PINA, 0	; 37E0 9BC8
		rjmp	avr37E3		; 37E1 C001
		clc				; 37E2 9488
avr37E3:ror	r16			; 37E3 9507
		nop				; 37E4 0000
		lds	r17, 0x04C4		; 37E5 9110 04C4
		dec	r17			; 37E7 951A
avr37E8:dec	r17			; 37E8 951A
		nop				; 37E9 0000
		nop				; 37EA 0000
		nop				; 37EB 0000
		brne	avr37E8		; 37EC F7D9
		nop				; 37ED 0000
		nop				; 37EE 0000
		dec	r18			; 37EF 952A
		brne	avr37DD		; 37F0 F761
		sbic	PINA, 0	; 37F1 99C8
		rjmp	avr3FBD		; 37F2 C7CA
		nop				; 37F3 0000
		rjmp	avr3FC7		; 37F4 C7D2


avr37F5:nop				; 37F5 0000
		push	r18			; 37F6 932F
		cbi	DDRA, 1	; 37F7 98D1
		sbi	PORTA, 1	; 37F8 9AD9
		sbic	PINA, 1	; 37F9 99C9
		rjmp	avr3FB1		; 37FA C7B6
		nop				; 37FB 0000
		call	sub3FCD		; 37FC 940E 3FCD
avr37FE:wdr				; 37FE 95A8
		sbic	PINA, 1	; 37FF 99C9
		rjmp	avr3805		; 3800 C004
		in	r16, $36		; 3801 B706
		sbrs	r16, 2		; 3802 FF02
		rjmp	avr37FE		; 3803 CFFA
		rjmp	avr3FB5		; 3804 C7B0
avr3805:nop				; 3805 0000
		lds	r17, 0x04C4		; 3806 9110 04C4
		lsr	r17			; 3808 9516
avr3809:dec	r17			; 3809 951A
		nop				; 380A 0000
		nop				; 380B 0000
		nop				; 380C 0000
		brne	avr3809		; 380D F7D9
		sbis	PINA, 1	; 380E 9BC9
		rjmp	avr3FB9		; 380F C7A9
		nop				; 3810 0000
		lds	r17, 0x04C4		; 3811 9110 04C4
		dec	r17			; 3813 951A
avr3814:dec	r17			; 3814 951A
		nop				; 3815 0000
		nop				; 3816 0000
		nop				; 3817 0000
		brne	avr3814		; 3818 F7D9
		nop				; 3819 0000
		clr	r16			; 381A 2700
		ldi	r18, 0x08		; 381B E028
avr381C:nop				; 381C 0000
		nop				; 381D 0000
		sec				; 381E 9408
		sbis	PINA, 1	; 381F 9BC9
		rjmp	avr3822		; 3820 C001
		clc				; 3821 9488
avr3822:ror	r16			; 3822 9507
		nop				; 3823 0000
		lds	r17, 0x04C4		; 3824 9110 04C4
		dec	r17			; 3826 951A
avr3827:dec	r17			; 3827 951A
		nop				; 3828 0000
		nop				; 3829 0000
		nop				; 382A 0000
		brne	avr3827		; 382B F7D9
		nop				; 382C 0000
		nop				; 382D 0000
		dec	r18			; 382E 952A
		brne	avr381C		; 382F F761
		sbic	PINA, 1	; 3830 99C9
		rjmp	avr3FBD		; 3831 C78B
		nop				; 3832 0000
		rjmp	avr3FC7		; 3833 C793

avr3834:nop				; 3834 0000
		push	r18			; 3835 932F
		cbi	DDRA, 2	; 3836 98D2
		sbi	PORTA, 2	; 3837 9ADA
		sbic	PINA, 2	; 3838 99CA
		rjmp	avr3FB1		; 3839 C777
		nop				; 383A 0000
		rcall	sub3FCD		; 383B D791
avr383C:wdr				; 383C 95A8
		sbic	PINA, 2	; 383D 99CA
		rjmp	avr3843		; 383E C004
		in	r16, $36		; 383F B706
		sbrs	r16, 2		; 3840 FF02
		rjmp	avr383C		; 3841 CFFA
		rjmp	avr3FB5		; 3842 C772
avr3843:nop				; 3843 0000
		lds	r17, 0x04C4		; 3844 9110 04C4
		lsr	r17			; 3846 9516
avr3847:dec	r17			; 3847 951A
		nop				; 3848 0000
		nop				; 3849 0000
		nop				; 384A 0000
		brne	avr3847		; 384B F7D9
		sbis	PINA, 2	; 384C 9BCA
		rjmp	avr3FB9		; 384D C76B
		nop				; 384E 0000
		lds	r17, 0x04C4		; 384F 9110 04C4
		dec	r17			; 3851 951A
avr3852:dec	r17			; 3852 951A
		nop				; 3853 0000
		nop				; 3854 0000
		nop				; 3855 0000
		brne	avr3852		; 3856 F7D9
		nop				; 3857 0000
		clr	r16			; 3858 2700
		ldi	r18, 0x08		; 3859 E028
avr385A:nop				; 385A 0000
		nop				; 385B 0000
		sec				; 385C 9408
		sbis	PINA, 2	; 385D 9BCA
		rjmp	avr3860		; 385E C001
		clc				; 385F 9488
avr3860:ror	r16			; 3860 9507
		nop				; 3861 0000
		lds	r17, 0x04C4		; 3862 9110 04C4
		dec	r17			; 3864 951A
avr3865:dec	r17			; 3865 951A
		nop				; 3866 0000
		nop				; 3867 0000
		nop				; 3868 0000
		brne	avr3865		; 3869 F7D9
		nop				; 386A 0000
		nop				; 386B 0000
		dec	r18			; 386C 952A
		brne	avr385A		; 386D F761
		sbic	PINA, 2	; 386E 99CA
		rjmp	avr3FBD		; 386F C74D
		nop				; 3870 0000
		rjmp	avr3FC7		; 3871 C755


avr3872:nop				; 3872 0000
		push	r18			; 3873 932F
		cbi	DDRA, 3	; 3874 98D3
		sbi	PORTA, 3	; 3875 9ADB
		sbic	PINA, 3	; 3876 99CB
		rjmp	avr3FB1		; 3877 C739
		nop				; 3878 0000
		rcall	sub3FCD		; 3879 D753
avr387A:		wdr				; 387A 95A8
		sbic	PINA, 3	; 387B 99CB
		rjmp	avr3881		; 387C C004
		in	r16, $36		; 387D B706
		sbrs	r16, 2		; 387E FF02
		rjmp	avr387A		; 387F CFFA
		rjmp	avr3FB5		; 3880 C734
avr3881:	nop				; 3881 0000
		lds	r17, 0x04C4		; 3882 9110 04C4
		lsr	r17			; 3884 9516
avr3885:	dec	r17			; 3885 951A
		nop				; 3886 0000
		nop				; 3887 0000
		nop				; 3888 0000
		brne	avr3885		; 3889 F7D9
		sbis	PINA, 3	; 388A 9BCB
		rjmp	avr3FB9		; 388B C72D
		nop				; 388C 0000
		lds	r17, 0x04C4		; 388D 9110 04C4
		dec	r17			; 388F 951A
avr3890:	dec	r17			; 3890 951A
		nop				; 3891 0000
		nop				; 3892 0000
		nop				; 3893 0000
		brne	avr3890		; 3894 F7D9
		nop				; 3895 0000
		clr	r16			; 3896 2700
		ldi	r18, 0x08		; 3897 E028
avr3898:	nop				; 3898 0000
		nop				; 3899 0000
		sec				; 389A 9408
		sbis	PINA, 3	; 389B 9BCB
		rjmp	avr389E		; 389C C001
		clc				; 389D 9488
avr389E:	ror	r16			; 389E 9507
		nop				; 389F 0000
		lds	r17, 0x04C4		; 38A0 9110 04C4
		dec	r17			; 38A2 951A
avr38A3:	dec	r17			; 38A3 951A
		nop				; 38A4 0000
		nop				; 38A5 0000
		nop				; 38A6 0000
		brne	avr38A3		; 38A7 F7D9
		nop				; 38A8 0000
		nop				; 38A9 0000
		dec	r18			; 38AA 952A
		brne	avr3898		; 38AB F761
		sbic	PINA, 3	; 38AC 99CB
		rjmp	avr3FBD		; 38AD C70F
		nop				; 38AE 0000
		rjmp	avr3FC7		; 38AF C717

avr38B0:nop				; 38B0 0000
		push	r18			; 38B1 932F
		cbi	DDRA, 4	; 38B2 98D4
		sbi	PORTA, 4	; 38B3 9ADC
		sbic	PINA, 4	; 38B4 99CC
		rjmp	avr3FB1		; 38B5 C6FB
		nop				; 38B6 0000
		rcall	sub3FCD		; 38B7 D715
avr38B8:	wdr				; 38B8 95A8
		sbic	PINA, 4	; 38B9 99CC
		rjmp	avr38BF		; 38BA C004
		in	r16, $36		; 38BB B706
		sbrs	r16, 2		; 38BC FF02
		rjmp	avr38B8		; 38BD CFFA
		rjmp	avr3FB5		; 38BE C6F6
avr38BF:	nop				; 38BF 0000
		lds	r17, 0x04C4		; 38C0 9110 04C4
		lsr	r17			; 38C2 9516
avr38C3:	dec	r17			; 38C3 951A
		nop				; 38C4 0000
		nop				; 38C5 0000
		nop				; 38C6 0000
		brne	avr38C3		; 38C7 F7D9
		sbis	PINA, 4	; 38C8 9BCC
		rjmp	avr3FB9		; 38C9 C6EF
		nop				; 38CA 0000
		lds	r17, 0x04C4		; 38CB 9110 04C4
		dec	r17			; 38CD 951A
avr38CE:	dec	r17			; 38CE 951A
		nop				; 38CF 0000
		nop				; 38D0 0000
		nop				; 38D1 0000
		brne	avr38CE		; 38D2 F7D9
		nop				; 38D3 0000
		clr	r16			; 38D4 2700
		ldi	r18, 0x08		; 38D5 E028
avr38D6:	nop				; 38D6 0000
		nop				; 38D7 0000
		sec				; 38D8 9408
		sbis	PINA, 4	; 38D9 9BCC
		rjmp	avr38DC		; 38DA C001
		clc				; 38DB 9488
avr38DC:	ror	r16			; 38DC 9507
		nop				; 38DD 0000
		lds	r17, 0x04C4		; 38DE 9110 04C4
		dec	r17			; 38E0 951A
avr38E1:	dec	r17			; 38E1 951A
		nop				; 38E2 0000
		nop				; 38E3 0000
		nop				; 38E4 0000
		brne	avr38E1		; 38E5 F7D9
		nop				; 38E6 0000
		nop				; 38E7 0000
		dec	r18			; 38E8 952A
		brne	avr38D6		; 38E9 F761
		sbic	PINA, 4	; 38EA 99CC
		rjmp	avr3FBD		; 38EB C6D1
		nop				; 38EC 0000
		rjmp	avr3FC7		; 38ED C6D9
avr38EE:nop				; 38EE 0000

		push	r18			; 38EF 932F
		cbi	DDRA, 5	; 38F0 98D5
		sbi	PORTA, 5	; 38F1 9ADD
		sbic	PINA, 5	; 38F2 99CD
		rjmp	avr3FB1		; 38F3 C6BD
		nop				; 38F4 0000
		rcall	sub3FCD		; 38F5 D6D7
avr38F6:	wdr				; 38F6 95A8
		sbic	PINA, 5	; 38F7 99CD
		rjmp	avr38FD		; 38F8 C004
		in	r16, $36		; 38F9 B706
		sbrs	r16, 2		; 38FA FF02
		rjmp	avr38F6		; 38FB CFFA
		rjmp	avr3FB5		; 38FC C6B8
avr38FD:	nop				; 38FD 0000
		lds	r17, 0x04C4		; 38FE 9110 04C4
		lsr	r17			; 3900 9516
avr3901:	dec	r17			; 3901 951A
		nop				; 3902 0000
		nop				; 3903 0000
		nop				; 3904 0000
		brne	avr3901		; 3905 F7D9
		sbis	PINA, 5	; 3906 9BCD
		rjmp	avr3FB9		; 3907 C6B1
		nop				; 3908 0000
		lds	r17, 0x04C4		; 3909 9110 04C4
		dec	r17			; 390B 951A
avr390C:	dec	r17			; 390C 951A
		nop				; 390D 0000
		nop				; 390E 0000
		nop				; 390F 0000
		brne	avr390C		; 3910 F7D9
		nop				; 3911 0000
		clr	r16			; 3912 2700
		ldi	r18, 0x08		; 3913 E028
avr3914:	nop				; 3914 0000
		nop				; 3915 0000
		sec				; 3916 9408
		sbis	PINA, 5	; 3917 9BCD
		rjmp	avr391A		; 3918 C001
		clc				; 3919 9488
avr391A:	ror	r16			; 391A 9507
		nop				; 391B 0000
		lds	r17, 0x04C4		; 391C 9110 04C4
		dec	r17			; 391E 951A
avr391F:	dec	r17			; 391F 951A
		nop				; 3920 0000
		nop				; 3921 0000
		nop				; 3922 0000
		brne	avr391F		; 3923 F7D9
		nop				; 3924 0000
		nop				; 3925 0000
		dec	r18			; 3926 952A
		brne	avr3914		; 3927 F761
		sbic	PINA, 5	; 3928 99CD
		rjmp	avr3FBD		; 3929 C693
		nop				; 392A 0000
		rjmp	avr3FC7		; 392B C69B

avr392C:nop				; 392C 0000
		push	r18			; 392D 932F
		cbi	DDRA, 6	; 392E 98D6
		sbi	PORTA, 6	; 392F 9ADE
		sbic	PINA, 6	; 3930 99CE
		rjmp	avr3FB1		; 3931 C67F
		nop			; 3932 0000
		rcall	sub3FCD		; 3933 D699
avr3934:	wdr				; 3934 95A8
		sbic	PINA, 6	; 3935 99CE
		rjmp	avr393B		; 3936 C004
		in	r16, $36		; 3937 B706
		sbrs	r16, 2		; 3938 FF02
		rjmp	avr3934		; 3939 CFFA
		rjmp	avr3FB5		; 393A C67A
avr393B:	nop				; 393B 0000
		lds	r17, 0x04C4		; 393C 9110 04C4
		lsr	r17			; 393E 9516
avr393F:	dec	r17			; 393F 951A
		nop				; 3940 0000
		nop				; 3941 0000
		nop				; 3942 0000
		brne	avr393F		; 3943 F7D9
		sbis	PINA, 6	; 3944 9BCE
		rjmp	avr3FB9		; 3945 C673
		nop				; 3946 0000
		lds	r17, 0x04C4		; 3947 9110 04C4
		dec	r17			; 3949 951A
avr394A:	dec	r17			; 394A 951A
		nop				; 394B 0000
		nop				; 394C 0000
		nop				; 394D 0000
		brne	avr394A		; 394E F7D9
		nop				; 394F 0000
		clr	r16			; 3950 2700
		ldi	r18, 0x08		; 3951 E028
avr3952:	nop				; 3952 0000
		nop				; 3953 0000
		sec				; 3954 9408
		sbis	PINA, 6	; 3955 9BCE
		rjmp	avr3958		; 3956 C001
		clc				; 3957 9488
avr3958:	ror	r16			; 3958 9507
		nop				; 3959 0000
		lds	r17, 0x04C4		; 395A 9110 04C4
		dec	r17			; 395C 951A
avr395D:	dec	r17			; 395D 951A
		nop				; 395E 0000
		nop				; 395F 0000
		nop				; 3960 0000
		brne	avr395D		; 3961 F7D9
		nop				; 3962 0000
		nop				; 3963 0000
		dec	r18			; 3964 952A
		brne	avr3952		; 3965 F761
		sbic	PINA, 6	; 3966 99CE
		rjmp	avr3FBD		; 3967 C655
		nop				; 3968 0000
		rjmp	avr3FC7		; 3969 C65D

avr396A:nop				; 396A 0000
		push	r18			; 396B 932F
		cbi	DDRA, 7	; 396C 98D7
		sbi	PORTA, 7	; 396D 9ADF
		sbic	PINA, 7	; 396E 99CF
		rjmp	avr3FB1		; 396F C641
		nop				; 3970 0000
		rcall	sub3FCD		; 3971 D65B
avr3972:	wdr				; 3972 95A8
		sbic	PINA, 7	; 3973 99CF
		rjmp	avr3979		; 3974 C004
		in	r16, $36		; 3975 B706
		sbrs	r16, 2		; 3976 FF02
		rjmp	avr3972		; 3977 CFFA
		rjmp	avr3FB5		; 3978 C63C
avr3979:	nop				; 3979 0000
		lds	r17, 0x04C4		; 397A 9110 04C4
		lsr	r17			; 397C 9516
avr397D:	dec	r17			; 397D 951A
		nop				; 397E 0000
		nop				; 397F 0000
		nop				; 3980 0000
		brne	avr397D		; 3981 F7D9
		sbis	PINA, 7	; 3982 9BCF
		rjmp	avr3FB9		; 3983 C635
		nop				; 3984 0000
		lds	r17, 0x04C4		; 3985 9110 04C4
		dec	r17			; 3987 951A
avr3988:	dec	r17			; 3988 951A
		nop				; 3989 0000
		nop				; 398A 0000
		nop				; 398B 0000
		brne	avr3988		; 398C F7D9
		nop				; 398D 0000
		clr	r16			; 398E 2700
		ldi	r18, 0x08		; 398F E028
avr3990:	nop				; 3990 0000
		nop				; 3991 0000
		sec				; 3992 9408
		sbis	PINA, 7	; 3993 9BCF
		rjmp	avr3996		; 3994 C001
		clc				; 3995 9488
avr3996:	ror	r16			; 3996 9507
		nop				; 3997 0000
		lds	r17, 0x04C4		; 3998 9110 04C4
		dec	r17			; 399A 951A
avr399B:	dec	r17			; 399B 951A
		nop				; 399C 0000
		nop				; 399D 0000
		nop				; 399E 0000
		brne	avr399B		; 399F F7D9
		nop				; 39A0 0000
		nop				; 39A1 0000
		dec	r18			; 39A2 952A
		brne	avr3990		; 39A3 F761
		sbic	PINA, 7	; 39A4 99CF
		rjmp	avr3FBD		; 39A5 C617
		nop				; 39A6 0000
		rjmp	avr3FC7		; 39A7 C61F

avr39A8:nop				; 39A8 0000
		push	r18			; 39A9 932F
		cbi	DDRB, 0	; 39AA 98B8
		sbi	PORTB, 0	; 39AB 9AC0
		sbic	PINB, 0	; 39AC 99B0
		rjmp	avr3FB1		; 39AD C603
		nop				; 39AE 0000
		rcall	sub3FCD		; 39AF D61D
avr39B0:	wdr				; 39B0 95A8
		sbic	PINB, 0	; 39B1 99B0
		rjmp	avr39B7		; 39B2 C004
		in	r16, $36		; 39B3 B706
		sbrs	r16, 2		; 39B4 FF02
		rjmp	avr39B0		; 39B5 CFFA
		rjmp	avr3FB5		; 39B6 C5FE
avr39B7:	nop				; 39B7 0000
		lds	r17, 0x04C4		; 39B8 9110 04C4
		lsr	r17			; 39BA 9516
avr39BB:	dec	r17			; 39BB 951A
		nop				; 39BC 0000
		nop				; 39BD 0000
		nop				; 39BE 0000
		brne	avr39BB		; 39BF F7D9
		sbis	PINB, 0	; 39C0 9BB0
		rjmp	avr3FB9		; 39C1 C5F7
		nop				; 39C2 0000
		lds	r17, 0x04C4		; 39C3 9110 04C4
		dec	r17			; 39C5 951A
avr39C6:	dec	r17			; 39C6 951A
		nop				; 39C7 0000
		nop				; 39C8 0000
		nop				; 39C9 0000
		brne	avr39C6		; 39CA F7D9
		nop				; 39CB 0000
		clr	r16			; 39CC 2700
		ldi	r18, 0x08		; 39CD E028
avr39CE:	nop				; 39CE 0000
		nop				; 39CF 0000
		sec				; 39D0 9408
		sbis	PINB, 0	; 39D1 9BB0
		rjmp	avr39D4		; 39D2 C001
		clc				; 39D3 9488
avr39D4:	ror	r16			; 39D4 9507
		nop				; 39D5 0000
		lds	r17, 0x04C4		; 39D6 9110 04C4
		dec	r17			; 39D8 951A
avr39D9:	dec	r17			; 39D9 951A
		nop				; 39DA 0000
		nop				; 39DB 0000
		nop				; 39DC 0000
		brne	avr39D9		; 39DD F7D9
		nop				; 39DE 0000
		nop				; 39DF 0000
		dec	r18			; 39E0 952A
		brne	avr39CE		; 39E1 F761
		sbic	PINB, 0	; 39E2 99B0
		rjmp	avr3FBD		; 39E3 C5D9
		nop				; 39E4 0000
		rjmp	avr3FC7		; 39E5 C5E1

avr39E6:nop				; 39E6 0000
		push	r18			; 39E7 932F
		cbi	DDRB, 1	; 39E8 98B9
		sbi	PORTB, 1	; 39E9 9AC1
		sbic	PINB, 1	; 39EA 99B1
		rjmp	avr3FB1		; 39EB C5C5
		nop				; 39EC 0000
		rcall	sub3FCD		; 39ED D5DF
avr39EE:	wdr				; 39EE 95A8
		sbic	PINB, 1	; 39EF 99B1
		rjmp	avr39F5		; 39F0 C004
		in	r16, $36		; 39F1 B706
		sbrs	r16, 2		; 39F2 FF02
		rjmp	avr39EE		; 39F3 CFFA
		rjmp	avr3FB5		; 39F4 C5C0
avr39F5:	nop				; 39F5 0000
		lds	r17, 0x04C4		; 39F6 9110 04C4
		lsr	r17			; 39F8 9516
avr39F9:	dec	r17			; 39F9 951A
		nop				; 39FA 0000
		nop				; 39FB 0000
		nop				; 39FC 0000
		brne	avr39F9		; 39FD F7D9
		sbis	PINB, 1	; 39FE 9BB1
		rjmp	avr3FB9		; 39FF C5B9
		nop				; 3A00 0000
		lds	r17, 0x04C4		; 3A01 9110 04C4
		dec	r17			; 3A03 951A
avr3A04:	dec	r17			; 3A04 951A
		nop				; 3A05 0000
		nop				; 3A06 0000
		nop				; 3A07 0000
		brne	avr3A04		; 3A08 F7D9
		nop				; 3A09 0000
		clr	r16			; 3A0A 2700
		ldi	r18, 0x08		; 3A0B E028
avr3A0c:	nop				; 3A0C 0000
		nop				; 3A0D 0000
		sec				; 3A0E 9408
		sbis	PINB, 1	; 3A0F 9BB1
		rjmp	avr3A12		; 3A10 C001
		clc				; 3A11 9488
avr3A12:	ror	r16			; 3A12 9507
		nop				; 3A13 0000
		lds	r17, 0x04C4		; 3A14 9110 04C4
		dec	r17			; 3A16 951A
avr3A17:	dec	r17			; 3A17 951A
		nop				; 3A18 0000
		nop				; 3A19 0000
		nop				; 3A1A 0000
		brne	avr3A17		; 3A1B F7D9
		nop				; 3A1C 0000
		nop				; 3A1D 0000
		dec	r18			; 3A1E 952A
		brne	avr3A0C		; 3A1F F761
		sbic	PINB, 1	; 3A20 99B1
		rjmp	avr3FBD		; 3A21 C59B
		nop				; 3A22 0000
		rjmp	avr3FC7		; 3A23 C5A3

avr3A24:nop				; 3A24 0000
		push	r18			; 3A25 932F
		cbi	DDRB, 2	; 3A26 98BA
		sbi	PORTB, 2	; 3A27 9AC2
		sbic	PINB, 2	; 3A28 99B2
		rjmp	avr3FB1		; 3A29 C587
		nop				; 3A2A 0000
		rcall	sub3FCD		; 3A2B D5A1
avr3A2C:	wdr				; 3A2C 95A8
		sbic	PINB, 2	; 3A2D 99B2
		rjmp	avr3A33		; 3A2E C004
		in	r16, $36		; 3A2F B706
		sbrs	r16, 2		; 3A30 FF02
		rjmp	avr3A2C		; 3A31 CFFA
		rjmp	avr3FB5		; 3A32 C582
avr3A33:	nop				; 3A33 0000
		lds	r17, 0x04C4		; 3A34 9110 04C4
		lsr	r17			; 3A36 9516
avr3A37:	dec	r17			; 3A37 951A
		nop				; 3A38 0000
		nop				; 3A39 0000
		nop				; 3A3A 0000
		brne	avr3A37		; 3A3B F7D9
		sbis	PINB, 2	; 3A3C 9BB2
		rjmp	avr3FB9		; 3A3D C57B
		nop				; 3A3E 0000
		lds	r17, 0x04C4		; 3A3F 9110 04C4
		dec	r17			; 3A41 951A
avr3A42:	dec	r17			; 3A42 951A
		nop				; 3A43 0000
		nop				; 3A44 0000
		nop				; 3A45 0000
		brne	avr3A42		; 3A46 F7D9
		nop				; 3A47 0000
		clr	r16			; 3A48 2700
		ldi	r18, 0x08		; 3A49 E028
avr3A4A:	nop				; 3A4A 0000
		nop				; 3A4B 0000
		sec				; 3A4C 9408
		sbis	PINB, 2	; 3A4D 9BB2
		rjmp	avr3A50		; 3A4E C001
		clc				; 3A4F 9488
avr3A50:	ror	r16			; 3A50 9507
		nop				; 3A51 0000
		lds	r17, 0x04C4		; 3A52 9110 04C4
		dec	r17			; 3A54 951A
avr3A55:	dec	r17			; 3A55 951A
		nop				; 3A56 0000
		nop				; 3A57 0000
		nop				; 3A58 0000
		brne	avr3A55		; 3A59 F7D9
		nop				; 3A5A 0000
		nop				; 3A5B 0000
		dec	r18			; 3A5C 952A
		brne	avr3A4A		; 3A5D F761
		sbic	PINB, 2	; 3A5E 99B2
		rjmp	avr3FBD		; 3A5F C55D
		nop				; 3A60 0000
		rjmp	avr3FC7		; 3A61 C565

avr3A62:nop				; 3A62 0000
		push	r18			; 3A63 932F
		cbi	DDRB, 3	; 3A64 98BB
		sbi	PORTB, 3	; 3A65 9AC3
		sbic	PINB, 3	; 3A66 99B3
		rjmp	avr3FB1		; 3A67 C549
		nop				; 3A68 0000
		rcall	sub3FCD		; 3A69 D563
avr3A6A:	wdr				; 3A6A 95A8
		sbic	PINB, 3	; 3A6B 99B3
		rjmp	avr3A71		; 3A6C C004
		in	r16, $36		; 3A6D B706
		sbrs	r16, 2		; 3A6E FF02
		rjmp	avr3A6A		; 3A6F CFFA
		rjmp	avr3FB5		; 3A70 C544
avr3A71:	nop				; 3A71 0000
		lds	r17, 0x04C4		; 3A72 9110 04C4
		lsr	r17			; 3A74 9516
avr3A75:	dec	r17			; 3A75 951A
		nop				; 3A76 0000
		nop				; 3A77 0000
		nop				; 3A78 0000
		brne	avr3A75		; 3A79 F7D9
		sbis	PINB, 3	; 3A7A 9BB3
		rjmp	avr3FB9		; 3A7B C53D
		nop				; 3A7C 0000
		lds	r17, 0x04C4		; 3A7D 9110 04C4
		dec	r17			; 3A7F 951A
avr3A80:	dec	r17			; 3A80 951A
		nop				; 3A81 0000
		nop				; 3A82 0000
		nop				; 3A83 0000
		brne	avr3A80		; 3A84 F7D9
		nop				; 3A85 0000
		clr	r16			; 3A86 2700
		ldi	r18, 0x08		; 3A87 E028
avr3A88:	nop				; 3A88 0000
		nop				; 3A89 0000
		sec				; 3A8A 9408
		sbis	PINB, 3	; 3A8B 9BB3
		rjmp	avr3A8E		; 3A8C C001
		clc				; 3A8D 9488
avr3A8E:	ror	r16			; 3A8E 9507
		nop				; 3A8F 0000
		lds	r17, 0x04C4		; 3A90 9110 04C4
		dec	r17			; 3A92 951A
avr3A93:	dec	r17			; 3A93 951A
		nop				; 3A94 0000
		nop				; 3A95 0000
		nop				; 3A96 0000
		brne	avr3A93		; 3A97 F7D9
		nop				; 3A98 0000
		nop				; 3A99 0000
		dec	r18			; 3A9A 952A
		brne	avr3A88		; 3A9B F761
		sbic	PINB, 3	; 3A9C 99B3
		rjmp	avr3FBD		; 3A9D C51F
		nop				; 3A9E 0000
		rjmp	avr3FC7		; 3A9F C527

avr3AA0:nop				; 3AA0 0000
		push	r18			; 3AA1 932F
		cbi	DDRB, 4	; 3AA2 98BC
		sbi	PORTB, 4	; 3AA3 9AC4
		sbic	PINB, 4	; 3AA4 99B4
		rjmp	avr3FB1		; 3AA5 C50B
		nop				; 3AA6 0000
		rcall	sub3FCD		; 3AA7 D525
avr3AA8:	wdr				; 3AA8 95A8
		sbic	PINB, 4	; 3AA9 99B4
		rjmp	avr3AAF		; 3AAA C004
		in	r16, $36		; 3AAB B706
		sbrs	r16, 2		; 3AAC FF02
		rjmp	avr3AA8		; 3AAD CFFA
		rjmp	avr3FB5		; 3AAE C506
avr3AAF:	nop				; 3AAF 0000
		lds	r17, 0x04C4		; 3AB0 9110 04C4
		lsr	r17			; 3AB2 9516
avr3AB3:	dec	r17			; 3AB3 951A
		nop				; 3AB4 0000
		nop				; 3AB5 0000
		nop				; 3AB6 0000
		brne	avr3AB3		; 3AB7 F7D9
		sbis	PINB, 4	; 3AB8 9BB4
		rjmp	avr3FB9		; 3AB9 C4FF
		nop				; 3ABA 0000
		lds	r17, 0x04C4		; 3ABB 9110 04C4
		dec	r17			; 3ABD 951A
avr3ABE:	dec	r17			; 3ABE 951A
		nop				; 3ABF 0000
		nop				; 3AC0 0000
		nop				; 3AC1 0000
		brne	avr3ABE		; 3AC2 F7D9
		nop				; 3AC3 0000
		clr	r16			; 3AC4 2700
		ldi	r18, 0x08		; 3AC5 E028
avr3AC6:		nop				; 3AC6 0000
		nop				; 3AC7 0000
		sec				; 3AC8 9408
		sbis	PINB, 4	; 3AC9 9BB4
		rjmp	avr3ACC		; 3ACA C001
		clc				; 3ACB 9488
avr3ACC:	ror	r16			; 3ACC 9507
		nop				; 3ACD 0000
		lds	r17, 0x04C4		; 3ACE 9110 04C4
		dec	r17			; 3AD0 951A
avr3AD1:	dec	r17			; 3AD1 951A
		nop				; 3AD2 0000
		nop				; 3AD3 0000
		nop				; 3AD4 0000
		brne	avr3AD1		; 3AD5 F7D9
		nop				; 3AD6 0000
		nop				; 3AD7 0000
		dec	r18			; 3AD8 952A
		brne	avr3AC6		; 3AD9 F761
		sbic	PINB, 4	; 3ADA 99B4
		rjmp	avr3FBD		; 3ADB C4E1
		nop				; 3ADC 0000
		rjmp	avr3FC7		; 3ADD C4E9

avr3ADE:nop				; 3ADE 0000
		push	r18			; 3ADF 932F
		cbi	DDRB, 5	; 3AE0 98BD
		sbi	PORTB, 5	; 3AE1 9AC5
		sbic	PINB, 5	; 3AE2 99B5
		rjmp	avr3FB1		; 3AE3 C4CD
		nop				; 3AE4 0000
		rcall	sub3FCD		; 3AE5 D4E7
avr3AE6:	wdr				; 3AE6 95A8
		sbic	PINB, 5	; 3AE7 99B5
		rjmp	avr3AED		; 3AE8 C004
		in	r16, $36		; 3AE9 B706
		sbrs	r16, 2		; 3AEA FF02
		rjmp	avr3AE6		; 3AEB CFFA
		rjmp	avr3FB5		; 3AEC C4C8
avr3AED:	nop				; 3AED 0000
		lds	r17, 0x04C4		; 3AEE 9110 04C4
		lsr	r17			; 3AF0 9516
avr3AF1:	dec	r17			; 3AF1 951A
		nop				; 3AF2 0000
		nop				; 3AF3 0000
		nop				; 3AF4 0000
		brne	avr3AF1		; 3AF5 F7D9
		sbis	PINB, 5	; 3AF6 9BB5
		rjmp	avr3FB9		; 3AF7 C4C1
		nop				; 3AF8 0000
		lds	r17, 0x04C4		; 3AF9 9110 04C4
		dec	r17			; 3AFB 951A
avr3AFC:	dec	r17			; 3AFC 951A
		nop				; 3AFD 0000
		nop				; 3AFE 0000
		nop				; 3AFF 0000
		brne	avr3AFC		; 3B00 F7D9
		nop				; 3B01 0000
		clr	r16			; 3B02 2700
		ldi	r18, 0x08		; 3B03 E028
avr3B04:	nop				; 3B04 0000
		nop				; 3B05 0000
		sec				; 3B06 9408
		sbis	PINB, 5	; 3B07 9BB5
		rjmp	avr3B0A		; 3B08 C001
		clc				; 3B09 9488
avr3B0A:	ror	r16			; 3B0A 9507
		nop				; 3B0B 0000
		lds	r17, 0x04C4		; 3B0C 9110 04C4
		dec	r17			; 3B0E 951A
avr3B0F:	dec	r17			; 3B0F 951A
		nop				; 3B10 0000
		nop				; 3B11 0000
		nop				; 3B12 0000
		brne	avr3B0F		; 3B13 F7D9
		nop				; 3B14 0000
		nop				; 3B15 0000
		dec	r18			; 3B16 952A
		brne	avr3B04		; 3B17 F761
		sbic	PINB, 5	; 3B18 99B5
		rjmp	avr3FBD		; 3B19 C4A3
		nop				; 3B1A 0000
		rjmp	avr3FC7		; 3B1B C4AB

avr3B1C:nop				; 3B1C 0000
		push	r18			; 3B1D 932F
		cbi	DDRB, 6	; 3B1E 98BE
		sbi	PORTB, 6	; 3B1F 9AC6
		sbic	PINB, 6	; 3B20 99B6
		rjmp	avr3FB1		; 3B21 C48F
		nop				; 3B22 0000
		rcall	sub3FCD		; 3B23 D4A9
avr3B24:	wdr				; 3B24 95A8
		sbic	PINB, 6	; 3B25 99B6
		rjmp	avr3B2B		; 3B26 C004
		in	r16, $36		; 3B27 B706
		sbrs	r16, 2		; 3B28 FF02
		rjmp	avr3B24		; 3B29 CFFA
		rjmp	avr3FB5		; 3B2A C48A
avr3B2B:	nop				; 3B2B 0000
		lds	r17, 0x04C4		; 3B2C 9110 04C4
		lsr	r17			; 3B2E 9516
avr3B2F:	dec	r17			; 3B2F 951A
		nop				; 3B30 0000
		nop				; 3B31 0000
		nop				; 3B32 0000
		brne	avr3B2F		; 3B33 F7D9
		sbis	PINB, 6	; 3B34 9BB6
		rjmp	avr3FB9		; 3B35 C483
		nop				; 3B36 0000
		lds	r17, 0x04C4		; 3B37 9110 04C4
		dec	r17			; 3B39 951A
avr3B3A:	dec	r17			; 3B3A 951A
		nop				; 3B3B 0000
		nop				; 3B3C 0000
		nop				; 3B3D 0000
		brne	avr3B3A		; 3B3E F7D9
		nop				; 3B3F 0000
		clr	r16			; 3B40 2700
		ldi	r18, 0x08		; 3B41 E028
avr3B42:	nop				; 3B42 0000
		nop				; 3B43 0000
		sec				; 3B44 9408
		sbis	PINB, 6	; 3B45 9BB6
		rjmp	avr3B48		; 3B46 C001
		clc				; 3B47 9488
avr3B48:	ror	r16			; 3B48 9507
		nop				; 3B49 0000
		lds	r17, 0x04C4		; 3B4A 9110 04C4
		dec	r17			; 3B4C 951A
avr3B4D:	dec	r17			; 3B4D 951A
		nop				; 3B4E 0000
		nop				; 3B4F 0000
		nop				; 3B50 0000
		brne	avr3B4D		; 3B51 F7D9
		nop				; 3B52 0000
		nop				; 3B53 0000
		dec	r18			; 3B54 952A
		brne	avr3B42		; 3B55 F761
		sbic	PINB, 6	; 3B56 99B6
		rjmp	avr3FBD		; 3B57 C465
		nop				; 3B58 0000
		rjmp	avr3FC7		; 3B59 C46D

avr3B5A:nop				; 3B5A 0000
		push	r18			; 3B5B 932F
		cbi	DDRB, 7	; 3B5C 98BF
		sbi	PORTB, 7	; 3B5D 9AC7
		sbic	PINB, 7	; 3B5E 99B7
		rjmp	avr3FB1		; 3B5F C451
		nop				; 3B60 0000
		rcall	sub3FCD		; 3B61 D46B
avr3B62:	wdr				; 3B62 95A8
		sbic	PINB, 7	; 3B63 99B7
		rjmp	avr3B69		; 3B64 C004
		in	r16, $36		; 3B65 B706
		sbrs	r16, 2		; 3B66 FF02
		rjmp	avr3B62		; 3B67 CFFA
		rjmp	avr3FB5		; 3B68 C44C
avr3B69:	nop				; 3B69 0000
		lds	r17, 0x04C4		; 3B6A 9110 04C4
		lsr	r17			; 3B6C 9516
avr3B6D:	dec	r17			; 3B6D 951A
		nop				; 3B6E 0000
		nop				; 3B6F 0000
		nop				; 3B70 0000
		brne	avr3B6D		; 3B71 F7D9
		sbis	PINB, 7	; 3B72 9BB7
		rjmp	avr3FB9		; 3B73 C445
		nop				; 3B74 0000
		lds	r17, 0x04C4		; 3B75 9110 04C4
		dec	r17			; 3B77 951A
avr3B78:	dec	r17			; 3B78 951A
		nop				; 3B79 0000
		nop				; 3B7A 0000
		nop				; 3B7B 0000
		brne	avr3B78		; 3B7C F7D9
		nop				; 3B7D 0000
		clr	r16			; 3B7E 2700
		ldi	r18, 0x08		; 3B7F E028
avr3B80:	nop				; 3B80 0000
		nop				; 3B81 0000
		sec				; 3B82 9408
		sbis	PINB, 7	; 3B83 9BB7
		rjmp	avr3B86		; 3B84 C001
		clc				; 3B85 9488
avr3B86:	ror	r16			; 3B86 9507
		nop				; 3B87 0000
		lds	r17, 0x04C4		; 3B88 9110 04C4
		dec	r17			; 3B8A 951A
avr3B8B:	dec	r17			; 3B8B 951A
		nop				; 3B8C 0000
		nop				; 3B8D 0000
		nop				; 3B8E 0000
		brne	avr3B8B		; 3B8F F7D9
		nop				; 3B90 0000
		nop				; 3B91 0000
		dec	r18			; 3B92 952A
		brne	avr3B80		; 3B93 F761
		sbic	PINB, 7	; 3B94 99B7
		rjmp	avr3FBD		; 3B95 C427
		nop				; 3B96 0000
		rjmp	avr3FC7		; 3B97 C42F

avr3B98:nop				; 3B98 0000
		push	r18			; 3B99 932F
		cbi	DDRC, 7	; 3B9A 98A7
		sbi	PORTC, 7	; 3B9B 9AAF
		sbic	PINC, 7	; 3B9C 999F
		rjmp	avr3FB1		; 3B9D C413
		nop				; 3B9E 0000
		rcall	sub3FCD		; 3B9F D42D
avr3BA0:	wdr				; 3BA0 95A8
		sbic	PINC, 7	; 3BA1 999F
		rjmp	avr3BA7		; 3BA2 C004
		in	r16, $36		; 3BA3 B706
		sbrs	r16, 2		; 3BA4 FF02
		rjmp	avr3BA0		; 3BA5 CFFA
		rjmp	avr3FB5		; 3BA6 C40E
avr3BA7:	nop				; 3BA7 0000
		lds	r17, 0x04C4		; 3BA8 9110 04C4
		lsr	r17			; 3BAA 9516
avr3BAB:	dec	r17			; 3BAB 951A
		nop				; 3BAC 0000
		nop				; 3BAD 0000
		nop				; 3BAE 0000
		brne	avr3BAB		; 3BAF F7D9
		sbis	PINC, 7	; 3BB0 9B9F
		rjmp	avr3FB9		; 3BB1 C407
		nop				; 3BB2 0000
		lds	r17, 0x04C4		; 3BB3 9110 04C4
		dec	r17			; 3BB5 951A
avr3BB6:	dec	r17			; 3BB6 951A
		nop				; 3BB7 0000
		nop				; 3BB8 0000
		nop				; 3BB9 0000
		brne	avr3BB6		; 3BBA F7D9
		nop				; 3BBB 0000
		clr	r16			; 3BBC 2700
		ldi	r18, 0x08		; 3BBD E028
avr3BBE:	nop				; 3BBE 0000
		nop				; 3BBF 0000
		sec				; 3BC0 9408
		sbis	PINC, 7	; 3BC1 9B9F
		rjmp	avr3BC4		; 3BC2 C001
		clc				; 3BC3 9488
avr3BC4:	ror	r16			; 3BC4 9507
		nop				; 3BC5 0000
		lds	r17, 0x04C4		; 3BC6 9110 04C4
		dec	r17			; 3BC8 951A
avr3BC9:	dec	r17			; 3BC9 951A
		nop				; 3BCA 0000
		nop				; 3BCB 0000
		nop				; 3BCC 0000
		brne	avr3BC9		; 3BCD F7D9
		nop				; 3BCE 0000
		nop				; 3BCF 0000
		dec	r18			; 3BD0 952A
		brne	avr3BBE		; 3BD1 F761
		sbic	PINC, 7	; 3BD2 999F
		rjmp	avr3FBD		; 3BD3 C3E9
		nop				; 3BD4 0000
		rjmp	avr3FC7		; 3BD5 C3F1

avr3BD6:nop				; 3BD6 0000
		push	r18			; 3BD7 932F
		cbi	DDRC, 6	; 3BD8 98A6
		sbi	PORTC, 6	; 3BD9 9AAE
		sbic	PINC, 6	; 3BDA 999E
		rjmp	avr3FB1		; 3BDB C3D5
		nop				; 3BDC 0000
		rcall	sub3FCD		; 3BDD D3EF
avr3BDE:	wdr				; 3BDE 95A8
		sbic	PINC, 6	; 3BDF 999E
		rjmp	avr3BE5		; 3BE0 C004
		in	r16, $36		; 3BE1 B706
		sbrs	r16, 2		; 3BE2 FF02
		rjmp	avr3BDE		; 3BE3 CFFA
		rjmp	avr3FB5		; 3BE4 C3D0
avr3BE5:	nop				; 3BE5 0000
		lds	r17, 0x04C4		; 3BE6 9110 04C4
		lsr	r17			; 3BE8 9516
avr3BE9:	dec	r17			; 3BE9 951A
		nop				; 3BEA 0000
		nop				; 3BEB 0000
		nop				; 3BEC 0000
		brne	avr3BE9		; 3BED F7D9
		sbis	PINC, 6	; 3BEE 9B9E
		rjmp	avr3FB9		; 3BEF C3C9
		nop				; 3BF0 0000
		lds	r17, 0x04C4		; 3BF1 9110 04C4
		dec	r17			; 3BF3 951A
avr3BF4:	dec	r17			; 3BF4 951A
		nop				; 3BF5 0000
		nop				; 3BF6 0000
		nop				; 3BF7 0000
		brne	avr3BF4		; 3BF8 F7D9
		nop				; 3BF9 0000
		clr	r16			; 3BFA 2700
		ldi	r18, 0x08		; 3BFB E028
avr3BFC:	nop				; 3BFC 0000
		nop				; 3BFD 0000
		sec				; 3BFE 9408
		sbis	PINC, 6	; 3BFF 9B9E
		rjmp	avr3C02		; 3C00 C001
		clc				; 3C01 9488
avr3C02:	ror	r16			; 3C02 9507
		nop				; 3C03 0000
		lds	r17, 0x04C4		; 3C04 9110 04C4
		dec	r17			; 3C06 951A
avr3C07:	dec	r17			; 3C07 951A
		nop				; 3C08 0000
		nop				; 3C09 0000
		nop				; 3C0A 0000
		brne	avr3C07		; 3C0B F7D9
		nop				; 3C0C 0000
		nop				; 3C0D 0000
		dec	r18			; 3C0E 952A
		brne	avr3BFC		; 3C0F F761
		sbic	PINC, 6	; 3C10 999E
		rjmp	avr3FBD		; 3C11 C3AB
		nop				; 3C12 0000
		rjmp	avr3FC7		; 3C13 C3B3

avr3C14:nop				; 3C14 0000
		push	r18			; 3C15 932F
		cbi	DDRC, 5	; 3C16 98A5
		sbi	PORTC, 5	; 3C17 9AAD
		sbic	PINC, 5	; 3C18 999D
		rjmp	avr3FB1		; 3C19 C397
		nop				; 3C1A 0000
		rcall	sub3FCD		; 3C1B D3B1
avr3C1C:	wdr				; 3C1C 95A8
		sbic	PINC, 5	; 3C1D 999D
		rjmp	avr3C23		; 3C1E C004
		in	r16, $36		; 3C1F B706
		sbrs	r16, 2		; 3C20 FF02
		rjmp	avr3C1C		; 3C21 CFFA
		rjmp	avr3FB5		; 3C22 C392
avr3C23:	nop				; 3C23 0000
		lds	r17, 0x04C4		; 3C24 9110 04C4
		lsr	r17			; 3C26 9516
avr3C27:	dec	r17			; 3C27 951A
		nop				; 3C28 0000
		nop				; 3C29 0000
		nop				; 3C2A 0000
		brne	avr3C27		; 3C2B F7D9
		sbis	PINC, 5	; 3C2C 9B9D
		rjmp	avr3FB9		; 3C2D C38B
		nop				; 3C2E 0000
		lds	r17, 0x04C4		; 3C2F 9110 04C4
		dec	r17			; 3C31 951A
avr3C32:	dec	r17			; 3C32 951A
		nop				; 3C33 0000
		nop				; 3C34 0000
		nop				; 3C35 0000
		brne	avr3C32		; 3C36 F7D9
		nop				; 3C37 0000
		clr	r16			; 3C38 2700
		ldi	r18, 0x08		; 3C39 E028
avr3C3A:	nop				; 3C3A 0000
		nop				; 3C3B 0000
		sec				; 3C3C 9408
		sbis	PINC, 5	; 3C3D 9B9D
		rjmp	avr3C40		; 3C3E C001
		clc				; 3C3F 9488
avr3C40:	ror	r16			; 3C40 9507
		nop				; 3C41 0000
		lds	r17, 0x04C4		; 3C42 9110 04C4
		dec	r17			; 3C44 951A
avr3C45:	dec	r17			; 3C45 951A
		nop				; 3C46 0000
		nop				; 3C47 0000
		nop				; 3C48 0000
		brne	avr3C45		; 3C49 F7D9
		nop				; 3C4A 0000
		nop				; 3C4B 0000
		dec	r18			; 3C4C 952A
		brne	avr3C3A		; 3C4D F761
		sbic	PINC, 5	; 3C4E 999D
		rjmp	avr3FBD		; 3C4F C36D
		nop				; 3C50 0000
		rjmp	avr3FC7		; 3C51 C375

avr3C52:nop				; 3C52 0000
		push	r18			; 3C53 932F
		cbi	DDRC, 4	; 3C54 98A4
		sbi	PORTC, 4	; 3C55 9AAC
		sbic	PINC, 4	; 3C56 999C
		rjmp	avr3FB1		; 3C57 C359
		nop				; 3C58 0000
		rcall	sub3FCD		; 3C59 D373
avr3C5A:	wdr				; 3C5A 95A8
		sbic	PINC, 4	; 3C5B 999C
		rjmp	avr3C61		; 3C5C C004
		in	r16, $36		; 3C5D B706
		sbrs	r16, 2		; 3C5E FF02
		rjmp	avr3C5A		; 3C5F CFFA
		rjmp	avr3FB5		; 3C60 C354
avr3C61:	nop				; 3C61 0000
		lds	r17, 0x04C4		; 3C62 9110 04C4
		lsr	r17			; 3C64 9516
avr3C65:	dec	r17			; 3C65 951A
		nop				; 3C66 0000
		nop				; 3C67 0000
		nop				; 3C68 0000
		brne	avr3C65		; 3C69 F7D9
		sbis	PINC, 4	; 3C6A 9B9C
		rjmp	avr3FB9		; 3C6B C34D
		nop				; 3C6C 0000
		lds	r17, 0x04C4		; 3C6D 9110 04C4
		dec	r17			; 3C6F 951A
avr3C70:	dec	r17			; 3C70 951A
		nop				; 3C71 0000
		nop				; 3C72 0000
		nop				; 3C73 0000
		brne	avr3C70		; 3C74 F7D9
		nop				; 3C75 0000
		clr	r16			; 3C76 2700
		ldi	r18, 0x08		; 3C77 E028
avr3C78:	nop				; 3C78 0000
		nop				; 3C79 0000
		sec				; 3C7A 9408
		sbis	PINC, 4	; 3C7B 9B9C
		rjmp	avr3C7E		; 3C7C C001
		clc				; 3C7D 9488
avr3C7E:	ror	r16			; 3C7E 9507
		nop				; 3C7F 0000
		lds	r17, 0x04C4		; 3C80 9110 04C4
		dec	r17			; 3C82 951A
avr3C83:	dec	r17			; 3C83 951A
		nop				; 3C84 0000
		nop				; 3C85 0000
		nop				; 3C86 0000
		brne	avr3C83		; 3C87 F7D9
		nop				; 3C88 0000
		nop				; 3C89 0000
		dec	r18			; 3C8A 952A
		brne	avr3C78		; 3C8B F761
		sbic	PINC, 4	; 3C8C 999C
		rjmp	avr3FBD		; 3C8D C32F
		nop				; 3C8E 0000
		rjmp	avr3FC7		; 3C8F C337

avr3C90:nop				; 3C90 0000
		push	r18			; 3C91 932F
		cbi	DDRC, 3	; 3C92 98A3
		sbi	PORTC, 3	; 3C93 9AAB
		sbic	PINC, 3	; 3C94 999B
		rjmp	avr3FB1		; 3C95 C31B
		nop				; 3C96 0000
		rcall	sub3FCD		; 3C97 D335
avr3C98:	wdr				; 3C98 95A8
		sbic	PINC, 3	; 3C99 999B
		rjmp	avr3C9F		; 3C9A C004
		in	r16, $36		; 3C9B B706
		sbrs	r16, 2		; 3C9C FF02
		rjmp	avr3C98		; 3C9D CFFA
		rjmp	avr3FB5		; 3C9E C316
avr3C9F:	nop				; 3C9F 0000
		lds	r17, 0x04C4		; 3CA0 9110 04C4
		lsr	r17			; 3CA2 9516
avr3CA3:	dec	r17			; 3CA3 951A
		nop				; 3CA4 0000
		nop				; 3CA5 0000
		nop				; 3CA6 0000
		brne	avr3CA3		; 3CA7 F7D9
		sbis	PINC, 3	; 3CA8 9B9B
		rjmp	avr3FB9		; 3CA9 C30F
		nop				; 3CAA 0000
		lds	r17, 0x04C4		; 3CAB 9110 04C4
		dec	r17			; 3CAD 951A
avr3CAE:	dec	r17			; 3CAE 951A
		nop				; 3CAF 0000
		nop				; 3CB0 0000
		nop				; 3CB1 0000
		brne	avr3CAE		; 3CB2 F7D9
		nop				; 3CB3 0000
		clr	r16			; 3CB4 2700
		ldi	r18, 0x08		; 3CB5 E028
avr3CB6:	nop				; 3CB6 0000
		nop				; 3CB7 0000
		sec				; 3CB8 9408
		sbis	PINC, 3	; 3CB9 9B9B
		rjmp	avr3CBC		; 3CBA C001
		clc				; 3CBB 9488
avr3CBC:	ror	r16			; 3CBC 9507
		nop				; 3CBD 0000
		lds	r17, 0x04C4		; 3CBE 9110 04C4
		dec	r17			; 3CC0 951A
avr3CC1:	dec	r17			; 3CC1 951A
		nop				; 3CC2 0000
		nop				; 3CC3 0000
		nop				; 3CC4 0000
		brne	avr3CC1		; 3CC5 F7D9
		nop				; 3CC6 0000
		nop				; 3CC7 0000
		dec	r18			; 3CC8 952A
		brne	avr3CB6		; 3CC9 F761
		sbic	PINC, 3	; 3CCA 999B
		rjmp	avr3FBD		; 3CCB C2F1
		nop				; 3CCC 0000
		rjmp	avr3FC7		; 3CCD C2F9

avr3CCE:nop				; 3CCE 0000
		push	r18			; 3CCF 932F
		cbi	DDRC, 2	; 3CD0 98A2
		sbi	PORTC, 2	; 3CD1 9AAA
		sbic	PINC, 2	; 3CD2 999A
		rjmp	avr3FB1		; 3CD3 C2DD
		nop				; 3CD4 0000
		rcall	sub3FCD		; 3CD5 D2F7
avr3CD6:	wdr				; 3CD6 95A8
		sbic	PINC, 2	; 3CD7 999A
		rjmp	avr3CDD		; 3CD8 C004
		in	r16, $36		; 3CD9 B706
		sbrs	r16, 2		; 3CDA FF02
		rjmp	avr3CD6		; 3CDB CFFA
		rjmp	avr3FB5		; 3CDC C2D8
avr3CDD:	nop				; 3CDD 0000
		lds	r17, 0x04C4		; 3CDE 9110 04C4
		lsr	r17			; 3CE0 9516
avr3CE1:	dec	r17			; 3CE1 951A
		nop				; 3CE2 0000
		nop				; 3CE3 0000
		nop				; 3CE4 0000
		brne	avr3CE1		; 3CE5 F7D9
		sbis	PINC, 2	; 3CE6 9B9A
		rjmp	avr3FB9		; 3CE7 C2D1
		nop				; 3CE8 0000
		lds	r17, 0x04C4		; 3CE9 9110 04C4
		dec	r17			; 3CEB 951A
avr3CEC:	dec	r17			; 3CEC 951A
		nop				; 3CED 0000
		nop				; 3CEE 0000
		nop				; 3CEF 0000
		brne	avr3CEC		; 3CF0 F7D9
		nop				; 3CF1 0000
		clr	r16			; 3CF2 2700
		ldi	r18, 0x08		; 3CF3 E028
avr3CF4:	nop				; 3CF4 0000
		nop				; 3CF5 0000
		sec				; 3CF6 9408
		sbis	PINC, 2	; 3CF7 9B9A
		rjmp	avr3CFA		; 3CF8 C001
		clc				; 3CF9 9488
avr3CFA:	ror	r16			; 3CFA 9507
		nop				; 3CFB 0000
		lds	r17, 0x04C4		; 3CFC 9110 04C4
		dec	r17			; 3CFE 951A
avr3CFF:	dec	r17			; 3CFF 951A
		nop				; 3D00 0000
		nop				; 3D01 0000
		nop				; 3D02 0000
		brne	avr3CFF		; 3D03 F7D9
		nop				; 3D04 0000
		nop				; 3D05 0000
		dec	r18			; 3D06 952A
		brne	avr3CF4		; 3D07 F761
		sbic	PINC, 2	; 3D08 999A
		rjmp	avr3FBD		; 3D09 C2B3
		nop				; 3D0A 0000
		rjmp	avr3FC7		; 3D0B C2BB

avr3D0C:nop				; 3D0C 0000
		push	r18			; 3D0D 932F
		cbi	DDRC, 1	; 3D0E 98A1
		sbi	PORTC, 1	; 3D0F 9AA9
		sbic	PINC, 1	; 3D10 9999
		rjmp	avr3FB1		; 3D11 C29F
		nop				; 3D12 0000
		rcall	sub3FCD		; 3D13 D2B9
avr3D14:	wdr				; 3D14 95A8
		sbic	PINC, 1	; 3D15 9999
		rjmp	avr3D1B		; 3D16 C004
		in	r16, $36		; 3D17 B706
		sbrs	r16, 2		; 3D18 FF02
		rjmp	avr3D14		; 3D19 CFFA
		rjmp	avr3FB5		; 3D1A C29A
avr3D1B:	nop				; 3D1B 0000
		lds	r17, 0x04C4		; 3D1C 9110 04C4
		lsr	r17			; 3D1E 9516
avr3D1F:	dec	r17			; 3D1F 951A
		nop				; 3D20 0000
		nop				; 3D21 0000
		nop				; 3D22 0000
		brne	avr3D1F		; 3D23 F7D9
		sbis	PINC, 1	; 3D24 9B99
		rjmp	avr3FB9		; 3D25 C293
		nop				; 3D26 0000
		lds	r17, 0x04C4		; 3D27 9110 04C4
		dec	r17			; 3D29 951A
avr3D2A:	dec	r17			; 3D2A 951A
		nop				; 3D2B 0000
		nop				; 3D2C 0000
		nop				; 3D2D 0000
		brne	avr3D2A		; 3D2E F7D9
		nop				; 3D2F 0000
		clr	r16			; 3D30 2700
		ldi	r18, 0x08		; 3D31 E028
avr3D32:	nop				; 3D32 0000
		nop				; 3D33 0000
		sec				; 3D34 9408
		sbis	PINC, 1	; 3D35 9B99
		rjmp	avr3D38		; 3D36 C001
		clc				; 3D37 9488
avr3D38:	ror	r16			; 3D38 9507
		nop				; 3D39 0000
		lds	r17, 0x04C4		; 3D3A 9110 04C4
		dec	r17			; 3D3C 951A
avr3D3D:	dec	r17			; 3D3D 951A
		nop				; 3D3E 0000
		nop				; 3D3F 0000
		nop				; 3D40 0000
		brne	avr3D3D		; 3D41 F7D9
		nop				; 3D42 0000
		nop				; 3D43 0000
		dec	r18			; 3D44 952A
		brne	avr3D32		; 3D45 F761
		sbic	PINC, 1	; 3D46 9999
		rjmp	avr3FBD		; 3D47 C275
		nop				; 3D48 0000
		rjmp	avr3FC7		; 3D49 C27D

avr3D4A:nop				; 3D4A 0000
		push	r18			; 3D4B 932F
		cbi	DDRC, 0	; 3D4C 98A0
		sbi	PORTC, 0	; 3D4D 9AA8
		sbic	PINC, 0	; 3D4E 9998
		rjmp	avr3FB1		; 3D4F C261
		nop				; 3D50 0000
		rcall	sub3FCD		; 3D51 D27B
avr3D52:	wdr				; 3D52 95A8
		sbic	PINC, 0	; 3D53 9998
		rjmp	avr3D59		; 3D54 C004
		in	r16, $36		; 3D55 B706
		sbrs	r16, 2		; 3D56 FF02
		rjmp	avr3D52		; 3D57 CFFA
		rjmp	avr3FB5		; 3D58 C25C
avr3D59:	nop				; 3D59 0000
		lds	r17, 0x04C4		; 3D5A 9110 04C4
		lsr	r17			; 3D5C 9516
avr3D5D:	dec	r17			; 3D5D 951A
		nop				; 3D5E 0000
		nop				; 3D5F 0000
		nop				; 3D60 0000
		brne	avr3D5D		; 3D61 F7D9
		sbis	PINC, 0	; 3D62 9B98
		rjmp	avr3FB9		; 3D63 C255
		nop				; 3D64 0000
		lds	r17, 0x04C4		; 3D65 9110 04C4
		dec	r17			; 3D67 951A
avr3D68:	dec	r17			; 3D68 951A
		nop				; 3D69 0000
		nop				; 3D6A 0000
		nop				; 3D6B 0000
		brne	avr3D68		; 3D6C F7D9
		nop				; 3D6D 0000
		clr	r16			; 3D6E 2700
		ldi	r18, 0x08		; 3D6F E028
avr3D70:	nop				; 3D70 0000
		nop				; 3D71 0000
		sec				; 3D72 9408
		sbis	PINC, 0	; 3D73 9B98
		rjmp	avr3D76		; 3D74 C001
		clc				; 3D75 9488
avr3D76:	ror	r16			; 3D76 9507
		nop				; 3D77 0000
		lds	r17, 0x04C4		; 3D78 9110 04C4
		dec	r17			; 3D7A 951A
avr3D7B:	dec	r17			; 3D7B 951A
		nop				; 3D7C 0000
		nop				; 3D7D 0000
		nop				; 3D7E 0000
		brne	avr3D7B		; 3D7F F7D9
		nop				; 3D80 0000
		nop				; 3D81 0000
		dec	r18			; 3D82 952A
		brne	avr3D70		; 3D83 F761
		sbic	PINC, 0	; 3D84 9998
		rjmp	avr3FBD		; 3D85 C237
		nop				; 3D86 0000
		rjmp	avr3FC7		; 3D87 C23F

avr3D88:nop				; 3D88 0000
		push	r18			; 3D89 932F
		cbi	$02, 7	; 3D8A 9817
		sbi	$03, 7	; 3D8B 9A1F
		sbic	$01, 7	; 3D8C 990F
		rjmp	avr3FB1		; 3D8D C223
		nop				; 3D8E 0000
		rcall	sub3FCD		; 3D8F D23D
avr3D90:	wdr				; 3D90 95A8
		sbic	$01, 7	; 3D91 990F
		rjmp	avr3D97		; 3D92 C004
		in	r16, $36		; 3D93 B706
		sbrs	r16, 2		; 3D94 FF02
		rjmp	avr3D90		; 3D95 CFFA
		rjmp	avr3FB5		; 3D96 C21E
avr3D97:	nop				; 3D97 0000
		lds	r17, 0x04C4		; 3D98 9110 04C4
		lsr	r17			; 3D9A 9516
avr3D9B:	dec	r17			; 3D9B 951A
		nop				; 3D9C 0000
		nop				; 3D9D 0000
		nop				; 3D9E 0000
		brne	avr3D9B		; 3D9F F7D9
		sbis	$01, 7	; 3DA0 9B0F
		rjmp	avr3FB9		; 3DA1 C217
		nop				; 3DA2 0000
		lds	r17, 0x04C4		; 3DA3 9110 04C4
		dec	r17			; 3DA5 951A
avr3DA6:	dec	r17			; 3DA6 951A
		nop				; 3DA7 0000
		nop				; 3DA8 0000
		nop				; 3DA9 0000
		brne	avr3DA6		; 3DAA F7D9
		nop				; 3DAB 0000
		clr	r16			; 3DAC 2700
		ldi	r18, 0x08		; 3DAD E028
avr3DAE:	nop				; 3DAE 0000
		nop				; 3DAF 0000
		sec				; 3DB0 9408
		sbis	$01, 7	; 3DB1 9B0F
		rjmp	avr3DB4		; 3DB2 C001
		clc				; 3DB3 9488
avr3DB4:	ror	r16			; 3DB4 9507
		nop				; 3DB5 0000
		lds	r17, 0x04C4		; 3DB6 9110 04C4
		dec	r17			; 3DB8 951A
avr3DB9:	dec	r17			; 3DB9 951A
		nop				; 3DBA 0000
		nop				; 3DBB 0000
		nop				; 3DBC 0000
		brne	avr3DB9		; 3DBD F7D9
		nop				; 3DBE 0000
		nop				; 3DBF 0000
		dec	r18			; 3DC0 952A
		brne	avr3DAE		; 3DC1 F761
		sbic	$01, 7	; 3DC2 990F
		rjmp	avr3FBD		; 3DC3 C1F9
		nop				; 3DC4 0000
		rjmp	avr3FC7		; 3DC5 C201

avr3DC6:nop				; 3DC6 0000
		push	r18			; 3DC7 932F
		cbi	$02, 6	; 3DC8 9816
		sbi	$03, 6	; 3DC9 9A1E
		sbic	$01, 6	; 3DCA 990E
		rjmp	avr3FB1		; 3DCB C1E5
		nop				; 3DCC 0000
		rcall	sub3FCD		; 3DCD D1FF
avr3DCE:	wdr				; 3DCE 95A8
		sbic	$01, 6	; 3DCF 990E
		rjmp	avr3DD5		; 3DD0 C004
		in	r16, $36		; 3DD1 B706
		sbrs	r16, 2		; 3DD2 FF02
		rjmp	avr3DCE		; 3DD3 CFFA
		rjmp	avr3FB5		; 3DD4 C1E0
avr3DD5:	nop				; 3DD5 0000
		lds	r17, 0x04C4		; 3DD6 9110 04C4
		lsr	r17			; 3DD8 9516
avr3DD9:	dec	r17			; 3DD9 951A
		nop				; 3DDA 0000
		nop				; 3DDB 0000
		nop				; 3DDC 0000
		brne	avr3DD9		; 3DDD F7D9
		sbis	$01, 6	; 3DDE 9B0E
		rjmp	avr3FB9		; 3DDF C1D9
		nop				; 3DE0 0000
		lds	r17, 0x04C4		; 3DE1 9110 04C4
		dec	r17			; 3DE3 951A
avr3DE4:	dec	r17			; 3DE4 951A
		nop				; 3DE5 0000
		nop				; 3DE6 0000
		nop				; 3DE7 0000
		brne	avr3DE4		; 3DE8 F7D9
		nop				; 3DE9 0000
		clr	r16			; 3DEA 2700
		ldi	r18, 0x08		; 3DEB E028
avr3DEC:	nop				; 3DEC 0000
		nop				; 3DED 0000
		sec				; 3DEE 9408
		sbis	$01, 6	; 3DEF 9B0E
		rjmp	avr3DF2		; 3DF0 C001
		clc				; 3DF1 9488
avr3DF2:	ror	r16			; 3DF2 9507
		nop				; 3DF3 0000
		lds	r17, 0x04C4		; 3DF4 9110 04C4
		dec	r17			; 3DF6 951A
avr3DF7:	dec	r17			; 3DF7 951A
		nop				; 3DF8 0000
		nop				; 3DF9 0000
		nop				; 3DFA 0000
		brne	avr3DF7		; 3DFB F7D9
		nop				; 3DFC 0000
		nop				; 3DFD 0000
		dec	r18			; 3DFE 952A
		brne	avr3DEC		; 3DFF F761
		sbic	$01, 6	; 3E00 990E
		rjmp	avr3FBD		; 3E01 C1BB
		nop				; 3E02 0000
		rjmp	avr3FC7		; 3E03 C1C3

avr3E04:nop				; 3E04 0000
		push	r18			; 3E05 932F
		cbi	DDRD, 7	; 3E06 988F
		sbi	PORTD, 7	; 3E07 9A97
		sbic	PIND, 7	; 3E08 9987
		rjmp	avr3FB1		; 3E09 C1A7
		nop				; 3E0A 0000
		rcall	sub3FCD		; 3E0B D1C1
avr3E0C:	wdr				; 3E0C 95A8
		sbic	PIND, 7	; 3E0D 9987
		rjmp	avr3E13		; 3E0E C004
		in	r16, $36		; 3E0F B706
		sbrs	r16, 2		; 3E10 FF02
		rjmp	avr3E0C		; 3E11 CFFA
		rjmp	avr3FB5		; 3E12 C1A2
avr3E13:	nop				; 3E13 0000
		lds	r17, 0x04C4		; 3E14 9110 04C4
		lsr	r17			; 3E16 9516
avr3E17:	dec	r17			; 3E17 951A
		nop				; 3E18 0000
		nop				; 3E19 0000
		nop				; 3E1A 0000
		brne	avr3E17		; 3E1B F7D9
		sbis	PIND, 7	; 3E1C 9B87
		rjmp	avr3FB9		; 3E1D C19B
		nop				; 3E1E 0000
		lds	r17, 0x04C4		; 3E1F 9110 04C4
		dec	r17			; 3E21 951A
avr3E22:	dec	r17			; 3E22 951A
		nop				; 3E23 0000
		nop				; 3E24 0000
		nop				; 3E25 0000
		brne	avr3E22		; 3E26 F7D9
		nop				; 3E27 0000
		clr	r16			; 3E28 2700
		ldi	r18, 0x08		; 3E29 E028
avr3E2A:	nop				; 3E2A 0000
		nop				; 3E2B 0000
		sec				; 3E2C 9408
		sbis	PIND, 7	; 3E2D 9B87
		rjmp	avr3E30		; 3E2E C001
		clc				; 3E2F 9488
avr3E30:	ror	r16			; 3E30 9507
		nop				; 3E31 0000
		lds	r17, 0x04C4		; 3E32 9110 04C4
		dec	r17			; 3E34 951A
avr3E35:	dec	r17			; 3E35 951A
		nop				; 3E36 0000
		nop				; 3E37 0000
		nop				; 3E38 0000
		brne	avr3E35		; 3E39 F7D9
		nop				; 3E3A 0000
		nop				; 3E3B 0000
		dec	r18			; 3E3C 952A
		brne	avr3E2A		; 3E3D F761
		sbic	PIND, 7	; 3E3E 9987
		rjmp	avr3FBD		; 3E3F C17D
		nop				; 3E40 0000
		rjmp	avr3FC7		; 3E41 C185

avr3E42:nop				; 3E42 0000
		push	r18			; 3E43 932F
		cbi	DDRD, 6	; 3E44 988E
		sbi	PORTD, 6	; 3E45 9A96
		sbic	PIND, 6	; 3E46 9986
		rjmp	avr3FB1		; 3E47 C169
		nop				; 3E48 0000
		rcall	sub3FCD		; 3E49 D183
avr3E4A:	wdr				; 3E4A 95A8
		sbic	PIND, 6	; 3E4B 9986
		rjmp	avr3E51		; 3E4C C004
		in	r16, $36		; 3E4D B706
		sbrs	r16, 2		; 3E4E FF02
		rjmp	avr3E4A		; 3E4F CFFA
		rjmp	avr3FB5		; 3E50 C164
avr3E51:	nop				; 3E51 0000
		lds	r17, 0x04C4		; 3E52 9110 04C4
		lsr	r17			; 3E54 9516
avr3E55:	dec	r17			; 3E55 951A
		nop				; 3E56 0000
		nop				; 3E57 0000
		nop				; 3E58 0000
		brne	avr3E55		; 3E59 F7D9
		sbis	PIND, 6	; 3E5A 9B86
		rjmp	avr3FB9		; 3E5B C15D
		nop				; 3E5C 0000
		lds	r17, 0x04C4		; 3E5D 9110 04C4
		dec	r17			; 3E5F 951A
avr3E60:	dec	r17			; 3E60 951A
		nop				; 3E61 0000
		nop				; 3E62 0000
		nop				; 3E63 0000
		brne	avr3E60		; 3E64 F7D9
		nop				; 3E65 0000
		clr	r16			; 3E66 2700
		ldi	r18, 0x08		; 3E67 E028
avr3E68:	nop				; 3E68 0000
		nop				; 3E69 0000
		sec				; 3E6A 9408
		sbis	PIND, 6	; 3E6B 9B86
		rjmp	avr3E6E		; 3E6C C001
		clc				; 3E6D 9488
avr3E6E:	ror	r16			; 3E6E 9507
		nop				; 3E6F 0000
		lds	r17, 0x04C4		; 3E70 9110 04C4
		dec	r17			; 3E72 951A
avr3E73:	dec	r17			; 3E73 951A
		nop				; 3E74 0000
		nop				; 3E75 0000
		nop				; 3E76 0000
		brne	avr3E73		; 3E77 F7D9
		nop				; 3E78 0000
		nop				; 3E79 0000
		dec	r18			; 3E7A 952A
		brne	avr3E68		; 3E7B F761
		sbic	PIND, 6	; 3E7C 9986
		rjmp	avr3FBD		; 3E7D C13F
		nop				; 3E7E 0000
		rjmp	avr3FC7		; 3E7F C147

avr3E80:nop				; 3E80 0000
		push	r18			; 3E81 932F
		cbi	DDRD, 5	; 3E82 988D
		sbi	PORTD, 5	; 3E83 9A95
		sbic	PIND, 5	; 3E84 9985
		rjmp	avr3FB1		; 3E85 C12B
		nop				; 3E86 0000
		rcall	sub3FCD		; 3E87 D145
avr3E88:	wdr				; 3E88 95A8
		sbic	PIND, 5	; 3E89 9985
		rjmp	avr3E8F		; 3E8A C004
		in	r16, $36		; 3E8B B706
		sbrs	r16, 2		; 3E8C FF02
		rjmp	avr3E88		; 3E8D CFFA
		rjmp	avr3FB5		; 3E8E C126
avr3E8F:	nop				; 3E8F 0000
		lds	r17, 0x04C4		; 3E90 9110 04C4
		lsr	r17			; 3E92 9516
avr3E93:	dec	r17			; 3E93 951A
		nop				; 3E94 0000
		nop				; 3E95 0000
		nop				; 3E96 0000
		brne	avr3E93		; 3E97 F7D9
		sbis	PIND, 5	; 3E98 9B85
		rjmp	avr3FB9		; 3E99 C11F
		nop				; 3E9A 0000
		lds	r17, 0x04C4		; 3E9B 9110 04C4
		dec	r17			; 3E9D 951A
avr3E9E:	dec	r17			; 3E9E 951A
		nop				; 3E9F 0000
		nop				; 3EA0 0000
		nop				; 3EA1 0000
		brne	avr3E9E		; 3EA2 F7D9
		nop				; 3EA3 0000
		clr	r16			; 3EA4 2700
		ldi	r18, 0x08		; 3EA5 E028
avr3EA6:	nop				; 3EA6 0000
		nop				; 3EA7 0000
		sec				; 3EA8 9408
		sbis	PIND, 5	; 3EA9 9B85
		rjmp	avr3EAC		; 3EAA C001
		clc				; 3EAB 9488
avr3EAC:	ror	r16			; 3EAC 9507
		nop				; 3EAD 0000
		lds	r17, 0x04C4		; 3EAE 9110 04C4
		dec	r17			; 3EB0 951A
avr3EB1:	dec	r17			; 3EB1 951A
		nop				; 3EB2 0000
		nop				; 3EB3 0000
		nop				; 3EB4 0000
		brne	avr3EB1		; 3EB5 F7D9
		nop				; 3EB6 0000
		nop				; 3EB7 0000
		dec	r18			; 3EB8 952A
		brne	avr3EA6		; 3EB9 F761
		sbic	PIND, 5	; 3EBA 9985
		rjmp	avr3FBD		; 3EBB C101
		nop				; 3EBC 0000
		rjmp	avr3FC7		; 3EBD C109

avr3EBE:nop				; 3EBE 0000
		push	r18			; 3EBF 932F
		lds	r18, 0x0064		; 3EC0 9120 0064
		andi	r18, 0xFB		; 3EC2 7F2B
		sts	0x0064, r18		; 3EC3 9320 0064
		nop				; 3EC5 0000
		lds	r18, 0x0065		; 3EC6 9120 0065
		ori	r18, 0x04		; 3EC8 6024
		sts	0x0065, r18		; 3EC9 9320 0065
		nop				; 3ECB 0000
		lds	r18, 0x0063		; 3ECC 9120 0063
		sbrc	r18, 2		; 3ECE FD22
		rjmp	avr3FB1		; 3ECF C0E1
		nop				; 3ED0 0000
		rcall	sub3FCD		; 3ED1 D0FB
avr3ED2:	wdr				; 3ED2 95A8
		lds	r18, 0x0063		; 3ED3 9120 0063
		sbrc	r18, 2		; 3ED5 FD22
		rjmp	avr3EDB		; 3ED6 C004
		in	r16, $36		; 3ED7 B706
		sbrs	r16, 2		; 3ED8 FF02
		rjmp	avr3ED2		; 3ED9 CFF8
		rjmp	avr3FB5		; 3EDA C0DA
avr3EDB:	nop				; 3EDB 0000
		lds	r17, 0x04C4		; 3EDC 9110 04C4
		lsr	r17			; 3EDE 9516
avr3EDF:	dec	r17			; 3EDF 951A
		nop				; 3EE0 0000
		nop				; 3EE1 0000
		nop				; 3EE2 0000
		brne	avr3EDF		; 3EE3 F7D9
		lds	r18, 0x0063		; 3EE4 9120 0063
		sbrs	r18, 2		; 3EE6 FF22
		rjmp	avr3FB9		; 3EE7 C0D1
		push	r19			; 3EE8 933F
		lds	r17, 0x04C4		; 3EE9 9110 04C4
		dec	r17			; 3EEB 951A
avr3EEC:	dec	r17			; 3EEC 951A
		nop				; 3EED 0000
		nop				; 3EEE 0000
		nop				; 3EEF 0000
		brne	avr3EEC		; 3EF0 F7D9
		nop				; 3EF1 0000
		clr	r16			; 3EF2 2700
		ldi	r18, 0x08		; 3EF3 E028
avr3EF4:	sec				; 3EF4 9408
		lds	r19, 0x0063		; 3EF5 9130 0063
		sbrs	r19, 2		; 3EF7 FF32
		rjmp	avr3EFA		; 3EF8 C001
		clc				; 3EF9 9488
avr3EFA:	ror	r16			; 3EFA 9507
		nop				; 3EFB 0000
		lds	r17, 0x04C4		; 3EFC 9110 04C4
		dec	r17			; 3EFE 951A
avr3EFF:	dec	r17			; 3EFF 951A
		nop				; 3F00 0000
		nop				; 3F01 0000
		nop				; 3F02 0000
		brne	avr3EFF		; 3F03 F7D9
		nop				; 3F04 0000
		nop				; 3F05 0000
		dec	r18			; 3F06 952A
		brne	avr3EF4		; 3F07 F761
		pop	r19			; 3F08 913F
		lds	r18, 0x0063		; 3F09 9120 0063
		sbrc	r18, 2		; 3F0B FD22
		rjmp	avr3FBD		; 3F0C C0B0
		nop				; 3F0D 0000
		rjmp	avr3FC7		; 3F0E C0B8

avr3F0F:nop				; 3F0F 0000
		push	r18			; 3F10 932F
		lds	r18, 0x0064		; 3F11 9120 0064
		andi	r18, 0xFD		; 3F13 7F2D
		sts	0x0064, r18		; 3F14 9320 0064
		nop				; 3F16 0000
		lds	r18, 0x0065		; 3F17 9120 0065
		ori	r18, 0x02		; 3F19 6022
		sts	0x0065, r18		; 3F1A 9320 0065
		nop				; 3F1C 0000
		lds	r18, 0x0063		; 3F1D 9120 0063
		sbrc	r18, 1		; 3F1F FD21
		rjmp	avr3FB1		; 3F20 C090
		nop				; 3F21 0000
		rcall	sub3FCD		; 3F22 D0AA
avr3F23:	wdr				; 3F23 95A8
		lds	r18, 0x0063		; 3F24 9120 0063
		sbrc	r18, 1		; 3F26 FD21
		rjmp	avr3F2C		; 3F27 C004
		in	r16, $36		; 3F28 B706
		sbrs	r16, 2		; 3F29 FF02
		rjmp	avr3F23		; 3F2A CFF8
		rjmp	avr3FB5		; 3F2B C089
avr3F2C:	nop				; 3F2C 0000
		lds	r17, 0x04C4		; 3F2D 9110 04C4
		lsr	r17			; 3F2F 9516
avr3F30:	dec	r17			; 3F30 951A
		nop				; 3F31 0000
		nop				; 3F32 0000
		nop				; 3F33 0000
		brne	avr3F30		; 3F34 F7D9
		lds	r18, 0x0063		; 3F35 9120 0063
		sbrs	r18, 1		; 3F37 FF21
		rjmp	avr3FB9		; 3F38 C080
		push	r19			; 3F39 933F
		lds	r17, 0x04C4		; 3F3A 9110 04C4
		dec	r17			; 3F3C 951A
avr3F3D:	dec	r17			; 3F3D 951A
		nop				; 3F3E 0000
		nop				; 3F3F 0000
		nop				; 3F40 0000
		brne	avr3F3D		; 3F41 F7D9
		nop				; 3F42 0000
		clr	r16			; 3F43 2700
		ldi	r18, 0x08		; 3F44 E028
avr3F45:	sec				; 3F45 9408
		lds	r19, 0x0063		; 3F46 9130 0063
		sbrs	r19, 1		; 3F48 FF31
		rjmp	avr3F4B		; 3F49 C001
		clc				; 3F4A 9488
avr3F4B:	ror	r16			; 3F4B 9507
		nop				; 3F4C 0000
		lds	r17, 0x04C4		; 3F4D 9110 04C4
		dec	r17			; 3F4F 951A
avr3F50:	dec	r17			; 3F50 951A
		nop				; 3F51 0000
		nop				; 3F52 0000
		nop				; 3F53 0000
		brne	avr3F50		; 3F54 F7D9
		nop				; 3F55 0000
		nop				; 3F56 0000
		dec	r18			; 3F57 952A
		brne	avr3F45		; 3F58 F761
		pop	r19			; 3F59 913F
		lds	r18, 0x0063		; 3F5A 9120 0063
		sbrc	r18, 1		; 3F5C FD21
		rjmp	avr3FBD		; 3F5D C05F
		nop				; 3F5E 0000
		rjmp	avr3FC7		; 3F5F C067

avr3F60:nop				; 3F60 0000
		push	r18			; 3F61 932F
		lds	r18, 0x0064		; 3F62 9120 0064
		andi	r18, 0xFE		; 3F64 7F2E
		sts	0x0064, r18		; 3F65 9320 0064
		nop				; 3F67 0000
		lds	r18, 0x0065		; 3F68 9120 0065
		ori	r18, 0x01		; 3F6A 6021
		sts	0x0065, r18		; 3F6B 9320 0065
		nop				; 3F6D 0000
		lds	r18, 0x0063		; 3F6E 9120 0063
		sbrc	r18, 0		; 3F70 FD20
		rjmp	avr3FB1		; 3F71 C03F
		nop				; 3F72 0000
		rcall	sub3FCD		; 3F73 D059
avr3F74:	wdr				; 3F74 95A8
		lds	r18, 0x0063		; 3F75 9120 0063
		sbrc	r18, 0		; 3F77 FD20
		rjmp	avr3F7D		; 3F78 C004
		in	r16, $36		; 3F79 B706
		sbrs	r16, 2		; 3F7A FF02
		rjmp	avr3F74		; 3F7B CFF8
		rjmp	avr3FB5		; 3F7C C038
avr3F7D:	nop				; 3F7D 0000
		lds	r17, 0x04C4		; 3F7E 9110 04C4
		lsr	r17			; 3F80 9516
avr3F81:	dec	r17			; 3F81 951A
		nop				; 3F82 0000
		nop				; 3F83 0000
		nop				; 3F84 0000
		brne	avr3F81		; 3F85 F7D9
		lds	r18, 0x0063		; 3F86 9120 0063
		sbrs	r18, 0		; 3F88 FF20
		rjmp	avr3FB9		; 3F89 C02F
		push	r19			; 3F8A 933F
		lds	r17, 0x04C4		; 3F8B 9110 04C4
		dec	r17			; 3F8D 951A
avr3F8E:	dec	r17			; 3F8E 951A
		nop				; 3F8F 0000
		nop				; 3F90 0000
		nop				; 3F91 0000
		brne	avr3F8E		; 3F92 F7D9
		nop				; 3F93 0000
		clr	r16			; 3F94 2700
		ldi	r18, 0x08		; 3F95 E028
avr3F96:	sec				; 3F96 9408
		lds	r19, 0x0063		; 3F97 9130 0063
		sbrs	r19, 0		; 3F99 FF30
		rjmp	avr3F9C		; 3F9A C001
		clc				; 3F9B 9488
avr3F9C:	ror	r16			; 3F9C 9507
		nop				; 3F9D 0000
		lds	r17, 0x04C4		; 3F9E 9110 04C4
		dec	r17			; 3FA0 951A
avr3FA1:	dec	r17			; 3FA1 951A
		nop				; 3FA2 0000
		nop				; 3FA3 0000
		nop				; 3FA4 0000
		brne	avr3FA1		; 3FA5 F7D9
		nop				; 3FA6 0000
		nop				; 3FA7 0000
		dec	r18			; 3FA8 952A
		brne	avr3F96		; 3FA9 F761
		pop	r19			; 3FAA 913F
		lds	r18, 0x0063		; 3FAB 9120 0063
		sbrc	r18, 0		; 3FAD FD20
		rjmp	avr3FBD		; 3FAE C00E
		nop				; 3FAF 0000
		rjmp	avr3FC7		; 3FB0 C016

avr3FB1:lds	r16, 0x04C3		; 3FB1 9100 04C3
		ori	r16, 0x80		; 3FB3 6800
		rjmp	avr3FC1		; 3FB4 C00C

avr3FB5:lds	r16, 0x04C3		; 3FB5 9100 04C3
		ori	r16, 0x40		; 3FB7 6400
		rjmp	avr3FC1		; 3FB8 C008

avr3FB9:lds	r16, 0x04C3		; 3FB9 9100 04C3
		ori	r16, 0x20		; 3FBB 6200
		rjmp	avr3FC1		; 3FBC C004

avr3FBD:lds	r16, 0x04C3		; 3FBD 9100 04C3
		ori	r16, 0x10		; 3FBF 6100
		rjmp	avr3FC1		; 3FC0 C000

avr3FC1:sts	0x04C3, r16		; 3FC1 9300 04C3
		pop	r18			; 3FC3 912F
		sec				; 3FC4 9408
		ldi	r16, 0x00		; 3FC5 E000
		ret				; 3FC6 9508
;-------------------------------------------------------------------------
avr3FC7:clr	r17			; 3FC7 2711
		sts	0x04C3, r17		; 3FC8 9310 04C3
		pop	r18			; 3FCA 912F
		clc				; 3FCB 9488
		ret				; 3FCC 9508
;-------------------------------------------------------------------------
sub3FCD:ldi	r16, 0x02		; 3FCD E002
		out	$2E, r16		; 3FCE BD0E
		in	r16, $36		; 3FCF B706
		andi	r16, 0x04		; 3FD0 7004
		out	$36, r16		; 3FD1 BF06
		ldi	r16, 0x27		; 3FD2 E207
		out	$2D, r16		; 3FD3 BD0D
		ldi	r16, 0x10		; 3FD4 E100
		out	$2C, r16		; 3FD5 BD0C
		ret				; 3FD6 9508
;-------------------------------------------------------------------------
; AI motors

sub3FD7:	lds	r16, 0x04F0		; 3FD7 9100 04F0 check if AI Motors enabled
			sbrs	r16, 7		; 3FD9 FF07
			rjmp	avr404B		; 3FDA C070 return if not enabled
			andi	r16, 0xBF	; 3FDB 7B0F clear bit 7 disable motors
			sts	0x04F0, r16		; 3FDC 9300 04F0 and save again

			ldi	r18, 0x1F		; 3FDE E12F count 31
avr3FDF:	dec	r18				; 3FDF 952A
			brne	avr3FE2		; 3FE0 F409 do this 31 times
			rjmp	avr404B		; 3FE1 C069 done

avr3FE2:	lds	r19, 0x04F1		; 3FE2 9130 04F1 if 0x4F1 greater than 31, then = 0
			inc	r19				; 3FE4 9533
			cpi	r19, 0x1F		; 3FE5 313F
			brlo	avr3FE8		; 3FE6 F008
			ldi	r19, 0x00		; 3FE7 E030

avr3FE8:	sts	0x04F1, r19		; 3FE8 9330 04F1 get the servo number
			cpi	r19, 0x08		; 3FEA 3038
			brlo	avr3FF2		; 3FEB F030 G8A
			cpi	r19, 0x10		; 3FEC 3130
			brlo	avr3FF3		; 3FED F028 G8B
			cpi	r19, 0x18		; 3FEE 3138
			brlo	avr3FF4		; 3FEF F020 G8C
			cpi	r19, 0x20		; 3FF0 3230
			brlo	avr3FF5		; 3FF1 F018 G8D
avr3FF2:	rjmp	avr3FF6		; 3FF2 C003
avr3FF3:	rjmp	avr400A		; 3FF3 C016
avr3FF4:	rjmp	avr4021		; 3FF4 C02C
avr3FF5:	rjmp	avr4036		; 3FF5 C040

avr3FF6:	ldi	r16, 0x01		; 3FF6 E001 G8A
avr3FF7:	tst	r19				; 3FF7 2333 set bit in r16 based on servo number in group
			breq	avr3FFC		; 3FF8 F019
			dec	r19				; 3FF9 953A
			lsl	r16				; 3FFA 0F00
			rjmp	avr3FF7		; 3FFB CFFB
avr3FFC:	lds	r17, 0x04CA		; 3FFC 9110 04CA get servo enables
			and	r17, r16		; 3FFE 2310
			tst	r17				; 3FFF 2311
			breq	avr401F		; 4000 F0F1 
			rcall	sub406A		; 4001 D068
			brlo	avr4004		; 4002 F008
			rjmp	avr404C		; 4003 C048
avr4004:	lds	r17, 0x04E3		; 4004 9110 04E3
			and	r17, r16		; 4006 2310
			tst	r17				; 4007 2311
			brne	avr401F		; 4008 F4B1
			rjmp	avr404C		; 4009 C042

avr400A:	subi	r19, 0x08		; 400A 5038 G8B
			ldi	r16, 0x01		; 400B E001
avr400C:	tst	r19				; 400C 2333
			breq	avr4011		; 400D F019
			dec	r19				; 400E 953A
			lsl	r16				; 400F 0F00
			rjmp	avr400C		; 4010 CFFB
avr4011:	lds	r17, 0x04CB		; 4011 9110 04CB
			and	r17, r16		; 4013 2310
			tst	r17				; 4014 2311
			breq	avr401F		; 4015 F049
			rcall	sub406A		; 4016 D053
			brlo	avr4019		; 4017 F008
			rjmp	avr404C		; 4018 C033
avr4019:	lds	r17, 0x04E4		; 4019 9110 04E4
			and	r17, r16		; 401B 2310
			tst	r17				; 401C 2311
			brne	avr401F		; 401D F409
			rjmp	avr404C		; 401E C02D
avr401F:	rjmp	avr3FDF		; 401F CFBF

			rjmp	avr404B		; 4020 C02A

avr4021:	subi	r19, 0x10	; 4021 5130 G8C
			ldi	r16, 0x01		; 4022 E001
avr4023:	tst	r19				; 4023 2333
			breq	avr4028		; 4024 F019
			dec	r19				; 4025 953A
			lsl	r16				; 4026 0F00
			rjmp	avr4023		; 4027 CFFB
avr4028:	lds	r17, 0x04CC		; 4028 9110 04CC
			and	r17, r16		; 402A 2310
			tst	r17				; 402B 2311
			breq	avr401F		; 402C F391
			rcall	sub406A		; 402D D03C
			brlo	avr4030		; 402E F008
			rjmp	avr404C		; 402F C01C
avr4030:	lds	r17, 0x04E5		; 4030 9110 04E5
			and	r17, r16		; 4032 2310
			tst	r17				; 4033 2311
			brne	avr401F		; 4034 F751
			rjmp	avr404C		; 4035 C016
avr4036:	subi	r19, 0x18	; 4036 5138
			ldi	r16, 0x01		; 4037 E001
avr4038:	tst	r19				; 4038 2333
			breq	avr403D		; 4039 F019
			dec	r19				; 403A 953A
			lsl	r16				; 403B 0F00
			rjmp	avr4038		; 403C CFFB

avr403D:	lds	r17, 0x04CD		; 403D 9110 04CD
			and	r17, r16		; 403F 2310
			tst	r17				; 4040 2311
			breq	avr401F		; 4041 F2E9
			rcall	sub406A		; 4042 D027
			brlo	avr4045		; 4043 F008
			rjmp	avr404C		; 4044 C007
avr4045:	lds	r17, 0x04E6		; 4045 9110 04E6
			and	r17, r16		; 4047 2310
			tst	r17				; 4048 2311
			brne	avr401F		; 4049 F6A9
			rjmp	avr404C		; 404A C001
avr404B:	ret					; 404B 9508

avr404C:	lds	r19, 0x04F1		; 404C 9130 04F1
			lds	r16, 0x04F0		; 404E 9100 04F0
			ori	r16, 0x40		; 4050 6400
			sts	0x04F0, r16		; 4051 9300 04F0
			ldi	XH, 0x03		; 4053 E0B3
			ldi	XL, 0x80		; 4054 E8A0
			add	XL, r19			; 4055 0FA3
			brsh	avr4058		; 4056 F408
			inc	XH				; 4057 95B3
avr4058:	ldi	YH, 0x04		; 4058 E0D4
			ldi	YL, 0xF5		; 4059 EFC5
			clr	r17				; 405A 2711
			ser	r16				; 405B EF0F
			st	Y+, r16			; 405C 9309
			ldi	r16, 0x00		; 405D E000
			or	r16, r19		; 405E 2B03
			st	Y+, r16			; 405F 9309
			eor	r17, r16		; 4060 2710
			ld	r16, X			; 4061 910C
			ldi	r18, 0x1C		; 4062 E12C
			add	r16, r18		; 4063 0F02
			st	Y+, r16			; 4064 9309
			eor	r17, r16		; 4065 2710
			andi	r17, 0x7F	; 4066 771F
			mov	r16, r17		; 4067 2F01
			st	Y+, r16			; 4068 9309
			ret					; 4069 9508

sub406A:	push	r16			; 406A 930F
			push	r17			; 406B 931F
			lds	r16, 0x04E3		; 406C 9100 04E3
			lds	r17, 0x04E4		; 406E 9110 04E4
			and	r16, r17		; 4070 2301
			lds	r17, 0x04E5		; 4071 9110 04E5
			and	r16, r17		; 4073 2301
			lds	r17, 0x04E6		; 4074 9110 04E6
			and	r16, r17		; 4076 2301
			cpi	r16, 0xFF		; 4077 3F0F
			breq	avr407D		; 4078 F021
			sec					; 4079 9408
			pop	r16				; 407A 910F
			pop	r17				; 407B 911F
			ret					; 407C 9508

avr407D:	clc					; 407D 9488
			pop	r16				; 407E 910F
			pop	r17				; 407F 911F
			ret					; 4080 9508

sub4081:	lds	r16, 0x04F1		; 4081 9100 04F1
			ldi	YH, 0x04		; 4083 E0D4
			ldi	YL, 0x20		; 4084 E2C0
			add	YL, r16			; 4085 0FC0
			brsh	avr4088		; 4086 F408
			inc	YH				; 4087 95D3
avr4088:	in	r16, $0C		; 4088 B10C
			st	Y, r16			; 4089 8308
			ret					; 408A 9508

;-------------------------------------------------------------------------
; Sends FF followed by two bytes in r16 and r17, followed by 7f
; Returns two bytes in r16 and r17
sub408B:	push	r16		; 408B 930F save first value
		in	r16, $0C	; 408C B10C Read USART0 Data
		pop	r16		; 408D 910F
		clr	r18		; 408E 2722 r18 = 0
		push	r16		; 408F 930F
		ser	r16		; 4090 EF0F r16 = FF
		call	sub013D		; 4091 940E 013D send FF to USART0
		ldi	r16, 0x00	; 4093 E000 r16 = 0
		or	r16, r17	; 4094 2B01 OR second value
		eor	r18, r16	; 4095 2720 XOR 0
		call	sub013D		; 4096 940E 013D send value to USART0
		pop	r16		; 4098 910F get back first value
		ldi	r17, 0x1C	; 4099 E11C r17 = 0x1c
		add	r16, r17	; 409A 0F01 add first value
		eor	r18, r16	; 409B 2720 
		call	sub013D		; 409C 940E 013D
		andi	r18, 0x7F	; 409E 772F
		mov	r16, r18	; 409F 2F02
		call	sub013D		; 40A0 940E 013D send 7f to USART0
		call	sub0142		; 40A2 940E 0142 get first response
		mov	r17, r16	; 40A4 2F10 
		call	sub0142		; 40A5 940E 0142 get second response
		ret			; 40A7 9508

;-------------------------------------------------------------------------

sub40A8:push	r16			; 40A8 930F
		in	r16, $0C		; 40A9 B10C
		pop	r16			; 40AA 910F
		push	r17			; 40AB 931F
		clr	r18			; 40AC 2722
		ser	r16			; 40AD EF0F
		call	sub013D		; 40AE 940E 013D
		ldi	r16, 0xA0		; 40B0 EA00
		or	r16, r17		; 40B1 2B01
		eor	r18, r16		; 40B2 2720
		call	sub013D		; 40B3 940E 013D
		ldi	r16, 0x00		; 40B5 E000
		ldi	r17, 0x1C		; 40B6 E11C
		add	r16, r17		; 40B7 0F01
		eor	r18, r16		; 40B8 2720
		call	sub013D		; 40B9 940E 013D
		andi	r18, 0x7F		; 40BB 772F
		mov	r16, r18		; 40BC 2F02
		call	sub013D		; 40BD 940E 013D
		call	sub0142		; 40BF 940E 0142
		brsh	avr40C7		; 40C1 F428
		mov	r17, r16		; 40C2 2F10
		call	sub0142		; 40C3 940E 0142
		brsh	avr40C7		; 40C5 F408
		rjmp	avr40C8		; 40C6 C001
avr40C7:	ret				; 40C7 9508
;-------------------------------------------------------------------------
avr40C8:	cpi	r16, 0x00		; 40C8 3000
		brne	avr40CB		; 40C9 F409
		ldi	r16, 0x01		; 40CA E001
avr40CB:	pop	r20			; 40CB 914F
		lds	r18, 0x04E7		; 40CC 9120 04E7
		lds	r19, 0x04E8		; 40CE 9130 04E8
		lds	r21, 0x04E9		; 40D0 9150 04E9
		lds	r22, 0x04EA		; 40D2 9160 04EA
		cpi	r20, 0x00		; 40D4 3040
		breq	avr4113		; 40D5 F1E9
		cpi	r20, 0x01		; 40D6 3041
		breq	avr4114		; 40D7 F1E1
		cpi	r20, 0x02		; 40D8 3042
		breq	avr4115		; 40D9 F1D9
		cpi	r20, 0x03		; 40DA 3043
		breq	avr4116		; 40DB F1D1
		cpi	r20, 0x04		; 40DC 3044
		breq	avr4117		; 40DD F1C9
		cpi	r20, 0x05		; 40DE 3045
		breq	avr4118		; 40DF F1C1
		cpi	r20, 0x06		; 40E0 3046
		breq	avr4119		; 40E1 F1B9
		cpi	r20, 0x07		; 40E2 3047
		breq	avr411A		; 40E3 F1B1
		cpi	r20, 0x08		; 40E4 3048
		breq	avr411B		; 40E5 F1A9
		cpi	r20, 0x09		; 40E6 3049
		breq	avr411C		; 40E7 F1A1
		cpi	r20, 0x0A		; 40E8 304A
		breq	avr411D		; 40E9 F199
		cpi	r20, 0x0B		; 40EA 304B
		breq	avr411E		; 40EB F191
		cpi	r20, 0x0C		; 40EC 304C
		breq	avr411F		; 40ED F189
		cpi	r20, 0x0D		; 40EE 304D
		breq	avr4120		; 40EF F181
		cpi	r20, 0x0E		; 40F0 304E
		breq	avr4121		; 40F1 F179
		cpi	r20, 0x0F		; 40F2 304F
		breq	avr4122		; 40F3 F171
		cpi	r20, 0x10		; 40F4 3140
		breq	avr4123		; 40F5 F169
		cpi	r20, 0x11		; 40F6 3141
		breq	avr4124		; 40F7 F161
		cpi	r20, 0x12		; 40F8 3142
		breq	avr4125		; 40F9 F159
		cpi	r20, 0x13		; 40FA 3143
		breq	avr4126		; 40FB F151
		cpi	r20, 0x14		; 40FC 3144
		breq	avr4127		; 40FD F149
		cpi	r20, 0x15		; 40FE 3145
		breq	avr4128		; 40FF F141
		cpi	r20, 0x16		; 4100 3146
		breq	avr4129		; 4101 F139
		cpi	r20, 0x17		; 4102 3147
		breq	avr412A		; 4103 F131
		cpi	r20, 0x18		; 4104 3148
		breq	avr412B		; 4105 F129
		cpi	r20, 0x19		; 4106 3149
		breq	avr412C		; 4107 F121
		cpi	r20, 0x1A		; 4108 314A
		breq	avr412D		; 4109 F119
		cpi	r20, 0x1B		; 410A 314B
		breq	avr412E		; 410B F111
		cpi	r20, 0x1C		; 410C 314C
		breq	avr412F		; 410D F109
		cpi	r20, 0x1D		; 410E 314D
		breq	avr4130		; 410F F101
		cpi	r20, 0x1E		; 4110 314E
		breq	avr4131		; 4111 F0F9
		ret				; 4112 9508
;-------------------------------------------------------------------------
avr4113:		rjmp	avr4132		; 4113 C01E
avr4114:		rjmp	avr4135		; 4114 C020
avr4115:		rjmp	avr4138		; 4115 C022
avr4116:		rjmp	avr413B		; 4116 C024
avr4117:		rjmp	avr413E		; 4117 C026
avr4118:		rjmp	avr4141		; 4118 C028
avr4119:		rjmp	avr4144		; 4119 C02A
avr411A:		rjmp	avr4147		; 411A C02C
avr411B:		rjmp	avr414A		; 411B C02E
avr411C:		rjmp	avr414D		; 411C C030
avr411D:		rjmp	avr4150		; 411D C032
avr411E:		rjmp	avr4153		; 411E C034
avr411F:		rjmp	avr4156		; 411F C036
avr4120:		rjmp	avr4159		; 4120 C038
avr4121:		rjmp	avr415C		; 4121 C03A
avr4122:		rjmp	avr415F		; 4122 C03C
avr4123:		rjmp	avr4162		; 4123 C03E
avr4124:		rjmp	avr4165		; 4124 C040
avr4125:		rjmp	avr4168		; 4125 C042
avr4126:		rjmp	avr416B		; 4126 C044
avr4127:		rjmp	avr416E		; 4127 C046
avr4128:		rjmp	avr4171		; 4128 C048
avr4129:		rjmp	avr4174		; 4129 C04A
avr412A:		rjmp	avr4177		; 412A C04C
avr412B:		rjmp	avr417A		; 412B C04E
avr412C:		rjmp	avr417D		; 412C C050
avr412D:		rjmp	avr4180		; 412D C052
avr412E:		rjmp	avr4183		; 412E C054
avr412F:		rjmp	avr4186		; 412F C056
avr4130:		rjmp	avr4189		; 4130 C058
avr4131:		rjmp	avr418C		; 4131 C05A

;-------------------------------------------------------------------------

avr4132:		sbrs	r18, 0		; 4132 FF20
			neg	r16			; 4133 9501
			ret				; 4134 9508
;-------------------------------------------------------------------------
avr4135:		sbrs	r18, 1		; 4135 FF21
		neg	r16			; 4136 9501
		ret				; 4137 9508
;-------------------------------------------------------------------------
avr4138:		sbrs	r18, 2		; 4138 FF22
		neg	r16			; 4139 9501
		ret				; 413A 9508
;-------------------------------------------------------------------------
avr413B:		sbrs	r18, 3		; 413B FF23
		neg	r16			; 413C 9501
		ret				; 413D 9508
;-------------------------------------------------------------------------
avr413E:		sbrs	r18, 4		; 413E FF24
		neg	r16			; 413F 9501
		ret				; 4140 9508
;-------------------------------------------------------------------------
avr4141:		sbrs	r18, 5		; 4141 FF25
		neg	r16			; 4142 9501
		ret				; 4143 9508
;-------------------------------------------------------------------------
avr4144:		sbrs	r18, 6		; 4144 FF26
		neg	r16			; 4145 9501
		ret				; 4146 9508
;-------------------------------------------------------------------------
avr4147:		sbrs	r18, 7		; 4147 FF27
		neg	r16			; 4148 9501
		ret				; 4149 9508
;-------------------------------------------------------------------------
avr414A:		sbrs	r19, 0		; 414A FF30
		neg	r16			; 414B 9501
		ret				; 414C 9508
;-------------------------------------------------------------------------
avr414D:		sbrs	r19, 1		; 414D FF31
		neg	r16			; 414E 9501
		ret				; 414F 9508
;-------------------------------------------------------------------------
avr4150:		sbrs	r19, 2		; 4150 FF32
		neg	r16			; 4151 9501
		ret				; 4152 9508
;-------------------------------------------------------------------------
avr4153:		sbrs	r19, 3		; 4153 FF33
		neg	r16			; 4154 9501
		ret				; 4155 9508
;-------------------------------------------------------------------------
avr4156:		sbrs	r19, 4		; 4156 FF34
		neg	r16			; 4157 9501
		ret				; 4158 9508
;-------------------------------------------------------------------------
avr4159:		sbrs	r19, 5		; 4159 FF35
		neg	r16			; 415A 9501
		ret				; 415B 9508
;-------------------------------------------------------------------------
avr415C:		sbrs	r19, 6		; 415C FF36
		neg	r16			; 415D 9501
		ret				; 415E 9508
;-------------------------------------------------------------------------
avr415F:		sbrs	r19, 7		; 415F FF37
		neg	r16			; 4160 9501
		ret				; 4161 9508
;-------------------------------------------------------------------------
avr4162:	sbrs	r21, 0		; 4162 FF50
		neg	r16			; 4163 9501
		ret				; 4164 9508
;-------------------------------------------------------------------------
avr4165:		sbrs	r21, 1		; 4165 FF51
		neg	r16			; 4166 9501
		ret				; 4167 9508
;-------------------------------------------------------------------------
avr4168:		sbrs	r21, 2		; 4168 FF52
		neg	r16			; 4169 9501
		ret				; 416A 9508
;-------------------------------------------------------------------------
avr416B:		sbrs	r21, 3		; 416B FF53
		neg	r16			; 416C 9501
		ret				; 416D 9508
;-------------------------------------------------------------------------
avr416E:		sbrs	r21, 4		; 416E FF54
		neg	r16			; 416F 9501
		ret				; 4170 9508
;-------------------------------------------------------------------------
avr4171:		sbrs	r21, 5		; 4171 FF55
		neg	r16			; 4172 9501
		ret				; 4173 9508
;-------------------------------------------------------------------------
avr4174:		sbrs	r21, 6		; 4174 FF56
		neg	r16			; 4175 9501
		ret				; 4176 9508
;-------------------------------------------------------------------------
avr4177:		sbrs	r21, 7		; 4177 FF57
		neg	r16			; 4178 9501
		ret				; 4179 9508
;-------------------------------------------------------------------------
avr417A:		sbrs	r22, 0		; 417A FF60
		neg	r16			; 417B 9501
		ret				; 417C 9508
;-------------------------------------------------------------------------
avr417D:		sbrs	r22, 1		; 417D FF61
		neg	r16			; 417E 9501
		ret				; 417F 9508
;-------------------------------------------------------------------------
avr4180:		sbrs	r22, 2		; 4180 FF62
		neg	r16			; 4181 9501
		ret				; 4182 9508
;-------------------------------------------------------------------------
avr4183:		sbrs	r22, 3		; 4183 FF63
		neg	r16			; 4184 9501
		ret				; 4185 9508
;-------------------------------------------------------------------------
avr4186:		sbrs	r22, 4		; 4186 FF64
		neg	r16			; 4187 9501
		ret				; 4188 9508
;-------------------------------------------------------------------------
avr4189:		sbrs	r22, 5		; 4189 FF65
		neg	r16			; 418A 9501
		ret				; 418B 9508
;-------------------------------------------------------------------------
avr418C:		sbrs	r22, 6		; 418C FF66
		neg	r16			; 418D 9501
		ret				; 418E 9508
;-------------------------------------------------------------------------
		push	r16			; 418F 930F
		in	r16, $0C		; 4190 B10C
		pop	r16			; 4191 910F
		clr	r18			; 4192 2722
		ser	r16			; 4193 EF0F
		call	sub013D		; 4194 940E 013D
		ldi	r16, 0xC0		; 4196 EC00
		or	r16, r17		; 4197 2B01
		eor	r18, r16		; 4198 2720
		call	sub013D		; 4199 940E 013D
		ldi	r16, 0x10		; 419B E100
		eor	r18, r16		; 419C 2720
		call	sub013D		; 419D 940E 013D
		andi	r18, 0x7F		; 419F 772F
		mov	r16, r18		; 41A0 2F02
		call	sub013D		; 41A1 940E 013D
		in	r16, $0C		; 41A3 B10C
		call	sub0142		; 41A4 940E 0142
		mov	r17, r16		; 41A6 2F10
		call	sub0142		; 41A7 940E 0142
		ret				; 41A9 9508
;-------------------------------------------------------------------------
sub41AA:		push	r16			; 41AA 930F
		in	r16, $0C		; 41AB B10C
		pop	r16			; 41AC 910F
		clr	r18			; 41AD 2722
		ser	r16			; 41AE EF0F
		call	sub013D		; 41AF 940E 013D
		ldi	r16, 0xDF		; 41B1 ED0F
		eor	r18, r16		; 41B2 2720
		call	sub013D		; 41B3 940E 013D
		ldi	r16, 0x20		; 41B5 E200
		eor	r18, r16		; 41B6 2720
		call	sub013D		; 41B7 940E 013D
		andi	r18, 0x7F		; 41B9 772F
		mov	r16, r18		; 41BA 2F02
		call	sub013D		; 41BB 940E 013D
		in	r16, $0C		; 41BD B10C
		call	sub0142		; 41BE 940E 0142
		brsh	avr41C8		; 41C0 F438
		sts	0x04CE, r16		; 41C1 9300 04CE
		call	sub0142		; 41C3 940E 0142
		brsh	avr41C8		; 41C5 F410
		sec				; 41C6 9408
		ret				; 41C7 9508
;-------------------------------------------------------------------------
avr41C8:	clc				; 41C8 9488
		ret				; 41C9 9508
;-------------------------------------------------------------------------
		push	r16			; 41CA 930F
		in	r16, $0C		; 41CB B10C
		pop	r16			; 41CC 910F
		clr	r18			; 41CD 2722
		push	r16			; 41CE 930F
		ser	r16			; 41CF EF0F
		call	sub013D		; 41D0 940E 013D
		ldi	r16, 0xC0		; 41D2 EC00
		or	r16, r17		; 41D3 2B01
		eor	r18, r16		; 41D4 2720
		call	sub013D		; 41D5 940E 013D
		pop	r16			; 41D7 910F
		call	sub013D		; 41D8 940E 013D
		eor	r18, r16		; 41DA 2720
		andi	r18, 0x7F		; 41DB 772F
		mov	r16, r18		; 41DC 2F02
		call	sub013D		; 41DD 940E 013D
		in	r16, $0C		; 41DF B10C
		call	sub0142		; 41E0 940E 0142
		mov	r17, r16		; 41E2 2F10
		call	sub0142		; 41E3 940E 0142
		ret				; 41E5 9508
;-------------------------------------------------------------------------
sub41E6:push	r16			; 41E6 930F
		in	r16, $0C		; 41E7 B10C
		pop	r16			; 41E8 910F
		ldi	ZH, high(avr0128 << 1)		; 41E9 E0F2
		ldi	ZL, low(avr0128 << 1)		; 41EA E5E0
		add	ZL, r16		; 41EB 0FE0
		brsh	avr41EE		; 41EC F408
		inc	ZH			; 41ED 95F3
avr41EE:clr	r18			; 41EE 2722
		ser	r16			; 41EF EF0F
		call	sub013D		; 41F0 940E 013D
		ldi	r16, 0xE0		; 41F2 EE00
		lds	r17, 0x04CE		; 41F3 9110 04CE
		or	r16, r17		; 41F5 2B01
		call	sub013D		; 41F6 940E 013D
		eor	r18, r16		; 41F8 2720
		ldi	r16, 0x08		; 41F9 E008
		call	sub013D		; 41FA 940E 013D
		eor	r18, r16		; 41FC 2720
		lpm				; 41FD 95C8
		mov	r19, r0		; 41FE 2D30
		mov	r16, r0		; 41FF 2D00
		call	sub013D		; 4200 940E 013D
		eor	r18, r16		; 4202 2720
		call	sub013D		; 4203 940E 013D
		eor	r18, r16		; 4205 2720
		andi	r18, 0x7F		; 4206 772F
		mov	r16, r18		; 4207 2F02
		call	sub013D		; 4208 940E 013D
		call	sub0142		; 420A 940E 0142
		brlo	avr4210 +1		; 420C F020  weird !!
		call	sub0142		; 420D 940E 0142
		brlo	avr4212		; 420F F010
avr4210:		call	sub0142		; 4210 940E 0142
avr4212:		brsh	avr4227		; 4212 F4A0
		cp	r16, r19		; 4213 1703
		brne	avr4227		; 4214 F491
		call	sub0142		; 4215 940E 0142
		brlo	avr421C + 1		; 4217 F020 weird !!
		call	sub0142		; 4218 940E 0142
		brlo	avr421D		; 421A F010
avr421C:call	sub0142		; 421B 940E 0142
avr421D:brsh	avr4227		; 421D F448
		cp	r16, r19		; 421E 1703
		brne	avr4227		; 421F F439
		mov	r16, r19		; 4220 2F03
		out	$09, r16		; 4221 B909
		ldi	r16, 0x00		; 4222 E000
		sts	0x0090, r16		; 4223 9300 0090
		sec				; 4225 9408
		ret				; 4226 9508
;-------------------------------------------------------------------------
avr4227:clc				; 4227 9488
		ret				; 4228 9508
;-------------------------------------------------------------------------
sub4229:	push	r16			; 4229 930F
		in	r16, $0C		; 422A B10C
		pop	r16			; 422B 910F
		clr	r18			; 422C 2722
		push	r16			; 422D 930F
		ser	r16			; 422E EF0F
		call	sub013D		; 422F 940E 013D
		clr	r16			; 4231 2700
		ldi	r16, 0xE0		; 4232 EE00
		lds	r17, 0x04CE		; 4233 9110 04CE
		or	r16, r17		; 4235 2B01
		call	sub013D		; 4236 940E 013D
		eor	r18, r16		; 4238 2720
		ldi	r16, 0x09		; 4239 E009
		call	sub013D		; 423A 940E 013D
		eor	r18, r16		; 423C 2720
		pop	r16			; 423D 910F
		call	sub013D		; 423E 940E 013D
		eor	r18, r16		; 4240 2720
		mov	r16, r19		; 4241 2F03
		call	sub013D		; 4242 940E 013D
		eor	r18, r16		; 4244 2720
		andi	r18, 0x7F		; 4245 772F
		mov	r16, r18		; 4246 2F02
		call	sub013D		; 4247 940E 013D
		call	sub0142		; 4249 940E 0142
		brlo	avr424F + 1		; 424B F020 weird !!
		call	sub0142		; 424C 940E 0142
		brlo	avr4251		; 424E F010
avr424F:	call	sub0142		; 424F 940E 0142
avr4251:	brsh	avr425E		; 4251 F460
		mov	r17, r16		; 4252 2F10
		call	sub0142		; 4253 940E 0142
		brlo	avr4259 + 1		; 4255 F020 weird !!
		call	sub0142		; 4256 940E 0142
		brlo	avr425B		; 4258 F010
avr4259:		call	sub0142		; 4259 940E 0142
avr425B:	brsh	avr425E		; 425B F410
		sec				; 425C 9408
		ret				; 425D 9508
;-------------------------------------------------------------------------
avr425E:		clc				; 425E 9488
		ret				; 425F 9508
;-------------------------------------------------------------------------
sub4260:	push	r16			; 4260 930F
		in	r16, $0C		; 4261 B10C
		pop	r16			; 4262 910F
		clr	r18			; 4263 2722
		ser	r16			; 4264 EF0F
		call	sub013D		; 4265 940E 013D
		clr	r16			; 4267 2700
		ldi	r16, 0xE0		; 4268 EE00
		lds	r17, 0x04CE		; 4269 9110 04CE
		or	r16, r17		; 426B 2B01
		call	sub013D		; 426C 940E 013D
		eor	r18, r16		; 426E 2720
		ldi	r16, 0x0C		; 426F E00C
		call	sub013D		; 4270 940E 013D
		eor	r18, r16		; 4272 2720
		ldi	r16, 0x00		; 4273 E000
		call	sub013D		; 4274 940E 013D
		eor	r18, r16		; 4276 2720
		ldi	r16, 0x00		; 4277 E000
		call	sub013D		; 4278 940E 013D
		eor	r18, r16		; 427A 2720
		andi	r18, 0x7F		; 427B 772F
		mov	r16, r18		; 427C 2F02
		call	sub013D		; 427D 940E 013D
		in	r16, $0C		; 427F B10C
		call	sub0142		; 4280 940E 0142
		sts	0x04C8, r16		; 4282 9300 04C8
		call	sub0142		; 4284 940E 0142
		sts	0x04C9, r16		; 4286 9300 04C9
		ret				; 4288 9508
;-------------------------------------------------------------------------
sub4289:	push	r16			; 4289 930F
		in	r16, $0C		; 428A B10C
		pop	r16			; 428B 910F
		clr	r18			; 428C 2722
		push	r16			; 428D 930F
		ser	r16			; 428E EF0F
		call	sub013D		; 428F 940E 013D
		clr	r16			; 4291 2700
		ldi	r16, 0xE0		; 4292 EE00
		lds	r17, 0x04CE		; 4293 9110 04CE
		or	r16, r17		; 4295 2B01
		call	sub013D		; 4296 940E 013D
		eor	r18, r16		; 4298 2720
		ldi	r16, 0x0F		; 4299 E00F
		call	sub013D		; 429A 940E 013D
		eor	r18, r16		; 429C 2720
		pop	r16			; 429D 910F
		mov	r0, r16		; 429E 2E00
		call	sub013D		; 429F 940E 013D
		eor	r18, r16		; 42A1 2720
		mov	r16, r0		; 42A2 2D00
		call	sub013D		; 42A3 940E 013D
		eor	r18, r16		; 42A5 2720
		andi	r18, 0x7F		; 42A6 772F
		mov	r16, r18		; 42A7 2F02
		call	sub013D		; 42A8 940E 013D
		call	sub0142		; 42AA 940E 0142
		brlo	avr42B0 + 1		; 42AC F020   weird
		call	sub0142		; 42AD 940E 0142
		brlo	avr42B2		; 42AF F010
avr42B0:	call	sub0142		; 42B0 940E 0142
avr42B2:	brsh	avr42BE		; 42B2 F458
		call	sub0142		; 42B3 940E 0142
		brlo	avr42B9 + 1		; 42B5 F020    weird
		call	sub0142		; 42B6 940E 0142
		brlo	avr42BB		; 42B8 F010
avr42B9:		call	sub0142		; 42B9 940E 0142
avr42BB:		brsh	avr42BE		; 42BB F410
		sec				; 42BC 9408
		ret				; 42BD 9508
;-------------------------------------------------------------------------
avr42BE:		clc				; 42BE 9488
		ret				; 42BF 9508
;-------------------------------------------------------------------------
sub42C0:	push	r16			; 42C0 930F
		in	r16, $0C		; 42C1 B10C
		pop	r16			; 42C2 910F
		clr	r18			; 42C3 2722
		ser	r16			; 42C4 EF0F
		call	sub013D		; 42C5 940E 013D
		clr	r16			; 42C7 2700
		ldi	r16, 0xE0		; 42C8 EE00
		lds	r17, 0x04CE		; 42C9 9110 04CE
		or	r16, r17		; 42CB 2B01
		call	sub013D		; 42CC 940E 013D
		eor	r18, r16		; 42CE 2720
		ldi	r16, 0x10		; 42CF E100
		call	sub013D		; 42D0 940E 013D
		eor	r18, r16		; 42D2 2720
		ldi	r16, 0x00		; 42D3 E000
		call	sub013D		; 42D4 940E 013D
		eor	r18, r16		; 42D6 2720
		ldi	r16, 0x00		; 42D7 E000
		call	sub013D		; 42D8 940E 013D
		eor	r18, r16		; 42DA 2720
		andi	r18, 0x7F		; 42DB 772F
		mov	r16, r18		; 42DC 2F02
		call	sub013D		; 42DD 940E 013D
		in	r16, $0C		; 42DF B10C
		call	sub0142		; 42E0 940E 0142
		call	sub0142		; 42E2 940E 0142
		sts	0x04C7, r16		; 42E4 9300 04C7
		ret				; 42E6 9508
;-------------------------------------------------------------------------
sub42E7:	push	r16			; 42E7 930F
		in	r16, $0C		; 42E8 B10C
		pop	r16			; 42E9 910F
		clr	r18			; 42EA 2722
		mov	r19, r16		; 42EB 2F30
		ser	r16			; 42EC EF0F
		call	sub013D		; 42ED 940E 013D
		clr	r16			; 42EF 2700
		ldi	r16, 0xE0		; 42F0 EE00
		lds	r17, 0x04CE		; 42F1 9110 04CE
		or	r16, r17		; 42F3 2B01
		call	sub013D		; 42F4 940E 013D
		eor	r18, r16		; 42F6 2720
		ldi	r16, 0x0A		; 42F7 E00A
		call	sub013D		; 42F8 940E 013D
		eor	r18, r16		; 42FA 2720
		mov	r16, r19		; 42FB 2F03
		call	sub013D		; 42FC 940E 013D
		eor	r18, r16		; 42FE 2720
		mov	r16, r19		; 42FF 2F03
		call	sub013D		; 4300 940E 013D
		eor	r18, r16		; 4302 2720
		andi	r18, 0x7F		; 4303 772F
		mov	r16, r18		; 4304 2F02
		call	sub013D		; 4305 940E 013D
		in	r16, $0C		; 4307 B10C
		call	sub0142		; 4308 940E 0142
		brlo	avr430E + 1		; 430A F020
		call	sub0142		; 430B 940E 0142
		brlo	avr4310		; 430D F010
avr430E:	call	sub0142		; 430E 940E 0142
avr4310:		brsh	avr4324		; 4310 F498
		cp	r16, r19		; 4311 1703
		brne	avr4324		; 4312 F489
		call	sub0142		; 4313 940E 0142
		brlo	avr4319	 + 1	; 4315 F020
		call	sub0142		; 4316 940E 0142
		brlo	avr431B		; 4318 F010
avr4319:	call	sub0142		; 4319 940E 0142
avr431B:	brsh	avr4324		; 431B F440
		cp	r16, r19		; 431C 1703
		brne	avr4324		; 431D F431
		sts	0x04CE, r19		; 431E 9330 04CE
		call	sub0142		; 4320 940E 0142
		sec				; 4322 9408
		ret				; 4323 9508
;-------------------------------------------------------------------------
avr4324:	clc				; 4324 9488
		ret				; 4325 9508
;-------------------------------------------------------------------------
sub4326:	push	r16			; 4326 930F
		in	r16, $0C		; 4327 B10C
		pop	r16			; 4328 910F
		clr	r18			; 4329 2722
		push	r16			; 432A 930F
		ser	r16			; 432B EF0F
		call	sub013D		; 432C 940E 013D
		clr	r16			; 432E 2700
		ldi	r16, 0xE0		; 432F EE00
		lds	r17, 0x04CE		; 4330 9110 04CE
		or	r16, r17		; 4332 2B01
		call	sub013D		; 4333 940E 013D
		eor	r18, r16		; 4335 2720
		ldi	r16, 0x0D		; 4336 E00D
		call	sub013D		; 4337 940E 013D
		eor	r18, r16		; 4339 2720
		pop	r16			; 433A 910F
		mov	r0, r16		; 433B 2E00
		call	sub013D		; 433C 940E 013D
		eor	r18, r16		; 433E 2720
		mov	r16, r0		; 433F 2D00
		call	sub013D		; 4340 940E 013D
		eor	r18, r16		; 4342 2720
		andi	r18, 0x7F		; 4343 772F
		mov	r16, r18		; 4344 2F02
		call	sub013D		; 4345 940E 013D
		call	sub0142		; 4347 940E 0142
		brlo	avr434D +1		; 4349 F020
		call	sub0142		; 434A 940E 0142
		brlo	avr434F		; 434C F010
avr434D:	call	sub0142		; 434D 940E 0142
avr434F:	brsh	avr435B		; 434F F458
		call	sub0142		; 4350 940E 0142
		brlo	avr4356 + 1		; 4352 F020
		call	sub0142		; 4353 940E 0142
		brlo	avr4358		; 4355 F010
avr4356:	call	sub0142		; 4356 940E 0142
avr4358:	brsh	avr435B		; 4358 F410
		sec				; 4359 9408
		ret				; 435A 9508
;-------------------------------------------------------------------------
avr435B:	clc				; 435B 9488
		ret				; 435C 9508
;-------------------------------------------------------------------------
sub435D:	push	r16			; 435D 930F
		in	r16, $0C		; 435E B10C
		pop	r16			; 435F 910F
		clr	r18			; 4360 2722
		ser	r16			; 4361 EF0F
		call	sub013D		; 4362 940E 013D
		clr	r16			; 4364 2700
		ldi	r16, 0xE0		; 4365 EE00
		lds	r17, 0x04CE		; 4366 9110 04CE
		or	r16, r17		; 4368 2B01
		call	sub013D		; 4369 940E 013D
		eor	r18, r16		; 436B 2720
		ldi	r16, 0x0E		; 436C E00E
		call	sub013D		; 436D 940E 013D
		eor	r18, r16		; 436F 2720
		ldi	r16, 0x00		; 4370 E000
		call	sub013D		; 4371 940E 013D
		eor	r18, r16		; 4373 2720
		ldi	r16, 0x00		; 4374 E000
		call	sub013D		; 4375 940E 013D
		eor	r18, r16		; 4377 2720
		andi	r18, 0x7F		; 4378 772F
		mov	r16, r18		; 4379 2F02
		call	sub013D		; 437A 940E 013D
		in	r16, $0C		; 437C B10C
		call	sub0142		; 437D 940E 0142
		sts	0x04C6, r16		; 437F 9300 04C6
		call	sub0142		; 4381 940E 0142
		sec				; 4383 9408
		ret				; 4384 9508
;-------------------------------------------------------------------------
sub4385:rcall	sub4391		; 4385 D00B
		brlo	avr438F		; 4386 F040
		rcall	sub4391		; 4387 D009
		brlo	avr438F		; 4388 F030
		rcall	sub4391		; 4389 D007
		brlo	avr438F		; 438A F020
		rcall	sub43A9		; 438B D01D
		brlo	avr438F		; 438C F010
		clc			; 438D 9488
		ret			; 438E 9508
;-------------------------------------------------------------------------
avr438F:sec			; 438F 9408
		ret			; 4390 9508
;-------------------------------------------------------------------------
sub4391:ldi	ZH, high(avr0128 << 1)	; 4391 E0F2 Data in prog meme at 0x128
		ldi	ZL, low(avr0128 << 1)	; 4392 E5E0
		push	r16		; 4393 930F
		in	r16, $0C	; 4394 B10C read USART0 data reg
		pop	r16		; 4395 910F
avr4396:		lpm			; 4396 95C8 
		mov	r16, r0		; 4397 2D00
		tst	r16		; 4398 2300
		breq	avr43A5		; 4399 F059
		sts	0x04CF, r16	; 439A 9300 04CF
		out	$09, r16	; 439C B909
		ldi	r16, 0x00	; 439D E000
		sts	0x0090, r16	; 439E 9300 0090
		nop			; 43A0 0000
		rcall	sub41AA		; 43A1 DE08
		brlo	avr43A7		; 43A2 F020
		adiw	ZL, 0x01	; 43A3 9631
		rjmp	avr4396		; 43A4 CFF1
avr43A5:	clc			; 43A5 9488
		ret			; 43A6 9508
;-------------------------------------------------------------------------
avr43A7:sec			; 43A7 9408
		ret			; 43A8 9508
;-------------------------------------------------------------------------
sub43A9:push	r16			; 43A9 930F
		in	r16, $0C		; 43AA B10C
		pop	r16			; 43AB 910F
		ldi	r16, 0x00		; 43AC E000
avr43AD:sts	0x04CF, r16		; 43AD 9300 04CF
		out	$09, r16		; 43AF B909
		ldi	r16, 0x00		; 43B0 E000
		sts	0x0090, r16		; 43B1 9300 0090
		nop				; 43B3 0000
		rcall	sub41AA			; 43B4 DDF5
		brlo	avr43BD			; 43B5 F038
		lds	r16, 0x04CF		; 43B6 9100 04CF
		inc	r16			; 43B8 9503
		cpi	r16, 0x00		; 43B9 3000
		brne	avr43AD		; 43BA F791
		clc				; 43BB 9488
		ret				; 43BC 9508
;-------------------------------------------------------------------------
avr43BD:sec				; 43BD 9408
		ret				; 43BE 9508
;-------------------------------------------------------------------------
; Command F5
; Read AI Motor
sub43BF:cli			; 43BF 94F8
		rcall	sub4385		; 43C0 DFC4
		brsh	avr43EE		; 43C1 F560
		lds	r16, 0x04CE	; 43C2 9100 04CE
		call	sub0641		; 43C4 940E 0641
		call	sub0629		; 43C6 940E 0629
		lds	r16, 0x04CF	; 43C8 9100 04CF
		call	sub0641		; 43CA 940E 0641
		call	sub0629		; 43CC 940E 0629
		rcall	sub4260		; 43CE DE91
		brsh	avr43EE		; 43CF F4F0
		lds	r16, 0x04C8	; 43D0 9100 04C8
		call	sub0641		; 43D2 940E 0641
		call	sub0629		; 43D4 940E 0629
		lds	r16, 0x04C9	; 43D6 9100 04C9
		call	sub0641		; 43D8 940E 0641
		in	r16, $0C	; 43DA B10C
		call	sub0629		; 43DB 940E 0629
		rcall	sub42C0		; 43DD DEE2
		brsh	avr43EE		; 43DE F478
		lds	r16, 0x04C7	; 43DF 9100 04C7
		call	sub0641		; 43E1 940E 0641
		in	r16, $0C	; 43E3 B10C
		call	sub0629		; 43E4 940E 0629
		rcall	sub435D		; 43E6 DF76
		brsh	avr43EE		; 43E7 F430
		lds	r16, 0x04C6	; 43E8 9100 04C6
		call	sub0641		; 43EA 940E 0641
		sei			; 43EC 9478
		ret			; 43ED 9508
;-------------------------------------------------------------------------
avr43EE:sei				; 43EE 9478
		ret				; 43EF 9508
;-------------------------------------------------------------------------
sub43F0:cli				; 43F0 94F8
		rcall	sub4385		; 43F1 DF93
		brsh	avr43EE		; 43F2 F7D8
		lds	r16, 0x04CE		; 43F3 9100 04CE
		call	sub0641		; 43F5 940E 0641
		ldi	YH, 0x0E		; 43F7 E0DE
		ldi	YL, 0x00		; 43F8 E0C0
		call	sub0629		; 43F9 940E 0629
		call	sub0641		; 43FB 940E 0641
		st	Y+, r16		; 43FD 9309
		call	sub0629		; 43FE 940E 0629
		call	sub0641		; 4400 940E 0641
		st	Y+, r16		; 4402 9309
		call	sub0629		; 4403 940E 0629
		call	sub0641		; 4405 940E 0641
		st	Y+, r16		; 4407 9309
		call	sub0629		; 4408 940E 0629
		call	sub0641		; 440A 940E 0641
		st	Y+, r16		; 440C 9309
		call	sub0629		; 440D 940E 0629
		call	sub0641		; 440F 940E 0641
		st	Y+, r16		; 4411 9309
		call	sub0629		; 4412 940E 0629
		call	sub0641		; 4414 940E 0641
		st	Y+, r16		; 4416 9309
		ldi	YH, 0x0E		; 4417 E0DE
		ldi	YL, 0x00		; 4418 E0C0
		ld	r16, Y+		; 4419 9109
		rcall	sub42E7		; 441A DECC
		brsh	avr4441		; 441B F528
		clr	r16			; 441C 2700
avr441D:	dec	r16			; 441D 950A
		brne	avr441D		; 441E F7F1
		ld	r16, Y+		; 441F 9109
		rcall	sub41E6		; 4420 DDC5
		brsh	avr4441		; 4421 F4F8
		clr	r16			; 4422 2700
avr4423:	dec	r16			; 4423 950A
		brne	avr4423		; 4424 F7F1
		ld	r16, Y+		; 4425 9109
		sts	0x04C8, r16		; 4426 9300 04C8
		ld	r19, Y+		; 4428 9139
		sts	0x04C9, r16		; 4429 9300 04C9
		rcall	sub4229		; 442B DDFD
		brsh	avr4441		; 442C F4A0
		clr	r16			; 442D 2700
avr442E:	dec	r16			; 442E 950A
		brne	avr442E		; 442F F7F1
		ld	r16, Y+		; 4430 9109
		rcall	sub4289		; 4431 DE57
		brsh	avr4441		; 4432 F470
		clr	r16			; 4433 2700
avr4434:	dec	r16			; 4434 950A
		brne	avr4434		; 4435 F7F1
		ld	r16, Y+		; 4436 9109
		rcall	sub4326		; 4437 DEEE
		brsh	avr4441		; 4438 F440
		clr	r16			; 4439 2700
avr443A:	dec	r16			; 443A 950A
		brne	avr443A		; 443B F7F1
		ldi	r16, 0x00		; 443C E000
		call	sub0641		; 443D 940E 0641
		sei				; 443F 9478
		ret				; 4440 9508
;-------------------------------------------------------------------------
avr4441:	ser	r16			; 4441 EF0F
		call	sub0641		; 4442 940E 0641
		sei				; 4444 9478
		ret				; 4445 9508
;-------------------------------------------------------------------------

sub4446:ldi	YH, 0x0E	; 4446 E0DE y = 0xe00
		ldi	YL, 0x00	; 4447 E0C0
		call	sub0629		; 4448 940E 0629 get next char
		call	sub0641		; 444A 940E 0641 echo
		st	Y+, r16		; 444C 9309
		call	sub0629		; 444D 940E 0629 get next char
		call	sub0641		; 444F 940E 0641
		st	Y+, r16		; 4451 9309
		ldi	YH, 0x0E	; 4452 E0DE
		ldi	YL, 0x00	; 4453 E0C0
		ld	r17, Y+		; 4454 9119 chars in r16 and r17
		ld	r16, Y+		; 4455 9109
		rcall	sub408B		; 4456 DC34 
		ret			; 4457 9508
;-------------------------------------------------------------------------
sub4458:	ldi	r18, 0x00		; 4458 E020
avr4459:	mov	r17, r18		; 4459 2F12
		ldi	r16, 0x2B		; 445A E20B
		call	sub2616		; 445B 940E 2616
		inc	r18			; 445D 9523
		cpi	r18, 0x20		; 445E 3220
		brne	avr4459		; 445F F7C9
		ret				; 4460 9508
;-------------------------------------------------------------------------
sub4461:	ldi	r18, 0x00		; 4461 E020
avr4462:	mov	r17, r18		; 4462 2F12
		ldi	r16, 0x00		; 4463 E000
		call	sub2616		; 4464 940E 2616
		inc	r18			; 4466 9523
		cpi	r18, 0x20		; 4467 3220
		brne	avr4462		; 4468 F7C9
		ldi	r16, 0x41		; 4469 E401
avr446A:	ldi	r17, 0x00		; 446A E010
avr446B:	ldi	r18, 0x00		; 446B E020
avr446C:	wdr				; 446C 95A8
		dec	r18			; 446D 952A
		brne	avr446C		; 446E F7E9
		dec	r17			; 446F 951A
		brne	avr446B		; 4470 F7D1
		dec	r16			; 4471 950A
		brne	avr446A		; 4472 F7B9
		ret				; 4473 9508
;-------------------------------------------------------------------------
; Here on Command D0 and D1
avr4474:	cli					; 4474 94F8 interrupts off
			ldi		XH, 0x0E	; 4475 E0BE X point to scratch buffer
			ldi		XL, 0x00	; 4476 E0A0
			st		X+, r16		; 4477 930D 0xE00 = 0xD0
			call	sub0629		; 4478 940E 0629 get next char
			brlo	avr4497		; 447A F0E0 timeout
			st		X+, r16		; 447B 930D 0xE01 = next char
			call	sub0629		; 447C 940E 0629 next char
			brlo	avr4497		; 447E F0C0 timeout
			st		X+, r16		; 447F 930D 0xE02 = next char
			call	sub0629		; 4480 940E 0629 next char
			brlo	avr4497		; 4482 F0A0 timeout
			st		X+, r16		; 4483 930D 0xE03 = next char = servo number
			rcall	sub4499		; 4484 D014
			push	r17			; 4485 931F
			call	sub0641		; 4486 940E 0641 send r16
			pop		r17			; 4488 911F
			mov		r16, r17	; 4489 2F01
			call	sub0641		; 448A 940E 0641 send r17
avr448C:	wdr			        ; 448C 95A8
	 		lds		r16, 0x009B	; 448D 9100 009B test rxready
			sbrs	r16, 7		; 448F FF07
			rjmp	avr448C		; 4490 CFFB
			call	sub0629		; 4491 940E 0629 get next char
			brlo	avr448C		; 4493 F3C0
			cpi		r16, 0x6F	; 4494 360F char = 0x6F
			breq	avr4497		; 4495 F009
			rjmp	avr4474		; 4496 CFDD
avr4497:	jmp		avr03CB		; 4497 940C 03CB done go back

; Perform the serial servo command
; command is in 0xE00 to 0xE03
; return values are in r16 and r17

sub4499:
			ldi		XH, 0x0E		; 4499 E0BE x = 0xE03
			ldi		XL, 0x03		; 449A E0A3
			ld		r18, X			; 449B 912C r18 contents of 0xE03
			mov		r17, r18		; 449C 2F12 r17 = servo number
			ldi		r16, 0x80		; 449D E800 r16 = header byte to servo
			call	sub25FE			; 449E 940E 25FE send byte to servo
			call	sub44C9			; 44A0 940E 44C9 delay
			ldi		XH, 0x0E		; 44A2 E0BE 
			ldi		XL, 0x00		; 44A3 E0A0
			mov		r17, r18		; 44A4 2F12
			ld		r16, X+			; 44A5 910D
			call	sub25FE			; 44A6 940E 25FE send byte D0 to servo
			mov		r17, r18		; 44A8 2F12
			ld		r16, X+			; 44A9 910D
			call	sub25FE			; 44AA 940E 25FE send next byte
			mov		r17, r18		; 44AC 2F12
			ld		r16, X+			; 44AD 910D
			call	sub25FE			; 44AE 940E 25FE send next byte
			mov		r17, r18		; 44B0 2F12
			ldi		XH, 0x0E		; 44B1 E0BE point back to beginning
			ldi		XL, 0x00		; 44B2 E0A0
			clr		r16				; 44B3 2700 clear r16 for checksum
			ldi		r18, 0x80		; 44B4 E820
			sub		r16, r18		; 44B5 1B02
			ld		r18, X+			; 44B6 912D
			sub		r16, r18		; 44B7 1B02
			ld		r18, X+			; 44B8 912D
			sub		r16, r18		; 44B9 1B02
			ld		r18, X+			; 44BA 912D
			sub		r16, r18		; 44BB 1B02
			call	sub25FE			; 44BC 940E 25FE send checksum
			ld		r18, X+			; 44BE 912D
			mov		r17, r18		; 44BF 2F12
			call	sub2604			; 44C0 940E 2604 get response 1 from servo
			push	r16				; 44C2 930F
			mov		r17, r18		; 44C3 2F12
			call	sub2604			; 44C4 940E 2604 get response 2 from servo
			mov		r17, r16		; 44C6 2F10
			pop		r16				; 44C7 910F
			ret						; 44C8 9508
;-------------------------------------------------------------------------
sub44C9:	push	r16			; 44C9 930F delay
			ldi		r16, 0x00	; 44CA E000
avr44CB:	dec		r16			; 44CB 950A
			brne	avr44CB		; 44CC F7F1
			pop		r16			; 44CD 910F
			ret					; 44CE 9508
;-------------------------------------------------------------------------
sub44CF:	push	XH			; 44CF 93BF
		push	XL			; 44D0 93AF
		push	YH			; 44D1 93DF
		push	YL			; 44D2 93CF
		push	r16			; 44D3 930F
		rcall	sub459C		; 44D4 D0C7
		brlo	avr44DA		; 44D5 F020
		ldi	r16, 0x00		; 44D6 E000
		rcall	sub459C		; 44D7 D0C4
		brlo	avr44DA		; 44D8 F008
		rjmp	avr458E		; 44D9 C0B4
avr44DA:	ldi	YH, 0x0E		; 44DA E0DE
		ldi	YL, 0x05		; 44DB E0C5
		ld	r16, Y+		; 44DC 9109
		ld	r17, Y+		; 44DD 9119
		rol	r17			; 44DE 1F11
		rol	r16			; 44DF 1F00
		rol	r17			; 44E0 1F11
		rol	r16			; 44E1 1F00
		andi	r17, 0xFC		; 44E2 7F1C
		ld	r18, Y+		; 44E3 9129
		ld	r19, Y+		; 44E4 9139
		add	r17, r19		; 44E5 0F13
		adc	r16, r18		; 44E6 1F02
		ld	r18, Y+		; 44E7 9129
		ld	r19, Y+		; 44E8 9139
		cp	r19, r17		; 44E9 1731
		cpc	r18, r16		; 44EA 0720
		brlo	avr44ED		; 44EB F008
		rjmp	avr4508		; 44EC C01B
avr44ED:	sub	r17, r19		; 44ED 1B13
		sbc	r16, r18		; 44EE 0B02
		mov	r0, r16		; 44EF 2E00
		mov	r1, r17		; 44F0 2E11
		ldi	r19, 0x01		; 44F1 E031
		ldi	r18, 0x00		; 44F2 E020
		ldi	r21, 0x00		; 44F3 E050
		ld	r20, Y+		; 44F4 9149
		call	sub02FD		; 44F5 940E 02FD divide
		mov	r17, r19		; 44F7 2F13
		mov	r16, r18		; 44F8 2F02
		mov	r19, r0		; 44F9 2D30
		mov	r18, r1		; 44FA 2D21
		call	sub02EE		; 44FB 940E 02EE multiply
		mov	r19, r19		; 44FD 2F33
		mov	r18, r18		; 44FE 2F22
		ldi	r21, 0x00		; 44FF E050
		ldi	r20, 0x24		; 4500 E244
		call	sub02FD		; 4501 940E 02FD divide
		ldi	r16, 0x00		; 4503 E000
		ldi	r17, 0x64		; 4504 E614
		sub	r17, r18		; 4505 1B12
		sbc	r16, r19		; 4506 0B03
		rjmp	avr4523		; 4507 C01B
avr4508:	sub	r19, r17		; 4508 1B31
		sbc	r18, r16		; 4509 0B20
		mov	r0, r18		; 450A 2E02
		mov	r1, r19		; 450B 2E13
		ldi	r19, 0x01		; 450C E031
		ldi	r18, 0x00		; 450D E020
		ldi	r21, 0x00		; 450E E050
		adiw	YL, 0x01		; 450F 9621
		ld	r20, Y+		; 4510 9149
		call	sub02FD		; 4511 940E 02FD divide
		mov	r17, r19		; 4513 2F13
		mov	r16, r18		; 4514 2F02
		mov	r19, r0		; 4515 2D30
		mov	r18, r1		; 4516 2D21
		call	sub02EE		; 4517 940E 02EE multiply
		mov	r19, r19		; 4519 2F33
		mov	r18, r18		; 451A 2F22
		ldi	r21, 0x00		; 451B E050
		ldi	r20, 0x22		; 451C E242
		call	sub02FD		; 451D 940E 02FD divide
		ldi	r16, 0x00		; 451F E000
		ldi	r17, 0x64		; 4520 E614
		add	r17, r18		; 4521 0F12
		adc	r16, r19		; 4522 1F03
avr4523:	pop	r16			; 4523 910F
		push	XH			; 4524 93BF
		push	XL			; 4525 93AF
		ldi	YH, 0x03		; 4526 E0D3
		ldi	YL, 0x00		; 4527 E0C0
		ldi	ZH, 0x03		; 4528 E0F3
		ldi	ZL, 0x20		; 4529 E2E0
		ldi	XH, 0x03		; 452A E0B3
		ldi	XL, 0x40		; 452B E4A0
		add	YL, r16		; 452C 0FC0
		brsh	avr452F		; 452D F408
		inc	YH			; 452E 95D3
avr452F:	add	ZL, r16		; 452F 0FE0
		brsh	avr4532		; 4530 F408
		inc	ZH			; 4531 95F3
avr4532:	add	XL, r16		; 4532 0FA0
		brsh	avr4535		; 4533 F408
		inc	XH			; 4534 95B3
avr4535:	mov	r18, r16		; 4535 2F20
		subi	r18, 0x18		; 4536 5128
		brlo	avr4539		; 4537 F008
		rjmp	avr4572		; 4538 C039
avr4539:	mov	r18, r16		; 4539 2F20
		subi	r18, 0x10		; 453A 5120
		brlo	avr453D		; 453B F008
		rjmp	avr4562		; 453C C025
avr453D:	mov	r18, r16		; 453D 2F20
		subi	r18, 0x08		; 453E 5028
		brlo	avr4541		; 453F F008
		rjmp	avr4552		; 4540 C011
avr4541:	mov	r18, r16		; 4541 2F20
		ldi	r19, 0x01		; 4542 E031
avr4543:cpi	r18, 0x00		; 4543 3020
		breq	avr4548		; 4544 F019
		dec	r18			; 4545 952A
		lsl	r19			; 4546 0F33
		rjmp	avr4543		; 4547 CFFB
avr4548:	lds	r18, 0x04E7		; 4548 9120 04E7
		and	r19, r18		; 454A 2332
		tst	r19			; 454B 2333
		breq	avr454E		; 454C F009
		rjmp	avr4582		; 454D C034
avr454E:	ldi	r18, 0xC8		; 454E EC28
		sub	r18, r17		; 454F 1B21
		mov	r17, r18		; 4550 2F12
		rjmp	avr4582		; 4551 C030
avr4552:	ldi	r19, 0x01		; 4552 E031
avr4553:	cpi	r18, 0x00		; 4553 3020
		breq	avr4558		; 4554 F019
		dec	r18			; 4555 952A
		lsl	r19			; 4556 0F33
		rjmp	avr4553		; 4557 CFFB
avr4558:	lds	r18, 0x04E8		; 4558 9120 04E8
		and	r19, r18		; 455A 2332
		tst	r19			; 455B 2333
		breq	avr455E		; 455C F009
		rjmp	avr4582		; 455D C024
avr455E:	ldi	r18, 0xC8		; 455E EC28
		sub	r18, r17		; 455F 1B21
		mov	r17, r18		; 4560 2F12
		rjmp	avr4582		; 4561 C020
avr4562:	ldi	r19, 0x01		; 4562 E031
avr4563:	cpi	r18, 0x00		; 4563 3020
		breq	avr4568		; 4564 F019
		dec	r18			; 4565 952A
		lsl	r19			; 4566 0F33
		rjmp	avr4563		; 4567 CFFB
avr4568:	lds	r18, 0x04E9		; 4568 9120 04E9
		and	r19, r18		; 456A 2332
		tst	r19			; 456B 2333
		breq	avr456E		; 456C F009
		rjmp	avr4582		; 456D C014
avr456E:	ldi	r18, 0xC8		; 456E EC28
		sub	r18, r17		; 456F 1B21
		mov	r17, r18		; 4570 2F12
		rjmp	avr4582		; 4571 C010
avr4572:	ldi	r19, 0x01		; 4572 E031
avr4573:	cpi	r18, 0x00		; 4573 3020
		breq	avr4578		; 4574 F019
		dec	r18			; 4575 952A
		lsl	r19			; 4576 0F33
		rjmp	avr4573		; 4577 CFFB
avr4578:	lds	r18, 0x04EA		; 4578 9120 04EA
		and	r19, r18		; 457A 2332
		tst	r19			; 457B 2333
		breq	avr457E		; 457C F009
		rjmp	avr4582		; 457D C004
avr457E:	ldi	r18, 0xC8		; 457E EC28
		sub	r18, r17		; 457F 1B21
		mov	r17, r18		; 4580 2F12
		rjmp	avr4582		; 4581 C000
avr4582:	ld	r18, X		; 4582 912C
		sub	r17, r18		; 4583 1B12
		st	Y, r17			; 4584 8318
		st	Z, r17			; 4585 8310
		pop	XL			; 4586 91AF
		pop	XH			; 4587 91BF
		ldi	r17, 0x00		; 4588 E010
		ldi	r16, 0x00		; 4589 E000
		call	sub2604		; 458A 940E 2604
		sec				; 458C 9408
		rjmp	avr4594		; 458D C006
avr458E:	pop	r16			; 458E 910F
		ldi	r17, 0x00		; 458F E010
		ldi	r16, 0x00		; 4590 E000
		call	sub2604		; 4591 940E 2604
		clc				; 4593 9488
avr4594:	pop	YL			; 4594 91CF
		pop	YH			; 4595 91DF
		pop	XL			; 4596 91AF
		pop	XH			; 4597 91BF
		ret				; 4598 9508
;-------------------------------------------------------------------------
;
avr4599:
		.db	0x88, 0x89, 0x92, 0x93, 0x96, 0x97
/*
		4599 8988
		459A 9392
		459B 9796
*/
;-------------------------------------------------------------------------
sub459C:mov	r19, r16		; 459C 2F30
		ldi	YH, 0x0E		; 459D E0DE
		ldi	YL, 0x05		; 459E E0C5
		ldi	r16, 0x65		; 459F E605
		sts	0x0E00, r16		; 45A0 9300 0E00
		ldi	r16, 0x00		; 45A2 E000
		sts	0x0E01, r16		; 45A3 9300 0E01
		ldi	r16, 0x00		; 45A5 E000
		sts	0x0E02, r16		; 45A6 9300 0E02
		sts	0x0E03, r19		; 45A8 9330 0E03
		rcall	sub4499		; 45AA DEEE
		st	Y+, r16		; 45AB 9309
		st	Y+, r17		; 45AC 9319
		ldi	ZH, high(avr4599 << 1)		; 45AD E8FB
		ldi	ZL, low(avr4599 << 1)		; 45AE E3E2
		ldi	r20, 0x06		; 45AF E046
avr45B0:	ldi	r16, 0x63		; 45B0 E603
		sts	0x0E00, r16		; 45B1 9300 0E00
		lpm	r16, Z+		; 45B3 9105
		sts	0x0E01, r16		; 45B4 9300 0E01
		ldi	r16, 0x00		; 45B6 E000
		sts	0x0E02, r16		; 45B7 9300 0E02
		sts	0x0E03, r19		; 45B9 9330 0E03
		rcall	sub4499		; 45BB DEDD
		st	Y+, r16		; 45BC 9309
		cpi	r17, 0x2B		; 45BD 321B
		breq	avr45C0		; 45BE F009
		rjmp	avr45C4		; 45BF C004
avr45C0:	dec	r20			; 45C0 954A
		brne	avr45B0		; 45C1 F771
		sec				; 45C2 9408
		ret				; 45C3 9508
;-------------------------------------------------------------------------
avr45C4:	clc				; 45C4 9488
		ret				; 45C5 9508
;-------------------------------------------------------------------------
; Here for read from IM code
avr45C6:
;--------------
;New 2.7 code
			cpi		r16, 0x20
			brcc	read001
			rcall	sub45CD
			rjmp	read000
read001:	rcall	read003			; 45C6 D006
read000:			mov	r19, YH			; 45C7 2F3D
			mov	r18, YL			; 45C8 2F2C
			call	sub14CD			; 45C9 940E 14CD save result
			jmp	avr0093			; 45CB 940C 0093
;-------------------------------------------------------------------------
; here to read servo position
; servo is in r16 result is in YL

sub45CD:	ldi	r17, 0x05			; 45CD E015 five tries
;---------
; 2.7 code
			rjmp	read002
read003:	ldi		r17, 0x02
;----------
read002:			mov	r18, r16			; 45CE 2F20

avr45CF:	mov	r16, r18			; 45CF 2F02
			rcall	sub45D7			; 45D0 D006
			cpi	YL, 0x00			; 45D1 30C0
			breq	avr45D4			; 45D2 F009
			ret						; 45D3 9508
		
avr45D4:	dec	r17					; 45D4 951A
			brne	avr45CF			; 45D5 F7C9
			ret						; 45D6 9508

sub45D7:	cli						; 45D7 94F8
			push	r17				; 45D8 931F
			push	r18				; 45D9 932F
;------------
; 2.7 code
			lds		r17, 0x0514
			ori		r17, 0x80
			sts		0x0514, r17
;-------------
			mov	r17, r16			; 45DA 2F10
			subi	r17, 0x20		; 45DB 5210
			brlo	avr45E7			; 45DC F050
			mov	r17, r16			; 45DD 2F10
			subi	r17, 0x40		; 45DE 5410
			brlo	avr45E9			; 45DF F048
			mov	r17, r16			; 45E0 2F10
			subi	r17, 0x60		; 45E1 5610
			brlo	avr45EC			; 45E2 F048
			mov	r17, r16			; 45E3 2F10
			subi	r17, 0x80		; 45E4 5810
			brlo	avr45EF			; 45E5 F048
			rjmp	avr45E7			; 45E6 C000
avr45E7:
;-----------
; 2.7 code
			lds		r17, 0x0514
			andi	r17, 0x7f
			sts		0x0514, r17
			ldi	r17, 0x00			; 45E7 E010
			rjmp	avr45F1			; 45E8 C008
avr45E9:	subi	r16, 0x20		; 45E9 5200
			ldi	r17, 0x01			; 45EA E011
			rjmp	avr45F1			; 45EB C005
avr45EC:	subi	r16, 0x40		; 45EC 5400
			ldi	r17, 0x02			; 45ED E012
			rjmp	avr45F1			; 45EE C002
avr45EF:	subi	r16, 0x60		; 45EF 5600
			ldi	r17, 0x03			; 45F0 E013

avr45F1:	cpi	r16, 0x00			; 45F1 3000
			brne	avr45F4			; 45F2 F409
			rjmp	avr4656			; 45F3 C062
avr45F4:	cpi	r16, 0x01			; 45F4 3001
			brne	avr45F7			; 45F5 F409
			rjmp	avr4696			; 45F6 C09F
avr45F7:	cpi	r16, 0x02			; 45F7 3002
			brne	avr45FA			; 45F8 F409
			rjmp	avr46D0			; 45F9 C0D6
avr45FA:	cpi	r16, 0x03			; 45FA 3003
			brne	avr45FD			; 45FB F409
			rjmp	avr470A			; 45FC C10D
avr45FD:	cpi	r16, 0x04			; 45FD 3004
			brne	avr4600			; 45FE F409
			rjmp	avr4744			; 45FF C144
avr4600:	cpi	r16, 0x05			; 4600 3005
			brne	avr4603			; 4601 F409
			rjmp	avr477E			; 4602 C17B
avr4603:	cpi	r16, 0x06			; 4603 3006
			brne	avr4606			; 4604 F409
			rjmp	avr47B8			; 4605 C1B2
avr4606:	cpi	r16, 0x07			; 4606 3007
			brne	avr4609			; 4607 F409
			rjmp	avr47F2			; 4608 C1E9
avr4609:	cpi	r16, 0x08			; 4609 3008
			brne	avr460C			; 460A F409
			rjmp	avr482C			; 460B C220
avr460C:	cpi	r16, 0x09			; 460C 3009
			brne	avr460F			; 460D F409
			rjmp	avr4866			; 460E C257
avr460F:	cpi	r16, 0x0A			; 460F 300A
			brne	avr4612			; 4610 F409
			rjmp	avr48A0			; 4611 C28E
avr4612:	cpi	r16, 0x0B			; 4612 300B
			brne	avr4615			; 4613 F409
			rjmp	avr48DA			; 4614 C2C5
avr4615:	cpi	r16, 0x0C			; 4615 300C
			brne	avr4618			; 4616 F409
			rjmp	avr4914			; 4617 C2FC
avr4618:	cpi	r16, 0x0D			; 4618 300D
			brne	avr461B			; 4619 F409
			rjmp	avr494E			; 461A C333
avr461B:	cpi	r16, 0x0E			; 461B 300E
			brne	avr461E			; 461C F409
			rjmp	avr4988			; 461D C36A
avr461E:	cpi	r16, 0x0F			; 461E 300F
			brne	avr4621			; 461F F409
			rjmp	avr49C2			; 4620 C3A1
avr4621:	cpi	r16, 0x10			; 4621 3100
			brne	avr4624			; 4622 F409
			rjmp	avr49FC			; 4623 C3D8
avr4624:	cpi	r16, 0x11			; 4624 3101
			brne	avr4627			; 4625 F409
			rjmp	avr4A36			; 4626 C40F
avr4627:	cpi	r16, 0x12			; 4627 3102
			brne	avr462A			; 4628 F409
			rjmp	avr4A70			; 4629 C446
avr462A:	cpi	r16, 0x13			; 462A 3103
			brne	avr462D			; 462B F409
			rjmp	avr4AAA			; 462C C47D
avr462D:	cpi	r16, 0x14			; 462D 3104
			brne	avr4630			; 462E F409
			rjmp	avr4AE4			; 462F C4B4
avr4630:	cpi	r16, 0x15			; 4630 3105
			brne	avr4633			; 4631 F409
			rjmp	avr4B1E			; 4632 C4EB
avr4633:	cpi	r16, 0x16			; 4633 3106
			brne	avr4636			; 4634 F409
			rjmp	avr4B58			; 4635 C522
avr4636:	cpi	r16, 0x17			; 4636 3107
			brne	avr4639			; 4637 F409
			rjmp	avr4B92			; 4638 C559
avr4639:	cpi	r16, 0x18			; 4639 3108
			brne	avr463C			; 463A F409
			rjmp	avr4BCC			; 463B C590
avr463C:	cpi	r16, 0x19			; 463C 3109
			brne	avr463F			; 463D F409
			rjmp	avr4C06			; 463E C5C7
avr463F:	cpi	r16, 0x1A			; 463F 310A
			brne	avr4642			; 4640 F409
			rjmp	avr4C40			; 4641 C5FE
avr4642:	cpi	r16, 0x1B			; 4642 310B
			brne	avr4645			; 4643 F409
			rjmp	avr4C7A			; 4644 C635
avr4645:	cpi	r16, 0x1C			; 4645 310C
			brne	avr4648			; 4646 F409
			rjmp	avr4CB4			; 4647 C66C
avr4648:	cpi	r16, 0x1D			; 4648 310D
			brne	avr464B			; 4649 F409
			rjmp	avr4CEE			; 464A C6A3
avr464B:	cpi	r16, 0x1E			; 464B 310E
			brne	avr464E			; 464C F409
			rjmp	avr4D50			; 464D C702
avr464E:	cpi	r16, 0x1F			; 464E 310F
			brne	avr4651			; 464F F409
			rjmp	avr4654			; 4650 C003
avr4651:	clr	YL					; 4651 27CC
			jmp	avr4E14				; 4652 940C 4E14
avr4654:	jmp	avr4DB2				; 4654 940C 4DB2

;----------------------------------------------------------------------
; 
avr4656:	cbi	PORTA, 0			; 4656 98D8 set output low
			sbi	DDRA, 0				; 4657 9AD0
			ldi	r16, 0x14			; 4658 E104 hold low for 5 microsec
avr4659:	dec	r16					; 4659 950A
			brne	avr4659			; 465A F7F1
			sbi	PORTA, 0			; 465B 9AD8 set hi
			call	sub4E24			; 465C 940E 4E24 hold for length of pulse in r17
			nop						; 465E 0000
			nop						; 465F 0000
			nop						; 4660 0000
			cbi	PORTA, 0			; 4661 98D8 set low again
			call	sub4E24			; 4662 940E 4E24 hold for length of time in r17
			nop						; 4664 0000
			nop						; 4665 0000
			nop						; 4666 0000
			nop						; 4667 0000
;------------
;New 2.7 code
			lds		r17, 0x0514
			sbrc	r17, 7
			jmp		0x00005097
;------------

			ldi	r16, 0x64			; 4668 E604 plus 40 microsec
avr4669:	dec	r16					; 4669 950A
			brne	avr4669			; 466A F7F1
			cbi	DDRA, 0				; 466B 98D0 set to input
			sbi	PORTA, 0			; 466C 9AD8
			nop						; 466D 0000

			ldi	r16, 0x0A			; 466E E00A
avr466F:	dec	r16					; 466F 950A
			brne	avr466F			; 4670 F7F1
			sbic	PINA, 0			; 4671 99C8 if it is high then exit
			rjmp	avr4691			; 4672 C01E
			ldi	YL, 0x01			; 4673 E0C1 result = 1
			clr	r16					; 4674 2700
avr4675:	nop						; 4675 0000
			nop						; 4676 0000
			nop						; 4677 0000
			nop						; 4678 0000
			nop						; 4679 0000
			sbic	PINA, 0			; 467A 99C8
			rjmp	avr467F			; 467B C003
			dec	r16					; 467C 950A
			brne	avr4675			; 467D F7B9
			rjmp	avr4691			; 467E C012
avr467F:	call	sub4ECD			; 467F 940E 4ECD wait 4 microsec
avr4681:	sbis	PINA, 0			; 4681 9BC8
			rjmp	avr468C			; 4682 C009
			cpi	YL, 0xFA			; 4683 3FCA
			brne	avr4688			; 4684 F419
			rjmp	avr468C			; 4685 C006
			nop						; 4686 0000
			nop						; 4687 0000
avr4688:	call	sub4ED2			; 4688 940E 4ED2
			inc	YL					; 468A 95C3
			rjmp	avr4681			; 468B CFF5
avr468C:		cbi	PORTA, 0		; 468C 98D8
			sbi	DDRA, 0				; 468D 9AD0
			ldi	r16, 0x00			; 468E E000
			jmp	avr4E14				; 468F 940C 4E14
avr4691:	cbi	PORTA, 0			; 4691 98D8
			sbi	DDRA, 0				; 4692 9AD0
			clr	YL					; 4693 27CC
			jmp	avr4E14				; 4694 940C 4E14



avr4696:		cbi	PORTA, 1	; 4696 98D9
		sbi	DDRA, 1	; 4697 9AD1
	ldi	r16, 0x14		; 4698 E104
avr4699:	dec	r16			; 4699 950A
		brne	avr4699		; 469A F7F1
		sbi	PORTA, 1	; 469B 9AD9
		call	sub4E24		; 469C 940E 4E24
		nop				; 469E 0000
		nop				; 469F 0000
		nop				; 46A0 0000
		cbi	PORTA, 1	; 46A1 98D9
		call	sub4E24		; 46A2 940E 4E24
		nop				; 46A4 0000
		nop				; 46A5 0000
		nop				; 46A6 0000
		nop				; 46A7 0000
;-------------
;2.7 code
		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTA, 1	; 46A8 9AD9
		cbi	DDRA, 1	; 46A9 98D1
		nop				; 46AA 0000
		sbic	PINA, 1	; 46AB 99C9
		rjmp	avr46CB		; 46AC C01E
		ldi	YL, 0x01		; 46AD E0C1
		clr	r16			; 46AE 2700
avr46AF:	nop				; 46AF 0000
		nop				; 46B0 0000
		nop				; 46B1 0000
		nop				; 46B2 0000
		nop				; 46B3 0000
		sbic	PINA, 1	; 46B4 99C9
		rjmp	avr46B9		; 46B5 C003
		dec	r16			; 46B6 950A
		brne	avr46AF		; 46B7 F7B9
		rjmp	avr46CB		; 46B8 C012
avr46B9:	call	sub4ECD		; 46B9 940E 4ECD
avr46BB:		sbis	PINA, 1	; 46BB 9BC9
		rjmp	avr46C6		; 46BC C009
		cpi	YL, 0xFA		; 46BD 3FCA
		brne	avr46C2		; 46BE F419
		rjmp	avr46C6		; 46BF C006
		nop				; 46C0 0000
		nop				; 46C1 0000
avr46C2:	call	sub4ED2		; 46C2 940E 4ED2
		inc	YL			; 46C4 95C3
		rjmp	avr46BB		; 46C5 CFF5
avr46C6:	cbi	PORTA, 1	; 46C6 98D9
		sbi	DDRA, 1	; 46C7 9AD1
		ldi	r16, 0x01		; 46C8 E001
		jmp	avr4E14		; 46C9 940C 4E14
avr46CB:	cbi	PORTA, 1	; 46CB 98D9
		sbi	DDRA, 1	; 46CC 9AD1
		clr	YL			; 46CD 27CC
		jmp	avr4E14		; 46CE 940C 4E14

avr46D0:		cbi	PORTA, 2	; 46D0 98DA
		sbi	DDRA, 2	; 46D1 9AD2
		ldi	r16, 0x14		; 46D2 E104
avr46D3:	dec	r16			; 46D3 950A
		brne	avr46D3		; 46D4 F7F1
		sbi	PORTA, 2	; 46D5 9ADA
		call	sub4E24		; 46D6 940E 4E24
		nop				; 46D8 0000
		nop				; 46D9 0000
		nop				; 46DA 0000
		cbi	PORTA, 2	; 46DB 98DA
		call	sub4E24		; 46DC 940E 4E24
		nop				; 46DE 0000
		nop				; 46DF 0000
		nop				; 46E0 0000
		nop				; 46E1 0000
		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
		sbi	PORTA, 2	; 46E2 9ADA
		cbi	DDRA, 2	; 46E3 98D2
		nop				; 46E4 0000
		sbic	PINA, 2	; 46E5 99CA
		rjmp	avr4705		; 46E6 C01E
		ldi	YL, 0x01		; 46E7 E0C1
		clr	r16			; 46E8 2700
avr46E9:	nop				; 46E9 0000
		nop				; 46EA 0000
		nop				; 46EB 0000
		nop				; 46EC 0000
		nop				; 46ED 0000
		sbic	PINA, 2	; 46EE 99CA
		rjmp	avr46F3		; 46EF C003
		dec	r16			; 46F0 950A
		brne	avr46E9		; 46F1 F7B9
		rjmp	avr4705		; 46F2 C012
avr46F3:	call	sub4ECD		; 46F3 940E 4ECD
avr46F5:	sbis	PINA, 2	; 46F5 9BCA
		rjmp	avr4700		; 46F6 C009
		cpi	YL, 0xFA		; 46F7 3FCA
		brne	avr46FC		; 46F8 F419
		rjmp	avr4700		; 46F9 C006
		nop				; 46FA 0000
		nop				; 46FB 0000
avr46FC:	call	sub4ED2		; 46FC 940E 4ED2
		inc	YL			; 46FE 95C3
		rjmp	avr46F5		; 46FF CFF5
avr4700:	cbi	PORTA, 2	; 4700 98DA
		sbi	DDRA, 2	; 4701 9AD2
		ldi	r16, 0x02		; 4702 E002
		jmp	avr4E14		; 4703 940C 4E14
avr4705:	cbi	PORTA, 2	; 4705 98DA
		sbi	DDRA, 2	; 4706 9AD2
		clr	YL			; 4707 27CC
		jmp	avr4E14		; 4708 940C 4E14

avr470A:		cbi	PORTA, 3	; 470A 98DB
		sbi	DDRA, 3	; 470B 9AD3
		ldi	r16, 0x14		; 470C E104
avr470D:	dec	r16			; 470D 950A
		brne	avr470D		; 470E F7F1
		sbi	PORTA, 3	; 470F 9ADB
		call	sub4E24		; 4710 940E 4E24
		nop				; 4712 0000
		nop				; 4713 0000
		nop				; 4714 0000
		cbi	PORTA, 3	; 4715 98DB
		call	sub4E24		; 4716 940E 4E24
		nop				; 4718 0000
		nop				; 4719 0000
		nop				; 471A 0000
		nop				; 471B 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTA, 3	; 471C 9ADB
		cbi	DDRA, 3	; 471D 98D3
		nop				; 471E 0000
		sbic	PINA, 3	; 471F 99CB
		rjmp	avr473F		; 4720 C01E
		ldi	YL, 0x01		; 4721 E0C1
		clr	r16			; 4722 2700
avr4723:	nop				; 4723 0000
		nop				; 4724 0000
		nop				; 4725 0000
		nop				; 4726 0000
		nop				; 4727 0000
		sbic	PINA, 3	; 4728 99CB
		rjmp	avr472D		; 4729 C003
		dec	r16			; 472A 950A
		brne	avr4723		; 472B F7B9
		rjmp	avr473F		; 472C C012
avr472D:	call	sub4ECD		; 472D 940E 4ECD
avr472F:	sbis	PINA, 3	; 472F 9BCB
		rjmp	avr473A		; 4730 C009
		cpi	YL, 0xFA		; 4731 3FCA
		brne	avr4736		; 4732 F419
		rjmp	avr473A		; 4733 C006
		nop				; 4734 0000
		nop				; 4735 0000
avr4736:	call	sub4ED2		; 4736 940E 4ED2
		inc	YL			; 4738 95C3
		rjmp	avr472F		; 4739 CFF5
avr473A:	cbi	PORTA, 3	; 473A 98DB
		sbi	DDRA, 3	; 473B 9AD3
		ldi	r16, 0x03		; 473C E003
		jmp	avr4E14		; 473D 940C 4E14
avr473F:	cbi	PORTA, 3	; 473F 98DB
		sbi	DDRA, 3	; 4740 9AD3
		clr	YL			; 4741 27CC
		jmp	avr4E14		; 4742 940C 4E14

avr4744:		cbi	PORTA, 4	; 4744 98DC
		sbi	DDRA, 4	; 4745 9AD4
		ldi	r16, 0x14		; 4746 E104
avr4747:	dec	r16			; 4747 950A
		brne	avr4747		; 4748 F7F1
		sbi	PORTA, 4	; 4749 9ADC
		call	sub4E24		; 474A 940E 4E24
		nop				; 474C 0000
		nop				; 474D 0000
		nop				; 474E 0000
		cbi	PORTA, 4	; 474F 98DC
		call	sub4E24		; 4750 940E 4E24
		nop				; 4752 0000
		nop				; 4753 0000
		nop				; 4754 0000
		nop				; 4755 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTA, 4	; 4756 9ADC
		cbi	DDRA, 4	; 4757 98D4
		nop				; 4758 0000
		sbic	PINA, 4	; 4759 99CC
		rjmp	avr4779		; 475A C01E
		ldi	YL, 0x01		; 475B E0C1
		clr	r16			; 475C 2700
avr475D:	nop				; 475D 0000
		nop				; 475E 0000
		nop				; 475F 0000
		nop				; 4760 0000
		nop				; 4761 0000
		sbic	PINA, 4	; 4762 99CC
		rjmp	avr4767		; 4763 C003
		dec	r16			; 4764 950A
		brne	avr475D		; 4765 F7B9
		rjmp	avr4779		; 4766 C012
avr4767:	call	sub4ECD		; 4767 940E 4ECD
avr4769:sbis	PINA, 4	; 4769 9BCC
		rjmp	avr4774		; 476A C009
		cpi	YL, 0xFA		; 476B 3FCA
		brne	avr4770		; 476C F419
		rjmp	avr4774		; 476D C006
		nop				; 476E 0000
		nop				; 476F 0000
avr4770:	call	sub4ED2		; 4770 940E 4ED2
		inc	YL			; 4772 95C3
		rjmp	avr4769		; 4773 CFF5
avr4774:	cbi	PORTA, 4	; 4774 98DC
		sbi	DDRA, 4	; 4775 9AD4
		ldi	r16, 0x04		; 4776 E004
		jmp	avr4E14		; 4777 940C 4E14
avr4779:		cbi	PORTA, 4	; 4779 98DC
		sbi	DDRA, 4	; 477A 9AD4
		clr	YL			; 477B 27CC
		jmp	avr4E14		; 477C 940C 4E14

avr477E:		cbi	PORTA, 5	; 477E 98DD
		sbi	DDRA, 5	; 477F 9AD5
		ldi	r16, 0x14		; 4780 E104
avr4781:	dec	r16			; 4781 950A
		brne	avr4781		; 4782 F7F1
		sbi	PORTA, 5	; 4783 9ADD
		call	sub4E24		; 4784 940E 4E24
		nop				; 4786 0000
		nop				; 4787 0000
		nop				; 4788 0000
		cbi	PORTA, 5	; 4789 98DD
		call	sub4E24		; 478A 940E 4E24
		nop				; 478C 0000
		nop				; 478D 0000
		nop				; 478E 0000
		nop				; 478F 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTA, 5	; 4790 9ADD
		cbi	DDRA, 5	; 4791 98D5
		nop				; 4792 0000
		sbic	PINA, 5	; 4793 99CD
		rjmp	avr47B3		; 4794 C01E
		ldi	YL, 0x01		; 4795 E0C1
		clr	r16			; 4796 2700
avr4797:	nop				; 4797 0000
		nop				; 4798 0000
		nop				; 4799 0000
		nop				; 479A 0000
		nop				; 479B 0000
		sbic	PINA, 5	; 479C 99CD
		rjmp	avr47A1		; 479D C003
		dec	r16			; 479E 950A
		brne	avr4797		; 479F F7B9
		rjmp	avr47B3		; 47A0 C012
avr47A1:	call	sub4ECD		; 47A1 940E 4ECD
avr47A3:	sbis	PINA, 5	; 47A3 9BCD
		rjmp	avr47AE		; 47A4 C009
		cpi	YL, 0xFA		; 47A5 3FCA
		brne	avr47AA		; 47A6 F419
		rjmp	avr47AE		; 47A7 C006
		nop				; 47A8 0000
		nop				; 47A9 0000
avr47AA:	call	sub4ED2		; 47AA 940E 4ED2
		inc	YL			; 47AC 95C3
		rjmp	avr47A3		; 47AD CFF5
avr47AE:	cbi	PORTA, 5	; 47AE 98DD
		sbi	DDRA, 5	; 47AF 9AD5
		ldi	r16, 0x05		; 47B0 E005
		jmp	avr4E14		; 47B1 940C 4E14
avr47B3:	cbi	PORTA, 5	; 47B3 98DD
		sbi	DDRA, 5	; 47B4 9AD5
		clr	YL			; 47B5 27CC
		jmp	avr4E14		; 47B6 940C 4E14

avr47B8:		cbi	PORTA, 6	; 47B8 98DE
		sbi	DDRA, 6	; 47B9 9AD6
		ldi	r16, 0x14		; 47BA E104
avr47BB:		dec	r16			; 47BB 950A
		brne	avr47BB		; 47BC F7F1
		sbi	PORTA, 6	; 47BD 9ADE
		call	sub4E24		; 47BE 940E 4E24
		nop				; 47C0 0000
		nop				; 47C1 0000
		nop				; 47C2 0000
		cbi	PORTA, 6	; 47C3 98DE
		call	sub4E24		; 47C4 940E 4E24
		nop				; 47C6 0000
		nop				; 47C7 0000
		nop				; 47C8 0000
		nop				; 47C9 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTA, 6	; 47CA 9ADE
		cbi	DDRA, 6	; 47CB 98D6
		nop				; 47CC 0000
		sbic	PINA, 6	; 47CD 99CE
		rjmp	avr47ED		; 47CE C01E
		ldi	YL, 0x01		; 47CF E0C1
		clr	r16			; 47D0 2700
avr47D1:	nop				; 47D1 0000
		nop				; 47D2 0000
		nop				; 47D3 0000
		nop				; 47D4 0000
		nop				; 47D5 0000
		sbic	PINA, 6	; 47D6 99CE
		rjmp	avr47DB		; 47D7 C003
		dec	r16			; 47D8 950A
		brne	avr47D1		; 47D9 F7B9
		rjmp	avr47ED		; 47DA C012
avr47DB:	call	sub4ECD		; 47DB 940E 4ECD
avr47DD:	sbis	PINA, 6	; 47DD 9BCE
		rjmp	avr47E8		; 47DE C009
		cpi	YL, 0xFA		; 47DF 3FCA
		brne	avr47E4		; 47E0 F419
		rjmp	avr47E8		; 47E1 C006
		nop				; 47E2 0000
		nop				; 47E3 0000
avr47E4:	call	sub4ED2		; 47E4 940E 4ED2
		inc	YL			; 47E6 95C3
		rjmp	avr47DD		; 47E7 CFF5
avr47E8:	cbi	PORTA, 6	; 47E8 98DE
		sbi	DDRA, 6	; 47E9 9AD6
		ldi	r16, 0x06		; 47EA E006
		jmp	avr4E14		; 47EB 940C 4E14
avr47ED:	cbi	PORTA, 6	; 47ED 98DE
		sbi	DDRA, 6	; 47EE 9AD6
		clr	YL			; 47EF 27CC
		jmp	avr4E14		; 47F0 940C 4E14

avr47F2:		cbi	PORTA, 7	; 47F2 98DF
		sbi	DDRA, 7	; 47F3 9AD7
		ldi	r16, 0x14		; 47F4 E104
avr47F5:	dec	r16			; 47F5 950A
		brne	avr47F5		; 47F6 F7F1
		sbi	PORTA, 7	; 47F7 9ADF
		call	sub4E24		; 47F8 940E 4E24
		nop				; 47FA 0000
		nop				; 47FB 0000
		nop				; 47FC 0000
		cbi	PORTA, 7	; 47FD 98DF
		call	sub4E24		; 47FE 940E 4E24
		nop				; 4800 0000
		nop				; 4801 0000
		nop				; 4802 0000
		nop				; 4803 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTA, 7	; 4804 9ADF
		cbi	DDRA, 7	; 4805 98D7
		nop				; 4806 0000
		sbic	PINA, 7	; 4807 99CF
		rjmp	avr4827		; 4808 C01E
		ldi	YL, 0x01		; 4809 E0C1
		clr	r16			; 480A 2700
avr480B:	nop				; 480B 0000
		nop				; 480C 0000
		nop				; 480D 0000
		nop				; 480E 0000
		nop				; 480F 0000
		sbic	PINA, 7	; 4810 99CF
		rjmp	avr4815		; 4811 C003
		dec	r16			; 4812 950A
		brne	avr480B		; 4813 F7B9
		rjmp	avr4827		; 4814 C012
avr4815:	call	sub4ECD		; 4815 940E 4ECD
avr4817:	sbis	PINA, 7	; 4817 9BCF
		rjmp	avr4822		; 4818 C009
		cpi	YL, 0xFA		; 4819 3FCA
		brne	avr481E		; 481A F419
		rjmp	avr4822		; 481B C006
		nop				; 481C 0000
		nop				; 481D 0000
avr481E:	call	sub4ED2		; 481E 940E 4ED2
		inc	YL			; 4820 95C3
		rjmp	avr4817		; 4821 CFF5
avr4822:	cbi	PORTA, 7	; 4822 98DF
		sbi	DDRA, 7	; 4823 9AD7
		ldi	r16, 0x07		; 4824 E007
		jmp	avr4E14		; 4825 940C 4E14
avr4827:	cbi	PORTA, 7	; 4827 98DF
		sbi	DDRA, 7	; 4828 9AD7
		clr	YL			; 4829 27CC
		jmp	avr4E14		; 482A 940C 4E14

avr482C:	cbi	PORTB, 0	; 482C 98C0
		sbi	DDRB, 0	; 482D 9AB8
		ldi	r16, 0x14		; 482E E104
avr482F:	dec	r16			; 482F 950A
		brne	avr482F		; 4830 F7F1
		sbi	PORTB, 0	; 4831 9AC0
		call	sub4E24		; 4832 940E 4E24
		nop				; 4834 0000
		nop				; 4835 0000
		nop				; 4836 0000
		cbi	PORTB, 0	; 4837 98C0
		call	sub4E24		; 4838 940E 4E24
		nop				; 483A 0000
		nop				; 483B 0000
		nop				; 483C 0000
		nop				; 483D 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 0	; 483E 9AC0
		cbi	DDRB, 0	; 483F 98B8
		nop				; 4840 0000
		sbic	PINB, 0	; 4841 99B0
		rjmp	avr4861		; 4842 C01E
		ldi	YL, 0x01		; 4843 E0C1
		clr	r16			; 4844 2700
avr4845:		nop				; 4845 0000
		nop				; 4846 0000
		nop				; 4847 0000
		nop				; 4848 0000
		nop				; 4849 0000
		sbic	PINB, 0	; 484A 99B0
		rjmp	avr484F		; 484B C003
		dec	r16			; 484C 950A
		brne	avr4845		; 484D F7B9
		rjmp	avr4861		; 484E C012
avr484F:	call	sub4ECD		; 484F 940E 4ECD
avr4851:	sbis	PINB, 0	; 4851 9BB0
		rjmp	avr485C		; 4852 C009
		cpi	YL, 0xFA		; 4853 3FCA
		brne	avr4858		; 4854 F419
		rjmp	avr485C		; 4855 C006
		nop				; 4856 0000
		nop				; 4857 0000
avr4858:	call	sub4ED2		; 4858 940E 4ED2
		inc	YL			; 485A 95C3
		rjmp	avr4851		; 485B CFF5
avr485C:	cbi	PORTB, 0	; 485C 98C0
		sbi	DDRB, 0	; 485D 9AB8
		ldi	r16, 0x08		; 485E E008
		jmp	avr4E14		; 485F 940C 4E14
avr4861:	cbi	PORTB, 0	; 4861 98C0
		sbi	DDRB, 0	; 4862 9AB8
		clr	YL			; 4863 27CC
		jmp	avr4E14		; 4864 940C 4E14

avr4866:	cbi	PORTB, 1	; 4866 98C1
		sbi	DDRB, 1	; 4867 9AB9
		ldi	r16, 0x14		; 4868 E104
avr4869:	dec	r16			; 4869 950A
		brne	avr4869		; 486A F7F1
		sbi	PORTB, 1	; 486B 9AC1
		call	sub4E24		; 486C 940E 4E24
		nop				; 486E 0000
		nop				; 486F 0000
		nop				; 4870 0000
		cbi	PORTB, 1	; 4871 98C1
		call	sub4E24		; 4872 940E 4E24
		nop				; 4874 0000
		nop				; 4875 0000
		nop				; 4876 0000
		nop				; 4877 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 1	; 4878 9AC1
		cbi	DDRB, 1	; 4879 98B9
		nop				; 487A 0000
		sbic	PINB, 1	; 487B 99B1
		rjmp	avr489B		; 487C C01E
		ldi	YL, 0x01		; 487D E0C1
		clr	r16			; 487E 2700
avr487F:	nop				; 487F 0000
		nop				; 4880 0000
		nop				; 4881 0000
		nop				; 4882 0000
		nop				; 4883 0000
		sbic	PINB, 1	; 4884 99B1
		rjmp	avr4889		; 4885 C003
		dec	r16			; 4886 950A
		brne	avr487F		; 4887 F7B9
		rjmp	avr489B		; 4888 C012
avr4889:	call	sub4ECD		; 4889 940E 4ECD
avr488B:	sbis	PINB, 1	; 488B 9BB1
		rjmp	avr4896		; 488C C009
		cpi	YL, 0xFA		; 488D 3FCA
		brne	avr4892		; 488E F419
		rjmp	avr4896		; 488F C006
		nop				; 4890 0000
		nop				; 4891 0000
avr4892:	call	sub4ED2		; 4892 940E 4ED2
		inc	YL			; 4894 95C3
		rjmp	avr488B		; 4895 CFF5
avr4896:	cbi	PORTB, 1	; 4896 98C1
		sbi	DDRB, 1	; 4897 9AB9
		ldi	r16, 0x09		; 4898 E009
		jmp	avr4E14		; 4899 940C 4E14
avr489B:	cbi	PORTB, 1	; 489B 98C1
		sbi	DDRB, 1	; 489C 9AB9
		clr	YL			; 489D 27CC
		jmp	avr4E14		; 489E 940C 4E14

avr48A0:	cbi	PORTB, 2	; 48A0 98C2
		sbi	DDRB, 2	; 48A1 9ABA
		ldi	r16, 0x14		; 48A2 E104
avr48A3:	dec	r16			; 48A3 950A
		brne	avr48A3		; 48A4 F7F1
		sbi	PORTB, 2	; 48A5 9AC2
		call	sub4E24		; 48A6 940E 4E24
		nop				; 48A8 0000
		nop				; 48A9 0000
		nop				; 48AA 0000
		cbi	PORTB, 2	; 48AB 98C2
		call	sub4E24		; 48AC 940E 4E24
		nop				; 48AE 0000
		nop				; 48AF 0000
		nop				; 48B0 0000
		nop				; 48B1 0000

;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------	
		sbi	PORTB, 2	; 48B2 9AC2
		cbi	DDRB, 2	; 48B3 98BA
		nop				; 48B4 0000
		sbic	PINB, 2	; 48B5 99B2
		rjmp	avr48D5		; 48B6 C01E
		ldi	YL, 0x01		; 48B7 E0C1
		clr	r16			; 48B8 2700
avr48B9:	nop				; 48B9 0000
		nop				; 48BA 0000
		nop				; 48BB 0000
		nop				; 48BC 0000
		nop				; 48BD 0000
		sbic	PINB, 2	; 48BE 99B2
		rjmp	avr48C3		; 48BF C003
		dec	r16			; 48C0 950A
		brne	avr48B9		; 48C1 F7B9
		rjmp	avr48D5		; 48C2 C012
avr48C3:	call	sub4ECD		; 48C3 940E 4ECD
avr48C5:	sbis	PINB, 2	; 48C5 9BB2
		rjmp	avr48D0		; 48C6 C009
		cpi	YL, 0xFA		; 48C7 3FCA
		brne	avr48CC		; 48C8 F419
		rjmp	avr48D0		; 48C9 C006
		nop				; 48CA 0000
		nop				; 48CB 0000
avr48CC:	call	sub4ED2		; 48CC 940E 4ED2
		inc	YL			; 48CE 95C3
		rjmp	avr48C5		; 48CF CFF5
avr48D0:	cbi	PORTB, 2	; 48D0 98C2
		sbi	DDRB, 2	; 48D1 9ABA
		ldi	r16, 0x0A		; 48D2 E00A
		jmp	avr4E14		; 48D3 940C 4E14
avr48D5:	cbi	PORTB, 2	; 48D5 98C2
		sbi	DDRB, 2	; 48D6 9ABA
		clr	YL			; 48D7 27CC
		jmp	avr4E14		; 48D8 940C 4E14

avr48DA:		cbi	PORTB, 3	; 48DA 98C3
		sbi	DDRB, 3	; 48DB 9ABB
		ldi	r16, 0x14		; 48DC E104
avr48DD:	dec	r16			; 48DD 950A
		brne	avr48DD		; 48DE F7F1
		sbi	PORTB, 3	; 48DF 9AC3
		call	sub4E24		; 48E0 940E 4E24
		nop				; 48E2 0000
		nop				; 48E3 0000
		nop				; 48E4 0000
		cbi	PORTB, 3	; 48E5 98C3
		call	sub4E24		; 48E6 940E 4E24
		nop				; 48E8 0000
		nop				; 48E9 0000
		nop				; 48EA 0000
		nop				; 48EB 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 3	; 48EC 9AC3
		cbi	DDRB, 3	; 48ED 98BB
		nop				; 48EE 0000
		sbic	PINB, 3	; 48EF 99B3
		rjmp	avr490F		; 48F0 C01E
		ldi	YL, 0x01		; 48F1 E0C1
		clr	r16			; 48F2 2700
avr48F3:	nop				; 48F3 0000
		nop				; 48F4 0000
		nop				; 48F5 0000
		nop				; 48F6 0000
		nop				; 48F7 0000
		sbic	PINB, 3	; 48F8 99B3
		rjmp	avr48FD		; 48F9 C003
		dec	r16			; 48FA 950A
		brne	avr48F3		; 48FB F7B9
		rjmp	avr490F		; 48FC C012
avr48FD:	call	sub4ECD		; 48FD 940E 4ECD
avr48FF:	sbis	PINB, 3	; 48FF 9BB3
		rjmp	avr490A		; 4900 C009
		cpi	YL, 0xFA		; 4901 3FCA
		brne	avr4906		; 4902 F419
		rjmp	avr490A		; 4903 C006
		nop				; 4904 0000
		nop				; 4905 0000
avr4906:	call	sub4ED2		; 4906 940E 4ED2
		inc	YL			; 4908 95C3
		rjmp	avr48FF		; 4909 CFF5
avr490A:	cbi	PORTB, 3	; 490A 98C3
		sbi	DDRB, 3	; 490B 9ABB
		ldi	r16, 0x0B		; 490C E00B
		jmp	avr4E14		; 490D 940C 4E14
avr490F:	cbi	PORTB, 3	; 490F 98C3
		sbi	DDRB, 3	; 4910 9ABB
		clr	YL			; 4911 27CC
		jmp	avr4E14		; 4912 940C 4E14

avr4914:		cbi	PORTB, 4	; 4914 98C4
		sbi	DDRB, 4	; 4915 9ABC
		ldi	r16, 0x14		; 4916 E104
avr4917:	dec	r16			; 4917 950A
		brne	avr4917		; 4918 F7F1
		sbi	PORTB, 4	; 4919 9AC4
		call	sub4E24		; 491A 940E 4E24
		nop				; 491C 0000
		nop				; 491D 0000
		nop				; 491E 0000
		cbi	PORTB, 4	; 491F 98C4
		call	sub4E24		; 4920 940E 4E24
		nop				; 4922 0000
		nop				; 4923 0000
		nop				; 4924 0000
		nop				; 4925 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 4	; 4926 9AC4
		cbi	DDRB, 4	; 4927 98BC
		nop				; 4928 0000
		sbic	PINB, 4	; 4929 99B4
		rjmp	avr4949		; 492A C01E
		ldi	YL, 0x01		; 492B E0C1
		clr	r16			; 492C 2700
avr492D:	nop				; 492D 0000
		nop				; 492E 0000
		nop				; 492F 0000
		nop				; 4930 0000
		nop				; 4931 0000
		sbic	PINB, 4	; 4932 99B4
		rjmp	avr4937		; 4933 C003
		dec	r16			; 4934 950A
		brne	avr492D		; 4935 F7B9
		rjmp	avr4949		; 4936 C012
avr4937:	call	sub4ECD		; 4937 940E 4ECD
avr4939:	sbis	PINB, 4	; 4939 9BB4
		rjmp	avr4944		; 493A C009
		cpi	YL, 0xFA		; 493B 3FCA
		brne	avr4940		; 493C F419
		rjmp	avr4944		; 493D C006
		nop				; 493E 0000
		nop				; 493F 0000
avr4940:	call	sub4ED2		; 4940 940E 4ED2
		inc	YL			; 4942 95C3
		rjmp	avr4939		; 4943 CFF5
avr4944:	cbi	PORTB, 4	; 4944 98C4
		sbi	DDRB, 4	; 4945 9ABC
		ldi	r16, 0x0C		; 4946 E00C
		jmp	avr4E14		; 4947 940C 4E14
avr4949:	cbi	PORTB, 4	; 4949 98C4
		sbi	DDRB, 4	; 494A 9ABC
		clr	YL			; 494B 27CC
		jmp	avr4E14		; 494C 940C 4E14

avr494E:		cbi	PORTB, 5	; 494E 98C5
		sbi	DDRB, 5	; 494F 9ABD
		ldi	r16, 0x14		; 4950 E104
avr4951:	dec	r16			; 4951 950A
		brne	avr4951		; 4952 F7F1
		sbi	PORTB, 5	; 4953 9AC5
		call	sub4E24		; 4954 940E 4E24
		nop				; 4956 0000
		nop				; 4957 0000
		nop				; 4958 0000
		cbi	PORTB, 5	; 4959 98C5
		call	sub4E24		; 495A 940E 4E24
		nop				; 495C 0000
		nop				; 495D 0000
		nop				; 495E 0000
		nop				; 495F 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 5	; 4960 9AC5
		cbi	DDRB, 5	; 4961 98BD
		nop				; 4962 0000
		sbic	PINB, 5	; 4963 99B5
		rjmp	avr4983		; 4964 C01E
		ldi	YL, 0x01		; 4965 E0C1
		clr	r16			; 4966 2700
avr4967:	nop				; 4967 0000
		nop				; 4968 0000
		nop				; 4969 0000
		nop				; 496A 0000
		nop				; 496B 0000
		sbic	PINB, 5	; 496C 99B5
		rjmp	avr4971		; 496D C003
		dec	r16			; 496E 950A
		brne	avr4967		; 496F F7B9
		rjmp	avr4983		; 4970 C012
avr4971:	call	sub4ECD		; 4971 940E 4ECD
avr4973:	sbis	PINB, 5	; 4973 9BB5
		rjmp	avr497E		; 4974 C009
		cpi	YL, 0xFA		; 4975 3FCA
		brne	avr497A		; 4976 F419
		rjmp	avr497E		; 4977 C006
		nop				; 4978 0000
		nop				; 4979 0000
avr497A:	call	sub4ED2		; 497A 940E 4ED2
		inc	YL			; 497C 95C3
		rjmp	avr4973		; 497D CFF5
avr497E:	cbi	PORTB, 5	; 497E 98C5
		sbi	DDRB, 5	; 497F 9ABD
		ldi	r16, 0x0D		; 4980 E00D
		jmp	avr4E14		; 4981 940C 4E14
avr4983:	cbi	PORTB, 5	; 4983 98C5
		sbi	DDRB, 5	; 4984 9ABD
		clr	YL			; 4985 27CC
		jmp	avr4E14		; 4986 940C 4E14

avr4988:		cbi	PORTB, 6	; 4988 98C6
		sbi	DDRB, 6	; 4989 9ABE
		ldi	r16, 0x14		; 498A E104
avr498B:	dec	r16			; 498B 950A
		brne	avr498B		; 498C F7F1
		sbi	PORTB, 6	; 498D 9AC6
		call	sub4E24		; 498E 940E 4E24
		nop				; 4990 0000
		nop				; 4991 0000
		nop				; 4992 0000
		cbi	PORTB, 6	; 4993 98C6
		call	sub4E24		; 4994 940E 4E24
		nop				; 4996 0000
		nop				; 4997 0000
		nop				; 4998 0000
		nop				; 4999 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 6	; 499A 9AC6
		cbi	DDRB, 6	; 499B 98BE
		nop				; 499C 0000
		sbic	PINB, 6	; 499D 99B6
		rjmp	avr49BD		; 499E C01E
		ldi	YL, 0x01		; 499F E0C1
		clr	r16			; 49A0 2700
avr49A1:	nop				; 49A1 0000
		nop				; 49A2 0000
		nop				; 49A3 0000
		nop				; 49A4 0000
		nop				; 49A5 0000
		sbic	PINB, 6	; 49A6 99B6
		rjmp	avr49AB		; 49A7 C003
		dec	r16			; 49A8 950A
		brne	avr49A1		; 49A9 F7B9
		rjmp	avr49BD		; 49AA C012
avr49AB:	call	sub4ECD		; 49AB 940E 4ECD
avr49AD:	sbis	PINB, 6	; 49AD 9BB6
		rjmp	avr49B8		; 49AE C009
		cpi	YL, 0xFA		; 49AF 3FCA
		brne	avr49B4		; 49B0 F419
		rjmp	avr49B8		; 49B1 C006
		nop				; 49B2 0000
		nop				; 49B3 0000
avr49B4:	call	sub4ED2		; 49B4 940E 4ED2
		inc	YL			; 49B6 95C3
		rjmp	avr49AD		; 49B7 CFF5
avr49B8:cbi	PORTB, 6	; 49B8 98C6
		sbi	DDRB, 6	; 49B9 9ABE
		ldi	r16, 0x0E		; 49BA E00E
		jmp	avr4E14		; 49BB 940C 4E14
avr49BD:	cbi	PORTB, 6	; 49BD 98C6
		sbi	DDRB, 6	; 49BE 9ABE
		clr	YL			; 49BF 27CC
		jmp	avr4E14		; 49C0 940C 4E14

avr49C2:		cbi	PORTB, 7	; 49C2 98C7
		sbi	DDRB, 7	; 49C3 9ABF
		ldi	r16, 0x14		; 49C4 E104
avr49C5:	dec	r16			; 49C5 950A
		brne	avr49C5		; 49C6 F7F1
		sbi	PORTB, 7	; 49C7 9AC7
		call	sub4E24		; 49C8 940E 4E24
		nop				; 49CA 0000
		nop				; 49CB 0000
		nop				; 49CC 0000
		cbi	PORTB, 7	; 49CD 98C7
		call	sub4E24		; 49CE 940E 4E24
		nop				; 49D0 0000
		nop				; 49D1 0000
		nop				; 49D2 0000
		nop				; 49D3 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTB, 7	; 49D4 9AC7
		cbi	DDRB, 7	; 49D5 98BF
		nop				; 49D6 0000
		sbic	PINB, 7	; 49D7 99B7
		rjmp	avr49F7		; 49D8 C01E
		ldi	YL, 0x01		; 49D9 E0C1
		clr	r16			; 49DA 2700
avr49DB:	nop				; 49DB 0000
		nop				; 49DC 0000
		nop				; 49DD 0000
		nop				; 49DE 0000
		nop				; 49DF 0000
		sbic	PINB, 7	; 49E0 99B7
		rjmp	avr49E5		; 49E1 C003
		dec	r16			; 49E2 950A
		brne	avr49DB		; 49E3 F7B9
		rjmp	avr49F7		; 49E4 C012
avr49E5:	call	sub4ECD		; 49E5 940E 4ECD
avr49E7:	sbis	PINB, 7	; 49E7 9BB7
		rjmp	avr49F2		; 49E8 C009
		cpi	YL, 0xFA		; 49E9 3FCA
		brne	avr49EE		; 49EA F419
		rjmp	avr49F2		; 49EB C006
		nop				; 49EC 0000
		nop				; 49ED 0000
avr49EE:	call	sub4ED2		; 49EE 940E 4ED2
		inc	YL			; 49F0 95C3
		rjmp	avr49E7		; 49F1 CFF5
avr49F2:	cbi	PORTB, 7	; 49F2 98C7
		sbi	DDRB, 7	; 49F3 9ABF
		ldi	r16, 0x0F		; 49F4 E00F
		jmp	avr4E14		; 49F5 940C 4E14
avr49F7:	cbi	PORTB, 7	; 49F7 98C7
		sbi	DDRB, 7	; 49F8 9ABF
		clr	YL			; 49F9 27CC
		jmp	avr4E14		; 49FA 940C 4E14

avr49FC:	cbi	PORTC, 7	; 49FC 98AF
		sbi	DDRC, 7	; 49FD 9AA7
		ldi	r16, 0x14		; 49FE E104
avr49FF:	dec	r16			; 49FF 950A
		brne	avr49FF		; 4A00 F7F1
		sbi	PORTC, 7	; 4A01 9AAF
		call	sub4E24		; 4A02 940E 4E24
		nop				; 4A04 0000
		nop				; 4A05 0000
		nop				; 4A06 0000
		cbi	PORTC, 7	; 4A07 98AF
		call	sub4E24		; 4A08 940E 4E24
		nop				; 4A0A 0000
		nop				; 4A0B 0000
		nop				; 4A0C 0000
		nop				; 4A0D 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 7	; 4A0E 9AAF
		cbi	DDRC, 7	; 4A0F 98A7
		nop				; 4A10 0000
		sbic	PINC, 7	; 4A11 999F
		rjmp	avr4A31		; 4A12 C01E
		ldi	YL, 0x01		; 4A13 E0C1
		clr	r16			; 4A14 2700
avr4A15:	nop				; 4A15 0000
		nop				; 4A16 0000
		nop				; 4A17 0000
		nop				; 4A18 0000
		nop				; 4A19 0000
		sbic	PINC, 7	; 4A1A 999F
		rjmp	avr4A1F		; 4A1B C003
		dec	r16			; 4A1C 950A
		brne	avr4A15		; 4A1D F7B9
		rjmp	avr4A31		; 4A1E C012
avr4A1F:	call	sub4ECD		; 4A1F 940E 4ECD
avr4A21:	sbis	PINC, 7	; 4A21 9B9F
		rjmp	avr4A2C		; 4A22 C009
		cpi	YL, 0xFA		; 4A23 3FCA
		brne	avr4A28		; 4A24 F419
		rjmp	avr4A2C		; 4A25 C006
		nop				; 4A26 0000
		nop				; 4A27 0000
avr4A28:	call	sub4ED2		; 4A28 940E 4ED2
		inc	YL			; 4A2A 95C3
		rjmp	avr4A21		; 4A2B CFF5
avr4A2C:	cbi	PORTC, 7	; 4A2C 98AF
		sbi	DDRC, 7	; 4A2D 9AA7
		ldi	r16, 0x10		; 4A2E E100
		jmp	avr4E14		; 4A2F 940C 4E14
avr4A31:	cbi	PORTC, 7	; 4A31 98AF
		sbi	DDRC, 7	; 4A32 9AA7
		clr	YL			; 4A33 27CC
		jmp	avr4E14		; 4A34 940C 4E14

avr4A36:		cbi	PORTC, 6	; 4A36 98AE
		sbi	DDRC, 6	; 4A37 9AA6
		ldi	r16, 0x14		; 4A38 E104
avr4A39:	dec	r16			; 4A39 950A
		brne	avr4A39		; 4A3A F7F1
		sbi	PORTC, 6	; 4A3B 9AAE
		call	sub4E24		; 4A3C 940E 4E24
		nop				; 4A3E 0000
		nop				; 4A3F 0000
		nop				; 4A40 0000
		cbi	PORTC, 6	; 4A41 98AE
		call	sub4E24		; 4A42 940E 4E24
		nop				; 4A44 0000
		nop				; 4A45 0000
		nop				; 4A46 0000
		nop				; 4A47 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 6	; 4A48 9AAE
		cbi	DDRC, 6	; 4A49 98A6
		nop				; 4A4A 0000
		sbic	PINC, 6	; 4A4B 999E
		rjmp	avr4A6B		; 4A4C C01E
		ldi	YL, 0x01		; 4A4D E0C1
		clr	r16			; 4A4E 2700
avr4A4F:	nop				; 4A4F 0000
		nop				; 4A50 0000
		nop				; 4A51 0000
		nop				; 4A52 0000
		nop				; 4A53 0000
		sbic	PINC, 6	; 4A54 999E
		rjmp	avr4A59		; 4A55 C003
		dec	r16			; 4A56 950A
		brne	avr4A4F		; 4A57 F7B9
		rjmp	avr4A6B		; 4A58 C012
avr4A59:	call	sub4ECD		; 4A59 940E 4ECD
avr4A5B:	sbis	PINC, 6	; 4A5B 9B9E
		rjmp	avr4A66		; 4A5C C009
		cpi	YL, 0xFA		; 4A5D 3FCA
		brne	avr4A62		; 4A5E F419
		rjmp	avr4A66		; 4A5F C006
		nop				; 4A60 0000
		nop				; 4A61 0000
avr4A62:	call	sub4ED2		; 4A62 940E 4ED2
		inc	YL			; 4A64 95C3
		rjmp	avr4A5B		; 4A65 CFF5
avr4A66:	cbi	PORTC, 6	; 4A66 98AE
		sbi	DDRC, 6	; 4A67 9AA6
		ldi	r16, 0x11		; 4A68 E101
		jmp	avr4E14		; 4A69 940C 4E14
avr4A6B:	cbi	PORTC, 6	; 4A6B 98AE
		sbi	DDRC, 6	; 4A6C 9AA6
		clr	YL			; 4A6D 27CC
		jmp	avr4E14		; 4A6E 940C 4E14

avr4A70:	cbi	PORTC, 5	; 4A70 98AD
		sbi	DDRC, 5	; 4A71 9AA5
		ldi	r16, 0x14		; 4A72 E104
avr4A73:	dec	r16			; 4A73 950A
		brne	avr4A73		; 4A74 F7F1
		sbi	PORTC, 5	; 4A75 9AAD
		call	sub4E24		; 4A76 940E 4E24
		nop				; 4A78 0000
		nop				; 4A79 0000
		nop				; 4A7A 0000
		cbi	PORTC, 5	; 4A7B 98AD
		call	sub4E24		; 4A7C 940E 4E24
		nop				; 4A7E 0000
		nop				; 4A7F 0000
		nop				; 4A80 0000
		nop				; 4A81 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 5	; 4A82 9AAD
		cbi	DDRC, 5	; 4A83 98A5
		nop				; 4A84 0000
		sbic	PINC, 5	; 4A85 999D
		rjmp	avr4AA5		; 4A86 C01E
		ldi	YL, 0x01		; 4A87 E0C1
		clr	r16			; 4A88 2700
avr4A89:	nop				; 4A89 0000
		nop				; 4A8A 0000
		nop				; 4A8B 0000
		nop				; 4A8C 0000
		nop				; 4A8D 0000
		sbic	PINC, 5	; 4A8E 999D
		rjmp	avr4A93		; 4A8F C003
		dec	r16			; 4A90 950A
		brne	avr4A89		; 4A91 F7B9
		rjmp	avr4AA5		; 4A92 C012
avr4A93:	call	sub4ECD		; 4A93 940E 4ECD
avr4A95:	sbis	PINC, 5	; 4A95 9B9D
		rjmp	avr4AA0		; 4A96 C009
		cpi	YL, 0xFA		; 4A97 3FCA
		brne	avr4A9C		; 4A98 F419
		rjmp	avr4AA0		; 4A99 C006
		nop				; 4A9A 0000
		nop				; 4A9B 0000
avr4A9C:	call	sub4ED2		; 4A9C 940E 4ED2
		inc	YL			; 4A9E 95C3
		rjmp	avr4A95		; 4A9F CFF5
avr4aa0:	cbi	PORTC, 5	; 4AA0 98AD
		sbi	DDRC, 5	; 4AA1 9AA5
		ldi	r16, 0x12		; 4AA2 E102
		jmp	avr4E14		; 4AA3 940C 4E14
avr4AA5:	cbi	PORTC, 5	; 4AA5 98AD
		sbi	DDRC, 5	; 4AA6 9AA5
		clr	YL			; 4AA7 27CC
		jmp	avr4E14		; 4AA8 940C 4E14

avr4AAA:		cbi	PORTC, 4	; 4AAA 98AC
		sbi	DDRC, 4	; 4AAB 9AA4
		ldi	r16, 0x14		; 4AAC E104
avr4AAD:	dec	r16			; 4AAD 950A
		brne	avr4AAD		; 4AAE F7F1
		sbi	PORTC, 4	; 4AAF 9AAC
		call	sub4E24		; 4AB0 940E 4E24
		nop				; 4AB2 0000
		nop				; 4AB3 0000
		nop				; 4AB4 0000
		cbi	PORTC, 4	; 4AB5 98AC
		call	sub4E24		; 4AB6 940E 4E24
		nop				; 4AB8 0000
		nop				; 4AB9 0000
		nop				; 4ABA 0000
		nop				; 4ABB 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 4	; 4ABC 9AAC
		cbi	DDRC, 4	; 4ABD 98A4
		nop				; 4ABE 0000
		sbic	PINC, 4	; 4ABF 999C
		rjmp	avr4ADF		; 4AC0 C01E
		ldi	YL, 0x01		; 4AC1 E0C1
		clr	r16			; 4AC2 2700
avr4AC3:	nop				; 4AC3 0000
		nop				; 4AC4 0000
		nop				; 4AC5 0000
		nop				; 4AC6 0000
		nop				; 4AC7 0000
		sbic	PINC, 4	; 4AC8 999C
		rjmp	avr4ACD		; 4AC9 C003
		dec	r16			; 4ACA 950A
		brne	avr4AC3		; 4ACB F7B9
		rjmp	avr4ADF		; 4ACC C012
avr4ACD:	call	sub4ECD		; 4ACD 940E 4ECD
avr4ACF:	sbis	PINC, 4	; 4ACF 9B9C
		rjmp	avr4ADA		; 4AD0 C009
		cpi	YL, 0xFA		; 4AD1 3FCA
		brne	avr4AD6		; 4AD2 F419
		rjmp	avr4ADA		; 4AD3 C006
		nop				; 4AD4 0000
		nop				; 4AD5 0000
avr4AD6:	call	sub4ED2		; 4AD6 940E 4ED2
		inc	YL			; 4AD8 95C3
		rjmp	avr4ACF		; 4AD9 CFF5
avr4ADA:	cbi	PORTC, 4	; 4ADA 98AC
		sbi	DDRC, 4	; 4ADB 9AA4
		ldi	r16, 0x13		; 4ADC E103
		jmp	avr4E14		; 4ADD 940C 4E14
avr4ADF:	cbi	PORTC, 4	; 4ADF 98AC
		sbi	DDRC, 4	; 4AE0 9AA4
		clr	YL			; 4AE1 27CC
		jmp	avr4E14		; 4AE2 940C 4E14

avr4AE4:		cbi	PORTC, 3	; 4AE4 98AB
		sbi	DDRC, 3	; 4AE5 9AA3
		ldi	r16, 0x14		; 4AE6 E104
avr4AE7:	dec	r16			; 4AE7 950A
		brne	avr4AE7		; 4AE8 F7F1
		sbi	PORTC, 3	; 4AE9 9AAB
		call	sub4E24		; 4AEA 940E 4E24
		nop				; 4AEC 0000
		nop				; 4AED 0000
		nop				; 4AEE 0000
		cbi	PORTC, 3	; 4AEF 98AB
		call	sub4E24		; 4AF0 940E 4E24
		nop				; 4AF2 0000
		nop				; 4AF3 0000
		nop				; 4AF4 0000
		nop				; 4AF5 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 3	; 4AF6 9AAB
		cbi	DDRC, 3	; 4AF7 98A3
		nop				; 4AF8 0000
		sbic	PINC, 3	; 4AF9 999B
		rjmp	avr4B19		; 4AFA C01E
		ldi	YL, 0x01		; 4AFB E0C1
		clr	r16			; 4AFC 2700
avr4AFD:	nop				; 4AFD 0000
		nop				; 4AFE 0000
		nop				; 4AFF 0000
		nop				; 4B00 0000
		nop				; 4B01 0000
		sbic	PINC, 3	; 4B02 999B
		rjmp	avr4B07		; 4B03 C003
		dec	r16			; 4B04 950A
		brne	avr4AFD		; 4B05 F7B9
		rjmp	avr4B19		; 4B06 C012
avr4B07:	call	sub4ECD		; 4B07 940E 4ECD
avr4B09:	sbis	PINC, 3	; 4B09 9B9B
		rjmp	avr4B14		; 4B0A C009
		cpi	YL, 0xFA		; 4B0B 3FCA
		brne	avr4B10		; 4B0C F419
		rjmp	avr4B14		; 4B0D C006
		nop				; 4B0E 0000
		nop				; 4B0F 0000
avr4B10:	call	sub4ED2		; 4B10 940E 4ED2
		inc	YL			; 4B12 95C3
		rjmp	avr4B09		; 4B13 CFF5
avr4B14:	cbi	PORTC, 3	; 4B14 98AB
		sbi	DDRC, 3	; 4B15 9AA3
		ldi	r16, 0x14		; 4B16 E104
		jmp	avr4E14		; 4B17 940C 4E14
avr4B19:	cbi	PORTC, 3	; 4B19 98AB
		sbi	DDRC, 3	; 4B1A 9AA3
		clr	YL			; 4B1B 27CC
		jmp	avr4E14		; 4B1C 940C 4E14

avr4B1E:		cbi	PORTC, 2	; 4B1E 98AA
		sbi	DDRC, 2	; 4B1F 9AA2
		ldi	r16, 0x14		; 4B20 E104
avr4B21:	dec	r16			; 4B21 950A
		brne	avr4B21		; 4B22 F7F1
		sbi	PORTC, 2	; 4B23 9AAA
		call	sub4E24		; 4B24 940E 4E24
		nop				; 4B26 0000
		nop				; 4B27 0000
		nop				; 4B28 0000
		cbi	PORTC, 2	; 4B29 98AA
		call	sub4E24		; 4B2A 940E 4E24
		nop				; 4B2C 0000
		nop				; 4B2D 0000
		nop				; 4B2E 0000
		nop				; 4B2F 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 2	; 4B30 9AAA
		cbi	DDRC, 2	; 4B31 98A2
		nop				; 4B32 0000
		sbic	PINC, 2	; 4B33 999A
		rjmp	avr4B53		; 4B34 C01E
		ldi	YL, 0x01		; 4B35 E0C1
		clr	r16			; 4B36 2700
avr4B37:	nop				; 4B37 0000
		nop				; 4B38 0000
		nop				; 4B39 0000
		nop				; 4B3A 0000
		nop				; 4B3B 0000
		sbic	PINC, 2	; 4B3C 999A
		rjmp	avr4B41		; 4B3D C003
		dec	r16			; 4B3E 950A
		brne	avr4B37		; 4B3F F7B9
		rjmp	avr4B53		; 4B40 C012
avr4B41:	call	sub4ECD		; 4B41 940E 4ECD
avr4B43:	sbis	PINC, 2	; 4B43 9B9A
		rjmp	avr4B4E		; 4B44 C009
		cpi	YL, 0xFA		; 4B45 3FCA
		brne	avr4B4A		; 4B46 F419
		rjmp	avr4B4E		; 4B47 C006
		nop				; 4B48 0000
		nop				; 4B49 0000
avr4B4A:	call	sub4ED2		; 4B4A 940E 4ED2
		inc	YL			; 4B4C 95C3
		rjmp	avr4B43		; 4B4D CFF5
avr4B4E:	cbi	PORTC, 2	; 4B4E 98AA
		sbi	DDRC, 2	; 4B4F 9AA2
		ldi	r16, 0x15		; 4B50 E105
		jmp	avr4E14		; 4B51 940C 4E14
avr4B53:	cbi	PORTC, 2	; 4B53 98AA
		sbi	DDRC, 2	; 4B54 9AA2
		clr	YL			; 4B55 27CC
		jmp	avr4E14		; 4B56 940C 4E14

avr4B58:	cbi	PORTC, 1	; 4B58 98A9
		sbi	DDRC, 1	; 4B59 9AA1
		ldi	r16, 0x14		; 4B5A E104
avr4B5B:	dec	r16			; 4B5B 950A
		brne	avr4B5B		; 4B5C F7F1
		sbi	PORTC, 1	; 4B5D 9AA9
		call	sub4E24		; 4B5E 940E 4E24
		nop				; 4B60 0000
		nop				; 4B61 0000
		nop				; 4B62 0000
		cbi	PORTC, 1	; 4B63 98A9
		call	sub4E24		; 4B64 940E 4E24
		nop				; 4B66 0000
		nop				; 4B67 0000
		nop				; 4B68 0000
		nop				; 4B69 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 1	; 4B6A 9AA9
		cbi	DDRC, 1	; 4B6B 98A1
		nop				; 4B6C 0000
		sbic	PINC, 1	; 4B6D 9999
		rjmp	avr4B8D		; 4B6E C01E
		ldi	YL, 0x01		; 4B6F E0C1
		clr	r16			; 4B70 2700
avr4B71:	nop				; 4B71 0000
		nop				; 4B72 0000
		nop				; 4B73 0000
		nop				; 4B74 0000
		nop				; 4B75 0000
		sbic	PINC, 1	; 4B76 9999
		rjmp	avr4B7B		; 4B77 C003
		dec	r16			; 4B78 950A
		brne	avr4B71		; 4B79 F7B9
		rjmp	avr4B8D		; 4B7A C012
avr4B7B:	call	sub4ECD		; 4B7B 940E 4ECD
avr4B7D:	sbis	PINC, 1	; 4B7D 9B99
		rjmp	avr4B88		; 4B7E C009
		cpi	YL, 0xFA		; 4B7F 3FCA
		brne	avr4B84		; 4B80 F419
		rjmp	avr4B88		; 4B81 C006
		nop				; 4B82 0000
		nop				; 4B83 0000
avr4B84:	call	sub4ED2		; 4B84 940E 4ED2
		inc	YL			; 4B86 95C3
		rjmp	avr4B7D		; 4B87 CFF5
avr4B88:	cbi	PORTC, 1	; 4B88 98A9
		sbi	DDRC, 1	; 4B89 9AA1
		ldi	r16, 0x16		; 4B8A E106
		jmp	avr4E14		; 4B8B 940C 4E14
avr4B8D:	cbi	PORTC, 1	; 4B8D 98A9
		sbi	DDRC, 1	; 4B8E 9AA1
		clr	YL			; 4B8F 27CC
		jmp	avr4E14		; 4B90 940C 4E14

avr4B92:		cbi	PORTC, 0	; 4B92 98A8
		sbi	DDRC, 0	; 4B93 9AA0
		ldi	r16, 0x14		; 4B94 E104
avr4B95:	dec	r16			; 4B95 950A
		brne	avr4B95		; 4B96 F7F1
		sbi	PORTC, 0	; 4B97 9AA8
		call	sub4E24		; 4B98 940E 4E24
		nop				; 4B9A 0000
		nop				; 4B9B 0000
		nop				; 4B9C 0000
		cbi	PORTC, 0	; 4B9D 98A8
		call	sub4E24		; 4B9E 940E 4E24
		nop				; 4BA0 0000
		nop				; 4BA1 0000
		nop				; 4BA2 0000
		nop				; 4BA3 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTC, 0	; 4BA4 9AA8
		cbi	DDRC, 0	; 4BA5 98A0
		nop				; 4BA6 0000
		sbic	PINC, 0	; 4BA7 9998
		rjmp	avr4BC7		; 4BA8 C01E
		ldi	YL, 0x01		; 4BA9 E0C1
		clr	r16			; 4BAA 2700
avr4BAB:	nop				; 4BAB 0000
		nop				; 4BAC 0000
		nop				; 4BAD 0000
		nop				; 4BAE 0000
		nop				; 4BAF 0000
		sbic	PINC, 0	; 4BB0 9998
		rjmp	avr4BB5		; 4BB1 C003
		dec	r16			; 4BB2 950A
		brne	avr4BAB		; 4BB3 F7B9
		rjmp	avr4BC7		; 4BB4 C012
avr4BB5:	call	sub4ECD		; 4BB5 940E 4ECD
avr4BB7:	sbis	PINC, 0	; 4BB7 9B98
		rjmp	avr4BC2		; 4BB8 C009
		cpi	YL, 0xFA		; 4BB9 3FCA
		brne	avr4BBE		; 4BBA F419
		rjmp	avr4BC2		; 4BBB C006
		nop				; 4BBC 0000
		nop				; 4BBD 0000
avr4BBE:	call	sub4ED2		; 4BBE 940E 4ED2
		inc	YL			; 4BC0 95C3
		rjmp	avr4BB7		; 4BC1 CFF5
avr4BC2:	cbi	PORTC, 0	; 4BC2 98A8
		sbi	DDRC, 0	; 4BC3 9AA0
		ldi	r16, 0x17		; 4BC4 E107
		jmp	avr4E14		; 4BC5 940C 4E14
avr4BC7:	cbi	PORTC, 0	; 4BC7 98A8
		sbi	DDRC, 0	; 4BC8 9AA0
		clr	YL			; 4BC9 27CC
		jmp	avr4E14		; 4BCA 940C 4E14

avr4BCC:	cbi	$03, 7	; 4BCC 981F
		sbi	$02, 7	; 4BCD 9A17
		ldi	r16, 0x14		; 4BCE E104
avr4BCF:	dec	r16			; 4BCF 950A
		brne	avr4BCF		; 4BD0 F7F1
		sbi	$03, 7	; 4BD1 9A1F
		call	sub4E24		; 4BD2 940E 4E24
		nop				; 4BD4 0000
		nop				; 4BD5 0000
		nop				; 4BD6 0000
		cbi	$03, 7	; 4BD7 981F
		call	sub4E24		; 4BD8 940E 4E24
		nop				; 4BDA 0000
		nop				; 4BDB 0000
		nop				; 4BDC 0000
		nop				; 4BDD 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	$03, 7	; 4BDE 9A1F
		cbi	$02, 7	; 4BDF 9817
		nop				; 4BE0 0000
		sbic	$01, 7	; 4BE1 990F
		rjmp	avr4C01		; 4BE2 C01E
		ldi	YL, 0x01		; 4BE3 E0C1
		clr	r16			; 4BE4 2700
avr4BE5:	nop				; 4BE5 0000
		nop				; 4BE6 0000
		nop				; 4BE7 0000
		nop				; 4BE8 0000
		nop				; 4BE9 0000

		sbic	$01, 7	; 4BEA 990F
		rjmp	avr4BEF		; 4BEB C003
		dec	r16			; 4BEC 950A
		brne	avr4BE5		; 4BED F7B9
		rjmp	avr4C01		; 4BEE C012
avr4BEF:	call	sub4ECD		; 4BEF 940E 4ECD
avr4BF1:	sbis	$01, 7	; 4BF1 9B0F
		rjmp	avr4BFC		; 4BF2 C009
		cpi	YL, 0xFA		; 4BF3 3FCA
		brne	avr4BF8		; 4BF4 F419
		rjmp	avr4BFC		; 4BF5 C006
		nop				; 4BF6 0000
		nop				; 4BF7 0000
avr4BF8:	call	sub4ED2		; 4BF8 940E 4ED2
		inc	YL			; 4BFA 95C3
		rjmp	avr4BF1		; 4BFB CFF5
avr4BFC:	cbi	$03, 7	; 4BFC 981F
		sbi	$02, 7	; 4BFD 9A17
		ldi	r16, 0x18		; 4BFE E108
		jmp	avr4E14		; 4BFF 940C 4E14
avr4C01:		cbi	$03, 7	; 4C01 981F
		sbi	$02, 7	; 4C02 9A17
		clr	YL			; 4C03 27CC
		jmp	avr4E14		; 4C04 940C 4E14

avr4C06:	cbi	$03, 6	; 4C06 981E
		sbi	$02, 6	; 4C07 9A16
		ldi	r16, 0x14		; 4C08 E104
avr4C09:	dec	r16			; 4C09 950A
		brne	avr4C09		; 4C0A F7F1
		sbi	$03, 6	; 4C0B 9A1E
		call	sub4E24		; 4C0C 940E 4E24
		nop				; 4C0E 0000
		nop				; 4C0F 0000
		nop				; 4C10 0000
		cbi	$03, 6	; 4C11 981E
		call	sub4E24		; 4C12 940E 4E24
		nop				; 4C14 0000
		nop				; 4C15 0000
		nop				; 4C16 0000
		nop				; 4C17 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	$03, 6	; 4C18 9A1E
		cbi	$02, 6	; 4C19 9816
		nop				; 4C1A 0000
		sbic	$01, 6	; 4C1B 990E
		rjmp	avr4C3B		; 4C1C C01E
		ldi	YL, 0x01		; 4C1D E0C1
		clr	r16			; 4C1E 2700
avr4C1F:	nop				; 4C1F 0000
		nop				; 4C20 0000
		nop				; 4C21 0000
		nop				; 4C22 0000
		nop				; 4C23 0000
		sbic	$01, 6	; 4C24 990E
		rjmp	avr4C29		; 4C25 C003
		dec	r16			; 4C26 950A
		brne	avr4C1F		; 4C27 F7B9
		rjmp	avr4C3B		; 4C28 C012
avr4C29:	call	sub4ECD		; 4C29 940E 4ECD
avr4C2B:	sbis	$01, 6	; 4C2B 9B0E
		rjmp	avr4C36		; 4C2C C009
		cpi	YL, 0xFA		; 4C2D 3FCA
		brne	avr4C32		; 4C2E F419
		rjmp	avr4C36		; 4C2F C006
		nop				; 4C30 0000
		nop				; 4C31 0000
avr4C32:	call	sub4ED2		; 4C32 940E 4ED2
		inc	YL			; 4C34 95C3
		rjmp	avr4C2B		; 4C35 CFF5
avr4C36:	cbi	$03, 6	; 4C36 981E
		sbi	$02, 6	; 4C37 9A16
		ldi	r16, 0x19		; 4C38 E109
		jmp	avr4E14		; 4C39 940C 4E14
avr4C3B:	cbi	$03, 6	; 4C3B 981E
		sbi	$02, 6	; 4C3C 9A16
		clr	YL			; 4C3D 27CC
		jmp	avr4E14		; 4C3E 940C 4E14

avr4C40:	cbi	PORTD, 7	; 4C40 9897
		sbi	DDRD, 7	; 4C41 9A8F
		ldi	r16, 0x14		; 4C42 E104
avr4C43:	dec	r16			; 4C43 950A
		brne	avr4C43		; 4C44 F7F1
		sbi	PORTD, 7	; 4C45 9A97
		call	sub4E24		; 4C46 940E 4E24
		nop				; 4C48 0000
		nop				; 4C49 0000
		nop				; 4C4A 0000
		cbi	PORTD, 7	; 4C4B 9897
		call	sub4E24		; 4C4C 940E 4E24
		nop				; 4C4E 0000
		nop				; 4C4F 0000
		nop				; 4C50 0000
		nop				; 4C51 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTD, 7	; 4C52 9A97
		cbi	DDRD, 7	; 4C53 988F
		nop				; 4C54 0000
		sbic	PIND, 7	; 4C55 9987
		rjmp	avr4C75		; 4C56 C01E
		ldi	YL, 0x01		; 4C57 E0C1
		clr	r16			; 4C58 2700
avr4C59:	nop				; 4C59 0000
		nop				; 4C5A 0000
		nop				; 4C5B 0000
		nop				; 4C5C 0000
		nop				; 4C5D 0000
		sbic	PIND, 7	; 4C5E 9987
		rjmp	avr4C63		; 4C5F C003
		dec	r16			; 4C60 950A
		brne	avr4C59		; 4C61 F7B9
		rjmp	avr4C75		; 4C62 C012
avr4C63:	call	sub4ECD		; 4C63 940E 4ECD
avr4C65:	sbis	PIND, 7	; 4C65 9B87
		rjmp	avr4C70		; 4C66 C009
		cpi	YL, 0xFA		; 4C67 3FCA
		brne	avr4C6C		; 4C68 F419
		rjmp	avr4C70		; 4C69 C006
		nop				; 4C6A 0000
		nop				; 4C6B 0000
avr4C6C:	call	sub4ED2		; 4C6C 940E 4ED2
		inc	YL			; 4C6E 95C3
		rjmp	avr4C65		; 4C6F CFF5
avr4C70:	cbi	PORTD, 7	; 4C70 9897
		sbi	DDRD, 7	; 4C71 9A8F
		ldi	r16, 0x1A		; 4C72 E10A
		jmp	avr4E14		; 4C73 940C 4E14
avr4C75:	cbi	PORTD, 7	; 4C75 9897
		sbi	DDRD, 7	; 4C76 9A8F
		clr	YL			; 4C77 27CC
		jmp	avr4E14		; 4C78 940C 4E14

avr4C7A:	cbi	PORTD, 6	; 4C7A 9896
		sbi	DDRD, 6	; 4C7B 9A8E
		ldi	r16, 0x14		; 4C7C E104
avr4C7D:	dec	r16			; 4C7D 950A
		brne	avr4C7D		; 4C7E F7F1
		sbi	PORTD, 6	; 4C7F 9A96
		call	sub4E24		; 4C80 940E 4E24
		nop				; 4C82 0000
		nop				; 4C83 0000
		nop				; 4C84 0000
		cbi	PORTD, 6	; 4C85 9896
		call	sub4E24		; 4C86 940E 4E24
		nop				; 4C88 0000
		nop				; 4C89 0000
		nop				; 4C8A 0000
		nop				; 4C8B 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTD, 6	; 4C8C 9A96
		cbi	DDRD, 6	; 4C8D 988E
		nop				; 4C8E 0000
		sbic	PIND, 6	; 4C8F 9986
		rjmp	avr4CAF		; 4C90 C01E
		ldi	YL, 0x01		; 4C91 E0C1
		clr	r16			; 4C92 2700
avr4C93:	nop				; 4C93 0000
		nop				; 4C94 0000
		nop				; 4C95 0000
		nop				; 4C96 0000
		nop				; 4C97 0000
		sbic	PIND, 6	; 4C98 9986
		rjmp	avr4C9D		; 4C99 C003
		dec	r16			; 4C9A 950A
		brne	avr4C93		; 4C9B F7B9
		rjmp	avr4CAF		; 4C9C C012
avr4C9D:	call	sub4ECD		; 4C9D 940E 4ECD
avr4C9F:	sbis	PIND, 6	; 4C9F 9B86
		rjmp	avr4CAA		; 4CA0 C009
		cpi	YL, 0xFA		; 4CA1 3FCA
		brne	avr4CA6		; 4CA2 F419
		rjmp	avr4CAA		; 4CA3 C006
		nop				; 4CA4 0000
		nop				; 4CA5 0000
avr4CA6:	call	sub4ED2		; 4CA6 940E 4ED2
		inc	YL			; 4CA8 95C3
		rjmp	avr4C9F		; 4CA9 CFF5
avr4CAA:	cbi	PORTD, 6	; 4CAA 9896
		sbi	DDRD, 6	; 4CAB 9A8E
		ldi	r16, 0x1B		; 4CAC E10B
		jmp	avr4E14		; 4CAD 940C 4E14
avr4CAF:	cbi	PORTD, 6	; 4CAF 9896
		sbi	DDRD, 6	; 4CB0 9A8E
		clr	YL			; 4CB1 27CC
		jmp	avr4E14		; 4CB2 940C 4E14

avr4CB4:	cbi	PORTD, 5	; 4CB4 9895
		sbi	DDRD, 5	; 4CB5 9A8D
		ldi	r16, 0x14		; 4CB6 E104
avr4CB7:	dec	r16			; 4CB7 950A
		brne	avr4CB7		; 4CB8 F7F1
		sbi	PORTD, 5	; 4CB9 9A95
		call	sub4E24		; 4CBA 940E 4E24
		nop				; 4CBC 0000
		nop				; 4CBD 0000
		nop				; 4CBE 0000
		cbi	PORTD, 5	; 4CBF 9895
		call	sub4E24		; 4CC0 940E 4E24
		nop				; 4CC2 0000
		nop				; 4CC3 0000
		nop				; 4CC4 0000
		nop				; 4CC5 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		sbi	PORTD, 5	; 4CC6 9A95
		cbi	DDRD, 5	; 4CC7 988D
		nop				; 4CC8 0000
		sbic	PIND, 5	; 4CC9 9985
		rjmp	avr4CE9		; 4CCA C01E
		ldi	YL, 0x01		; 4CCB E0C1
		clr	r16			; 4CCC 2700
avr4CCD:	nop				; 4CCD 0000
		nop				; 4CCE 0000
		nop				; 4CCF 0000
		nop				; 4CD0 0000
		nop				; 4CD1 0000
		sbic	PIND, 5	; 4CD2 9985
		rjmp	avr4CD7		; 4CD3 C003
		dec	r16			; 4CD4 950A
		brne	avr4CCD		; 4CD5 F7B9
		rjmp	avr4CE9		; 4CD6 C012
avr4CD7:	call	sub4ECD		; 4CD7 940E 4ECD
avr4CD9:	sbis	PIND, 5	; 4CD9 9B85
		rjmp	avr4CE4		; 4CDA C009
		cpi	YL, 0xFA		; 4CDB 3FCA
		brne	avr4CE0		; 4CDC F419
		rjmp	avr4CE4		; 4CDD C006
		nop				; 4CDE 0000
		nop				; 4CDF 0000
avr4CE0:	call	sub4ED2		; 4CE0 940E 4ED2
		inc	YL			; 4CE2 95C3
		rjmp	avr4CD9		; 4CE3 CFF5
avr4CE4:	cbi	PORTD, 5	; 4CE4 9895
		sbi	DDRD, 5	; 4CE5 9A8D
		ldi	r16, 0x1C		; 4CE6 E10C
		jmp	avr4E14		; 4CE7 940C 4E14
avr4CE9:	cbi	PORTD, 5	; 4CE9 9895
		sbi	DDRD, 5	; 4CEA 9A8D
		clr	YL			; 4CEB 27CC
		jmp	avr4E14		; 4CEC 940C 4E14

avr4CEE:	lds	r16, 0x0065		; 4CEE 9100 0065
		andi	r16, 0xFB		; 4CF0 7F0B
		sts	0x0065, r16		; 4CF1 9300 0065
		lds	r16, 0x0064		; 4CF3 9100 0064
		ori	r16, 0x04		; 4CF5 6004
		sts	0x0064, r16		; 4CF6 9300 0064
		ldi	r16, 0x14		; 4CF8 E104
avr4CF9:	dec	r16			; 4CF9 950A
		brne	avr4CF9		; 4CFA F7F1
		lds	r16, 0x0065		; 4CFB 9100 0065
		ori	r16, 0x04		; 4CFD 6004
		sts	0x0065, r16		; 4CFE 9300 0065
		call	sub4E24		; 4D00 940E 4E24
		lds	r16, 0x0065		; 4D02 9100 0065
		andi	r16, 0xFB		; 4D04 7F0B
		sts	0x0065, r16		; 4D05 9300 0065
		call	sub4E24		; 4D07 940E 4E24
		nop				; 4D09 0000
		nop				; 4D0A 0000
		nop				; 4D0B 0000
		nop				; 4D0C 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		lds	r16, 0x0065		; 4D0D 9100 0065
		ori	r16, 0x04		; 4D0F 6004
		sts	0x0065, r16		; 4D10 9300 0065
		lds	r16, 0x0064		; 4D12 9100 0064
		andi	r16, 0xFB		; 4D14 7F0B
		sts	0x0064, r16		; 4D15 9300 0064
		nop				; 4D17 0000
		lds	r17, 0x0063		; 4D18 9110 0063
		sbrc	r17, 2		; 4D1A FD12
		rjmp	avr4D43		; 4D1B C027
		ldi	YL, 0x01		; 4D1C E0C1
		clr	r16			; 4D1D 2700
avr4D1E:	nop				; 4D1E 0000
		nop				; 4D1F 0000
		nop				; 4D20 0000
		lds	r17, 0x0063		; 4D21 9110 0063
		sbrc	r17, 2		; 4D23 FD12
		rjmp	avr4D28		; 4D24 C003
		dec	r16			; 4D25 950A
		brne	avr4D1E		; 4D26 F7B9
		rjmp	avr4D43		; 4D27 C01B
avr4D28:	call	sub4ECD		; 4D28 940E 4ECD
avr4D2A:	lds	r17, 0x0063		; 4D2A 9110 0063
		sbrs	r17, 2		; 4D2C FF12
		rjmp	avr4D37		; 4D2D C009
		cpi	YL, 0xFA		; 4D2E 3FCA
		brne	avr4D33		; 4D2F F419
		rjmp	avr4D37		; 4D30 C006
		nop				; 4D31 0000
		nop				; 4D32 0000
avr4D33:	call	sub4ED2		; 4D33 940E 4ED2
		inc	YL			; 4D35 95C3
		rjmp	avr4D2A		; 4D36 CFF3
avr4D37:	lds	r16, 0x0065		; 4D37 9100 0065
		andi	r16, 0xFB		; 4D39 7F0B
		sts	0x0065, r16		; 4D3A 9300 0065
		lds	r16, 0x0064		; 4D3C 9100 0064
		ori	r16, 0x04		; 4D3E 6004
		sts	0x0064, r16		; 4D3F 9300 0064
		jmp	avr4E14		; 4D41 940C 4E14
avr4D43:	lds	r16, 0x0065		; 4D43 9100 0065
		andi	r16, 0xFB		; 4D45 7F0B
		sts	0x0065, r16		; 4D46 9300 0065
		lds	r16, 0x0064		; 4D48 9100 0064
		ori	r16, 0x04		; 4D4A 6004
		sts	0x0064, r16		; 4D4B 9300 0064
		clr	YL			; 4D4D 27CC
		jmp	avr4E14		; 4D4E 940C 4E14

avr4D50:		lds	r16, 0x0065		; 4D50 9100 0065
		andi	r16, 0xFD		; 4D52 7F0D
		sts	0x0065, r16		; 4D53 9300 0065
		lds	r16, 0x0064		; 4D55 9100 0064
		ori	r16, 0x02		; 4D57 6002
		sts	0x0064, r16		; 4D58 9300 0064
		ldi	r16, 0x14		; 4D5A E104
avr4D5B:	dec	r16			; 4D5B 950A
		brne	avr4D5B		; 4D5C F7F1
		lds	r16, 0x0065		; 4D5D 9100 0065
		ori	r16, 0x02		; 4D5F 6002
		sts	0x0065, r16		; 4D60 9300 0065
		call	sub4E24		; 4D62 940E 4E24
		lds	r16, 0x0065		; 4D64 9100 0065
		andi	r16, 0xFD		; 4D66 7F0D
		sts	0x0065, r16		; 4D67 9300 0065
		call	sub4E24		; 4D69 940E 4E24
		nop				; 4D6B 0000
		nop				; 4D6C 0000
		nop				; 4D6D 0000
		nop				; 4D6E 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		lds	r16, 0x0065		; 4D6F 9100 0065
		ori	r16, 0x02		; 4D71 6002
		sts	0x0065, r16		; 4D72 9300 0065
		lds	r16, 0x0064		; 4D74 9100 0064
		andi	r16, 0xFD		; 4D76 7F0D
		sts	0x0064, r16		; 4D77 9300 0064
		nop				; 4D79 0000
		lds	r17, 0x0063		; 4D7A 9110 0063
		sbrc	r17, 1		; 4D7C FD11
		rjmp	avr4DA5		; 4D7D C027
		ldi	YL, 0x01		; 4D7E E0C1
		clr	r16			; 4D7F 2700
avr4D80:	nop				; 4D80 0000
		nop				; 4D81 0000
		nop				; 4D82 0000
		lds	r17, 0x0063		; 4D83 9110 0063
		sbrc	r17, 1		; 4D85 FD11
		rjmp	avr4D8A		; 4D86 C003
		dec	r16			; 4D87 950A
		brne	avr4D80		; 4D88 F7B9
		rjmp	avr4DA5		; 4D89 C01B
avr4D8A:	call	sub4ECD		; 4D8A 940E 4ECD
avr4D8C:	lds	r17, 0x0063		; 4D8C 9110 0063
		sbrs	r17, 1		; 4D8E FF11
		rjmp	avr4D99		; 4D8F C009
		cpi	YL, 0xFA		; 4D90 3FCA
		brne	avr4D95		; 4D91 F419
		rjmp	avr4D99		; 4D92 C006
		nop				; 4D93 0000
		nop				; 4D94 0000
avr4D95:	call	sub4ED2		; 4D95 940E 4ED2
		inc	YL			; 4D97 95C3
		rjmp	avr4D8C		; 4D98 CFF3
avr4D99:	lds	r16, 0x0065		; 4D99 9100 0065
		andi	r16, 0xFD		; 4D9B 7F0D
		sts	0x0065, r16		; 4D9C 9300 0065
		lds	r16, 0x0064		; 4D9E 9100 0064
		ori	r16, 0x02		; 4DA0 6002
		sts	0x0064, r16		; 4DA1 9300 0064
		jmp	avr4E14		; 4DA3 940C 4E14
avr4DA5:	lds	r16, 0x0065		; 4DA5 9100 0065
		andi	r16, 0xFD		; 4DA7 7F0D
		sts	0x0065, r16		; 4DA8 9300 0065
		lds	r16, 0x0064		; 4DAA 9100 0064
		ori	r16, 0x02		; 4DAC 6002
		sts	0x0064, r16		; 4DAD 9300 0064
		clr	YL			; 4DAF 27CC
		jmp	avr4E14		; 4DB0 940C 4E14

avr4DB2:lds	r16, 0x0065		; 4DB2 9100 0065
		andi	r16, 0xFE		; 4DB4 7F0E
		sts	0x0065, r16		; 4DB5 9300 0065
		lds	r16, 0x0064		; 4DB7 9100 0064
		ori	r16, 0x01		; 4DB9 6001
		sts	0x0064, r16		; 4DBA 9300 0064
		ldi	r16, 0x14		; 4DBC E104
avr4DBD:	dec	r16			; 4DBD 950A
		brne	avr4DBD		; 4DBE F7F1
		lds	r16, 0x0065		; 4DBF 9100 0065
		ori	r16, 0x01		; 4DC1 6001
		sts	0x0065, r16		; 4DC2 9300 0065
		call	sub4E24		; 4DC4 940E 4E24
		lds	r16, 0x0065		; 4DC6 9100 0065
		andi	r16, 0xFE		; 4DC8 7F0E
		sts	0x0065, r16		; 4DC9 9300 0065
		call	sub4E24		; 4DCB 940E 4E24
		nop				; 4DCD 0000
		nop				; 4DCE 0000
		nop				; 4DCF 0000
		nop				; 4DD0 0000
;----------
; 2.7 code

		lds		r17, 0x0514
		sbrc	r17,7
		jmp		0x00005097
;--------------
		lds	r16, 0x0065		; 4DD1 9100 0065
		ori	r16, 0x01		; 4DD3 6001
		sts	0x0065, r16		; 4DD4 9300 0065
		lds	r16, 0x0064		; 4DD6 9100 0064
		andi	r16, 0xFE		; 4DD8 7F0E
		sts	0x0064, r16		; 4DD9 9300 0064
		nop				; 4DDB 0000
		lds	r17, 0x0063		; 4DDC 9110 0063
		sbrc	r17, 0		; 4DDE FD10
		rjmp	avr4E07		; 4DDF C027
		ldi	YL, 0x01		; 4DE0 E0C1
		clr	r16			; 4DE1 2700
avr4DE2:	nop				; 4DE2 0000
		nop				; 4DE3 0000
		nop				; 4DE4 0000
		lds	r17, 0x0063		; 4DE5 9110 0063
		sbrc	r17, 0		; 4DE7 FD10
		rjmp	avr4DEC		; 4DE8 C003
		dec	r16			; 4DE9 950A
		brne	avr4DE2		; 4DEA F7B9
		rjmp	avr4E07		; 4DEB C01B
avr4DEC:	call	sub4ECD		; 4DEC 940E 4ECD
avr4DEE:	lds	r17, 0x0063		; 4DEE 9110 0063
		sbrs	r17, 0		; 4DF0 FF10
		rjmp	avr4DFB		; 4DF1 C009
		cpi	YL, 0xFA		; 4DF2 3FCA
		brne	avr4DF7		; 4DF3 F419
		rjmp	avr4DFB		; 4DF4 C006
		nop				; 4DF5 0000
		nop				; 4DF6 0000
avr4DF7:	call	sub4ED2		; 4DF7 940E 4ED2
		inc	YL			; 4DF9 95C3
		rjmp	avr4DEE		; 4DFA CFF3
avr4DFB:	lds	r16, 0x0065		; 4DFB 9100 0065
		andi	r16, 0xFE		; 4DFD 7F0E
		sts	0x0065, r16		; 4DFE 9300 0065
		lds	r16, 0x0064		; 4E00 9100 0064
		ori	r16, 0x01		; 4E02 6001
		sts	0x0064, r16		; 4E03 9300 0064
		jmp	avr4E14		; 4E05 940C 4E14
avr4E07:	lds	r16, 0x0065		; 4E07 9100 0065
		andi	r16, 0xFE		; 4E09 7F0E
		sts	0x0065, r16		; 4E0A 9300 0065
		lds	r16, 0x0064		; 4E0C 9100 0064
		ori	r16, 0x01		; 4E0E 6001
		sts	0x0064, r16		; 4E0F 9300 0064
		clr	YL			; 4E11 27CC
		jmp	avr4E14		; 4E12 940C 4E14

;----------------------------------------------------------------------------
avr4E14:	cpi	YL, 0x00		; 4E14 30C0
		breq	avr4E1F		; 4E15 F049
		cpi	YL, 0x3F		; 4E16 33CF
		brsh	avr4E19		; 4E17 F408
		ldi	YL, 0x3F		; 4E18 E3CF
avr4E19:	subi	YL, 0x32		; 4E19 53C2
		brsh	avr4E1C		; 4E1A F408
		ldi	YL, 0x01		; 4E1B E0C1
avr4E1C:		mov	r17, YL		; 4E1C 2F1C
		rcall	sub4E63		; 4E1D D045
		mov	YL, r17		; 4E1E 2FC1
avr4E1F:		clr	YH			; 4E1F 27DD
		pop	r18			; 4E20 912F
		pop	r17			; 4E21 911F
		sei				; 4E22 9478
		ret				; 4E23 9508
;-------------------------------------------------------------------------
; delay routine length based on r17 
; 0 = 50 microsec
; 1 = 100 microsec
; 2 = 150 microsec
; 3 = 200 microsec
sub4E24:	cpi	r17, 0x00		; 4E24 3010
		breq	avr4E2D		; 4E25 F039
		cpi	r17, 0x01		; 4E26 3011
		breq	avr4E39		; 4E27 F089
		cpi	r17, 0x02		; 4E28 3012
		breq	avr4E46		; 4E29 F0E1
		cpi	r17, 0x03		; 4E2A 3013
		breq	avr4E54		; 4E2B F141
		rjmp	avr4E39		; 4E2C C00C

;------------------------------------------------------------------------
avr4E2D:		ldi	r17, 0x02		; 4E2D E012
avr4E2E:		ldi	r16, 0x39		; 4E2E E309
avr4E2F:		dec	r16			; 4E2F 950A
		brne	avr4E2F		; 4E30 F7F1
		dec	r17			; 4E31 951A
		brne	avr4E2E		; 4E32 F7D9
		nop				; 4E33 0000
		nop				; 4E34 0000
		nop				; 4E35 0000
		nop				; 4E36 0000
		nop				; 4E37 0000
		ret				; 4E38 9508
;-------------------------------------------------------------------------
avr4E39:	ldi	r17, 0x02		; 4E39 E012
avr4E3A:		ldi	r16, 0x76		; 4E3A E706
avr4E3B:	dec	r16			; 4E3B 950A
		brne	avr4E3B		; 4E3C F7F1
		dec	r17			; 4E3D 951A
		brne	avr4E3A		; 4E3E F7D9
		nop				; 4E3F 0000
		nop				; 4E40 0000
		nop				; 4E41 0000
		nop				; 4E42 0000
		nop				; 4E43 0000
		nop				; 4E44 0000
		ret				; 4E45 9508
;-------------------------------------------------------------------------
avr4E46:	ldi	r17, 0x02		; 4E46 E012
avr4E47:		ldi	r16, 0xB3		; 4E47 EB03
avr4E48:	dec	r16			; 4E48 950A
		brne	avr4E48		; 4E49 F7F1
		dec	r17			; 4E4A 951A
		brne	avr4E47		; 4E4B F7D9
		nop				; 4E4C 0000
		nop				; 4E4D 0000
		nop				; 4E4E 0000
		nop				; 4E4F 0000
		nop				; 4E50 0000
		nop				; 4E51 0000
		nop				; 4E52 0000
		ret				; 4E53 9508
;-------------------------------------------------------------------------
avr4E54:		ldi	r17, 0x02		; 4E54 E012
avr4E55:		ldi	r16, 0xF0		; 4E55 EF00
avr4E56:		dec	r16			; 4E56 950A
		brne	avr4E56		; 4E57 F7F1
		dec	r17			; 4E58 951A
		brne	avr4E55		; 4E59 F7D9
		nop				; 4E5A 0000
		nop				; 4E5B 0000
		nop				; 4E5C 0000
		nop				; 4E5D 0000
		nop				; 4E5E 0000
		nop				; 4E5F 0000
		nop				; 4E60 0000
		nop				; 4E61 0000
		ret				; 4E62 9508
;-------------------------------------------------------------------------
;

sub4E63:	push	XH			; 4E63 93BF
		push	XL			; 4E64 93AF
		ldi	YH, 0x03		; 4E65 E0D3
		ldi	YL, 0x00		; 4E66 E0C0
		ldi	ZH, 0x03		; 4E67 E0F3
		ldi	ZL, 0x20		; 4E68 E2E0
		ldi	XH, 0x03		; 4E69 E0B3
		ldi	XL, 0x40		; 4E6A E4A0
		add	YL, r16		; 4E6B 0FC0
		brsh	avr4E6E		; 4E6C F408
		inc	YH			; 4E6D 95D3
avr4E6E:	add	ZL, r16		; 4E6E 0FE0
		brsh	avr4E71		; 4E6F F408
		inc	ZH			; 4E70 95F3
avr4E71:	add	XL, r16		; 4E71 0FA0
		brsh	avr4E74		; 4E72 F408
		inc	XH			; 4E73 95B3
avr4E74:	mov	r18, r16		; 4E74 2F20
		subi	r18, 0x18		; 4E75 5128
		brlo	avr4E78		; 4E76 F008
		rjmp	avr4EB1		; 4E77 C039

avr4E78:	mov	r18, r16		; 4E78 2F20
		subi	r18, 0x10		; 4E79 5120
		brlo	avr4E7C		; 4E7A F008
		rjmp	avr4EA1		; 4E7B C025

avr4E7C:	mov	r18, r16		; 4E7C 2F20
		subi	r18, 0x08		; 4E7D 5028
		brlo	avr4E80		; 4E7E F008
		rjmp	avr4E91		; 4E7F C011

avr4E80:	mov	r18, r16		; 4E80 2F20
		ldi	r19, 0x01		; 4E81 E031
avr4E82:	cpi	r18, 0x00		; 4E82 3020
		breq	avr4E87		; 4E83 F019
		dec	r18			; 4E84 952A
		lsl	r19			; 4E85 0F33
		rjmp	avr4E82		; 4E86 CFFB

avr4E87:	lds	r18, 0x04E7		; 4E87 9120 04E7
		and	r19, r18		; 4E89 2332
		tst	r19			; 4E8A 2333
		breq	avr4E8D		; 4E8B F009
		rjmp	avr4EC1		; 4E8C C034

avr4E8D:	ldi	r18, 0xC8		; 4E8D EC28
		sub	r18, r17		; 4E8E 1B21
		mov	r17, r18		; 4E8F 2F12
		rjmp	avr4EC1		; 4E90 C030


avr4E91:	ldi	r19, 0x01		; 4E91 E031
avr4E92:	cpi	r18, 0x00		; 4E92 3020
		breq	avr4E97		; 4E93 F019
		dec	r18			; 4E94 952A
		lsl	r19			; 4E95 0F33
		rjmp	avr4E92		; 4E96 CFFB

avr4E97:		lds	r18, 0x04E8		; 4E97 9120 04E8
		and	r19, r18		; 4E99 2332
		tst	r19			; 4E9A 2333
		breq	avr4E9D		; 4E9B F009
		rjmp	avr4EC1		; 4E9C C024

avr4E9D:		ldi	r18, 0xC8		; 4E9D EC28
		sub	r18, r17		; 4E9E 1B21
		mov	r17, r18		; 4E9F 2F12
		rjmp	avr4EC1		; 4EA0 C020

avr4EA1:	ldi	r19, 0x01		; 4EA1 E031
avr4EA2:	cpi	r18, 0x00		; 4EA2 3020
		breq	avr4EA7		; 4EA3 F019
		dec	r18			; 4EA4 952A
		lsl	r19			; 4EA5 0F33
		rjmp	avr4EA2		; 4EA6 CFFB

avr4EA7:	lds	r18, 0x04E9		; 4EA7 9120 04E9
		and	r19, r18		; 4EA9 2332
		tst	r19			; 4EAA 2333
		breq	avr4EAD		; 4EAB F009
		rjmp	avr4EC1		; 4EAC C014

avr4EAD:	ldi	r18, 0xC8		; 4EAD EC28
		sub	r18, r17		; 4EAE 1B21
		mov	r17, r18		; 4EAF 2F12
		rjmp	avr4EC1		; 4EB0 C010

avr4EB1:	ldi	r19, 0x01		; 4EB1 E031
avr4EB2:	cpi	r18, 0x00		; 4EB2 3020
		breq	avr4EB7		; 4EB3 F019
		dec	r18			; 4EB4 952A
		lsl	r19			; 4EB5 0F33
		rjmp	avr4EB2		; 4EB6 CFFB

avr4EB7:	lds	r18, 0x04EA		; 4EB7 9120 04EA
		and	r19, r18		; 4EB9 2332
		tst	r19			; 4EBA 2333
		breq	avr4EBD		; 4EBB F009
		rjmp	avr4EC1		; 4EBC C004

avr4EBD:	ldi	r18, 0xC8		; 4EBD EC28
		sub	r18, r17		; 4EBE 1B21
		mov	r17, r18		; 4EBF 2F12
		rjmp	avr4EC1		; 4EC0 C000

avr4EC1:	ldi	r19, 0x14		; 4EC1 E134
		add	r17, r19		; 4EC2 0F13
		brsh	avr4EC5		; 4EC3 F408
		ser	r17			; 4EC4 EF1F
avr4EC5:	ld	r18, X		; 4EC5 912C
		sub	r17, r18		; 4EC6 1B12
		subi	r17, 0x14		; 4EC7 5114
		brsh	avr4ECA		; 4EC8 F408
		ldi	r17, 0x00		; 4EC9 E010
avr4ECA:	pop	XL			; 4ECA 91AF
		pop	XH			; 4ECB 91BF
		ret				; 4ECC 9508
;-------------------------------------------------------------------------
; delay 4 microsec
sub4ECD:	ldi	r16, 0x09		; 4ECD E009
avr4ECE:	dec	r16			; 4ECE 950A
			brne	avr4ECE		; 4ECF F7F1
			nop				; 4ED0 0000
			ret				; 4ED1 9508
;-------------------------------------------------------------------------
; delay 8 microsec
sub4ED2:	ldi	r16, 0x13		; 4ED2 E103
avr4ED3:	dec	r16			; 4ED3 950A
			brne	avr4ED3		; 4ED4 F7F1
			nop				; 4ED5 0000
			ret				; 4ED6 9508
;-------------------
; 2.7 code
			call	0x00005092
			call	0x00005092
			call	0x00005092
			call	0x00005092
			call	0x00005092
			clr		YL
			jmp		0x00004fd4
;-----------------------------

;-------------------------------------------------------------------------
sub4ED7:	call	sub4458		; 4ED7 940E 4458
			call	sub0263		; 4ED9 940E 0263
			call	sub0263		; 4EDB 940E 0263
			ldi	r16, 0x00		; 4EDD E000
			call	sub44CF		; 4EDE 940E 44CF
			call	sub4461		; 4EE0 940E 4461
			call	sub0291		; 4EE2 940E 0291
			call	sub0291		; 4EE4 940E 0291
			call	sub0291		; 4EE6 940E 0291
			ret				; 4EE8 9508
;-------------------------------------------------------------------------
; Command A0
;
avr4EE9:	cli					; 4EE9 94F8 
			call	sub0641		; 4EEA 940E 0641 echo
			wdr					; 4EEC 95A8
			call	sub0629		; 4EED 940E 0629 get next char

			brlo	avr4F11		; 4EEF F108 timeout
			cpi	r16, 0xF0		; 4EF0 3F00 exit if not equal F0 
			brne	avr4F11		; 4EF1 F4F9
			call	sub0641		; 4EF2 940E 0641 echo
			wdr					; 4EF4 95A8
			call	sub0629		; 4EF5 940E 0629 get next char

			brlo	avr4F11		; 4EF7 F0C8 timeout
			cpi	r16, 0xAF		; 4EF8 3A0F exit if not equal AF
			brne	avr4F11		; 4EF9 F4B9
			call	sub0641		; 4EFA 940E 0641 echo

			ldi	r22, 0x00		; 4EFC E060 r22 = 0x00
avr4EFD:	wdr					; 4EFD 95A8
			lds	r16, 0x009B		; 4EFE 9100 009B get rxcomplete
			sbrs	r16, 7		; 4F00 FF07 skip if bit 7 set
			rjmp	avr4F1A		; 4F01 C018
			call	sub0629		; 4F02 940E 0629 get next char
			brlo	avr4EFD		; 4F04 F3C0 timeout

			cpi	r16, 0x20		; 4F05 3200 char = 0x20 goto avr4F16
			brlo	avr4F16		; 4F06 F078
			cpi	r16, 0x6F		; 4F07 360F char = 0x6f goto avr4F11
			brne	avr4F0A		; 4F08 F409
			rjmp	avr4F11		; 4F09 C007
avr4F0A:	cpi	r16, 0xF7		; 4F0A 3F07 char = 0xf7 goto avr4FB6
			brne	avr4F0D		; 4F0B F409
			rjmp	avr4FB6		; 4F0C C0A9
AVR4F0D:	cpi	r16, 0xF8		; 4F0D 3F08 char = 0xf8 goto avr 4FD2
			brne	avr4F10		; 4F0E F409
			rjmp	avr4FD2		; 4F0F C0C2
avr4F10:	rjmp	avr4EFD		; 4F10 CFEC

avr4F11:	call	sub0641		; 4F11 940E 0641 Here on timeout
			sei					; 4F13 9478
			jmp	avr03CB			; 4F14 940C 03CB  return


avr4f16:	mov	r22, r16		; 4F16 2F60
			call	sub0641		; 4F17 940E 0641
			rjmp	avr4EFD		; 4F19 CFE3

avr4F1A:	mov	r17, r22		; 4F1A 2F16
			call	sub2604		; 4F1B 940E 2604
			brlo	avr4EFD		; 4F1D F2F8
			cbi	PORTA, 0		; 4F1E 98D8
			sbi	DDRA, 0			; 4F1F 9AD0
			call	sub0641		; 4F20 940E 0641
			call	sub0629		; 4F22 940E 0629
			brlo	avr4EFD		; 4F24 F2C0
			mov	r17, r22		; 4F25 2F16
			call	sub25FE		; 4F26 940E 25FE
			call	sub0629		; 4F28 940E 0629
			brsh	avr4F2C		; 4F2A F408
			rjmp	avr4EFD		; 4F2B CFD1
avr4F2C:	mov	r17, r22		; 4F2C 2F16
			call	sub25FE		; 4F2D 940E 25FE
			call	sub0629		; 4F2F 940E 0629
			brsh	avr4F33		; 4F31 F408
			rjmp	avr4EFD		; 4F32 CFCA
avr4F33:	mov	r17, r22	; 4F33 2F16
			call	sub25FE		; 4F34 940E 25FE
			call	sub0629		; 4F36 940E 0629
			brsh	avr4F3A		; 4F38 F408
			rjmp	avr4EFD		; 4F39 CFC3
avr4F3A:	mov	r17, r22	; 4F3A 2F16
			call	sub25FE		; 4F3B 940E 25FE
			call	sub0629		; 4F3D 940E 0629
			brsh	avr4F41		; 4F3F F408
			rjmp	avr4EFD		; 4F40 CFBC
avr4F41:	mov	r17, r22	; 4F41 2F16
			call	sub25FE		; 4F42 940E 25FE
			call	sub0629		; 4F44 940E 0629
			brsh	avr4F48		; 4F46 F408
			rjmp	avr4EFD		; 4F47 CFB5
avr4F48:	mov	r17, r22	; 4F48 2F16
			call	sub25FE		; 4F49 940E 25FE
			call	sub0629		; 4F4B 940E 0629
			brsh	avr4F4F		; 4F4D F408
			rjmp	avr4EFD		; 4F4E CFAE
avr4F4F:	mov	r17, r22		; 4F4F 2F16
			call	sub25FE		; 4F50 940E 25FE
			ldi	r16, 0x41		; 4F52 E401 send 0x41
			call	sub0641		; 4F53 940E 0641
			ldi	r16, 0x6C		; 4F55 E60C send 0x6c
			call	sub0641		; 4F56 940E 0641
			ldi	r16, 0x63		; 4F58 E603 send 0x63
			call	sub0641		; 4F59 940E 0641
			ldi	r16, 0x52		; 4F5B E502 send 0x52
			call	sub0641		; 4F5C 940E 0641
avr4F5E:	ldi	r16, 0x21		; 4F5E E201 send 0x21
			call	sub0641		; 4F5F 940E 0641

			call	sub0629		; 4F61 940E 0629 get next char
			brsh	avr4F65		; 4F63 F408
			rjmp	avr4EFD		; 4F64 CF98

avr4F65:	mov	ZH, r16		; 4F65 2FF0 z reg =next 2 chars
		call	sub0629		; 4F66 940E 0629
		brsh	avr4F6A		; 4F68 F408
		rjmp	avr4EFD		; 4F69 CF93
avr4F6A:	mov	ZL, r16		; 4F6A 2FE0
		mov	r16, ZH		; 4F6B 2F0F 
		mov	r17, r22		; 4F6C 2F16
		call	sub25FE		; 4F6D 940E 25FE
		mov	r16, ZL		; 4F6F 2F0E
		mov	r17, r22		; 4F70 2F16
		call	sub25FE		; 4F71 940E 25FE
		ldi	r17, 0x1D	; 4F73 E11D
		ser	r18		; 4F74 EF2F
		cp	r18, ZL		; 4F75 172E
		cpc	r17, ZH		; 4F76 071F
		brlo	avr4F79		; 4F77 F008
		rjmp	avr4F81		; 4F78 C008
avr4F79:	call	sub0629		; 4F79 940E 0629 get next char
		brsh	avr4F7D		; 4F7B F408
		rjmp	avr4EFD		; 4F7C CF80 tiemout
avr4F7D:	cpi	r16, 0x45	; 4F7D 3405  is char 45 ?
		brne	avr4F80		; 4F7E F409
		rjmp	avr4F95		; 4F7F C015
avr4F80:	rjmp	avr4EFD		; 4F80 CF7C return
avr4F81:	ldi	XH, 0x0E		; 4F81 E0BE
		ldi	XL, 0x00		; 4F82 E0A0
		ldi	r21, 0x41		; 4F83 E451
avr4F84:	call	sub0629		; 4F84 940E 0629 get next char
		brsh	avr4F88		; 4F86 F408
		rjmp	avr4EFD		; 4F87 CF75
avr4F88:	st	X+, r16		; 4F88 930D
		dec	r21			; 4F89 955A
		brne	avr4F84		; 4F8A F7C9
		ldi	XH, 0x0E		; 4F8B E0BE
		ldi	XL, 0x00		; 4F8C E0A0
		ldi	r21, 0x41		; 4F8D E451
avr4F8E:	ld	r16, X+		; 4F8E 910D
		mov	r17, r22		; 4F8F 2F16
		call	sub25FE		; 4F90 940E 25FE
		dec	r21			; 4F92 955A
		brne	avr4F8E		; 4F93 F7D1
		rjmp	avr4F5E		; 4F94 CFC9
avr4F95:	ldi	r16, 0x45	; 4F95 E405 send 45
		call	sub0641		; 4F96 940E 0641
		ldi	r16, 0x45	; 4F98 E405 send 45
		call	sub0641		; 4F99 940E 0641
		ldi	r16, 0x50	; 4F9B E500 send 50
		call	sub0641		; 4F9C 940E 0641
		ldi	r16, 0x45	; 4F9E E405
		ldi	r17, 0x00	; 4F9F E010
		call	sub25FE		; 4FA0 940E 25FE
		ldi	YH, 0x02	; 4FA2 E0D2
		ldi	YL, 0x00	; 4FA3 E0C0
avr4FA4:call	sub0629		; 4FA4 940E 0629
		brsh	avr4FA8		; 4FA6 F408
		rjmp	avr4FB0		; 4FA7 C008
avr4FA8:	ldi	r17, 0x00	; 4FA8 E010
		call	sub25FE		; 4FA9 940E 25FE
		cpi	YH, 0x00	; 4FAB 30D0
		brne	avr4FA4		; 4FAC F7B9
		cpi	YL, 0x00		; 4FAD 30C0
		brne	avr4FA4		; 4FAE F7A9
		rjmp	avr4EFD		; 4FAF CF4D

avr4FB0:	call	sub0291		; 4FB0 940E 0291 Delay
			call	sub0291		; 4FB2 940E 0291 Delay
			call	sub0291		; 4FB4 940E 0291 Delay
	
avr4FB6:	ldi	XH, 0x0E	; 4FB6 E0BE x = 0x0E00
			ldi	XL, 0x00	; 4FB7 E0A0 
			ldi	r16, 0xF7	; 4FB8 EF07 0xE00 = F7
			st	X+, r16		; 4FB9 930D 
			ldi	r16, 0x00	; 4FBA E000 0xE01 = 00
			st	X+, r16		; 4FBB 930D
			ldi	r16, 0x00	; 4FBC E000 0xE02 = 00
			st	X+, r16		; 4FBD 930D
			ldi	r16, 0x00	; 4FBE E000 0xE03 = 00
			st	X+, r16		; 4FBF 930D
			call	sub4499		; 4FC0 940E 4499
avr4FC2:	push	r16		; 4FC2 930F
			call	sub0641		; 4FC3 940E 0641  return value
			pop	r16		; 4FC5 910F
			lds	r17, 0x0511	; 4FC6 9110 0511
			cp	r16, r17	; 4FC8 1701
			breq	avr4FCB		; 4FC9 F009
			rjmp	avr4EFD		; 4FCA CF32

avr4FCB:	sbi	DDRA, 5		; 4FCB 9AD5 
			cbi	PORTA, 5	; 4FCC 98DD
			call	sub027A		; 4FCD 940E 027A delay
			sbi	PORTA, 5	; 4FCF 9ADD
			cbi	DDRA, 5		; 4FD0 98D5
			rjmp	avr4EFD		; 4FD1 CF2B

avr4FD2:	ldi	r16, 0xF8	; 4FD2 EF08 echo 0xF8
			call	sub0641		; 4FD3 940E 0641
			call	sub0629		; 4FD5 940E 0629 get next char
			brsh	avr4FD9		; 4FD7 F408
			rjmp	avr4EFD		; 4FD8 CF24 timeout
avr4FD9:	call	sub0641		; 4FD9 940E 0641 echo
			sts	0x0511, r16	; 4FDB 9300 0511 save in 0x511
			rjmp	avr4EFD		; 4FDD CF1F
;----------------------------------------------------------------
; Command AF
avr4FDE:cli			; 4FDE 94F8 
		ldi	r16, 0xAE	; 4FDF EA0E echo AE
		call	sub0641		; 4FE0 940E 0641 

		call	sub0629		; 4FE2 940E 0629 get next char
		brsh	avr4FE6		; 4FE4 F408 
		rjmp	avr500E		; 4FE5 C028 timeout

avr4FE6:	cpi	r16, 0x62	; 4FE6 3602 is char = 0x62 ? 'b'
		brne	avr500E		; 4FE7 F531 exit if not
		ldi	r16, 0x42	; 4FE8 E402 echo 0x42
		call	sub0641		; 4FE9 940E 0641

		call	sub0629		; 4FEB 940E 0629 get next char 
		brsh	avr4FEF		; 4FED F408
		rjmp	avr500E		; 4FEE C01F timeout

avr4FEF:	cpi	r16, 0x6F	; 4FEF 360F is char = 0x6F 'o'
		brne	avr500E		; 4FF0 F4E9
		ldi	r16, 0x4F	; 4FF1 E40F echo 0x4F
		call	sub0641		; 4FF2 940E 0641

		call	sub0629		; 4FF4 940E 0629 get next char
		brsh	avr4FF8		; 4FF6 F408
		rjmp	avr500E		; 4FF7 C016
avr4ff8:	cpi	r16, 0x6F	; 4FF8 360F is char = 0x6F 'o'
		brne	avr500E		; 4FF9 F4A1
		ldi	r16, 0x4F	; 4FFA E40F echo 0x4F
		call	sub0641		; 4FFB 940E 0641

		call	sub0629		; 4FFD 940E 0629 get next char
		brsh	avr5001		; 4FFF F408
		rjmp	avr500E		; 5000 C00D
avr5001:	cpi	r16, 0x74	; 5001 3704 is char = 0x74 't'
		brne	avr500E		; 5002 F459
		ldi	r16, 0x54	; 5003 E504 echo 0x54
		call	sub0641		; 5004 940E 0641

		call	sub027A		; 5006 940E 027A wait rx rdy
		call	sub02AB		; 5008 940E 02AB turn off wdt
		call	sub02B6		; 500A 940E 02B6 tristate IO
		jmp	avrF000		; 500C 940C F000

avr500E:	sei			; 500E 9478 here on timeout
		jmp	avr03CB		; 500F 940C 03CB return
;--------------------------------------------------------------------------
; Gyro Routines
;first check if KRG or GWS

sub5011:	lds	r16, 0x052F		; 5011 9100 052F
			andi	r16, 0xF0	; 5013 7F00
			cpi	r16, 0x00		; 5014 3000
			brne	avr5017		; 5015 F409
			rjmp	avr5025		; 5016 C00E
avr5017:	cpi	r16, 0x10		; 5017 3100
			brne	avr501A		; 5018 F409
			rjmp	avr50B6		; 5019 C09C
avr501A:	ret					; 501A 9508
;---------------------------------------------------------
; first check if KRG or GWS
sub501B:	lds	r16, 0x052F		; 501B 9100 052F 
			andi	r16, 0xF0	; 501D 7F00
			cpi	r16, 0x00		; 501E 3000
			brne	avr5021		; 501F F409
			rjmp	avr5048		; 5020 C027
avr5021:	cpi	r16, 0x10		; 5021 3100
			brne	avr5024		; 5022 F409
			rjmp	avr50D9		; 5023 C0B5
avr5024:	ret					; 5024 9508
;-------------------------------------------------------------------------
avr5025:	clr	r17		; 5025 2711 GWS Servo Part 1
			lds	r16, 0x052F		; 5026 9100 052F
			andi	r16, 0x0F	; 5028 700F
			sbrc	r16, 0		; 5029 FD00
			ori	r17, 0x01		; 502A 6011
			sbrc	r16, 1		; 502B FD01
			ori	r17, 0x02		; 502C 6012
			sbrc	r16, 2		; 502D FD02
			ori	r17, 0x04		; 502E 6014
			sbrc	r16, 3		; 502F FD03
			ori	r17, 0x08		; 5030 6018
			sbrs	r16, 0		; 5031 FF00
			rjmp	avr5033		; 5032 C000
avr5033:	sbrs	r16, 1		; 5033 FF01
			rjmp	avr5035		; 5034 C000
avr5035:	sbrs	r16, 2		; 5035 FF02
			rjmp	avr5037		; 5036 C000
avr5037:	sbrs	r16, 3		; 5037 FF03
			rjmp	avr5039		; 5038 C000
avr5039:	mov	r18, r17		; 5039 2F21
			swap	r18			; 503A 9522
			andi	r18, 0xF0	; 503B 7F20
			or	r18, r17		; 503C 2B21
			lds	r16, 0x0062		; 503D 9100 0062 get outputs
			or	r18, r16		; 503F 2B20 or gyro
			sts	0x0062, r18		; 5040 9320 0062 set outputs
			lds	r16, 0x0061		; 5042 9100 0061 get directions
			or	r17, r16		; 5044 2B10 set or gyro
			sts	0x0061, r17		; 5045 9310 0061 set direction
			ret					; 5047 9508
;-------------------------------------------------------------------------
avr5048:	lds	r16, 0x052F		; 5048 9100 052F GWS Servo part 2
			andi	r16, 0x0F	; 504A 700F r16 = gyro enables
			ldi	r19, 0x00		; 504B E030 r19 = 0
			ldi	r18, 0x7F		; 504C E72F
			mov	r3, r18			; 504D 2E32 r3, r4, r5, r6 = 0x7f
			mov	r4, r18			; 504E 2E42
			mov	r5, r18			; 504F 2E52
			mov	r6, r18			; 5050 2E62
			clr	r7				; 5051 2477 r7, r8, r9, r10 = 0
			clr	r8				; 5052 2488
			clr	r9				; 5053 2499
			clr	r10				; 5054 24AA
avr5055:	ldi	r17, 0x00		; 5055 E010 r17 = 0
			cp	r3, r19			; 5056 1633 if r19 = 0x7f
			brne	avr505A		; 5057 F411
			sbrc	r16, 0		; 5058 FD00
			ori	r17, 0x01		; 5059 6011
avr505A:	cp	r4, r19			; 505A 1643
			brne	avr505E		; 505B F411
			sbrc	r16, 1		; 505C FD01
			ori	r17, 0x02		; 505D 6012
avr505E:	cp	r5, r19			; 505E 1653
			brne	avr5062		; 505F F411
			sbrc	r16, 2		; 5060 FD02
			ori	r17, 0x04		; 5061 6014
avr5062:	cp	r6, r19			; 5062 1663
			brne	avr5066		; 5063 F411
			sbrc	r16, 3		; 5064 FD03
			ori	r17, 0x08		; 5065 6018
avr5066:	lds	r18, 0x0062		; 5066 9120 0062 stop the pulse out at 0x7f
			com	r17				; 5068 9510
			and	r17, r18		; 5069 2312
			sts	0x0062, r17		; 506A 9310 0062
			nop					; 506C 0000
			nop					; 506D 0000
			nop					; 506E 0000
			nop					; 506F 0000
			nop					; 5070 0000
			nop					; 5071 0000
			nop					; 5072 0000
			nop					; 5073 0000
			nop					; 5074 0000
			nop					; 5075 0000
			sbrs	r16, 0		; 5076 FF00
			rjmp	avr507B		; 5077 C003
			sbic	$00, 4		; 5078 9904 test gyro 1
			mov	r7, r19			; 5079 2E73
			rjmp	avr507E		; 507A C003
avr507B:	nop					; 507B 0000
			nop					; 507C 0000
			nop					; 507D 0000
avr507E:		sbrs	r16, 1	; 507E FF01
			rjmp	avr5083		; 507F C003
			sbic	$00, 5		; 5080 9905 test gyro 2
			mov	r8, r19			; 5081 2E83
			rjmp	avr5086		; 5082 C003
avr5083:	nop					; 5083 0000
			nop					; 5084 0000
			nop					; 5085 0000
avr5086:	sbrs	r16, 2		; 5086 FF02
			rjmp	avr508B		; 5087 C003
			sbic	$00, 6		; 5088 9906 test gyro 3
			mov	r9, r19			; 5089 2E93
			rjmp	avr508E		; 508A C003


avr508B:	nop					; 508B 0000
			nop					; 508C 0000
			nop					; 508D 0000
avr508E:	sbrs	r16, 3		; 508E FF03
			rjmp	avr5093		; 508F C003
			sbic	$00, 7		; 5090 9907 test gyro 4
			mov	r10, r19		; 5091 2EA3
			rjmp	avr5096		; 5092 C003
avr5093:	nop					; 5093 0000
			nop					; 5094 0000
			nop					; 5095 0000
avr5096:	cpi	r19, 0xC8		; 5096 3C38 compare 200
			breq	avr509A		; 5097 F011
			inc	r19				; 5098 9533
			rjmp	avr5055		; 5099 CFBB

avr509A:	ldi	r16, 0x90		; 509A E900 r16 = 144
			sub	r7, r16			; 509B 1A70
			sub	r8, r16			; 509C 1A80
			sub	r9, r16			; 509D 1A90
			sub	r10, r16		; 509E 1AA0
			ldi	r16, 0x38		; 509F E308 r16 = 56
			ldi	r19, 0x2C		; 50A0 E23C r19 = 44
			cp	r16, r7			; 50A1 1507 
			brne	avr50A4		; 50A2 F409
			mov	r7, r19			; 50A3 2E73
avr50A4:	cp	r16, r8			; 50A4 1508
			brne	avr50A7		; 50A5 F409
			mov	r7, r19			; 50A6 2E73
avr50A7:	cp	r16, r9			; 50A7 1509
			brne	avr50AA		; 50A8 F409
			mov	r7, r19			; 50A9 2E73
avr50AA:	cp	r16, r10		; 50AA 150A
			brne	avr50AD		; 50AB F409
			mov	r7, r19			; 50AC 2E73
avr50AD:	sts	0x0530, r7		; 50AD 9270 0530
			sts	0x0531, r8		; 50AF 9280 0531
			sts	0x0532, r9		; 50B1 9290 0532
			sts	0x0533, r10		; 50B3 92A0 0533
			ret					; 50B5 9508
;-------------------------------------------------------------------------
avr50B6:	clr	r17		; 50B6 2711
		lds	r16, 0x052F		; 50B7 9100 052F
		andi	r16, 0x0F	; 50B9 700F
		sbrc	r16, 0		; 50BA FD00
		ori	r17, 0x01		; 50BB 6011
		sbrc	r16, 1		; 50BC FD01
		ori	r17, 0x02		; 50BD 6012
		sbrc	r16, 2		; 50BE FD02
		ori	r17, 0x04		; 50BF 6014
		sbrc	r16, 3		; 50C0 FD03
		ori	r17, 0x08		; 50C1 6018
		sbrs	r16, 0		; 50C2 FF00
		rjmp	avr50C4		; 50C3 C000
avr50C4:	sbrs	r16, 1		; 50C4 FF01
		rjmp	avr50C6		; 50C5 C000
avr50C6:	sbrs	r16, 2		; 50C6 FF02
		rjmp	avr50C8		; 50C7 C000
avr50C8:	sbrs	r16, 3		; 50C8 FF03
		rjmp	avr50CA		; 50C9 C000
avr50CA:	mov	r18, r17		; 50CA 2F21
		swap	r18			; 50CB 9522
		andi	r18, 0xF0		; 50CC 7F20
		or	r18, r17		; 50CD 2B21
		lds	r16, 0x0062		; 50CE 9100 0062
		or	r18, r16		; 50D0 2B20
		sts	0x0062, r18		; 50D1 9320 0062
		lds	r16, 0x0061		; 50D3 9100 0061
		or	r17, r16		; 50D5 2B10
		sts	0x0061, r17		; 50D6 9310 0061
		ret				; 50D8 9508
;-------------------------------------------------------------------------
avr50D9:	lds	r16, 0x052F		; 50D9 9100 052F
		andi	r16, 0x0F		; 50DB 700F
		ldi	r19, 0x00		; 50DC E030
		ldi	r18, 0x7F		; 50DD E72F
		mov	r3, r18		; 50DE 2E32
		mov	r4, r18		; 50DF 2E42
		mov	r5, r18		; 50E0 2E52
		mov	r6, r18		; 50E1 2E62
		clr	r7			; 50E2 2477
		clr	r8			; 50E3 2488
		clr	r9			; 50E4 2499
		clr	r10			; 50E5 24AA
avr50E6:	ldi	r17, 0x00		; 50E6 E010
		cp	r3, r19		; 50E7 1633
		brne	avr50EB		; 50E8 F411
		sbrc	r16, 0		; 50E9 FD00
		ori	r17, 0x01		; 50EA 6011
avr50EB:	cp	r4, r19		; 50EB 1643
		brne	avr50EF		; 50EC F411
		sbrc	r16, 1		; 50ED FD01
		ori	r17, 0x02		; 50EE 6012
avr50EF:	cp	r5, r19		; 50EF 1653
		brne	avr50F3		; 50F0 F411
		sbrc	r16, 2		; 50F1 FD02
		ori	r17, 0x04		; 50F2 6014
avr50F3:	cp	r6, r19		; 50F3 1663
		brne	avr50F7		; 50F4 F411
		sbrc	r16, 3		; 50F5 FD03
		ori	r17, 0x08		; 50F6 6018
avr50F7:	lds	r18, 0x0062		; 50F7 9120 0062
		com	r17			; 50F9 9510
		and	r17, r18		; 50FA 2312
		sts	0x0062, r17		; 50FB 9310 0062
		nop				; 50FD 0000
		nop				; 50FE 0000
		nop				; 50FF 0000
		nop				; 5100 0000
		nop				; 5101 0000
		nop				; 5102 0000
		nop				; 5103 0000
		nop				; 5104 0000
		nop				; 5105 0000
		nop				; 5106 0000
		sbrs	r16, 0		; 5107 FF00
		rjmp	avr510C		; 5108 C003
		sbic	$00, 4	; 5109 9904
		mov	r7, r19		; 510A 2E73
		rjmp	avr510F		; 510B C003
avr510C:	nop				; 510C 0000
		nop				; 510D 0000
		nop				; 510E 0000
avr510f:	sbrs	r16, 1		; 510F FF01
		rjmp	avr5114		; 5110 C003
		sbic	$00, 5	; 5111 9905
		mov	r8, r19		; 5112 2E83
		rjmp	avr5117		; 5113 C003
avr5114:	nop				; 5114 0000
		nop				; 5115 0000
		nop				; 5116 0000
avr5117:	sbrs	r16, 2		; 5117 FF02
		rjmp	avr511C		; 5118 C003
		sbic	$00, 6	; 5119 9906
		mov	r9, r19		; 511A 2E93
		rjmp	avr511F		; 511B C003
avr511C:	nop				; 511C 0000
		nop				; 511D 0000
		nop				; 511E 0000
avr511F:	sbrs	r16, 3		; 511F FF03
		rjmp	avr5124		; 5120 C003
		sbic	$00, 7	; 5121 9907
		mov	r10, r19		; 5122 2EA3
		rjmp	avr5127		; 5123 C003
avr5124:		nop				; 5124 0000
		nop				; 5125 0000
		nop				; 5126 0000
avr5127:	cpi	r19, 0xBE		; 5127 3B3E
		breq	avr512B		; 5128 F011
		inc	r19			; 5129 9533
		rjmp	avr50E6		; 512A CFBB
avr512B:	ldi	r19, 0x00		; 512B E030
avr512C:	ldi	r17, 0x00		; 512C E010
		cp	r3, r19		; 512D 1633
		brne	avr5131		; 512E F411
		sbrc	r16, 0		; 512F FD00
		ori	r17, 0x01		; 5130 6011
avr5131:	cp	r4, r19		; 5131 1643
		brne	avr5135		; 5132 F411
		sbrc	r16, 1		; 5133 FD01
		ori	r17, 0x02		; 5134 6012
avr5135:	cp	r5, r19		; 5135 1653
		brne	avr5139		; 5136 F411
		sbrc	r16, 2		; 5137 FD02
		ori	r17, 0x04		; 5138 6014
avr5139:	cp	r6, r19		; 5139 1663
		brne	avr513D		; 513A F411
		sbrc	r16, 3		; 513B FD03
		ori	r17, 0x08		; 513C 6018
avr513D:	lds	r18, 0x0062		; 513D 9120 0062
		com	r17			; 513F 9510
		and	r17, r18		; 5140 2312
		nop				; 5141 0000
		nop				; 5142 0000
		nop				; 5143 0000
		nop				; 5144 0000
		nop				; 5145 0000
		nop				; 5146 0000
		nop				; 5147 0000
		nop				; 5148 0000
		nop				; 5149 0000
		nop				; 514A 0000
		push	r16			; 514B 930F
		ldi	r16, 0x14		; 514C E104
avr514D:	dec	r16			; 514D 950A
		brne	avr514D		; 514E F7F1
		pop	r16			; 514F 910F
		sbrs	r16, 0		; 5150 FF00
		rjmp	avr5155		; 5151 C003
		sbic	$00, 4	; 5152 9904
		mov	r7, r19		; 5153 2E73
		rjmp	avr5158		; 5154 C003
avr5155:	nop				; 5155 0000
		nop				; 5156 0000
		nop				; 5157 0000
avr5158:	sbrs	r16, 1		; 5158 FF01
		rjmp	avr515D		; 5159 C003
		sbic	$00, 5	; 515A 9905
		mov	r8, r19		; 515B 2E83
		rjmp	avr5160		; 515C C003
avr515D:	nop				; 515D 0000
		nop				; 515E 0000
		nop				; 515F 0000
avr5160:	sbrs	r16, 2		; 5160 FF02
		rjmp	avr5165		; 5161 C003
		sbic	$00, 6	; 5162 9906
		mov	r9, r19		; 5163 2E93
		rjmp	avr5168		; 5164 C003
avr5165:	nop				; 5165 0000
		nop				; 5166 0000
		nop				; 5167 0000
avr5168:	sbrs	r16, 3		; 5168 FF03
		rjmp	avr516D		; 5169 C003
		sbic	$00, 7	; 516A 9907
		mov	r10, r19		; 516B 2EA3
		rjmp	avr5170		; 516C C003
avr516D:	nop				; 516D 0000
		nop				; 516E 0000
		nop				; 516F 0000
avr5170:	cpi	r19, 0xA0		; 5170 3A30
		breq	avr5174		; 5171 F011
		inc	r19			; 5172 9533
		rjmp	avr512C		; 5173 CFB8
avr5174:	ldi	r16, 0x01		; 5174 E001
		sub	r7, r16		; 5175 1A70
		sub	r8, r16		; 5176 1A80
		sub	r9, r16		; 5177 1A90
		sub	r10, r16		; 5178 1AA0
		ldi	r16, 0x38		; 5179 E308
		ldi	r19, 0x2C		; 517A E23C
		cp	r16, r7		; 517B 1507
		brne	avr517E		; 517C F409
		mov	r7, r19		; 517D 2E73
avr517E:		cp	r16, r8		; 517E 1508
		brne	avr5181		; 517F F409
		mov	r7, r19		; 5180 2E73
avr5181:		cp	r16, r9		; 5181 1509
		brne	avr5184		; 5182 F409
		mov	r7, r19		; 5183 2E73
avr5184:	cp	r16, r10		; 5184 150A
		brne	avr5187		; 5185 F409
		mov	r7, r19		; 5186 2E73
avr5187:	sts	0x0530, r7		; 5187 9270 0530
		sts	0x0531, r8		; 5189 9280 0531
		sts	0x0532, r9		; 518B 9290 0532
		sts	0x0533, r10		; 518D 92A0 0533
		ret				; 518F 9508
;-------------------------------------------------------------------------
; Timer 0 Interrupt
; This is the motion timer interrupt
;
avr5190:	wdr						; 5190 95A8 Reset watchdog
			push	r16				; 5191 930F
			in	r16, SREG			; 5192 B70F save status register
			push	r16				; 5193 930F
			ldi	r16, 0x19			; 5194 E109 send 0x19 to timer count 0
			out	$32, r16			; 5195 BF02 reset the count to 4 millisec (counts up)

			lds	r16, 0x04F4			; 5196 9100 04F4 Test Interupt already in progress flag
			sbrc	r16, 7			; 5198 FD07 if bit 7 set in 0x4f4 then skip this routine
			rjmp	avr5214			; 5199 C07A
			ori	r16, 0x80			; 519A 6800 set bit 7 in 0x4f4 Interrupt in progress
			sts	0x04F4, r16			; 519B 9300 04F4
			push	r17				; 519D 931F save registers
			push	r18				; 519E 932F, 
			push	r19				; 519F 933F
			push	r20				; 51A0 934F
			push	r21				; 51A1 935F
			push	XL				; 51A2 93AF
			push	XH				; 51A3 93BF
			push	YL				; 51A4 93CF
			push	YH				; 51A5 93DF
			push	ZL				; 51A6 93EF
			push	ZH				; 51A7 93FF
			push	r0				; 51A8 920F
	
			rcall	sub5584			; 51A9 D3DA increment delay counter and clear delay busy if done

			rcall	sub557E			; 51AA D3D3 increment 0x513 (4 ms timer)

			lds	r16, 0x04EB			; 51AB 9100 04EB any G8A servos in use ? y  avr51C4
			tst	r16					; 51AD 2300 	 
			brne	avr51C4			; 51AE F4A9
			lds	r16, 0x04EC			; 51AF 9100 04EC any G8B servos in use ? y avr51C4
			tst	r16					; 51B1 2300
			brne	avr51C4			; 51B2 F489
			lds	r16, 0x04ED			; 51B3 9100 04ED any G8C servos in use ? y avr51C4
			tst	r16					; 51B5 2300
			brne	avr51C4			; 51B6 F469
			lds	r16, 0x04EE			; 51B7 9100 04EE any G8D servos in use ? y avr51C4
			tst	r16					; 51B9 2300
			brne	avr51C4			; 51BA F449
			lds	r16, 0x052F			; 51BB 9100 052F any Gyros in use ? y avr51C4
			tst	r16					; 51BD 2300
			brne	avr51C4			; 51BE F429

			lds	r16, 0x04F0			; 51BF 9100 04F0 AIMOTOR s enable ? y avr51C4
			sbrc	r16, 7			; 51C1 FD07
			rjmp	avr51C4			; 51C2 C001

			rjmp	avr51DD			; 51C3 C019 no motion actions to do
	
avr51C4:	call	sub3FD7			; 51C4 940E 3FD7 AI Motors
			ldi	r17, 0x03			; 51C6 E013
			lds	r16, 0x052F			; 51C7 9100 052F if any Gyro enable then enable phase 4
			andi	r16, 0x0F		; 51C9 700F
			tst	r16					; 51CA 2300
			breq	avr51CD			; 51CB F009
			ldi	r17, 0x04			; 51CC E014

avr51CD:	lds	r16, 0x04D7			; 51CD 9100 04D7 get phase ( 1 to 4) and increment
			inc	r16					; 51CF 9503
			cp	r16, r17			; 51D0 1701
			brlo	avr51D3			; 51D1 F008
			clr	r16					; 51D2 2700
avr51D3:	sts	0x04D7, r16			; 51D3 9300 04D7

			cpi	r16, 0x00			; 51D5 3000
			breq	avr51DE			; 51D6 F039
			cpi	r16, 0x01			; 51D7 3001
			breq	avr51E2			; 51D8 F049
			cpi	r16, 0x02			; 51D9 3002
			breq	avr51E6			; 51DA F059
			cpi	r16, 0x03			; 51DB 3003
			breq	avr51EA			; 51DC F069

avr51DD:	rjmp	avr51EF			; 51DD C011

avr51DE:	rcall	sub5218			; 51DE D039 Phase 1 sets first 12 on
			rcall	sub5474			; 51DF D294 minimum pulse delay
			rcall	sub52E1			; 51E0 D100 off after length
			rjmp	avr51EF			; 51E1 C00D done

avr51E2:	rcall	sub5258			; 51E2 D075 Phase 2 sets second 12 on
			rcall	sub5474			; 51E3 D290 minimum pulse delay
			rcall	sub5366			; 51E4 D181 off after length
			rjmp	avr51EF			; 51E5 C009 done
	
avr51E6:	rcall	sub5298			; 51E6 D0B1 Phase 3 sets last 8 on
			rcall	sub5474			; 51E7 D28C minimum pulse delay
			rcall	sub53EA			; 51E8 D201 off after length
			rjmp	avr51EF			; 51E9 C005 done

avr51EA:	call	sub5011			; 51EA 940E 5011 Phase 4 Gyro start pulse out
			call	sub501B			; 51EC 940E 501B Gyro get result values
			rjmp	avr51EF			; 51EE C000 done

avr51EF:	rcall	sub54A6			; 51EF D2B6 set change angle
			rcall	sub54B8			; 51F0 D2C7 move angle if change
			lds	r16, 0x04EF			; 51F1 9100 04EF Test high speed
			tst	r16					; 51F3 2300 skip if hi speed
			breq	avr51F9			; 51F4 F021
			rcall	sub54A6			; 51F5 D2B0 set change angle
			rcall	sub54B8			; 51F6 D2C1 move angle if change
			rcall	sub54A6			; 51F7 D2AE set change angle
			rcall	sub54B8			; 51F8 D2BF move angle if change
avr51F9:	rcall	sub54D4			; 51F9 D2DA set motion complete if present = desired
			rcall	sub5503			; 51FA D308 Gyro correction to adjusted
			rcall	sub54EA			; 51FB D2EE add direction to adjusted position for sending to servo
			rcall	sub5487			; 51FC D28A adjusted = desired + zero offset

			lds	r19, 0x04F0			; 51FD 9130 04F0 AI motors ?
			sbrs	r19, 7			; 51FF FF37
			rjmp	avr5203			; 5200 C002
			call	sub4081			; 5201 940E 4081
avr5203:	pop	r0					; 5203 900F
			pop	ZH					; 5204 91FF
			pop	ZL					; 5205 91EF
			pop	YH					; 5206 91DF
			pop	YL					; 5207 91CF
			pop	XH					; 5208 91BF
			pop	XL					; 5209 91AF
			pop	r21					; 520A 915F
			pop	r20					; 520B 914F
			pop	r19					; 520C 913F
			pop	r18					; 520D 912F
			pop	r17					; 520E 911F
			lds	r16, 0x04F4			; 520F 9100 04F4 Clear the interrupt in progress flag
			andi	r16, 0x7F		; 5211 770F
			sts	0x04F4, r16			; 5212 9300 04F4
avr5214:	pop	r16					; 5214 910F
			out	SREG, r16			; 5215 BF0F
			pop	r16					; 5216 910F
			reti					; 5217 9518
;-------------------------------------------------------------------------
;  first 12  servos Based on the bits in 0x4Eb amd 0x4EC sets the bits, and equalises the delay
sub5218:	lds	r16, 0x04EB		; 5218 9100 04EB sets port a 0 to 7  and port b 0 to 3 if enabled
			lds	r17, 0x04EC		; 521A 9110 04EC
			sbrc	r16, 0			; 521C FD00
			sbi	PORTA, 0		; 521D 9AD8
			nop				; 521E 0000
			sbrc	r16, 1			; 521F FD01
			sbi	PORTA, 1		; 5220 9AD9
			nop				; 5221 0000
			sbrc	r16, 2			; 5222 FD02
			sbi	PORTA, 2		; 5223 9ADA
			nop				; 5224 0000
			sbrc	r16, 3			; 5225 FD03
			sbi	PORTA, 3		; 5226 9ADB
			nop				; 5227 0000
			sbrc	r16, 4			; 5228 FD04
			sbi	PORTA, 4		; 5229 9ADC
			nop				; 522A 0000
			sbrc	r16, 5			; 522B FD05
			sbi	PORTA, 5		; 522C 9ADD
			nop				; 522D 0000
			sbrc	r16, 6			; 522E FD06
			sbi	PORTA, 6		; 522F 9ADE
			nop				; 5230 0000
			sbrc	r16, 7			; 5231 FD07
			sbi	PORTA, 7		; 5232 9ADF
			nop				; 5233 0000
			sbrc	r17, 0			; 5234 FD10
			sbi	PORTB, 0		; 5235 9AC0
			nop				; 5236 0000
			sbrc	r17, 1			; 5237 FD11
			sbi	PORTB, 1		; 5238 9AC1
			nop				; 5239 0000
			sbrc	r17, 2			; 523A FD12
			sbi	PORTB, 2		; 523B 9AC2
			nop				; 523C 0000
			sbrc	r17, 3			; 523D FD13
			sbi	PORTB, 3		; 523E 9AC3

			sbrs	r16, 0			; 523F FF00 Next part probably equalises the time delay
			rjmp	avr5241			; 5240 C000

avr5241:	sbrs	r16, 1			; 5241 FF01
			rjmp	avr5243			; 5242 C000

avr5243:	sbrs	r16, 2			; 5243 FF02
			rjmp	avr5245			; 5244 C000

avr5245:	sbrs	r16, 3			; 5245 FF03
			rjmp	avr5247			; 5246 C000
avr5247:		sbrs	r16, 4			; 5247 FF04
			rjmp	avr5249			; 5248 C000
avr5249:	sbrs	r16, 5			; 5249 FF05
			rjmp	avr524B			; 524A C000
avr524B:	sbrs	r16, 6			; 524B FF06
			rjmp	avr524D			; 524C C000
avr524D:	sbrs	r16, 7			; 524D FF07
			rjmp	avr524F			; 524E C000
avr524F:	sbrs	r17, 0			; 524F FF10
			rjmp	avr5251			; 5250 C000
avr5251:	sbrs	r17, 1			; 5251 FF11
			rjmp	avr5253			; 5252 C000
avr5253:	sbrs	r17, 2			; 5253 FF12
			rjmp	avr5255			; 5254 C000
avr5255:	sbrs	r17, 3			; 5255 FF13
			rjmp	avr5257			; 5256 C000
avr5257:	ret				; 5257 9508
;-------------------------------------------------------------------------
;second 12  servos Based on the bits in 0x4Eb amd 0x4EC sets the bits, and equalises the delay
sub5258:	lds	r16, 0x04EC		; 5258 9100 04EC
		lds	r17, 0x04ED		; 525A 9110 04ED
		sbrc	r16, 4			; 525C FD04
		sbi	PORTB, 4		; 525D 9AC4
		nop				; 525E 0000
		sbrc	r16, 5			; 525F FD05
		sbi	PORTB, 5		; 5260 9AC5
		nop				; 5261 0000
		sbrc	r16, 6			; 5262 FD06
		sbi	PORTB, 6		; 5263 9AC6
		nop				; 5264 0000
		sbrc	r16, 7			; 5265 FD07
		sbi	PORTB, 7		; 5266 9AC7
		nop				; 5267 0000
		sbrc	r17, 0			; 5268 FD10
		sbi	PORTC, 7		; 5269 9AAF
		nop				; 526A 0000
		sbrc	r17, 1			; 526B FD11
		sbi	PORTC, 6		; 526C 9AAE
		nop				; 526D 0000
		sbrc	r17, 2			; 526E FD12
		sbi	PORTC, 5		; 526F 9AAD
		nop				; 5270 0000
		sbrc	r17, 3			; 5271 FD13
		sbi	PORTC, 4		; 5272 9AAC
		nop				; 5273 0000
		sbrc	r17, 4			; 5274 FD14
		sbi	PORTC, 3		; 5275 9AAB
		nop				; 5276 0000
		sbrc	r17, 5			; 5277 FD15
		sbi	PORTC, 2		; 5278 9AAA
		nop				; 5279 0000
		sbrc	r17, 6			; 527A FD16
		sbi	PORTC, 1		; 527B 9AA9
		nop				; 527C 0000
		sbrc	r17, 7			; 527D FD17
		sbi	PORTC, 0		; 527E 9AA8
		sbrs	r16, 4			; 527F FF04
		rjmp	avr5281			; 5280 C000
avr5281:	sbrs	r16, 5			; 5281 FF05
		rjmp	avr5283			; 5282 C000
avr5283:	sbrs	r16, 6			; 5283 FF06
		rjmp	avr5285			; 5284 C000
avr5285:	sbrs	r16, 7			; 5285 FF07
		rjmp	avr5287			; 5286 C000
avr5287:	sbrs	r17, 0			; 5287 FF10
		rjmp	avr5289			; 5288 C000
avr5289:	sbrs	r17, 1			; 5289 FF11
		rjmp	avr528B			; 528A C000
avr528B:	sbrs	r17, 2			; 528B FF12
		rjmp	avr528D			; 528C C000
avr528D:	sbrs	r17, 3			; 528D FF13
		rjmp	avr528F			; 528E C000
avr528F:	sbrs	r17, 4			; 528F FF14
		rjmp	avr5291			; 5290 C000
avr5291:	sbrs	r17, 5			; 5291 FF15
		rjmp	avr5293			; 5292 C000
avr5293:	sbrs	r17, 6			; 5293 FF16
		rjmp	avr5295			; 5294 C000
avr5295:	sbrs	r17, 7			; 5295 FF17
		rjmp	avr5297			; 5296 C000
avr5297:	ret				; 5297 9508
;-------------------------------------------------------------------------
; last 8  servos Based on the bits in 0x4Eb amd 0x4EC sets the bits, and equalises the delay
sub5298:	lds	r16, 0x04EE		; 5298 9100 04EE
		sbrc	r16, 0		; 529A FD00
		sbi	$03, 7	; 529B 9A1F
		nop				; 529C 0000
		sbrc	r16, 1		; 529D FD01
		sbi	$03, 6	; 529E 9A1E
		nop				; 529F 0000
		sbrc	r16, 2		; 52A0 FD02
		sbi	PORTD, 7	; 52A1 9A97
		nop				; 52A2 0000
		sbrc	r16, 3		; 52A3 FD03
		sbi	PORTD, 6	; 52A4 9A96
		nop				; 52A5 0000
		sbrc	r16, 4		; 52A6 FD04
		sbi	PORTD, 5	; 52A7 9A95
		nop				; 52A8 0000
		sbrs	r16, 5		; 52A9 FF05
		rjmp	avr52B0		; 52AA C005
		lds	r18, 0x0065		; 52AB 9120 0065
		ori	r18, 0x04		; 52AD 6024
		sts	0x0065, r18		; 52AE 9320 0065
avr52B0:	sbrs	r16, 6		; 52B0 FF06
		rjmp	avr52B7		; 52B1 C005
		lds	r18, 0x0065		; 52B2 9120 0065
		ori	r18, 0x02		; 52B4 6022
		sts	0x0065, r18		; 52B5 9320 0065
avr52B7:	sbrs	r16, 7		; 52B7 FF07
		rjmp	avr52BE		; 52B8 C005
		lds	r18, 0x0065		; 52B9 9120 0065
		ori	r18, 0x01		; 52BB 6021
		sts	0x0065, r18		; 52BC 9320 0065
avr52BE:	sbrc	r17, 0		; 52BE FD10
		nop				; 52BF 0000
		nop				; 52C0 0000
		sbrc	r17, 1		; 52C1 FD11
		nop				; 52C2 0000
		nop				; 52C3 0000
		sbrc	r17, 2		; 52C4 FD12
		nop				; 52C5 0000
		nop				; 52C6 0000
		sbrc	r17, 3		; 52C7 FD13
		sbrs	r16, 0		; 52C8 FF00
		rjmp	avr52CA		; 52C9 C000
avr52CA:	sbrs	r16, 1		; 52CA FF01
		rjmp	avr52CC		; 52CB C000
avr52CC:		sbrs	r16, 2		; 52CC FF02
		rjmp	avr52CE		; 52CD C000
avr52CE:	sbrs	r16, 3		; 52CE FF03
		rjmp	avr52D0		; 52CF C000
avr52D0:	sbrs	r16, 4		; 52D0 FF04
		rjmp	avr52D2		; 52D1 C000
avr52D2:	sbrs	r16, 5		; 52D2 FF05
		rjmp	avr52D4		; 52D3 C000
avr52D4:	sbrs	r16, 6		; 52D4 FF06
		rjmp	avr52D6		; 52D5 C000
avr52D6:	sbrs	r16, 7		; 52D6 FF07
		rjmp	avr52D8		; 52D7 C000
avr52D8:		sbrs	r17, 0		; 52D8 FF10
		rjmp	avr52DA		; 52D9 C000
avr52DA:	sbrs	r17, 1		; 52DA FF11
		rjmp	avr52DC		; 52DB C000
avr52DC:		sbrs	r17, 2		; 52DC FF12
		rjmp	avr52DE		; 52DD C000
avr52DE:		sbrs	r17, 3		; 52DE FF13
		rjmp	avr52E0		; 52DF C000
avr52E0:	ret				; 52E0 9508
;-------------------------------------------------------------------------
; first 12 servos output pulse length
sub52E1:	lds	r3, 0x0380		; 52E1 9030 0380
		lds	r4, 0x0381		; 52E3 9040 0381
		lds	r5, 0x0382		; 52E5 9050 0382
		lds	r6, 0x0383		; 52E7 9060 0383
		lds	r7, 0x0384		; 52E9 9070 0384
		lds	r8, 0x0385		; 52EB 9080 0385
		lds	r9, 0x0386		; 52ED 9090 0386
		lds	r10, 0x0387		; 52EF 90A0 0387
		lds	r11, 0x0388		; 52F1 90B0 0388
		lds	r12, 0x0389		; 52F3 90C0 0389
		lds	r13, 0x038A		; 52F5 90D0 038A
		lds	r14, 0x038B		; 52F7 90E0 038B
		ldi	r16, 0x00		; 52F9 E000
		lds	r17, 0x04EB		; 52FA 9110 04EB
		lds	r18, 0x04EC		; 52FC 9120 04EC
		ldi	YH, 0x04		; 52FE E0D4
		ldi	YL, 0xF5		; 52FF EFC5
		lds	r19, 0x04F0		; 5300 9130 04F0
		clr	XL			; 5302 27AA
avr5303:	cp	r3, r16		; 5303 1630
		brne	avr5307		; 5304 F411
		sbrc	r17, 0		; 5305 FD10
		cbi	PORTA, 0	; 5306 98D8
avr5307:	cp	r4, r16		; 5307 1640
		brne	avr530B		; 5308 F411
		sbrc	r17, 1		; 5309 FD11
		cbi	PORTA, 1	; 530A 98D9
avr530B:	cp	r5, r16		; 530B 1650
		brne	avr530F		; 530C F411
		sbrc	r17, 2		; 530D FD12
		cbi	PORTA, 2	; 530E 98DA
avr530F:	cp	r6, r16		; 530F 1660
		brne	avr5313		; 5310 F411
		sbrc	r17, 3		; 5311 FD13
		cbi	PORTA, 3	; 5312 98DB
avr5313:	cp	r7, r16		; 5313 1670
		brne	avr5317		; 5314 F411
		sbrc	r17, 4		; 5315 FD14
		cbi	PORTA, 4	; 5316 98DC
avr5317:	cp	r8, r16		; 5317 1680
		brne	avr531B		; 5318 F411
		sbrc	r17, 5		; 5319 FD15
		cbi	PORTA, 5	; 531A 98DD
avr531B:	cp	r9, r16		; 531B 1690
		brne	avr531F		; 531C F411
		sbrc	r17, 6		; 531D FD16
		cbi	PORTA, 6	; 531E 98DE
avr531F:	cp	r10, r16		; 531F 16A0
		brne	avr5323		; 5320 F411
		sbrc	r17, 7		; 5321 FD17
		cbi	PORTA, 7	; 5322 98DF
avr5323:	cp	r11, r16		; 5323 16B0
		brne	avr5327		; 5324 F411
		sbrc	r18, 0		; 5325 FD20
		cbi	PORTB, 0	; 5326 98C0
avr5327:	cp	r12, r16		; 5327 16C0
		brne	avr532B		; 5328 F411
		sbrc	r18, 1		; 5329 FD21
		cbi	PORTB, 1	; 532A 98C1
avr532B:	cp	r13, r16		; 532B 16D0
		brne	avr532F		; 532C F411
		sbrc	r18, 2		; 532D FD22
		cbi	PORTB, 2	; 532E 98C2
avr532F:	cp	r14, r16		; 532F 16E0
		brne	avr5333		; 5330 F411
		sbrc	r18, 3		; 5331 FD23
		cbi	PORTB, 3	; 5332 98C3
avr5333:		nop				; 5333 0000
		nop				; 5334 0000
		nop				; 5335 0000
		nop				; 5336 0000
		nop				; 5337 0000
		nop				; 5338 0000
		nop				; 5339 0000
		nop				; 533A 0000
		nop				; 533B 0000
		nop				; 533C 0000
		nop				; 533D 0000
		nop				; 533E 0000
		nop				; 533F 0000
		nop				; 5340 0000
		nop				; 5341 0000
		nop				; 5342 0000
		nop				; 5343 0000
		nop				; 5344 0000
		nop				; 5345 0000
		nop				; 5346 0000
		nop				; 5347 0000
		nop				; 5348 0000
		sbrs	r19, 6		; 5349 FF36
		rjmp	avr5353		; 534A C008
		sbis	$0B, 5	; 534B 9B5D
		rjmp	avr535A		; 534C C00D
		ld	r20, Y+		; 534D 9149
		cpi	XL, 0x04		; 534E 30A4
		breq	avr535F		; 534F F079
		inc	XL			; 5350 95A3
		out	$0C, r20		; 5351 B94C
		rjmp	avr5361		; 5352 C00E
avr5353:	nop				; 5353 0000
		nop				; 5354 0000
		nop				; 5355 0000
		nop				; 5356 0000
		nop				; 5357 0000
		nop				; 5358 0000
		rjmp	avr5361		; 5359 C007
avr535a:	nop				; 535A 0000
		nop				; 535B 0000
		nop				; 535C 0000
		nop				; 535D 0000
		rjmp	avr5361		; 535E C002
avr535f:	nop				; 535F 0000
		rjmp	avr5361		; 5360 C000
avr5361:	inc	r16			; 5361 9503
		cpi	r16, 0xCD		; 5362 3C0D
		breq	avr5365		; 5363 F009
		rjmp	avr5303		; 5364 CF9E
avr5365:	ret				; 5365 9508
;-------------------------------------------------------------------------
; second 12 servos output pulse length
sub5366:	lds	r3, 0x038C		; 5366 9030 038C
		lds	r4, 0x038D		; 5368 9040 038D
		lds	r5, 0x038E		; 536A 9050 038E
		lds	r6, 0x038F		; 536C 9060 038F
		lds	r7, 0x0390		; 536E 9070 0390
		lds	r8, 0x0391		; 5370 9080 0391
		lds	r9, 0x0392		; 5372 9090 0392
		lds	r10, 0x0393		; 5374 90A0 0393
		lds	r11, 0x0394		; 5376 90B0 0394
		lds	r12, 0x0395		; 5378 90C0 0395
		lds	r13, 0x0396		; 537A 90D0 0396
		lds	r14, 0x0397		; 537C 90E0 0397
		ldi	r16, 0x00		; 537E E000
		lds	r17, 0x04EC		; 537F 9110 04EC
		lds	r18, 0x04ED		; 5381 9120 04ED
		ldi	YH, 0x04		; 5383 E0D4
		ldi	YL, 0xF5		; 5384 EFC5
		lds	r19, 0x04F0		; 5385 9130 04F0
		clr	XL			; 5387 27AA
avr5388:	cp	r3, r16		; 5388 1630
		brne	avr538C		; 5389 F411
		sbrc	r17, 4		; 538A FD14
		cbi	PORTB, 4	; 538B 98C4
avr538C:	cp	r4, r16		; 538C 1640
		brne	avr5390		; 538D F411
		sbrc	r17, 5		; 538E FD15
		cbi	PORTB, 5	; 538F 98C5
avr5390:	cp	r5, r16		; 5390 1650
		brne	avr5394		; 5391 F411
		sbrc	r17, 6		; 5392 FD16
		cbi	PORTB, 6	; 5393 98C6
avr5394:	cp	r6, r16		; 5394 1660
		brne	avr5398		; 5395 F411
		sbrc	r17, 7		; 5396 FD17
		cbi	PORTB, 7	; 5397 98C7
avr5398:	cp	r7, r16		; 5398 1670
		brne	avr539C		; 5399 F411
		sbrc	r18, 0		; 539A FD20
		cbi	PORTC, 7	; 539B 98AF
avr539C:	cp	r8, r16		; 539C 1680
		brne	avr53A0		; 539D F411
		sbrc	r18, 1		; 539E FD21
		cbi	PORTC, 6	; 539F 98AE
avr53A0:	cp	r9, r16		; 53A0 1690
		brne	avr53A4		; 53A1 F411
		sbrc	r18, 2		; 53A2 FD22
		cbi	PORTC, 5	; 53A3 98AD
avr53A4:	cp	r10, r16		; 53A4 16A0
		brne	avr53A8		; 53A5 F411
		sbrc	r18, 3		; 53A6 FD23
		cbi	PORTC, 4	; 53A7 98AC
avr53A8:	cp	r11, r16		; 53A8 16B0
		brne	avr53AC		; 53A9 F411
		sbrc	r18, 4		; 53AA FD24
		cbi	PORTC, 3	; 53AB 98AB
avr53AC:	cp	r12, r16		; 53AC 16C0
		brne	avr53B0		; 53AD F411
		sbrc	r18, 5		; 53AE FD25
		cbi	PORTC, 2	; 53AF 98AA
avr53B0:@	cp	r13, r16		; 53B0 16D0
		brne	avr53B4		; 53B1 F411
		sbrc	r18, 6		; 53B2 FD26
		cbi	PORTC, 1	; 53B3 98A9
avr53B4:	cp	r14, r16		; 53B4 16E0
		brne	avr53B8		; 53B5 F411
		sbrc	r18, 7		; 53B6 FD27
		cbi	PORTC, 0	; 53B7 98A8
avr53B8:	nop				; 53B8 0000
		nop				; 53B9 0000
		nop				; 53BA 0000
		nop				; 53BB 0000
		nop				; 53BC 0000
		nop				; 53BD 0000
		nop				; 53BE 0000
		nop				; 53BF 0000
		nop				; 53C0 0000
		nop				; 53C1 0000
		nop				; 53C2 0000
		nop				; 53C3 0000
		nop				; 53C4 0000
		nop				; 53C5 0000
		nop				; 53C6 0000
		nop				; 53C7 0000
		nop				; 53C8 0000
		nop				; 53C9 0000
		nop				; 53CA 0000
		nop				; 53CB 0000
		nop				; 53CC 0000
		sbrs	r19, 6		; 53CD FF36
		rjmp	avr53D7		; 53CE C008
		sbis	$0B, 5	; 53CF 9B5D
		rjmp	avr53DE		; 53D0 C00D
		ld	r20, Y+		; 53D1 9149
		cpi	XL, 0x04		; 53D2 30A4
		breq	avr53E3		; 53D3 F079
		inc	XL			; 53D4 95A3
		out	$0C, r20		; 53D5 B94C
		rjmp	avr53E5		; 53D6 C00E
avr53D7:	nop				; 53D7 0000
		nop				; 53D8 0000
		nop				; 53D9 0000
		nop				; 53DA 0000
		nop				; 53DB 0000
		nop				; 53DC 0000
		rjmp	avr53E5		; 53DD C007
avr53DE:	nop				; 53DE 0000
		nop				; 53DF 0000
		nop				; 53E0 0000
		nop				; 53E1 0000
		rjmp	avr53E5		; 53E2 C002
avr53E3:	nop				; 53E3 0000
		rjmp	avr53E5		; 53E4 C000
avr53E5:	inc	r16			; 53E5 9503
		cpi	r16, 0xCD		; 53E6 3C0D
		breq	avr53E9		; 53E7 F009
		rjmp	avr5388		; 53E8 CF9F
avr53E9:	ret				; 53E9 9508
;-------------------------------------------------------------------------
; last 8 servos output pulse length
sub53EA:	lds		r3, 0x0398		; 53EA 9030 0398
			lds		r4, 0x0399		; 53EC 9040 0399
			lds		r5, 0x039A		; 53EE 9050 039A
			lds		r6, 0x039B		; 53F0 9060 039B
			lds		r7, 0x039C		; 53F2 9070 039C
			lds		r8, 0x039D		; 53F4 9080 039D
			lds		r9, 0x039E		; 53F6 9090 039E
			lds		r10, 0x039F		; 53F8 90A0 039F
			ldi		r16, 0x00		; 53FA E000
			lds		r17, 0x04EE		; 53FB 9110 04EE
			ldi		YH, 0x04		; 53FD E0D4 for AIMotors
			ldi		YL, 0xF5		; 53FE EFC5
			lds		r19, 0x04F0		; 53FF 9130 04F0 for AI Motors
			clr		XL				; 5401 27AA
avr5402:	cp		r3, r16			; 5402 1630
			brne	avr5406			; 5403 F411
			sbrc	r17, 0			; 5404 FD10
			cbi		$03, 7			; 5405 981F Port E7
avr5406:	cp		r4, r16			; 5406 1640
			brne	avr540A			; 5407 F411
			sbrc	r17, 1			; 5408 FD11
			cbi		$03, 6			; 5409 981E Port E6
avr540A:	cp		r5, r16			; 540A 1650
			brne	avr540E			; 540B F411
			sbrc	r17, 2			; 540C FD12
			cbi		PORTD, 7		; 540D 9897 Port D7
avr540E:	cp		r6, r16			; 540E 1660
			brne	avr5412			; 540F F411
			sbrc	r17, 3			; 5410 FD13
			cbi		PORTD, 6		; 5411 9896 Port D6
avr5412:	cp		r7, r16			; 5412 1670
			brne	avr5416			; 5413 F411
			sbrc	r17, 4			; 5414 FD14
			cbi		PORTD, 5		; 5415 9895 Port D5
avr5416:	cp		r8, r16			; 5416 1680
			brne	avr541F			; 5417 F439
			sbrs	r17, 5			; 5418 FF15
			rjmp	avr541F			; 5419 C005
			lds		r18, 0x0065		; 541A 9120 0065 Port G2
			andi	r18, 0xFB		; 541C 7F2B
			sts		0x0065, r18		; 541D 9320 0065
avr541F:	cp		r9, r16			; 541F 1690
			brne	avr5428			; 5420 F439
			sbrs	r17, 6			; 5421 FF16
			rjmp	avr5428			; 5422 C005
			lds		r18, 0x0065		; 5423 9120 0065 Port G1
			andi	r18, 0xFD		; 5425 7F2D
			sts		0x0065, r18		; 5426 9320 0065
avr5428:	cp		r10, r16		; 5428 16A0
			brne	avr5431			; 5429 F439
			sbrs	r17, 7			; 542A FF17
			rjmp	avr5431			; 542B C005
			lds		r18, 0x0065		; 542C 9120 0065 Port G0
			andi	r18, 0xFE		; 542E 7F2E
			sts		0x0065, r18		; 542F 9320 0065
avr5431:	cp		r11, r16		; 5431 16B0
			brne	avr5435			; 5432 F411
			sbrc	r17, 0			; 5433 FD10
			nop						; 5434 0000
avr5435:	cp		r12, r16		; 5435 16C0
			brne	avr5439			; 5436 F411
			sbrc	r17, 1			; 5437 FD11
			nop						; 5438 0000
avr5439:	cp		r13, r16		; 5439 16D0
			brne	avr543D			; 543A F411
			sbrc	r17, 2			; 543B FD12
			nop						; 543C 0000
avr543D:	cp		r14, r16		; 543D 16E0
			brne	avr5441			; 543E F411
			sbrc	r17, 3			; 543F FD13
			nop						; 5440 0000
avr5441:	nop						; 5441 0000
			nop						; 5442 0000
			nop						; 5443 0000
			nop						; 5444 0000
			nop						; 5445 0000
			nop						; 5446 0000
			nop						; 5447 0000
			nop						; 5448 0000
			nop						; 5449 0000
			nop						; 544A 0000
			nop						; 544B 0000
			nop						; 544C 0000
			nop						; 544D 0000
			nop						; 544E 0000
			nop						; 544F 0000
			nop						; 5450 0000
			nop						; 5451 0000
			nop						; 5452 0000
			nop						; 5453 0000
			nop						; 5454 0000
			nop						; 5455 0000
			nop						; 5456 0000
			sbrs	r19, 6			; 5457 FF36 AIMotor seton ?
			rjmp	avr5461			; 5458 C008
			sbis	$0B, 5			; 5459 9B5D
			rjmp	avr5468			; 545A C00D
			ld		r20, Y+			; 545B 9149
			cpi		XL, 0x04		; 545C 30A4
			breq	avr546D			; 545D F079
			inc		XL				; 545E 95A3
			out		$0C, r20		; 545F B94C
			rjmp	avr546F			; 5460 C00E
avr5461:	nop						; 5461 0000
			nop						; 5462 0000
			nop						; 5463 0000
			nop						; 5464 0000
			nop						; 5465 0000
			nop						; 5466 0000
			rjmp	avr546F			; 5467 C007
avr5468:	nop						; 5468 0000
			nop						; 5469 0000
			nop						; 546A 0000
			nop						; 546B 0000
			rjmp	avr546F			; 546C C002
avr546D:	nop						; 546D 0000
			rjmp	avr546F			; 546E C000
avr546F:	inc		r16				; 546F 9503
			cpi		r16, 0xCD		; 5470 3C0D reached 205 ?
			breq	avr5473			; 5471 F009
			rjmp	avr5402			; 5472 CF8F
avr5473:	ret						; 5473 9508
;-------------------------------------------------------------------------
; 500 microsec delay
sub5474:	ldi		r16, 0xB0		; 5474 EB00  Delay  500 microsec this is the minimumpulse length
			nop						; 5475 0000
			nop						; 5476 0000
			nop						; 5477 0000
			nop						; 5478 0000
			nop						; 5479 0000
			nop						; 547A 0000
			nop						; 547B 0000
			nop						; 547C 0000
			nop						; 547D 0000
			nop						; 547E 0000
avr547F:	nop						; 547F 0000
			nop						; 5480 0000
			ldi		r17, 0x05		; 5481 E015
avr5482:	dec		r17				; 5482 951A
			brne	avr5482			; 5483 F7F1
			dec		r16				; 5484 950A
			brne	avr547F			; 5485 F7C9
			ret						; 5486 9508
;-------------------------------------------------------------------------
; Do zero correction
sub5487:	ldi		XH, 0x03		; 5487 E0B3 x = desired
			ldi		XL, 0x20		; 5488 E2A0
			ldi		YH, 0x03		; 5489 E0D3 y = zero offset data
			ldi		YL, 0x40		; 548A E4C0
			ldi		ZH, 0x03		; 548B E0F3 z = zero corrected
			ldi		ZL, 0x60		; 548C E6E0
			ldi		r18, 0x20		; 548D E220 for 32 servo
avr548E:	ld		r16, Y+			; 548E 9109 get zero data
			sbrs	r16, 7			; 548F FF07 top bit set ?
			rjmp	avr549A			; 5490 C009
			ld		r17, X+			; 5491 911D get desired add offset
			add		r16, r17		; 5492 0F01
			brlo	avr5496			; 5493 F010
			ldi		r16, 0x01		; 5494 E001
			rjmp	avr54A2			; 5495 C00C
avr5496:	cpi		r16, 0x01		; 5496 3001
			brsh	avr54A2			; 5497 F450
			ldi		r16, 0x01		; 5498 E001
			rjmp	avr54A2			; 5499 C008
avr549A:	ld		r17, X+			; 549A 911D
			add		r16, r17		; 549B 0F01
			brsh	avr549F			; 549C F410
			ldi		r16, 0xC7		; 549D EC07
			rjmp	avr54A2			; 549E C003
avr549F:	cpi		r16, 0xC7		; 549F 3C07
			brlo	avr54A2			; 54A0 F008
			ldi		r16, 0xC7		; 54A1 EC07
avr54A2:	st		Z+, r16			; 54A2 9301
			dec		r18				; 54A3 952A
			brne	avr548E			; 54A4 F749
			ret						; 54A5 9508
;-------------------------------------------------------------------------
; Set change angle 
sub54A6:	ldi		XH, 0x03		; 54A6 E0B3 X=0x3A0 speed counters
			ldi		XL, 0xA0		; 54A7 EAA0
			ldi		YH, 0x03		; 54A8 E0D3 Y=0x3C0 drift speed
			ldi		YL, 0xC0		; 54A9 ECC0
			ldi		ZH, 0x03		; 54AA E0F3 Z=0x3E0 angle modify trigger
			ldi		ZL, 0xE0		; 54AB EEE0
			ldi		r19, 0x20		; 54AC E230 for 32 servos
avr54AD:	ldi		r18, 0x00		; 54AD E020 
			ld		r16, Y+			; 54AE 9109 get the drift speed
			ld		r17, X			; 54AF 911C get the speed counter
			add		r17, r16		; 54B0 0F10 add
			st		X+, r17			; 54B1 931D save in speed counter
			brsh	avr54B4			; 54B2 F408
			ser		r18				; 54B3 EF2F set all bits
avr54B4:	st		Z+, r18			; 54B4 9321 angle modify set if non zero
			dec		r19				; 54B5 953A
			brne	avr54AD			; 54B6 F7B1
			ret						; 54B7 9508
;-------------------------------------------------------------------------
; change angle if modify
; if modify set then add or subtract one
sub54B8:	ldi		XH, 0x03		; 54B8 E0B3 X = present angle
			ldi		XL, 0x20		; 54B9 E2A0
			ldi		YH, 0x03		; 54BA E0D3 Y = desired angle
			ldi		YL, 0x00		; 54BB E0C0
			ldi		ZH, 0x03		; 54BC E0F3 z = modify trigger
			ldi		ZL, 0xE0		; 54BD EEE0
			ldi		r18, 0x20		; 54BE E220 for all servos

avr54BF:	ld		r16, Z			; 54BF 8100 modify set ?
			tst		r16				; 54C0 2300
			breq	avr54CE			; 54C1 F061
			ld		r16, X			; 54C2 910C get present
			ld		r17, Y			; 54C3 8118 get dest
			cp		r17, r16		; 54C4 1710 are we there yet ?
			brlo	avr54CC			; 54C5 F030
			cp		r16, r17		; 54C6 1701
			brlo	avr54C9			; 54C7 F008
			rjmp	avr54CE			; 54C8 C005
avr54C9:	inc		r16				; 54C9 9503 if lower add one
			st		X, r16			; 54CA 930C
			rjmp	avr54CE			; 54CB C002
avr54CC:	dec		r16				; 54CC 950A if higher lose one
			st		X, r16			; 54CD 930C
avr54CE:	adiw	XL, 0x01		; 54CE 9611 else next
			adiw	YL, 0x01		; 54CF 9621
			adiw	ZL, 0x01		; 54D0 9631
			dec		r18				; 54D1 952A
			brne	avr54BF			; 54D2 F761
			ret						; 54D3 9508
;-------------------------------------------------------------------------
; Set motion complete if present = desired

sub54D4:	ldi		XH, 0x03		; 54D4 E0B3 X = desired
			ldi		XL, 0x20		; 54D5 E2A0
			ldi		YH, 0x03		; 54D6 E0D3 y = present
			ldi		YL, 0x00		; 54D7 E0C0
			ldi		ZH, 0x04		; 54D8 E0F4 z = motion complete
			ldi		ZL, 0xE3		; 54D9 EEE3
			ldi		r21, 0x04		; 54DA E054 for 4 bytes
avr54DB:	ld		r16, Z			; 54DB 8100 get enables
			ldi		r17, 0x01		; 54DC E011
			ldi		r20, 0x08		; 54DD E048
avr54DE:	ld		r18, X+			; 54DE 912D
			ld		r19, Y+			; 54DF 9139
			cp		r18, r19		; 54E0 1723 if equal set the enable bit
			brne	avr54E3			; 54E1 F409
			or		r16, r17		; 54E2 2B01
avr54E3:	lsl		r17				; 54E3 0F11
			dec		r20				; 54E4 954A
			brne	avr54DE			; 54E5 F7C1
			st		Z+, r16			; 54E6 9301
			dec		r21				; 54E7 955A
			brne	avr54DB			; 54E8 F791
			ret						; 54E9 9508
;-------------------------------------------------------------------------
; set direction and set to send to servo

sub54EA:	push	XH				; 54EA 93BF
			push	XL				; 54EB 93AF
			ldi		XH, 0x03		; 54EC E0B3 X = Adjusted position
			ldi		XL, 0x60		; 54ED E6A0
			ldi		YH, 0x03		; 54EE E0D3 y = after direction this is what is sent to servo
			ldi		YL, 0x80		; 54EF E8C0
			ldi		ZH, 0x04		; 54F0 E0F4 z = direction
			ldi		ZL, 0xE7		; 54F1 EEE7
			ldi		r20, 0x04		; 54F2 E044
avr54F3:	ldi		r19, 0x08		; 54F3 E038
			ld		r16, Z+			; 54F4 9101 get direction
avr54F5:	ld		r17, X+			; 54F5 911D
			ror		r16				; 54F6 9507 if direction set then position = 200- value
			brlo	avr54FB			; 54F7 F018
			ldi		r18, 0xC8		; 54F8 EC28 r18 = 200
			sub		r18, r17		; 54F9 1B21
			mov		r17, r18		; 54FA 2F12
avr54FB:	st		Y+, r17			; 54FB 9319 save in after direction
			dec		r19				; 54FC 953A
			brne	avr54F5			; 54FD F7B9
			dec		r20				; 54FE 954A
			brne	avr54F3			; 54FF F799
			pop		XH				; 5500 91BF
			pop		XL				; 5501 91AF
			ret						; 5502 9508
;-------------------------------------------------------------------------
;
sub5503:	lds		r16, 0x052F		; 5503 9100 052F get gyro byte
			andi	r16, 0x0F		; 5505 700F 
			tst		r16				; 5506 2300 any enabled ?
			brne	avr5509			; 5507 F409
			ret						; 5508 9508 no go back
;-------------------------------------------------------------------------
avr5509:	push	XH				; 5509 93BF Gyro modifier
			push	XL				; 550A 93AF
			ldi		r16, 0x00		; 550B E000
			ldi		ZH, 0x03		; 550C E0F3 Adjusted position
			ldi		ZL, 0x60		; 550D E6E0
			ldi		YH, 0x05		; 550E E0D5 Gyro enable
			ldi		YL, 0x34		; 550F E3C4
			ldi		XH, 0x05		; 5510 E0B5 Gyro direction
			ldi		XL, 0x54		; 5511 E5A4
avr5512:	push	r16				; 5512 930F save counter
			ld		r16, Y			; 5513 8108 get enables
			cpi		r16, 0x01		; 5514 3001
			breq	avr551D			; 5515 F039
			cpi		r16, 0x02		; 5516 3002
			breq	avr5520			; 5517 F041
			cpi		r16, 0x03		; 5518 3003
			breq	avr5523			; 5519 F049
			cpi		r16, 0x04		; 551A 3004
			breq	avr5526			; 551B F051
			rjmp	avr5573			; 551C C056
avr551D:	lds		r17, 0x0530		; 551D 9110 0530 get gyro 1 value
			rjmp	avr5529			; 551F C009
avr5520:	lds		r17, 0x0531		; 5520 9110 0531
			rjmp	avr5529			; 5522 C006
avr5523:	lds		r17, 0x0532		; 5523 9110 0532
			rjmp	avr5529			; 5525 C003
avr5526:	lds		r17, 0x0533		; 5526 9110 0533
			rjmp	avr5529			; 5528 C000

avr5529:	ldi		r18, 0x38		; 5529 E328 larger than 56 ?
			cp		r18, r17		; 552A 1721
			brsh	avr552D			; 552B F408
			ldi		r17, 0x38			; 552C E318 = 56
avr552D:	ldi		r18, 0x04			; 552D E024 less than 4
			cp		r17, r18			; 552E 1712
			brsh	avr5531			; 552F F408
			ldi		r17, 0x04			; 5530 E014 = 4
avr5531:	ld		r16, X				; 5531 910C get direction
			tst		r16					; 5532 2300
			brne	avr5537			; 5533 F419
			ldi		r16, 0x58			; 5534 E508
			sub		r16, r17			; 5535 1B01 swap direction
			mov		r17, r16			; 5536 2F10
avr5537:	mov		r12, XH				; 5537 2ECB
			mov		r13, XL				; 5538 2EDA
			mov		r14, YH				; 5539 2EED
			mov		r15, YL				; 553A 2EFC
			ldi		XH, 0x05			; 553B E0B5 Gyro Filter
			ldi		XL, 0x74			; 553C E7A4
			ldi		YH, 0x05			; 553D E0D5 Gyro sensitivity
			ldi		YL, 0x94			; 553E E9C4
			pop		r16					; 553F 910F add the servo number to X and Y address
			ldi		r18, 0x00			; 5540 E020
			add		XL, r16				; 5541 0FA0
			adc		YH, r18				; 5542 1FD2
			add		YL, r16				; 5543 0FC0
			adc		YH, r18				; 5544 1FD2
			push	r16					; 5545 930F
			ld		r16, X				; 5546 910C get Gyro Filter
			ldi		r18, 0x01			; 5547 E021
			add		r16, r18			; 5548 0F02 add 1
			cp		r16, r17			; 5549 1701 is current gyro > Gyro Filter + 1
			brsh	avr5555				; 554A F450
			ld		r16, Y				; 554B 8108 r16 = Sensitivity
			ld		r17, X				; 554C 911C r17 = Filter
			lds		r18, 0x05B4			; 554D 9120 05B4 get 
			add		r18, r16			; 554F 0F20 add sensitivity
			sts		0x05B4, r18			; 5550 9320 05B4 save again
			brsh	avr5554				; 5552 F408
			inc		r17					; 5553 9513 inc ref
avr5554:	rjmp	avr5565				; 5554 C010 
avr5555:	ld		r16, X				; 5555 910C get Gyro Filter
			ldi		r18, 0x01			; 5556 E021
			sub		r16, r18			; 5557 1B02 subtract 1
			cp		r17, r16			; 5558 1710
			brsh	avr5564				; 5559 F450 is current gyro < Gryo Filter - 1
			ld		r16, Y				; 555A 8108 r16 = sensitivity
			ld		r17, X				; 555B 911C r17 = Gyro Filter
			lds		r18, 0x05B4			; 555C 9120 05B4
			add		r18, r16			; 555E 0F20
			sts		0x05B4, r18			; 555F 9320 05B4
			brsh	avr5563				; 5561 F408
			dec		r17					; 5562 951A dec filter
avr5563:	rjmp	avr5565				; 5563 C001
avr5564:	rjmp	avr5566				; 5564 C001
avr5565:	st		X, r17				; 5565 931C store gyro value as Gyro Filter
avr5566:	mov		XH, r12				; 5566 2DBC  restore X = direction
			mov		XL, r13				; 5567 2DAD
			mov		YH, r14				; 5568 2DDE  restore Y = enable
			mov		YL, r15				; 5569 2DCF
			ldi		r16, 0x00			; 556A E000
			ldi		r18, 0x00			; 556B E020
			ld		r19, Z				; 556C 8130 get Adjusted position
			add		r17, r19			; 556D 0F13 add gyro filter
			adc		r16, r18			; 556E 1F02 r16 has carry
			ldi		r18, 0x00			; 556F E020
			ldi		r19, 0x2C			; 5570 E23C subtract 44
			sbc		r17, r19			; 5571 0B13
			st		Z, r17				; 5572 8310 store result in adjusted position
avr5573:	adiw	XL, 0x01			; 5573 9611 inc pointers
			adiw	YL, 0x01			; 5574 9621
			adiw	ZL, 0x01			; 5575 9631
			pop		r16					; 5576 910F restore counter
			inc		r16					; 5577 9503 next servo
			cpi		r16, 0x20			; 5578 3200 all done
			breq	avr557B				; 5579 F009
			rjmp	avr5512				; 557A CF97 next
avr557B:	pop		XL					; 557B 91AF
			pop		XH					; 557C 91BF
			ret							; 557D 9508

;-------------------------------------------------------------------------
; used by timer 0 routine increment 0x513
sub557E:	lds		r16, data0513		; 557E 9100 0513
			inc		r16					; 5580 9503
			sts		data0513, r16		; 5581 9300 0513
			ret							; 5583 9508
;-------------------------------------------------------------------------
; used by timer 0 routine
; if 0x4dc = 0 and 0x4dd = 0 then  0x4de = 0  decrement 0x4dc/0x4dd
sub5584:	lds		YL, 0x04DC		; 5584 91C0 04DC
			lds		YH, 0x04DD		; 5586 91D0 04DD
			tst		YH				; 5588 23DD
			brne	avr5590			; 5589 F431
			tst		YL				; 558A 23CC
			brne	avr5590			; 558B F421
			ldi		r16, 0x00		; 558C E000
			sts		0x04DE, r16		; 558D 9300 04DE
			ret						; 558F 9508
avr5590:	sbiw	YL, 0x01		; 5590 9721 decrement Y
			sts		0x04DC, YL		; 5591 93C0 04DC
			sts		0x04DD, YH		; 5593 93D0 04DD
			ret						; 5595 9508
;-------------------------------------------------------------------------
; Timer 1 Interrupt
avr5596:	cli						; 5596 94F8
			call	sub0975			; 5597 940E 0975 routine is back down bottom
			sei						; 5599 9478
			reti					; 559A 9518
;-------------------------------------------------------------------------

.org 0x06000

;changed in2.7
			rjmp	nocmd		; 6000 C1F5
			rjmp	nocmd		; 6001 C1F4
			rjmp	nocmd		; 6002 C1F3
			rjmp	nocmd		; 6003 C1F2
			rjmp	nocmd		; 6004 C1F1
			rjmp	nocmd		; 6005 C1F0
			rjmp	nocmd		; 6006 C1EF
			rjmp	nocmd		; 6007 C1EE
			rjmp	nocmd		; 6008 C1ED
			rjmp	nocmd		; 6009 C1EC
			rjmp	nocmd		; 600A C1EB
			rjmp	nocmd		; 600B C1EA
			rjmp	nocmd		; 600C C1E9
			rjmp	nocmd		; 600D C1E8
			rjmp	nocmd		; 600E C1E7
			rjmp	nocmd		; 600F C1E6
			rjmp	nocmd		; 6010 C1E5
			rjmp	nocmd		; 6011 C1E4
			rjmp	nocmd		; 6012 C1E3
			rjmp	nocmd		; 6013 C1E2
			rjmp	nocmd		; 6014 C1E1
			rjmp	nocmd		; 6015 C1E0
			rjmp	nocmd		; 6016 C1DF
			rjmp	nocmd		; 6017 C1DE
			rjmp	nocmd		; 6018 C1DD
			rjmp	nocmd		; 6019 C1DC
			rjmp	nocmd		; 601A C1DB
			rjmp	nocmd		; 601B C1DA
			rjmp	nocmd		; 601C C1D9
			rjmp	nocmd		; 601D C1D8
			rjmp	nocmd		; 601E C1D7
			rjmp	nocmd		; 601F C1D6
			rjmp	nocmd		; 6020 C1D5
			rjmp	nocmd		; 6021 C1D4
			rjmp	nocmd		; 6022 C1D3
			rjmp	nocmd		; 6023 C1D2
			rjmp	nocmd		; 6024 C1D1
			rjmp	nocmd		; 6025 C1D0
			rjmp	nocmd		; 6026 C1CF
			rjmp	nocmd		; 6027 C1CE
			rjmp	nocmd		; 6028 C1CD
			rjmp	nocmd		; 6029 C1CC
			rjmp	nocmd		; 602A C1CB
			rjmp	nocmd		; 602B C1CA
			rjmp	nocmd		; 602C C1C9
			rjmp	nocmd		; 602D C1C8
			rjmp	nocmd		; 602E C1C7
			rjmp	nocmd		; 602F C1C6
			rjmp	nocmd		; 6030 C1C5
			rjmp	nocmd		; 6031 C1C4
			rjmp	nocmd		; 6032 C1C3
			rjmp	nocmd		; 6033 C1C2
			rjmp	nocmd		; 6034 C1C1
			rjmp	nocmd		; 6035 C1C0
			rjmp	nocmd		; 6036 C1BF
			rjmp	nocmd		; 6037 C1BE
			rjmp	nocmd		; 6038 C1BD
			rjmp	nocmd		; 6039 C1BC
			rjmp	nocmd		; 603A C1BB
			rjmp	nocmd		; 603B C1BA
			rjmp	nocmd		; 603C C1B9
			rjmp	nocmd		; 603D C1B8
			rjmp	nocmd		; 603E C1B7
			rjmp	nocmd		; 603F C1B6
			rjmp	nocmd		; 6040 C1B5
			rjmp	nocmd		; 6041 C1B4
			rjmp	nocmd		; 6042 C1B3
			rjmp	nocmd		; 6043 C1B2
			rjmp	nocmd		; 6044 C1B1
			rjmp	nocmd		; 6045 C1B0
			rjmp	nocmd		; 6046 C1AF
			rjmp	nocmd		; 6047 C1AE
			rjmp	nocmd		; 6048 C1AD
			rjmp	nocmd		; 6049 C1AC
			rjmp	nocmd		; 604A C1AB
			rjmp	nocmd		; 604B C1AA
			rjmp	nocmd		; 604C C1A9
			rjmp	nocmd		; 604D C1A8
			rjmp	nocmd		; 604E C1A7
			rjmp	nocmd		; 604F C1A6
			rjmp	nocmd		; 6050 C1A5
			rjmp	nocmd		; 6051 C1A4
			rjmp	nocmd		; 6052 C1A3
			rjmp	nocmd		; 6053 C1A2
			rjmp	nocmd		; 6054 C1A1
			rjmp	nocmd		; 6055 C1A0
			rjmp	nocmd		; 6056 C19F
			rjmp	nocmd		; 6057 C19E
			rjmp	nocmd		; 6058 C19D
			rjmp	nocmd		; 6059 C19C
			rjmp	nocmd		; 605A C19B
			rjmp	nocmd		; 605B C19A
			rjmp	nocmd		; 605C C199
			rjmp	nocmd		; 605D C198
			rjmp	nocmd		; 605E C197
			rjmp	nocmd		; 605F C196
			rjmp	nocmd		; 6060 C195
			rjmp	nocmd		; 6061 C194
			rjmp	nocmd		; 6062 C193
			rjmp	nocmd		; 6063 C192
			rjmp	nocmd		; 6064 C191
			rjmp	nocmd		; 6065 C190
			rjmp	nocmd		; 6066 C18F
			rjmp	nocmd		; 6067 C18E
			rjmp	nocmd		; 6068 C18D
			rjmp	nocmd		; 6069 C18C
			rjmp	nocmd		; 606A C18B
			rjmp	nocmd		; 606B C18A
			rjmp	nocmd		; 606C C189
			rjmp	nocmd		; 606D C188
			rjmp	nocmd		; 606E C187
			rjmp	nocmd		; 606F C186
			rjmp	nocmd		; 6070 C185
			rjmp	nocmd		; 6071 C184
			rjmp	nocmd		; 6072 C183
			rjmp	nocmd		; 6073 C182
			rjmp	nocmd		; 6074 C181
			rjmp	nocmd		; 6075 C180
			rjmp	nocmd		; 6076 C17F
			rjmp	nocmd		; 6077 C17E
			rjmp	nocmd		; 6078 C17D
			rjmp	nocmd		; 6079 C17C
			rjmp	nocmd		; 607A C17B
			rjmp	nocmd		; 607B C17A
			rjmp	nocmd		; 607C C179
			rjmp	nocmd		; 607D C178
			rjmp	nocmd		; 607E C177
			rjmp	nocmd		; 607F C176
			rjmp	nocmd		; 6080 C175
			rjmp	nocmd		; 6081 C174
			rjmp	nocmd		; 6082 C173
			rjmp	nocmd		; 6083 C172
			rjmp	nocmd		; 6084 C171
			rjmp	nocmd		; 6085 C170
			rjmp	nocmd		; 6086 C16F
			rjmp	nocmd		; 6087 C16E
			rjmp	nocmd		; 6088 C16D
			rjmp	nocmd		; 6089 C16C
			rjmp	nocmd		; 608A C16B
			rjmp	nocmd		; 608B C16A
			rjmp	nocmd		; 608C C169
			rjmp	nocmd		; 608D C168
			rjmp	nocmd		; 608E C167
			rjmp	nocmd		; 608F C166
			rjmp	avr6100		; 6090 C165
			rjmp	avr6103		; 6091 C164
			rjmp	avr6106		; 6092 C163
			rjmp	avr6109		; 6093 C162
			rjmp	avr610c		; 6094 C161
			rjmp	nocmd		; 6095 C160
			rjmp	nocmd		; 6096 C15F
			rjmp	nocmd		; 6097 C15E
			rjmp	nocmd		; 6098 C15D
			rjmp	nocmd		; 6099 C15C
			rjmp	nocmd		; 609A C15B
			rjmp	nocmd		; 609B C15A
			rjmp	nocmd		; 609C C159
			rjmp	nocmd		; 609D C158
			rjmp	nocmd		; 609E C157
			rjmp	nocmd		; 609F C156
			rjmp	avr6112		; 60A0 C062
			rjmp	avr6115		; 60A1 C064
			rjmp	avr610F		; 60A2 C05D
			rjmp	avr6118		; 60A3 C152
			rjmp	avr611B		; 60A4 C151
			rjmp	avr611E		; 60A5 C150
			rjmp	avr6121		; 60A6 C14F
			rjmp	avr6124		; 60A7 C14E
			rjmp	avr6127		; 60A8 C14D
			rjmp	avr612A		; 60A9 C14C
			rjmp	avr612D		; 60AA C14B
			rjmp	avr6130		; 60AB C14A
			rjmp	avr6133		; 60AC C149
			rjmp	avr6136		; 60AD C148
			rjmp	avr6139		; 60AE C147
			rjmp	nocmd		; 60AF C146
			rjmp	avr613C		; 60B0 C058
			rjmp	avr613F		; 60B1 C05A
			rjmp	avr6142		; 60B2 C05C
			rjmp	avr6145		; 60B3 C05E
			rjmp	avr6148 	; 60B4 C060
			rjmp	avr614B		; 60B5 C062
			rjmp	avr614E		; 60B6 C064
			rjmp	avr6151		; 60B7 C066
			rjmp	avr6154		; 60B8 C068
			rjmp	avr6157		; 60B9 C06A
			rjmp	avr615A		; 60BA C06C
			rjmp	avr615D		; 60BB C06E
			rjmp	avr6160		; 60BC C070
			rjmp	avr6163 	; 60BD C072
			rjmp	avr6166		; 60BE C074
			rjmp	avr6169		; 60BF C076
			rjmp	avr616C		; 60C0 C078
			rjmp	avr616F		; 60C1 C07A
			rjmp	avr6172		; 60C2 C07C
			rjmp	avr6175		; 60C3 C07E
			rjmp	avr6178 	; 60C4 C080
			rjmp	avr617B		; 60C5 C082
			rjmp	avr617E		; 60C6 C084
			rjmp	avr6181		; 60C7 C086
			rjmp	avr6184		; 60C8 C088
			rjmp	avr6187		; 60C9 C08A
			rjmp	avr618A 	; 60CA C08C
			rjmp	avr618D		; 60CB C08E
			rjmp	avr6190		; 60CC C090
			rjmp	avr6193		; 60CD C092
			rjmp	avr6196		; 60CE C094
			rjmp	avr6199		; 60CF C096
			rjmp	avr619C		; 60D0 C098
			rjmp	avr619F		; 60D1 C09A
			rjmp	avr61A2		; 60D2 C09C
			rjmp	avr61A5		; 60D3 C09E
			rjmp	avr61A8		; 60D4 C0A0
			rjmp	avr61AB		; 60D5 C0A2
			rjmp	avr61AE		; 60D6 C0A4
			rjmp	avr61B1		; 60D7 C0A6
			rjmp	avr61B4		; 60D8 C0A8
			rjmp	avr61B7		; 60D9 C0AA
			rjmp	avr61BA		; 60DA C0AC
			rjmp	avr61BD		; 60DB C0AE
			rjmp	avr61C0		; 60DC C0B0
			rjmp	avr61C3		; 60DD C0B2
			rjmp	avr61C6		; 60DE C0B4
			rjmp	avr61C9		; 60DF C0B6
			rjmp	avr61CC		; 60E0 C0B8
			rjmp	avr61CF		; 60E1 C0BA
			rjmp	avr61D2		; 60E2 C0BC
			rjmp	avr61D5		; 60E3 C0BE
			rjmp	avr61D8		; 60E4 C0C0
			rjmp	avr61DB		; 60E5 C0C2
			rjmp	avr61DE		; 60E6 C0C4
			rjmp	avr61E1		; 60E7 C0C6
			rjmp	avr61E4		; 60E8 C0C8
			rjmp	avr61E7		; 60E9 C0CA
			rjmp	avr61EA		; 60EA C0CC
			rjmp	avr61ED		; 60EB C0CE
			rjmp	avr61F0		; 60EC C0D0
			rjmp	avr61F3		; 60ED C0D2
			rjmp	avr61F6		; 60EE C0D4
			rjmp	nocmd		; 60EF C106
			rjmp	avr61F9 	; 60F0 C0D5
			rjmp	avr61FC		; 60F1 C0D7
			rjmp	avr61FF		; 60F2 C0D9
			rjmp	avr6202		; 60F3 C0DB
			rjmp	avr6205		; 60F4 C0DD
			rjmp	avr6208		; 60F5 C0DF
			rjmp	avr620B		; 60F6 C0E1
			rjmp	avr620E		; 60F7 C0E3
			rjmp	avr6211		; 60F8 C0E5
			rjmp	avr6214		; 60F9 C0E7
			rjmp	avr6217		; 60FA C0E9
			rjmp	avr621A		; 60FB C0EB
			rjmp	avr621D		; 60FC C0ED
			rjmp	avr6220		; 60FD C0EF
			rjmp	avr6223		; 60FE C0F1
			rjmp	nocmd		; 60FF C0F6



avr6100:	ldi		ZH, 0x25		; 6100 E2F4 GYROSENSE
			ldi		ZL, 0x30		; 6101 E3E9
			ijmp							; 6102 9409
	
avr6103:	ldi		ZH, 0x61		; 6103 E2F3 GYROSET
			ldi		ZL, 0x03		; 6104 EEE8
			ijmp							; 6105 9409

avr6106:	ldi		ZH, 0x25		; 6106 E2F4 GYRODIR
			ldi		ZL, 0x34		; 6107 E2E4
			ijmp							; 6108 9409

avr6109:	ldi		ZH, 0x25		; 6109 E1FF MOVE
			ldi		ZL, 0x36		; 610A E3EE
			ijmp							; 610B 9409

avr610C:	ldi		ZH, 0x25		; 610C E1FF POS
			ldi		ZL, 0x38		; 610D E7E3
			ijmp							; 610E 9409

avr610F:	ldi		ZH, 0x25		; 610F E1FF MOVEPOS
			ldi		ZL, 0x03		; 6110 E7EB
			ijmp							; 6111 9409

avr6112:	ldi		ZH, 0x24		; 6112 E1FF ZERO
			ldi		ZL, 0xB2		; 6113 ECE7
			ijmp							; 6114 9409

avr6115:	ldi		ZH, 0x24		; 6115 E1FF DIR
			ldi		ZL, 0xEE		; 6116 EEE2
			ijmp							; 6117 9409

avr6118:	ldi		ZH, 0x25		; 6118 E1FF INIT
			ldi		ZL, 0x18		; 6119 EFE0
			ijmp		 					; 611A 9409

avr611B:	ldi		ZH, 0x25		; 611B E2F0 SERVO CONTROL
			ldi		ZL, 0x1A		; 611C E1E1
			ijmp				 			; 611D 9409
		
avr611E:ldi	ZH, 0x25		; 611E E2F0 AIMOTOR ON
		ldi	ZL, 0x1C		; 611F EDE0
		ijmp						; 6120 9409

avr6121:ldi	ZH, 0x25		; 6121 E2F1 AI MOTOR OFF
		ldi	ZL, 0x1E		; 6122 E6EE
		ijmp						; 6123 9409
		
avr6124:ldi	ZH, 0x25		; 6124 E2F2 GETMOTORSET
		ldi	ZL, 0x20		; 6125 E1E0
		ijmp						; 6126 9409

avr6127:ldi	ZH, 0x25		; 6127 E2F2 MUSIC
		ldi	ZL, 0x22		; 6128 E3EC
		ijmp						; 6129 9409

avr612A:ldi	ZH, 0x25		; 612A E2F2 BB ?
		ldi	ZL, 0x24		; 612B E5E8
		ijmp						; 612C 9409

avr612D:ldi	ZH, 0x25		; 612D E2F2 BC ?
		ldi	ZL, 0x26		; 612E E6EA
		ijmp						; 612F 9409

avr6130:ldi	ZH, 0x25		; 6130 E2F2  BD ?
		ldi	ZL, 0x28		; 6131 E7E4
		ijmp						; 6132 9409

avr6133:ldi	ZH, 0x25		; 6133 E2F2 BE ?
		ldi	ZL, 0x2A		; 6134 E7EC
		ijmp						; 6135 9409

avr6136:ldi	ZH, 0x25		; 6136 E2F2 BF TEMPO
		ldi	ZL, 0x2C		; 6137 E9E0
		ijmp						; 6138 9409

avr6139:ldi	ZH, 0x25		; 6139 E1F1 IF
		ldi	ZL, 0x2E		; 613A E1E2
		ijmp						; 613B 9409
		
avr613C:ldi	ZH, 0x20		; 613C E1F1 FOR
		ldi	ZL, 0x08		; 613D E9E6
		ijmp						; 613E 9409
		
avr613F:ldi	ZH, 0x20		; 613F E1F1 NEXT
		ldi	ZL, 0x3D		; 6140 EAE6
		ijmp						; 6141 9409

avr6142:ldi	ZH, 0x20		; 6142 E1F1 TO
		ldi	ZL, 0x45		; 6143 EBED
		ijmp						; 6144 9409

avr6145:ldi	ZH, 0x20		; 6145 E1F1 GOTO
		ldi	ZL, 0x91		; 6146 ECEA
		ijmp						; 6147 9409

avr6148:ldi	ZH, 0x20		; 6148 E1F1 GOSUB
		ldi	ZL, 0xAC		; 6149 EDE4
		ijmp						; 614A 9409

avr614B:ldi	ZH, 0x20		; 614B E1F1 RETURN
		ldi	ZL, 0xBA		; 614C EEE4
		ijmp						; 614D 9409

avr614E:ldi	ZH, 0x20		; 614E E1F1 ON
		ldi	ZL, 0xDB		; 614F EFE3
		ijmp						; 6150 9409

avr6151:ldi	ZH, 0x21		; 6151 E1F2 unused
		ldi	ZL, 0x9A		; 6152 E0E6
		ijmp						; 6153 9409

avr6154:ldi	ZH, 0x22		; 6154 E1F2 unused
		ldi	ZL, 0x38		; 6155 E0E9
		ijmp						; 6156 9409

avr6157:ldi	ZH, 0x22		; 6157 E1F2 unused
		ldi	ZL, 0xDA		; 6158 E0EC
		ijmp						; 6159 9409

avr615A:ldi	ZH, 0x23		; 615A E1F2 BREAK
		ldi	ZL, 0x06		; 615B E0EF
		ijmp						; 615C 9409

avr615D:ldi	ZH, 0x23		; 615D E1F2 POKE
		ldi	ZL, 0x22		; 615E E1E7
		ijmp						; 615F 9409

avr6160:ldi	ZH, 0x23		; 6160 E1F2 ROMPOKE
		ldi	ZL, 0x34		; 6161 E2E4
		ijmp						; 6162 9409

avr6163:ldi	ZH, 0x23		; 6163 E1F2 unused
		ldi	ZL, 0x3E		; 6164 E3EB
		ijmp						; 6165 9409

avr6166:ldi	ZH, 0x23		; 6166 E1F2 unused
		ldi	ZL, 0x46		; 6167 E3EE
		ijmp						; 6168 9409

avr6169:ldi	ZH, 0x23		; 6169 E1F4 =
		ldi	ZL, 0x5A		; 616A E5EB
		ijmp						; 616B 9409

avr616C:ldi	ZH, 0x11		; 616C E1F4 OUT
		ldi	ZL, 0xDA		; 616D EEED
		ijmp						; 616E 9409

avr616F:ldi	ZH, 0x12		; 616F E1F8 PULSE
		ldi	ZL, 0x5E		; 6170 E6EC
		ijmp						; 6171 9409

avr6172:ldi	ZH, 0x12		; 6172 E1FA TOGGLE
		ldi	ZL, 0x6E		; 6173 ECEB
		ijmp						; 6174 9409

avr6175:ldi	ZH, 0x12		; 6175 E1FC DELAY
		ldi	ZL, 0x85		; 6176 EAE3
		ijmp						; 6177 9409

avr6178:ldi	ZH, 0x12		; 6178 E1FC ERX
		ldi	ZL, 0x92		; 6179 EBE5
		ijmp						; 617A 9409

avr617B:ldi	ZH, 0x12		; 617B E1FC ETX
		ldi	ZL, 0x9C		; 617C EDEA
		ijmp						; 617D 9409

avr617E:ldi	ZH, 0x12		; 617E E1FC LCDOUT
		ldi	ZL, 0xAC		; 617F EFEC
		ijmp						; 6180 9409

avr6181:ldi	ZH, 0x12		; 6181 E1FD unused
		ldi	ZL, 0xBB		; 6182 E0E6
		ijmp						; 6183 9409

avr6184:ldi	ZH, 0x12		; 6184 E1FD OFFSET
		ldi	ZL, 0xD0		; 6185 E0E8
		ijmp						; 6186 9409

avr6187:ldi	ZH, 0x12		; 6187 E1FD MOTOR ON
		ldi	ZL, 0xD3		; 6188 E1EA
		ijmp						; 6189 9409

avr618A:ldi	ZH, 0x12		; 618A E1FD MOTOR OFF
		ldi	ZL, 0xD6		; 618B EEE8
		ijmp						; 618C 9409

avr618D:ldi	ZH, 0x12		; 618D E1FE DC? Moves first 6 servos
		ldi	ZL, 0xD9		; 618E E8EE
		ijmp						; 618F 9409

avr6190:ldi	ZH, 0x12		; 6190 E1FE SPEED
		ldi	ZL, 0xE1		; 6191 EBE9
		ijmp						; 6192 9409

avr6193:ldi	ZH, 0x12		; 6193 E1FE PWM
		ldi	ZL, 0xEE		; 6194 ECEA
		ijmp						; 6195 9409

avr6196:ldi	ZH, 0x13		; 6196 E1FF SERVO
		ldi	ZL, 0x05		; 6197 E1E6
		ijmp						; 6198 9409

avr6199:ldi	ZH, 0x13		; 6199 E1F2 LCDINIT
		ldi	ZL, 0x08		; 619A E4E1
		ijmp						; 619B 9409

avr619C:ldi	ZH, 0x15		; 619C E1F2 CLS
		ldi	ZL, 0x25		; 619D E5E0
		ijmp						; 619E 9409
		
avr619F:ldi	ZH, 0x15		; 619F E1F2 LOCATE
		ldi	ZL, 0xB7		; 61A0 E5EF
		ijmp						; 61A1 9409
		
avr61A2:ldi	ZH, 0x19		; 61A2 E1F2 PRINT
		ldi	ZL, 0x36		; 61A3 E7E6
		ijmp						; 61A4 9409
		
avr61A5:ldi	ZH, 0x1B		; 61A5 E1F3 CSON
		ldi	ZL, 0x95		; 61A6 E2E9
		ijmp						; 61A7 9409

avr61A8:ldi	ZH, 0x1D		; 61A8 E1F3 CSOFF
		ldi	ZL, 0x6D		; 61A9 E3E2
		ijmp						; 61AA 9409

avr61AB:ldi	ZH, 0x1D		; 61AB E1F3 CONS
		ldi	ZL, 0x7F		; 61AC E3EB
		ijmp						; 61AD 9409

avr61AE:ldi	ZH, 0x1D		; 61AE E1F3 BYTEOUT
		ldi	ZL, 0xA4		; 61AF E4E9
		ijmp						; 61B0 9409

avr61B1:ldi	ZH, 0x1D		; 61B1 E1F3 unused
		ldi	ZL, 0xC6		; 61B2 ECE0
		ijmp						; 61B3 9409

avr61B4:ldi	ZH, 0x1D		; 61B4 E1F3 WAIT 
		ldi	ZL, 0xD0		; 61B5 ECE2
		ijmp						; 61B6 9409

avr61B7:ldi	ZH, 0x1D		; 61B7 E1F3 STOP
		ldi	ZL, 0xD2		; 61B8 EDEB
		ijmp						; 61B9 9409

avr61BA:ldi	ZH, 0x1D		; 61BA E1F3 RUN
		ldi	ZL, 0xE4		; 61BB EEE2
		ijmp						; 61BC 9409

avr61BD:ldi	ZH, 0x1E		; 61BD E1F3 EC ?
		ldi	ZL, 0xB2		; 61BE EEE9
		ijmp						; 61BF 9409

avr61C0:ldi	ZH, 0x1F		; 61C0 E1F3 SET PTP
		ldi	ZL, 0x58		; 61C1 EFEC
		ijmp						; 61C2 9409

avr61C3:ldi	ZH, 0x1F		; 61C3 E1F4 FPWM
		ldi	ZL, 0x83		; 61C4 E0E2
		ijmp						; 61C5 9409

avr61C6:ldi	ZH, 0x1F		; 61C6 E0FB IN(n)
		ldi	ZL, 0x94		; 61C7 ECEC
		ijmp						; 61C8 9409

avr61C9:ldi	ZH, 0x1F		; 61C9 E0FD INKEY
		ldi	ZL, 0xE0		; 61CA E7EC
		ijmp						; 61CB 9409

avr61CC:ldi	ZH, 0x13		; 61CC E0FD BYTEIN
		ldi	ZL, 0x0B		; 61CD EDE8
		ijmp						; 61CE 9409

avr61CF:ldi	ZH, 0x13		; 61CF E0FE AD
		ldi	ZL, 0x1A		; 61D0 E3EE
		ijmp						; 61D1 9409

avr61D2:ldi	ZH, 0x13		; 61D2 E0FE unused
		ldi	ZL, 0x29		; 61D3 EBEF
		ijmp						; 61D4 9409

avr61D5:ldi	ZH, 0x13			; 61D5 E0FE unused
		ldi	ZL, 0x40			; 61D6 ECE1
		ijmp						; 61D7 9409

avr61D8:ldi	ZH, 0x13		; 61D8 E0FE STATE
		ldi	ZL, 0xF3			; 61D9 ECE3
		ijmp						; 61DA 9409

avr61DB:ldi	ZH, 0x13		; 61DB E0FF unused
		ldi	ZL, 0xFC		; 61DC E0E1
		ijmp						; 61DD 9409

avr61DE:ldi	ZH, 0x14		; 61DE E0FF RND
		ldi	ZL, 0x05		; 61DF E0E3
		ijmp						; 61E0 9409

avr61E1:ldi	ZH, 0x14			; 61E1 E0FF PEEK
		ldi	ZL, 0x13			; 61E2 E0EB
		ijmp						; 61E3 9409

avr61E4:ldi	ZH, 0x14		; 61E4 E0FF ROMPEEK
		ldi	ZL, 0x8A		; 61E5 E1E6
		ijmp						; 61E6 9409

avr61E7:ldi	ZH, 0x14		; 61E7 E0FF REMOCON
		ldi	ZL, 0x8C		; 61E8 E2E9
		ijmp						; 61E9 9409

avr61EA:ldi	ZH, 0x14		; 61EA E0FF AIMOTOR IN
		ldi	ZL, 0xA5		; 61EB E3EC
		ijmp						; 61EC 9409

avr61ED:ldi	ZH, 0x14		; 61ED E0FF SONAR
		ldi	ZL, 0xAC		; 61EE E4E7
		ijmp						; 61EF 9409
avr61F0:
		ldi	ZH, 0x14
		ldi	ZL, 0xB3
		ijmp
avr61F3:								; 
		ldi	ZH, 0x14
		ldi	ZL, 0xC6
		ijmp
avr61F6:								; 
		ldi	ZH, 0x14
		ldi	ZL, 0xCC
		ijmp

avr61F9:								; 
		ldi	ZH, 0x0C
		ldi	ZL, 0x72
		ijmp
avr61FC:								; 
		ldi	ZH, 0x0E
		ldi	ZL, 0x22
		ijmp
								;
avr61FF:									; 
		ldi	ZH, 0x0E
		ldi	ZL, 0x7E
		ijmp

avr6202:								; 
		ldi	ZH, 0x0E
		ldi	ZL, 0xE4
		ijmp

avr6205:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0x65
		ijmp

avr6208:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0x67
		ijmp


avr620B:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0x69
		ijmp

avr620E:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xA7
		ijmp

avr6211:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xA9
		ijmp

avr6214:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xB1
		ijmp

avr6217:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xBC
		ijmp

avr621A:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xCF
		ijmp


avr621D:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xE2
		ijmp

avr6220:								; 
		ldi	ZH, 0x0F
		ldi	ZL, 0xED
		ijmp

avr6223:								; 
		ldi	ZH, 0x11
		ldi	ZL, 0xD0
		ijmp

avr6226:								; 
		ldi	ZH, 0x00
		ldi	ZL, 0x93
		ijmp


								; 61F8 9409
nocmd:ldi	ZH, high(avr0093)		; 61F6 E0F0 unused
		ldi	ZL, low(avr0093)		; 61F7 E9E3
		ijmp	
;---------------------------------------------------------
; Hex Table
avr622C:

	.db "0123456789ABCDEF", 0x00, 0x00
/*
		61F9 3130
		61FA 3332
		61FB 3534
		61FC 3736
		61FD 3938
		61FE 4241
		61FF 4443
		6200 4645
		6201 0000
*/



.org 0x0F000

avrF000:

.org 0x0F001
avrF001:

.org 0x0F080
avrF080:
		.exit

