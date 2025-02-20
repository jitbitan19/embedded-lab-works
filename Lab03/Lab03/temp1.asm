// for push button LED
.INCLUDE "M32DEF.INC"
.ORG 0

    LDI R16, HIGH(RAMEND)
    OUT SPH, R16
    LDI R16, LOW(RAMEND)
    OUT SPL, R16

    SBI DDRC, PINC0
    CBI DDRB, PINB0

    LDI R17, 0x01
    LDI R18, 0x00

MAIN:
    IN R16, PINB
    CPI R16, 0x00
    BRNE ON
    JMP OFF

ON:
    OUT PORTC, R17
    JMP MAIN

OFF:
    OUT PORTC, R18
    JMP MAIN


// 