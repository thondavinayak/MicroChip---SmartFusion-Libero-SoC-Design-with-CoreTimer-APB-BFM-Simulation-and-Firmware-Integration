# SmartFusion APB LED Engine

Custom APB slave peripheral implemented in VHDL for SmartFusion SoC.

## Features
- Register-mapped APB interface
- Programmable LED pattern
- Programmable period
- Interrupt generation
- Firmware driver integration
- BFM simulation support

## Base Address
0x40050000

## Register Map
0x00 CONTROL
0x04 PATTERN
0x08 PERIOD
0x0C STATUS
0x10 INTCLR

## Flow
RTL Design → APB Integration → BFM Verification → Firmware Driver → Interrupt Handling
