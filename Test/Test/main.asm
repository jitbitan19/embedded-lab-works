.include "m32def.inc"
.org 0

    ldi r16, high(ramend)
    out sph, r16
    ldi r16, low(ramend)
    out spl, r16

    ldi r16, 96

    mov r17, r16%10