.INCLUDE "M32DEF.INC"
.ORG 0

    LDI R16, HIGH(RAMEND)
    OUT SPH, R16
    LDI R16, LOW(RAMEND)
    OUT SPL, R16

    CBI DDRB, PINB0
    SBI PORTB, PINB0
    CBI DDRD, PIND2
    SBI PORTD, PIND2
    LDI R16, 0xFF
    OUT DDRC, R16

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

    LDI XH, 0x00
    LDI XL, 0x09
    CALL DISPLAY

MAIN:
    IN R16, PINB
    IN R17, PIND

    CPI R16, 0x00
    BREQ INCR
    CPI R17, 0x00
    BREQ DECR
        
    JMP MAIN

INCR:
    IN R16, PINB
    CPI R16, 0x00
    BREQ INCR

    INC XL
    CALL CHECK
    CALL DISPLAY
    JMP MAIN

DECR:
    IN R16, PIND
    CPI R16, 0x00
    BREQ DECR

    DEC XL
    CALL CHECK
    CALL DISPLAY
    JMP MAIN

DISPLAY:
    LD R16, X
    OUT PORTC, R16
    RET

CHECK:
    CPI R26, 0xFF
    BREQ LD9
    CPI R26, 0x0A
    BREQ LD0
    RET

LD9:
    LDI XL, 0x09
    RET
LD0:
    LDI XL, 0x00
    RET
