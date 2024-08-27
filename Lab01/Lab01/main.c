/*
 * Lab01.c
 *
 * Created: 04-Jan-24 2:12:29 PM
 * Author : jitbitan
 */

#include <avr/io.h>
#define F_CPU 1000000UL // What does it mean?
#include <util/delay.h>

int main(void)
{
    DDRC = 0xFF;
    while(1)
    {
        PORTC = 0xFF;
        _delay_ms(500);
        PORTC = 0x00;
        _delay_ms(500);
    }
}
// void dot(int n)
// {
//     for (int i = 0; i < n; i++)
//     {
//         PORTC = 0xFF;
//         _delay_ms(100);
//         PORTC = 0x00;
//         _delay_ms(400);
//     }
// }
// void dash(int n)
// {
//     for (int i = 0; i < n; i++)
//     {
//         PORTC = 0xFF;
//         _delay_ms(400);
//         PORTC = 0x00;
//         _delay_ms(100);
//     }
// }
// void space()
// {
//     _delay_ms(500);
// }
// void start()
// {
//     PORTC = 0xFF;
//     _delay_ms(3000);
//     PORTC = 0x00;
//     _delay_ms(3000);
// }

// int main(void)
// {
//     DDRC = 0xFF;
//     while (1)
//     {
//         start();
//         // j
//         dot(1);
//         dash(3);
//         space();
//         // i
//         dot(2);
//         space();
//         // t
//         dash(1);
//         space();
//         // b
//         dash(1);
//         dot(3);
//         // i
//         dot(2);
//         space();
//         // t
//         dash(1);
//         space();
//         // a
//         dot(1);
//         dash(1);
//         // n
//         dash(1);
//         dot(1);
//     }
// }

