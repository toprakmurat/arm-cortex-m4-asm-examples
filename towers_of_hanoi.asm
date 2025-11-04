        AREA    TowersOfHanoi, CODE, READONLY
        ENTRY
        ALIGN
__main  FUNCTION
        EXPORT  __main

        MOVS    R0, #7          ; n = 7
        BL      hanoi
        B       .               ; done, result in R0

;------------------------------------
; T(n):
;   if n == 1 ? return 1
;   else return 2*T(n - 1) + 1
;------------------------------------
hanoi
        PUSH    {R0, LR}        ; save n and return address

        CMP     R0, #1
        BEQ     base_case

        SUB     R0, R0, #1      ; n - 1
        BL      hanoi           ; call recursively

        MOV     R1, R0          ; store result T(n-1)
        POP     {R0, LR}        ; restore n and LR

        LSL     R1, R1, #1      ; 2 * T(n-1)
        ADD     R0, R1, #1      ; +1 = 2*T(n-1)+1
        BX      LR

base_case
        MOVS    R0, #1
        POP     {R1, LR}        ; pop discarded n and LR
        BX      LR
