.text
.globl reverse

reverse:
        mov x10, #0
        b find_text_length

find_text_length:
        ldrb w9, [x0, x10]                //w9 stores our byte at address of x0 + x10
        cmp w9, #0 //check if null byte
        b.eq setup_right_pointer

        add x10, x10, #1           //x10 is our text length and address offset at the same time
        b find_text_length

setup_right_pointer:
        sub x10, x10, #1
        add x10, x0, x10
        b switch_places

switch_places:        //x10 now serves as the right pointer, and x0 will serve as left pointer
        cmp x0, x10
        b.ge return
        
        ldrb w9, [x0]               //w9 is used as temporary store for a char at address on the left
        ldrb w13, [x10]              //w13 is used as temporary store for a char at address on the right

        strb w9, [x10], #-1    //set the address on right with the char at the left and then moves the address to the left
        strb w13, [x0], #1     //and vice-versa
        
        b switch_places

return:
        ret
