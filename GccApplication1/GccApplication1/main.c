/*
   LCD16x2 4 bit ATmega16 interface
   http://www.electronicwings.com
*/

#define F_CPU 8000000UL /* Define CPU Frequency e.g. here 8MHz */
#include <avr/io.h>     /* Include AVR std. library file */
#include <util/delay.h> /* Include Delay header file */

#define LCD_Dir DDRC   /* Define LCD data port direction */
#define LCD_Port PORTC /* Define LCD data port */
#define RS PC0         /* Define Register Select pin */
#define EN PC1         /* Define Enable signal pin */

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

void LCD_String(char *str) /* Send string to LCD function */
{
    int i;
    for (i = 0; str[i] != 0; i++) /* Send each char of string till the NULL */
    {
        LCD_Char(str[i]);
    }
}

void LCD_String_xy(char row, char pos, char *str) /* Send string to LCD with xy position */
{
    if (row == 0 && pos < 16)
        LCD_Command((pos & 0x0F) | 0x80); /* Command of first row and required position<16 */
    else if (row == 1 && pos < 16)
        LCD_Command((pos & 0x0F) | 0xC0); /* Command of first row and required position<16 */
    LCD_String(str);                      /* Call LCD string function */
}

void LCD_Clear()
{
    LCD_Command(0x01); /* Clear display */
    _delay_ms(2);
    LCD_Command(0x80); /* Cursor at home position */
}

int main()
{
    LCD_Init(); /* Initialization of LCD*/

    // LCD_String("Jitbitan"); /* Write string on 1st line of LCD*/
    // LCD_Command(0xC0);      /* Go to 2nd line*/
    // LCD_String("Baroi");    /* Write string on 2nd line*/
    LCD_Char('J');
    LCD_Command(0xC0);
    LCD_Char('B');
    while (1)
        ;
}