TARGET=device.elf

GCC_ROOT = /opt/gcc-arm-none-eabi/bin

CC = $(GCC_ROOT)/arm-none-eabi-gcc
LD = $(GCC_ROOT)/arm-none-eabi-gcc
OBJCOPY = $(GCC_ROOT)/arm-none-eabi-objcopy

DEFINES = -D__MSP432P401R__

CFLAGS = -c -Wall -std=c99 -Os -I. -Iinclude/ -Icmsis/include/CMSIS -Icmsis/include/
CFLAGS += -mthumb -mcpu=cortex-m4 -nostartfiles

LDFLAGS = -Tcmsis/include/msp432p401r.lds -mthumb -mcpu=cortex-m4 -nostartfiles

CMSIS_SRCS = cmsis/src/startup_msp432p401r_gcc.c cmsis/src/interrupt_msp432p401r_gcc.c cmsis/src/system_msp432p401r.c
CMSIS_OBJECTS = cmsis/src/startup_msp432p401r_gcc.o cmsis/src/interrupts_msp432p401r_gcc.o cmsis/src/system_msp432p401r.o

SRCS = main.c

OBJECTS = main.o

all: $(TARGET)

$(TARGET): $(OBJECTS) $(CMSIS_OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) $(CMSIS_OBJECTS) -o $(TARGET)
	$(OBJCOPY) -O ihex $(TARGET) device.hex
	$(OBJCOPY) -O binary $(TARGET) device.bin



%.o: %.c
	$(CC) $(DEFINES) $(CFLAGS) $^ -o $@

burn:
	/opt/uniflash/dslite.sh --config=/opt/uniflash/user_files/configs/msp432p401r.ccxml device.hex

clean:
	rm *.o *.elf
	rm cmsis/src/*.o
	rm *.hex
	rm *.bin
