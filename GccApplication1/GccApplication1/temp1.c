#include <avr/io.h>
#define F_CPU 1000000UL
#include <util/delay.h>
#include <avr/interrupt.h>

// int main(void)
// {
//     /* Replace with your application code */
//     int a[] = {0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B};
//     DDRC = 0xFF;
//     DDRA = 0xFF;
//     while (1)
//     {
//         PORTA = 0x01;
//         for (int i = 9; i >= 0; i--)
//             PORTC = a[i], _delay_ms(1000);

//         PORTA = 0x08;
//         for (int i = 9; i >= 0; i--)
//             PORTC = a[i], _delay_ms(1000);
//     }
// }

int f = 1;

int main(void)
{
    GICR |= 0x40;
    MCUCR |= 0x02;
    sei();

    DDRA = 0xFF;
    DDRC = 0xFF;
    DDRD = 0x00;
    PORTD = 0xFF;

    while (1)
    {
        if (f)
        {
            PORTA = 0xFF;
            _delay_ms(1000);
            PORTA = 0x00;
            _delay_ms(1000);
        }
        else
        {
            PORTC = 0xFF;
            _delay_ms(1000);
            PORTC = 0x00;
            _delay_ms(1000);
        }
    }
}

ISR(INT0_vect)
{
    f = !f;
}