SmartFusion APB LED Engine – Custom IP with Interrupt Support
Overview

This project implements a fully custom APB slave peripheral integrated into a Microchip SmartFusion SoC using Libero.

The design demonstrates:

Custom APB slave implementation in VHDL

Register-mapped peripheral architecture

Programmable timing engine

Interrupt generation

BFM-based APB verification

ARM Cortex-M3 firmware driver integration

This project reflects a complete hardware-software co-design flow.

System Architecture

MSS (Cortex-M3) – APB Master

CoreAPB3 – APB Interconnect

APB_LED_CTRL – Custom APB Slave (FPGA Fabric)

UART – Debug output

NVIC – Interrupt handling

Base address: 0x40050000

Register Map
Offset	Register	Description
0x00	CONTROL	Bit0: Enable, Bit1: IRQ Enable
0x04	PATTERN	8-bit LED pattern
0x08	PERIOD	Timer reload value
0x0C	STATUS	Bit0: Interrupt flag
0x10	INTCLR	Write 1 to clear interrupt
Functional Description

When enabled:

Counter loads PERIOD value

When counter reaches zero:

PATTERN is driven to LED outputs

STATUS interrupt flag is set

IRQ asserted if enabled

Firmware clears interrupt via INTCLR

Verification Strategy

APB write/read operations verified using BFM

PSEL, PENABLE, PADDR, PWDATA observed

Interrupt flag behavior verified

Status register validated

Firmware Layer

A lightweight driver abstracts memory-mapped register access:

LED_init()

LED_clear_irq()

Interrupt handler sends UART debug message.

Tools Used

Libero SoC

SmartFusion Evaluation Kit

SoftConsole

APB BFM Simulation
