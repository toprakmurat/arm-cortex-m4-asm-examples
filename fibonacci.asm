        AREA FACTORIAL, CODE, READONLY    
        ENTRY                           
        ALIGN                           

; R0 = counter
; R1 = F(N - 2)
; R2 = F(N - 1)
; F(0) = 0
; F(1) = 1
; F(n) = F(n - 1) + F(n - 2), n > 1
; Computes F(Input)

__main  FUNCTION                        
        EXPORT __main

        LDR        R7, =Input
        LDR        R0, [R7]
        MOV        R1, #0
        MOV        R2, #1

loop
        ADD        R3, R1, R2
        MOV        R1, R2
        MOV        R2, R3
        
        SUB        R0, R0, #1
        CMP        R0, #1
        BGT        loop

        LDR        R8, =Result
        STR        R3, [R8]
        B          .

; -------------------------------
; Data section
; -------------------------------
        AREA INPUT_DATA, DATA, READONLY
        EXPORT Input
        ALIGN
Input        
        DCB         0x0A
                
        AREA RESULT_DATA, DATA, READWRITE
        EXPORT Result
        ALIGN
Result        
        SPACE        0x08                       
        END                             
