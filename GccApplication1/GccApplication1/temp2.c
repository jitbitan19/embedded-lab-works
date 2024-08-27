#include <avr/io.h>
#define F_CPU 1000000UL
#include <util/delay.h>
#include <avr/interrupt.h>

void init_intr()
{
    GICR |= 0xC0;
    MCUCR |= 0x0A;
    sei();
}

int x = 0;



ISR(INT0_vect)
{
    x++;
}

ISR(INT1_vect)
{
    x--;
}

int main(void)
{
    int a[] = {0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B};
    DDRC = 0xFF;
    DDRD = 0x00;
    PORTD = 0xFF;
    init_intr();

    while (1)
    {
        PORTC = a[x];
        check();
    }
}
