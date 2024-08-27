#include <avr/io.h>
// #define F_CPU 1000000UL
#define F_CPU 16000000UL
#include <util/delay.h>
#include <avr/interrupt.h>

void init_intr()
{
    GICR |= 0x40;
    MCUCR |= 0x02;
    sei();
}

int f = 0;

int main(void)
{
    int a[] = {0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B};
    DDRC = 0xFF;
    DDRD = 0x00;
    PORTD = 0xFF;
    init_intr();

    int i = 0;
    while (1)
    {
        if (f)
        {
            i++;
            if (i == 10)
                i = 0;
        }
        else
        {
            i--;
            if (i < 0)
                i = 9;
        }
        PORTC = a[i];
        _delay_ms(500);
    }
}

ISR(INT0_vect)
{
    f = !f;
}