        AREA    ARRAY_MULT_BYTE, CODE, READONLY
        ENTRY
        ALIGN

__main  FUNCTION
        EXPORT  __main

        LDR     R0, =ArrA
        LDR     R1, =ArrB
        LDR     R2, =Result
        MOV     R3, #4

loop
        LDRB    R4, [R0], #1
        LDRB    R5, [R1], #1
        MUL     R6, R4, R5
        STRH    R6, [R2], #2
        SUBS    R3, R3, #1
        BNE     loop

        B       .
        ENDFUNC

; -------------------------------
; Data section
; -------------------------------
        AREA    INPUT_DATA, DATA, READONLY
        EXPORT  ArrA, ArrB
        ALIGN
ArrA
        DCB     0xFF, 0x08, 0x07, 0x06
ArrB
        DCB     0xFF, 0x02, 0x03, 0x04

        AREA    RESULT_DATA, DATA, READWRITE
        EXPORT  Result
        ALIGN
Result
        SPACE   8

        END
