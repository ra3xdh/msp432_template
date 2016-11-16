###MSP 432 project template

This repository contains template project for Texas Instrument MSP432 Launchpad.
No IDE is needed to build it. Use ARM-GCC to compile and Uniflash utility from TI to 
flash target.

Makefile targets description:

* Execute `make` to compile project
* Execute `make burn` to write into flash target.

If necessary, correct GCC and flasher paths in the `Makefile`

