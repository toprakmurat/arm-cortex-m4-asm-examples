	AREA SUM_LOOP, CODE, READONLY
	ENTRY
	ALIGN

__main FUNCTION
	EXPORT __main

	LDR     R0, =numbers    ; R0 = address of array
	MOV     R1, #4          ; number of elements
	MOV     R2, #0          ; accumulator (sum = 0)

loop
	LDR     R3, [R0], #4    ; load value from array, then R0 += 4
	ADD     R2, R2, R3      ; sum += value
	SUBS    R1, R1, #1      ; count down
	BNE     loop            ; if not zero, repeat

	B       .               ; done
	
	; Note: It is important to align the array address 
	; if not aligned, DCD will align the address automatically
	; by adding zero bytes as padding to fit in word size.
	; therefore, there is a high chance of loading padded bytes in that case. 
	ALIGN
numbers
	DCD     1, 2, 3, 4      ; array
	END
