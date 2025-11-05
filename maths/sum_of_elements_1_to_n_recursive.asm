        AREA    SumUntilN, CODE, READONLY
        ENTRY
        ALIGN
__main  FUNCTION
        EXPORT  __main

        MOV     R0, #11         ; example n = 11
        BL      sum
        B       .               ; stop here (check R0 in debugger)

;------------------------------------
; int S(int n)
; base: S(1)=1, S(2)=3
; if n>2 and even: S(n) = 3*S(n/2) + S(n/2 - 1)
; if n>2 and odd:  S(n) = 3*S((n-1)/2) + S((n+1)/2)
;------------------------------------

sum
        PUSH    {R4, LR}        ; save callee-saved and return addr
        MOV     R4, R0          ; R4 := n (preserve original n)

        ; base cases n < 3: compute 2*n - 1
        CMP     R0, #3
        BLT     sum_base

        TST     R4, #1          ; test odd/even on original n
        BEQ     sum_even

; compute S((n-1)/2) then S((n+1)/2)
sum_odd
        ; first argument: (n-1)/2
        MOV     R0, R4
        SUBS    R0, R0, #1
        ASRS    R0, R0, #1      ; R0 = (n-1)/2
        BL      sum             ; returns in R0 = S((n-1)/2)

        PUSH    {R0}            ; save S((n-1)/2) on stack

        ; second argument: (n+1)/2
        MOV     R0, R4
        ADDS    R0, R0, #1
        ASRS    R0, R0, #1      ; R0 = (n+1)/2
        BL      sum             ; returns in R0 = S((n+1)/2)

        ; restore first result
        POP     {R1}            ; R1 = S((n-1)/2)
        MOVS    R2, #3
        MUL     R1, R1, R2      ; R1 = 3 * S((n-1)/2)

        ADDS    R0, R0, R1      ; R0 = S((n+1)/2) + 3*S((n-1)/2)
        B       sum_done

; compute S(n/2) then S(n/2 - 1)
sum_even
        MOV     R0, R4
        ASRS    R0, R0, #1      ; R0 = n/2
        BL      sum             ; R0 = S(n/2)

        PUSH    {R0}            ; save S(n/2)

        MOV     R0, R4
        ASRS    R0, R0, #1      ; R0 = n/2
        SUBS    R0, R0, #1      ; R0 = n/2 - 1
        BL      sum             ; R0 = S(n/2 - 1)

        POP     {R1}            ; R1 = S(n/2)
        MOVS    R2, #3
        MUL     R1, R1, R2      ; R1 = 3 * S(n/2)

        ADDS    R0, R0, R1      ; R0 = S(n/2 - 1) + 3*S(n/2)
        B       sum_done

sum_base
        ; Using formula 2*n - 1 for n==1 -> 1, n==2 -> 3
        LSL     R0, R0, #1
        SUBS    R0, R0, #1
        B       sum_done

sum_done
        POP     {R4, LR}
        BX      LR
        ENDFUNC
        END
