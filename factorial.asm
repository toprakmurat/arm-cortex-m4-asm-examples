        AREA    FACTORIAL, CODE, READONLY
        ENTRY
        ALIGN

__main  FUNCTION
        EXPORT  __main

        LDR     R0, =Input
        LDRB    R1, [R0]
        MOV     R2, #1
        CMP     R1, #2
        BLT     end_factorial

factorial_loop
        MUL     R2, R2, R1
        SUBS    R1, #1
        BNE     factorial_loop

end_factorial
        LDR     R3, =Result
        STR     R2, [R3]
        B       .
        ENDFUNC

; -------------------------------
; Data section
; -------------------------------
        AREA    INPUT_DATA, DATA, READONLY
        EXPORT  Input
        ALIGN
Input
        DCB     0x05

        AREA    RESULT_DATA, DATA, READWRITE
        EXPORT  Result
        ALIGN
Result
        SPACE   0x08

        END
