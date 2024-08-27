//triangular
.include "m32def.inc"
.org 0

    ldi     r16, high(ramend)
    out     sph, r16
    ldi     r16, low(ramend)
    out     spl, r16

    ldi     r16, 0xff
    out     ddrc, r16

decr:
    out     portc, r16
    dec     r16
    breq    incr
    jmp     decr

incr:
    out     portc, r16
    inc     r16
    brvs    decr
    jmp     incr
