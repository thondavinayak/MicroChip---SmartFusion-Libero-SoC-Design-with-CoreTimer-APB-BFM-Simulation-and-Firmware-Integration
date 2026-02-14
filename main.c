
#include "apb_led_driver.h"
#include "mss_uart.h"
#include "cortex_nvic.h"

mss_uart_instance_t * const gp_uart = &g_mss_uart0;

void Fabric_IRQHandler(void)
{
    MSS_UART_polled_tx_string(gp_uart,
        (const uint8_t*)"LED cycle complete\n");
    LED_clear_irq();
}

int main(void)
{
    MSS_UART_init(gp_uart,
                  MSS_UART_115200_BAUD,
                  MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

    LED_init(0xAA, 0x000FFFFF);
    NVIC_EnableIRQ(Fabric_IRQn);

    while(1) { }
}
