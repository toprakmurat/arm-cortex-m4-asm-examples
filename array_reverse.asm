        AREA    ARRAY_REVERSE, CODE, READONLY
        ENTRY
        ALIGN

__main  FUNCTION
        EXPORT  __main

        LDR     R0, =Source
        LDR     R1, =Destination
        MOV     R2, #4

push_loop
        LDR     R3, [R0], #4
        PUSH    {R3}
        SUBS    R2, R2, #1
        BNE     push_loop

        MOV     R2, #4

pop_loop
        POP     {R3}
        STR     R3, [R1], #4
        SUBS    R2, R2, #1
        BNE     pop_loop

        B       .
        ENDFUNC

; -------------------------------
; Data section
; -------------------------------
        AREA    SRC_ARRAY, DATA, READONLY
        EXPORT  Source
        ALIGN
Source
        DCD     0x12345678, 0x87654321, 0x11223344, 0x55667788

        AREA    DEST_ARRAY, DATA, READWRITE
        EXPORT  Destination
        ALIGN
Destination
        SPACE   16

        END
