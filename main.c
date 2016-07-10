#include "msp432.h"

int main(void)
{
    SystemInit();

    P1DIR = 0x01;
    P1OUT = 0x01;

    while(1);
    return 0;
}

