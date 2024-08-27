.include "m32def.inc"
.org 0

    ldi     r16, high(ramend)
    out     sph, r16
    ldi     r16, low(ramend)
    out     spl, r16

    ldi     r20, 0x60
    ldi     r21, 0x46
    add     r20, r21
    andi    r20, r21
