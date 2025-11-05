        AREA    StirlingSecondKind, CODE, READONLY
        EXPORT  __main
        ENTRY
        ALIGN

__main  FUNCTION
        ; Example test: S(5, 2) = 15
        MOV     R0, #5        ; n
        MOV     R1, #2        ; k
        BL      stirling
        B       .             ; done, check R0 for result
        ENDFUNC

;---------------------------------------------------------
; uint32_t stirling(uint32_t n, uint32_t k)
; Recurrence:
; S(n,k) = k*S(n-1,k) + S(n-1,k-1)
;
; Base Cases:
; S(0,0) = 1
; S(n,0) = 0   for n > 0
; S(k>n) = 0
;---------------------------------------------------------

stirling FUNCTION
        PUSH    {R4, R5, LR}      ; save callee-saved registers + LR
        MOV     R4, R0            ; R4 = n
        MOV     R5, R1            ; R5 = k

        ; ---- Base Case 1: S(0,0) = 1 ----
        CMP     R4, #0
        BNE     check_k_zero
        CMP     R5, #0
        BNE     return_zero
        MOV     R0, #1            ; return 1
        B       return_done

check_k_zero
        ; ---- Base Case 2: S(n,0) = 0 ----
        CMP     R5, #0
        BEQ     return_zero

        ; ---- Base Case 3: S(k>n) = 0 ----
        CMP     R5, R4
        BGT     return_zero

        ; ---- Recursive case: S(n,k) = k*S(n-1,k) + S(n-1,k-1) ----

        ; Compute S(n-1, k-1)
        SUB     R0, R4, #1
        SUB     R1, R5, #1
        BL      stirling
        PUSH    {R0}              ; save S(n-1,k-1) on stack

        ; Compute S(n-1, k)
        SUB     R0, R4, #1
        MOV     R1, R5
        BL      stirling

        ; Combine result: k * S(n-1,k) + S(n-1,k-1)
        POP     {R2}              ; R2 = S(n-1,k-1)
        MUL     R0, R0, R5        ; k * S(n-1,k)
        ADD     R0, R0, R2

        B       return_done

return_zero
        MOV     R0, #0

return_done
        POP     {R4, R5, LR}
        BX      LR
        ENDFUNC

        END
