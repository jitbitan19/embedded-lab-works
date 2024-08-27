.INCLUDE "M32DEF.INC"
.ORG 0

    LDI R16, HIGH(RAMEND)
    OUT SPH, R16
    LDI R16, LOW(RAMEND)
    OUT SPL, R16

    LDI R16, 0x7E //Seven Segment Bits for 0
    MOV R0, R16
    LDI R16, 0x30 //Seven Segment Bits for 1
    MOV R1, R16
    LDI R16, 0x6D //Seven Segment Bits for 2
    MOV R2, R16
    LDI R16, 0x79 //Seven Segment Bits for 3
    MOV R3, R16
    LDI R16, 0x33 //Seven Segment Bits for 4
    MOV R4, R16
    LDI R16, 0x5B //Seven Segment Bits for 5
    MOV R5, R16
    LDI R16, 0x5F //Seven Segment Bits for 6
    MOV R6, R16
    LDI R16, 0x70 //Seven Segment Bits for 7
    MOV R7, R16
    LDI R16, 0x7F //Seven Segment Bits for 8
    MOV R8, R16
    LDI R16, 0x7B //Seven Segment Bits for 9
    MOV R9, R16

    LDI R16, 0XFF
    OUT DDRC, R16
    OUT DDRB, R16
    OUT DDRA, R16

MAIN:
    LDI R16, 0x01
    OUT PORTA, R16
    CALL MODXY

    LDI R16, 0x02
    OUT PORTA, R16
    CALL MODXY

    JMP MAIN

MODXY:
    LDI YL, 0x04 // set the tens place
    LDI XL, 0x02 // set the unit place
N1:
    CALL DISPLAY
    CALL DELAY
    DEC XL
    CPI XL, 0xFF
    BRNE N1

    DEC YL
    CPI YL, 0xFF
    BRNE RXL
    RET

RXL:
    LDI XL, 0x09
    JMP N1

DISPLAY:
    LD R16, Y
    OUT PORTB, R16
    LD R16, X
    OUT PORTC, R16
    RET

// A generic (PQ RS TU)_16 counter
DELAY:
    LDI R19, 0x0A //PQ
    LDI R18, 0xFF //RS
    LDI R17, 0xFF //TU
L1:
    DEC R17
    CPI R17, 0xFF
    BRNE L1

    DEC R18
    CPI R18, 0xFF
    BRNE L1

    DEC R19
    CPI R19, 0xFF
    BRNE L1

    RET
