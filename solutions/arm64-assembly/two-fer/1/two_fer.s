.section .rodata
first_half: .string "One for "
second_half: .string ", one for me."
null_case: .string "you"

.text
.globl two_fer

two_fer:
        adrp x2, first_half
        add x2, x2, :lo12:first_half         //x2 is now a pointer to the first byte of first_half string
                                                //x2 will also serve as the universal pointer for all loops
        mov x10, #0       //x10 is our current writing state(0 = writing first part, 1 = writing name, 2 = writing second
                          //part
        
        cmp x1, #0                //check if x1 is a null pointer
        b.eq null_name
        
        b write_loop

switch_state:
        add x10, x10, #1 //switch to next state

        cmp x10, #3
        b.eq end

        cmp x10, #1
        b.eq second_state

        cmp x10, #2
        b.eq third_state

        b write_loop

second_state:
        mov x2, x1
        b write_loop

third_state:
        adrp x2, second_half
        add x2, x2, :lo12:second_half

write_loop:
        ldrb w11, [x2], #1
        cmp w11, #0
        b.eq switch_state

        strb w11, [x0], #1
        b write_loop
        
end:
        mov w11, #0
        str w11, [x0]
        ret

null_name:
        adrp x1, null_case
        add x1, x1, :lo12:null_case
        b write_loop
