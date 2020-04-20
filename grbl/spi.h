#ifndef _SPI_H_
#define _SPI_H_
#include <avr/io.h>

extern void spi_init();
extern uint8_t spi_fast_shift (uint8_t data);
extern unsigned long spi_send16bit(unsigned long datagram, volatile uint8_t *cs_port, uint8_t cs_bit);

// Chip select active state inversion. Inverts the chip select pins from low-selected/high-deselected
// to low-deselected/high-selected. Useful for stepper driver ICs with SPI-configurable registers and
// inverted chip select logic.
#define INVERT_CHIP_SELECT_PIN // Default disabled. Uncomment to enable.

#endif /* _SPI_H_ */
