        AREA    POWER_FUNCTION, CODE, READONLY
        ENTRY
        ALIGN

__main  FUNCTION
        EXPORT  __main

        LDR     R0, =Base
        LDR     R1, =Power
        LDR     R2, =Result
        LDR     R3, [R0]                        ; Store base
        LDR     R4, [R1]                        ; Store power
        MOV     R5, R3                          ; Store intermediate result
        MOV     R6, R4                          ; Act as a counter

multiply_loop
        MUL     R3, R3, R5
        SUB     R6, R6, #1
        CMP     R6, #1
        BGT     multiply_loop

        STR	R3, [R2]
        B       .
        ENDFUNC

; -------------------------------
; Data section
; -------------------------------
        AREA    SRC_ARRAY, DATA, READONLY
        EXPORT  Base, Power
        ALIGN
Base
        DCD     0x03
Power
        DCD     0x04

        AREA    DEST_ARRAY, DATA, READWRITE
        EXPORT  Result
        ALIGN
Result
        SPACE   0x04

        END
