
#ifndef APB_LED_DRIVER_H
#define APB_LED_DRIVER_H
#include <stdint.h>
void LED_init(uint32_t pattern, uint32_t period);
void LED_clear_irq(void);
#endif
