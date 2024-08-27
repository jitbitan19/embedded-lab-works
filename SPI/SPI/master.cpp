// master

#include <avr/io.h>
#include <avr/delay.h>

#define SS PINB4
#define MOSI PINB5
#define MISO PINB6
#define SCK PINB7

void spi_master_init() /* SPI Initialize function */
{
    DDRB |= (1 << MOSI) | (1 << SCK) | (1 << SS);
    DDRB &= ~(1 << MISO);
    PORTB |= (1 << SS);
    SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR0);
    SPSR &= ~(1 << SPI2X);
}

void master_write(char data)
{
    char flush_buffer;
    SPDR = data;
    while (!(SPSR & (1 << SPIF)))
        ;
    flush_buffer = SPDR;
}

char master_read()
{
    SPDR = 0xFF;
    while (!(SPSR & (1 << SPIF)))
        ;
    return (SPDR);
}

int main(void)
{
    DDRC = 0xff;
    spi_master_init();

    // char d;
    // d = master_read();
    // PORTC = d;

    char d = 0x2e;
    PORTC = d;
    master_write(d);

    while (1)
    {
    }
}
