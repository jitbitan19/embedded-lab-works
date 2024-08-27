// slave

#include <avr/io.h>
#include <avr/delay.h>

#define SS PINB4
#define MOSI PINB5
#define MISO PINB6
#define SCK PINB7

void spi_slave_init() /* SPI Initialize function */
{
	DDRB &= ~((1 << MOSI) | (1 << SCK) | (1 << SS));
	DDRB |= (1 << MISO);
	SPCR = (1 << SPE);
}

void slave_write(char data)
{
	char flush_buffer;
	SPDR = data;
	while (!(SPSR & (1 << SPIF)))
	;
	flush_buffer = SPDR;
}

char slave_read()
{
	SPDR = 0xFF;
	while (!(SPSR & (1 << SPIF)))
	;
	return (SPDR);
}

int main(void)
{
	DDRC = 0xff;
	spi_slave_init();

	// char d = 0x2e;
	// PORTC = d;
	// slave_write(d);

	char d = slave_read();
	PORTC = d;

	while (1)
	{
	}
}
