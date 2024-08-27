.include "m32def.inc"
.org 0

    ldi     r16, high(ramend)
    out     sph, r16
    ldi     r16, low(ramend)
    out     spl, r16

    call    lcd_init

    ldi     r30, 74
    call    lcd_char

    ldi     r30, 105
    call    lcd_char

    ldi     r30, 116
    call    lcd_char

    ldi     r30, 98
    call    lcd_char

    ldi     r30, 105
    call    lcd_char

    ldi     r30, 116
    call    lcd_char

    ldi     r30, 97
    call    lcd_char

    ldi     r30, 110
    call    lcd_char

    ldi     r20, 0x01
    call    lcd_command

    ldi     r20, 0x80
    call    lcd_command

main:
    jmp     main

lcd_init:
    ldi     r16, 0xff
    out     ddrc, r16
    out     ddra, r16

    ldi     r20, 0x02
    call    lcd_command

    ldi     r20, 0x28
    call    lcd_command

    ldi     r20, 0x0c
    call    lcd_command

    ldi     r20, 0x06
    call    lcd_command

    ldi     r20, 0x01
    call    lcd_command

    ret

// r30 as arg
lcd_char:
    mov     r29, r30
    andi    r29, 0xf0
    out     portc, r29
    ldi     r16, 0x01
    out     porta, r16
    ldi     r16, 0x03
    out     porta, r16
    ldi     r19, 0x00 // delay of 1us
    ldi     r18, 0x00
    ldi     r17, 0x01
    call    delay
    ldi     r16, 0x01
    out     porta, r16

    ldi     r19, 0x00 // delay of 200us
    ldi     r18, 0x03
    ldi     r17, 0x00
    call    delay

    lsl     r30
    lsl     r30
    lsl     r30
    lsl     r30
    out     portc, r30

    ldi     r16, 0x03
    out     porta, r16
    ldi     r19, 0x00 // delay of 1us
    ldi     r18, 0x00
    ldi     r17, 0x01
    call    delay
    ldi     r16, 0x01
    out     porta, r16

    ldi     r19, 0x00 // delay of 2ms
    ldi     r18, 0x1f
    ldi     r17, 0x00
    call    delay

    ret

//r20 as arg
lcd_command:
    mov     r21, r20
    andi    r21, 0xf0
    out     portc, r21

    ldi     r16, 0x00
    out     porta, r16
    ldi     r16, 0x02
    out     porta, r16
    ldi     r19, 0x00 // delay of 1us
    ldi     r18, 0x00
    ldi     r17, 0x01
    call    delay
    ldi     r16, 0x00
    out     porta, r16

    ldi     r19, 0x00 // delay of 200us
    ldi     r18, 0x03
    ldi     r17, 0x00
    call    delay

    lsl     r20
    lsl     r20
    lsl     r20
    lsl     r20
    out     portc, r20
    ldi     r16, 0x02
    out     porta, r16
    ldi     r19, 0x00 // delay of 1us
    ldi     r18, 0x00
    ldi     r17, 0x01
    call    delay
    ldi     r16, 0x00
    out     porta, r16

    ldi     r19, 0x00 // delay of 2ms
    ldi     r18, 0x1f
    ldi     r17, 0x00
    call    delay

    ret

delay:
    dec     r17
    cpi     r17, 0xff
    brne    delay

    dec     r18
    cpi     r18, 0xff
    brne    delay

    dec     r19
    cpi     r19, 0xff
    brne    delay

    ret
