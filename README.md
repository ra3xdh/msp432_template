###MSP 432 project template

This repository contains template project for Texas Instrument MSP432 Launchpad.
No IDE is needed to build it. Use any ARM-GCC to compile. 

Two utilities could be used to flash target:

* Uniflash utility from TexasInstruments http://www.ti.com/tool/uniflash
* Unofficial OpenOCD fork with MSP432 support: https://github.com/ungureanuvladvictor/openocd-code

and Uniflash utility from TI to 
flash target.

Makefile targets description:

* Execute `make` to compile project
* Execute `make burn` to write into flash target with TI Uniflash
* Execute `make flash` to program target with OpenOCD

If necessary, correct GCC and flasher paths in the `Makefile`

