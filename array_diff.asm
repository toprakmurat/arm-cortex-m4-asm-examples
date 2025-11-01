        AREA ARRAY_DIFF, CODE, READONLY    
        ENTRY                           
        ALIGN                           

__main  FUNCTION                        
        EXPORT __main                   
        LDR         R0, =ArrA
        LDR         R1, =ArrB
        LDR         R2, =Result
        MOV         R3, #4
        
loop
        LDR         R4, [R0], #4
        LDR         R5, [R1], #4
        SUB         R6, R4, R5
        STR         R6, [R2], #4
        SUBS        R3, R3, #1
        BNE         loop
        B           .
        
        AREA INPUT_DATA, DATA, READONLY
        EXPORT ArrA, ArrB
        ALIGN
ArrA
        DCD         0x09, 0x08, 0x07, 0x06
ArrB        
        DCD         0x01, 0x02, 0x03, 0x04
                
        AREA RESULT_DATA, DATA, READWRITE
        EXPORT Result
        ALIGN
Result        
        SPACE        16         
        END
