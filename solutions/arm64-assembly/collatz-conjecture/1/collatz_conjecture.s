.equ INVALID_NUMBER, -1

.text
.globl steps

steps:
        mov x1, x0        //x0 and x1 now both contain our input
        cmp x1, #1         //special case when our input is lower than 1
        mov x15, INVALID_NUMBER
        mov x16, #0
        csel x0, x15, x16, lt
        

loop_start:
        cmp x1, #1
        b.eq exit

        cmp x0, INVALID_NUMBER
        b.eq exit

        tst x1, #1 //determine if even or odd (1 if odd, 0 if even), tst makes bitwise AND but keeps num in x1
        b.eq even //if the result was 0

odd:
        add x1, x1, x1, lsl #1 //multiplying by 3 with adding x1 to x1 and then adding additional x1 multiplied by 2
        add x1, x1, #1
        b loop_end

even:
        lsr x1, x1, #1 //shifting right by one divides by two in binary

loop_end:
        add x0, x0, #1
        b loop_start
        
exit:
        ret        //we can ret as x0 contains the answer now
