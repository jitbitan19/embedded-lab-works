.INCLUDE "m32def.inc"
.ORG 0

    SBI ddrb, PINB0
    LDI R16, high(ramend)
    OUT SPH, R16
    LDI R16, LOW(RAMEND)
    OUT SPL, R16

MAIN:
    sbi PORTB, PINB0
    CALL DELAY
    CBI PORTB, PINB0
    CALL DELAY
	JMP MAIN

// A generic (PQ RS TU)_16 counter
DELAY:
    LDI R19, 0x40 //PQ
    LDI R18, 0x00 //RS
    LDI R17, 0x00 //TU
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
