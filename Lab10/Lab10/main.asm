// slave

.include "m32def.inc"
.org 0

    ldi     r16, high(ramend)
    out     sph, r16
    ldi     r16, low(ramend)
    out     spl, r16

    call    spi_slave_init

    ldi     r16, 0xff
    out     ddrc, r16

    ldi     r16, 0x7e
    mov     r0, r16
    ldi     r16, 0x30
    mov     r1, r16
    ldi     r16, 0x6d
    mov     r2, r16
    ldi     r16, 0x79
    mov     r3, r16
    ldi     r16, 0x33
    mov     r4, r16
    ldi     r16, 0x5b
    mov     r5, r16
    ldi     r16, 0x5f
    mov     r6, r16
    ldi     r16, 0x70
    mov     r7, r16
    ldi     r16, 0x7f
    mov     r8, r16
    ldi     r16, 0x7b
    mov     r9, r16

    ldi     r21, 1
    call    slave_write

main:
    call    slave_read

    cpi     r20, 1
    breq    incr
    cpi     r20, 8
    breq    decr
res:
    call    display
    call    slave_write
    jmp     main

decr:
    ldi     r21, 0xff
    jmp     res
incr:
    ldi     r21, 1
    jmp     res

spi_slave_init:
    ldi     r16, 0x40
    out     ddrb, r16
    out     spcr, r16
    ldi     r16, 0x41
    out     spcr, r16
    ret

slave_read: // arg as r20
l2:
    in      r16, spsr
    andi    r16, 0x80
    breq    l2

    in      r20, spdr
    ret

slave_write: // arg as r21
    out     spdr, r21
    ret

display:
    andi    r20, 0x0f
    mov     r26, r20
    ldi     r27, 0
    ld      r16, x
    out     portc, r16
    ret
