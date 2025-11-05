        AREA    REVERSE_STACK_MANUAL, CODE, READONLY
        ENTRY
        ALIGN

__main  FUNCTION
        EXPORT  __main

        LDR     R0, =Arr
        LDR     R1, =Result
        MOV     R2, #4

        LDR     R13, =Stack_Top
        MOV     SP, R13

push_loop
        LDR     R3, [R0], #4
        STMDB   SP!, {R3}
        SUBS    R2, R2, #1
        BNE     push_loop

        MOV     R2, #4

pop_loop
        LDMIA   SP!, {R3}
        STR     R3, [R1], #4
        SUBS    R2, R2, #1
        BNE     pop_loop

        B       .
        ENDFUNC

; -------------------------------
; Data section
; -------------------------------
        AREA    DATA_ARR, DATA, READONLY
        EXPORT  Arr
        ALIGN
Arr
        DCD     1, 2, 3, 4

        AREA    DATA_SEC, DATA, READWRITE
        EXPORT  Result
        ALIGN
Result
        SPACE   16
Stack_Mem
        SPACE   64
Stack_Top

        END
