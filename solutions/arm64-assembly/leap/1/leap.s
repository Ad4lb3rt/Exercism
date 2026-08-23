.text
.globl leap_year

leap_year:
        mov x1, #100
        sdiv x2, x0, x1
        msub x2, x2, x1, x0        //x2 is now our remainder of division

        cmp x2, #0
        b.eq special_case

        mov x1, #4
        sdiv x2, x0, x1
        msub x2, x2, x1, x0

        cmp x2, #0
        b.eq return_true
        b.ne return_false
        
special_case:
        mov x1, #400
        sdiv x2, x0, x1
        msub x2, x2, x1, x0

        cmp x2, #0
        b.eq return_true
        
return_false:
        mov x0, #0
        ret

return_true:
        mov x0, #1
        ret
        