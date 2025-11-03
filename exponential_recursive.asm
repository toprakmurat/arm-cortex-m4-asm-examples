; ARM Cortex-M4 Recursive Power Function
; Computes y = x^a using recursion
; Base x in R0, Exponent a in R1
; Result returned in R0

        AREA    PowerFunction, CODE, READONLY
        ENTRY
        ALIGN
__main  FUNCTION
        EXPORT  __main

        MOVS    R0, #3          ; x
        MOVS    R1, #5          ; a

        BL      power
        B       .               ; done, result is in R0

power
        PUSH    {R0, R1, LR}    ; push base, exponent and return address to the stack
        CMP     R1, #0
        BEQ     base_case

        SUB     R1, R1, #1
        BL      power           ; calculate x^(a-1)

        POP     {R2, R3, LR}    ; pop original base, exponent and return address from the stack
        MUL     R0, R0, R2
        BX      LR

base_case
        MOV     R0, #1          ; result is 1 in base case
        POP     {R2, R3, LR}    ; clean stack
        BX      LR        
