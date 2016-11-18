TARGET=device.elf

GCC_ROOT = /opt/gcc-arm-none-eabi/bin
OOCD_ROOT = /opt/oocd-msp432/bin

CC = $(GCC_ROOT)/arm-none-eabi-gcc
LD = $(GCC_ROOT)/arm-none-eabi-gcc
OBJCOPY = $(GCC_ROOT)/arm-none-eabi-objcopy
OOCD = $(OOCD_ROOT)/openocd

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
	$(OBJCOPY) -O ihex $(TARGET) $(basename $(TARGET)).hex
	$(OBJCOPY) -O binary $(TARGET) $(basename $(TARGET)).bin



%.o: %.c
	$(CC) $(DEFINES) $(CFLAGS) $^ -o $@

burn:
	/opt/uniflash/dslite.sh --config=/opt/uniflash/user_files/configs/msp432p401r.ccxml $(basename $(TARGET)).hex

flash:
	$(OOCD) -f msp432.cfg -c "init" \
		-c "reset halt" \
		-c "msp432p4 init 0" \
		-c "msp432p4 mass_erase 0" \
		-c "msp432p4 init 0" \
		-c "flash write_image $(basename $(TARGET)).bin" \
		-c "reset run" \
		-c "shutdown"


clean:
	rm *.o *.elf
	rm cmsis/src/*.o
	rm *.hex
	rm *.bin
