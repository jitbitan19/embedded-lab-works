.include "m32def.inc"
.org 0
    jmp start
.org 2
    jmp int_isr0

start:
    ldi r16, high(ramend)
    out sph, r16
    ldi r16, low(ramend)
    out spl, r16

    ldi r16, 0x00
    out ddra, r16
    out ddrd, r16
    ldi r16, 0xff
    out ddrc, r16
    out ddrb, r16
    out portd, r16
    sei

    ldi r16, 0x40
    out gicr, r16
    ldi r16, 0x03
    out mcucr, r16

    ldi r30, 0x07 // max idx of ip
    ldi r18, 0x00 // used as mux reg
    ldi r19, 0x20

    ldi r16, 0x69 //init pwm
    out tccr0, r16

    ldi r20, 0x20

main:
    out admux, r20
    out portc, r18

    ldi r16, 0x87
    out adcsra, r16

    ldi r16, 0xc7
    out adcsra, r16
l1:
    in r16, adcsra
    andi r16, 0b00010000
    breq l1
    in r17, adch
    out ocr0, r17

    ldi r16, 0x97
    out adcsra, r16

    jmp main

int_isr0:
    inc r18
    and r18, r30
    mov r20, r18
    or r20, r19
    reti
