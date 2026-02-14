
#include "apb_led_driver.h"

#define LED_BASE 0x40050000
#define REG_CONTROL (*(volatile uint32_t*)(LED_BASE + 0x00))
#define REG_PATTERN (*(volatile uint32_t*)(LED_BASE + 0x04))
#define REG_PERIOD  (*(volatile uint32_t*)(LED_BASE + 0x08))
#define REG_STATUS  (*(volatile uint32_t*)(LED_BASE + 0x0C))
#define REG_INTCLR  (*(volatile uint32_t*)(LED_BASE + 0x10))

void LED_init(uint32_t pattern, uint32_t period)
{
    REG_PATTERN = pattern;
    REG_PERIOD  = period;
    REG_CONTROL = 0x03;
}

void LED_clear_irq(void)
{
    REG_INTCLR = 1;
}
