.include "m32def.inc"
.org 0
    ldi r16, high(ramend)
    out sph, r16
    ldi r16, low(ramend)
    out spl, r16

    ldi r16, 0x00
    out ddra, r16
    ldi r16, 0x20
    out admux, r16
    ldi r16, 0x87
    out adcsra, r16

    ldi r16, 0xff
    out ddrc, r16

main:
    ldi r16, 0xc7
    out adcsra, r16
l1:
    in r16, adcsra
    andi r16, 0x10
    breq l1
    in r17, adch

    out portc, r17
    ldi r16, 0x97
    out adcsra, r16
    jmp main
