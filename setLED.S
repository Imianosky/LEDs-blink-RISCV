.section  .text
.align    2
.globl    setLED


.include "memory_map.inc"
.include "GPIO.inc"


.equ NOERROR,   0x0
.equ ERROR,     0x1
.equ LEDON,     0x1

# wich led to set comes into register a0
# desired on/off state comes into register a1


setLED:
    addi sp,sp, -16               # alocates the stack frame
    sw ra, 12(sp)                 # save our return address onto the stack

    li t0, GPIO_CTRL_ADDR         # load the gpio address
    lw t1, GPIO_OUTPUT_VAL(t0)    # get the current value of the pins

    beqz a1, ledOff               # branch off to turn off LED if a1 requires it
    li t2, LEDON                  # load up on/1 into our temporary register
    beq a1, t2, ledOn             # branch if on requested
    li a0, ERROR                  # we got a bad status request, return ERROR
    j exit


ledOn:
    xor t1, t1, a0                  # to an xro to only chance the value of the requested LED
    sw t1, GPIO_OUTPUT_VAL(t0)    # write the new output value to the GPIO output
    li a0, NOERROR
    j exit


ledOff:
    xori a0, a0, -1         # invert everything so that all bits are 1 except the led we are turning off
    and t1, t1, a0                 # and a0 and t1 to get the led we want to turn off
    sw t1, GPIO_OUTPUT_VAL(t0)     # write the new output value to the right gpio register
    li a0, NOERROR


exit:
    lw ra, 12(sp)                  # restore our return address
    addi sp, sp, 16                # deallocating stack frame
    ret
