        AREA    PowerFunction, CODE, READONLY
        ENTRY
        ALIGN
__main  FUNCTION
        EXPORT  __main

        MOVS    R0, #2          ; x
        MOVS    R1, #6          ; a
        BL      power
        B       .               ; done, result in R0

;------------------------------------
; power(x, a):
;   if a == 0 ? return 1
;   if a even ? t = power(x, a/2); return t*t
;   if a odd  ? t = power(x, a/2); return t*t*x
;------------------------------------

power
        PUSH    {R0, R1, LR}        ; save x, a, return addr

        CMP     R1, #0              ; if a == 0
        BEQ     base_case

        ASRS    R1, R1, #1          ; a = a / 2
        BL      power               ; recurse with half exponent

        POP     {R2, R3, LR}        ; restore x=R2, a=R3, LR
        MUL     R0, R0, R0          ; square the result

        TST     R3, #1              ; check if original a was odd
        BEQ     done                ; if even, done
        MUL     R0, R0, R2          ; if odd, multiply by x

done
        BX      LR

base_case
        MOVS    R0, #1
        POP     {R2, R3, LR}
        BX      LR
