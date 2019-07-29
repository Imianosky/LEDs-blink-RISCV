.section .text
.align 2
.globl setupGPIO

.include "memory_map.inc"
.include "GPIO.inc"

setupGPIO:
    addi sp,sp,-16              # allocate the stack framework
    sw ra, 12(sp)               # save the return address into the stack

    li t0, GPIO_CTRL_ADDR       # load teh base GPIO address
    li t1, GPIO_RGB_PINS        # set the rgb pins offset
    sw t1, GPIO_OUTPUT_EN(t0)   # Enable output on the rgb pin so they are writable
    sw t1, GPIO_OUTPUT_XOR(t0)  #set the xor so the rgb pins are active high
    sw x0, GPIO_OUTPUT_VAL(t0)  # set all the writable pins to zero to clear the leds

    lw ra, 12(sp)               # restore the return address
    addi sp, sp, 16             # dealocate the stack frame
    ret
