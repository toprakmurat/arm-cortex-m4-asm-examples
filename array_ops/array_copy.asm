        AREA    ARRAY_COPY, CODE, READONLY
        ENTRY
        ALIGN

__main  FUNCTION
        EXPORT  __main

        LDR     R0, =Source
        LDR     R1, =Destination

        LDM     R0, {R2 - R5}
        STM     R1, {R2 - R5}

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
