.INCLUDE "M32DEF.INC"
.ORG 0x0000
    JMP MAIN
.ORG 0x0002
    JMP EX0_ISR

MAIN:
    LDI R16, HIGH(RAMEND)
    OUT SPH, R16
    LDI R16, LOW(RAMEND)
    OUT SPL, R16

    LDI R16, 0xFF
    OUT DDRA, R16
    OUT DDRC, R16
    CBI DDRD, PIND2
    SBI PORTD, PIND2
    SEI
    LDI R16, 0x40
    OUT GICR, R16
    LDI R16, 0x03
    OUT MCUCR, R16

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

    LDI R20, 1

LOOP:
    CPI R20, 0
    BREQ SET00
    CPI R20, 1
    BREQ SET59
    JMP LOOP
SET59:
    LDI YL, 5
    LDI XL, 9
    JMP DECXY
SET00:
    LDI YL, 0
    LDI XL, 0
    JMP INCXY

TOGGLE:
    LDI R21, 0
    CPI R20, 0
    BREQ INCXY
    CPI R20, 1
    BREQ DECXY

DECXY:
    CPI R21, 1
    BREQ TOGGLE
    CALL DISPLAY
    CALL DELAY
    DEC XL
    CPI XL, 0xFF
    BRNE DECXY

    DEC YL
    CPI YL, 0xFF
    BRNE RXL1
    JMP LOOP
RXL1:
    LDI XL, 0x09
    JMP DECXY

INCXY:
    CPI R21, 1
    BREQ TOGGLE

    CALL DISPLAY
    CALL DELAY
    INC XL
    CPI XL, 0x0A
    BRNE INCXY

    INC YL
    CPI YL, 0x06
    BRNE RXL2
    JMP LOOP
RXL2:
    LDI XL, 0x00
    JMP INCXY

DISPLAY:
    LD R16, Y
    OUT PORTA, R16
    LD R16, X
    OUT PORTC, R16
    RET

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

EX0_ISR:
    LDI R21, 1
    CPI R20, 0
    BREQ SET1
    CPI R20, 1
    BREQ SET0
RES:
    RETI
SET1:
    LDI R20, 1
    JMP RES
SET0:
    LDI R20, 0
    JMP RES
