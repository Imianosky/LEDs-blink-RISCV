.section .text
.align 2
.globl delay

.include "memory_map.inc"

# our delay value in milliseconds passed into a0

delay:
    addi sp, sp, -16
    sw ra, 12(sp)

    li t0, MTIME              # load the timer register
    lw t1, 0(t0)              # load the current value of the timer

    li t2, MTIME_FREQUENCY    # get our clock frequency
    mul t2, t2, a0            # multiply milliseconds with frequency
    add t2, t1, t2            # target mtime is now in t2

1:
    lw t1, 0(t0)              # read mtime value again
    blt t1, t2, 1b          # keep looping until time out

    lw ra, 12(sp)             # restore the return address
    addi sp, sp, 16           #deallocate the stack frame
    ret
