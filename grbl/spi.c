#include "spi.h"
#include <avr/io.h>
#include <avr/interrupt.h>
#include "grbl.h"



void spi_init()
// Initialize pins for spi communication
{
    DDR_SPI &= ~((1<<DD_MOSI)|(1<<DD_MISO)|(1<<DD_SS)|(1<<DD_SCK));   // Set as input pins

    PORT_SPI |= (1<<DD_MISO);   // Enable internal pull-up resistor
    
    // Define the following pins as output
    DDR_SPI |= ((1<<DD_MOSI)|(1<<DD_SS)|(1<<DD_SCK));
   
    SPCR = ((1<<SPE)|               // SPI Enable
            (0<<SPIE)|              // SPI Interupt Enable
            (0<<DORD)|              // Data Order (0:MSB first / 1:LSB first)
            (1<<MSTR)|              // Master/Slave select   
            (1<<SPR1)|(0<<SPR0)|    // SPI Clock Rate .....  fosc/32 (given that SPI2X is set below in line 31, otherwise fosc/64)
            (0<<CPOL)|              // Clock Polarity (0:SCK low / 1:SCK hi when idle)
            (0<<CPHA));             // Clock Phase (0:leading / 1:trailing edge sampling)

    SPSR = (1<<SPI2X);              // Double Clock Rate
}


uint8_t spi_fast_shift (uint8_t data)
// Clocks only one byte to target device and returns the received one
{
    SPDR = data;
    while((SPSR & (1<<SPIF))==0);
    return SPDR;
}


unsigned long spi_send16bit(unsigned long datagram, volatile uint8_t *cs_port, uint8_t cs_bit)
{
  unsigned long i_datagram; // this is the returned value

  #ifdef INVERT_CHIP_SELECT_PIN
    *cs_port |= (1<<cs_bit);  // chip select
  #else
    *cs_port &= ~(1<<cs_bit); // chip select
  #endif

  delay_us(10);

  datagram &= 0xFFFFul; // force to 16 bit

  i_datagram = spi_fast_shift( (datagram>>8) & 0xff );
  i_datagram <<= 8;
  i_datagram |= spi_fast_shift( datagram & 0xff );

  delay_us(10);

  #ifdef INVERT_CHIP_SELECT_PIN
    *cs_port &= ~(1<<cs_bit); // deselect chip
  #else
    *cs_port |= (1<<cs_bit);  // deselect chip
  #endif

  return i_datagram;
}
