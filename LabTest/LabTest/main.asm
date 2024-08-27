.include "m32def.inc"
.org 0x0000
    jmp main
.org 0x0002
    jmp ex0_isr

main:
    ldi r16, high(ramend)
    out sph, r16
    ldi r16, low(ramend)
    out spl, r16

    ldi r16, 0xff
    out ddra, r16
    out ddrc, r16
    cbi ddrd, pind2
    sbi portd, pind2
    sei
    ldi r16, 0x40
    out gicr, r16
    ldi r16, 0x03
    out mcucr, r16

    ldi r16, 0x7e //seven segment bits for 0
    mov r0, r16
    ldi r16, 0x30 //seven segment bits for 1
    mov r1, r16
    ldi r16, 0x6d //seven segment bits for 2
    mov r2, r16
    ldi r16, 0x79 //seven segment bits for 3
    mov r3, r16
    ldi r16, 0x33 //seven segment bits for 4
    mov r4, r16
    ldi r16, 0x5b //seven segment bits for 5
    mov r5, r16
    ldi r16, 0x5f //seven segment bits for 6
    mov r6, r16
    ldi r16, 0x70 //seven segment bits for 7
    mov r7, r16
    ldi r16, 0x7f //seven segment bits for 8
    mov r8, r16
    ldi r16, 0x7b //seven segment bits for 9
    mov r9, r16

    ldi r20, 1

loop:
    cpi r20, 0
    breq set00
    cpi r20, 1
    breq set59
    jmp loop
set59:
    ldi yl, 5
    ldi xl, 9
    jmp decxy
set00:
    ldi yl, 0
    ldi xl, 0
    jmp incxy

toggle:
    ldi r21, 0
    cpi r20, 0
    breq incxy
    cpi r20, 1
    breq decxy

decxy:
    cpi r21, 1
    breq toggle
    call display
    call delay
    dec xl
    cpi xl, 0xff
    brne decxy

    dec yl
    cpi yl, 0xff
    brne rxl1
    jmp loop
rxl1:
    ldi xl, 0x09
    jmp decxy

incxy:
    cpi r21, 1
    breq toggle

    call display
    call delay
    inc xl
    cpi xl, 0x0a
    brne incxy

    inc yl
    cpi yl, 0x06
    brne rxl2
    jmp loop
rxl2:
    ldi xl, 0x00
    jmp incxy

display:
    ld r16, y
    out porta, r16
    ld r16, x
    out portc, r16
    ret

delay:
    ldi r19, 0x0a //pq
    ldi r18, 0xff //rs
    ldi r17, 0xff //tu
l1:
    dec r17
    cpi r17, 0xff
    brne l1

    dec r18
    cpi r18, 0xff
    brne l1

    dec r19
    cpi r19, 0xff
    brne l1

    ret

ex0_isr:
    ldi r21, 1
    cpi r20, 0
    breq set1
    cpi r20, 1
    breq set0
res:
    reti
set1:
    ldi r20, 1
    jmp res
set0:
    ldi r20, 0
    jmp res
