/*
 * GccApplication2.cpp
 *
 * Created: 07-Apr-24 9:55:23 AM
 * Author : jitbitan
 */

#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/delay.h>

#define LCD_Dir DDRB
#define LCD_Port PORTB
#define RS PB0
#define EN PB1

void LCD_Command(unsigned char cmnd)
{
    LCD_Port = (LCD_Port & 0x0F) | (cmnd & 0xF0); /* sending upper nibble */
    LCD_Port &= ~(1 << RS);                       /* RS=0, command reg. */
    LCD_Port |= (1 << EN);                        /* Enable pulse */
    _delay_us(1);
    LCD_Port &= ~(1 << EN);

    _delay_us(200);

    LCD_Port = (LCD_Port & 0x0F) | (cmnd << 4); /* sending lower nibble */
    LCD_Port |= (1 << EN);
    _delay_us(1);
    LCD_Port &= ~(1 << EN);
    _delay_ms(2);
}

void LCD_Char(unsigned char data)
{
    LCD_Port = (LCD_Port & 0x0F) | (data & 0xF0); /* sending upper nibble */
    LCD_Port |= (1 << RS);                        /* RS=1, data reg. */
    LCD_Port |= (1 << EN);
    _delay_us(1);
    LCD_Port &= ~(1 << EN);

    _delay_us(200);

    LCD_Port = (LCD_Port & 0x0F) | (data << 4); /* sending lower nibble */
    LCD_Port |= (1 << EN);
    _delay_us(1);
    LCD_Port &= ~(1 << EN);
    _delay_ms(2);
}

void LCD_Init(void) /* LCD Initialize function */
{
    LCD_Dir = 0xFF; /* Make LCD port direction as o/p */
    _delay_ms(20);  /* LCD Power ON delay always >15ms */

    LCD_Command(0x02); /* send for 4 bit initialization of LCD  */
    LCD_Command(0x28); /* 2 line, 5*7 matrix in 4-bit mode */
    LCD_Command(0x0c); /* Display on cursor off*/
    LCD_Command(0x06); /* Increment cursor (shift cursor to right)*/
    LCD_Command(0x01); /* Clear display screen*/
    _delay_ms(2);
}

int main(void)
{
    /* Replace with your application code */
    while (1)
    {
    }
}
