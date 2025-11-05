        AREA    BinomialCoefficient, CODE, READONLY
        EXPORT  __main
        ENTRY
        ALIGN

__main  FUNCTION
        ; example: C(5,2)
        MOV     R0, #5
        MOV     R1, #2
        BL      binom
        B       .               ; stop, result in R0

;---------------------------------------------------------
; uint32_t binom(uint32_t n, uint32_t k)
; R0 = n, R1 = k -> returns R0 = C(n,k)
; Recurrence:
; if k == 0 or k == n -> 1
; else -> C(n-1,k-1) + C(n-1,k)
;---------------------------------------------------------
binom
        PUSH    {R4, R5, LR}    ; save callee-saved we use + LR

        MOV     R4, R0          ; R4 := original n
        MOV     R5, R1          ; R5 := original k

        CMP     R5, #0          ; if k == 0 -> base
        BEQ     binom_base
        CMP     R4, R5          ; if k == n -> base
        BEQ     binom_base

        ; ---------- compute C(n-1, k-1) ----------
        SUB     R0, R4, #1      ; R0 = n - 1
        SUB     R1, R5, #1      ; R1 = k - 1
        BL      binom           ; returns in R0
        PUSH    {R0}            ; push the result into stack for future use 
        
        ; ---------- compute C(n-1, k) ----------
        SUB     R0, R4, #1      ; R0 = n - 1
        MOV     R1, R5          ; R1 = k
        BL      binom           ; returns in R0
        
        POP     {R2}            ; Pop the first result into R2
        ADDS    R0, R0, R2      ; R0 = result2 + result1

        POP     {R4, R5, LR}
        BX      LR

binom_base
        MOVS    R0, #1          ; return 1
        POP     {R4, R5, LR}
        BX      LR
        ENDFUNC
        END
