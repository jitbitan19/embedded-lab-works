.include "m32def.inc"
.org 0

    ldi r16, high(ramend)
    out sph, r16
    ldi r16, low(ramend)
    out spl, r16

    call usart_init
    call echo_check

main:
    call usart_rxchar
    mov r26, r25
    call usart_txchar
    jmp main

usart_init:
    ldi r16, 0x18
    out ucsrb, r16
    ldi r16, 0x86
    out ucsrc, r16
    ldi r16, 0x33
    out ubrrl, r16
    ldi r16, 0x00
    out ubrrh, r16
    ret

usart_rxchar: // R25 as return reg
l1:
    in r16, ucsra
    andi r16, 0x80
    breq l1
    in r25, udr
    ret

usart_txchar: // r26 as tx reg
u1:
    in r16, ucsra
    andi r16, 0x20
    breq u1
    out udr, r26
    ret

echo_check:
    ldi r26, 'E'
    call usart_txchar
    ldi r26, 'c'
    call usart_txchar
    ldi r26, 'h'
    call usart_txchar
    ldi r26, 'o'
    call usart_txchar
    ldi r26, ' '
    call usart_txchar
    ldi r26, 'C'
    call usart_txchar
    ldi r26, 'h'
    call usart_txchar
    ldi r26, 'e'
    call usart_txchar
    ldi r26, 'c'
    call usart_txchar
    ldi r26, 'k'
    call usart_txchar
    ldi r26, 10
    call usart_txchar
    ret
