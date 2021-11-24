        AREA question1, CODE, READONLY
        ENTRY
;R0 is for result
;R1 for data/UPC
;R2 COUNTER
;R3 for load odd pos
;R4 for load even pos
;R5 for sum of odd pos
;R6 for sum of even pos
;R7 for muliplication and result of UPC calculation


        LDR R1, =UPC ; load a reference to the UPC string into R1
ACCUM   LDRB R3, [R1], #1 ; load the odd positioned numbers of the string as a byte to r3 starting from the first one
		SUB R3, #0x30 ; clear the offset betwen the actual value in decimal and the representation in ASCII
		ADD R5, R3 ; add the value of stored in r3 to the r5, which contain the previous loaded value of R3
        LDRB R4, [R1], #1 ; load the even positioned numbers of the string as a byte to r3 starting from the first one
		SUB R4, #0x30 ; clear the offset betwen the actual value in decimal and the representation in ASCII
		ADD R6, R4 ; add the value of stored in r4 to the r6, which contain the previous loaded value of R4
        ADD R2, #2 ; increment the counter by 2
        CMP R2, #0xC ; compared to the length of the UPC string
		BNE ACCUM ; loop if it is not equal to 0
		
		MOV R7, #3          ; move the multiplier 3 to r7
		MLA R7, R5, R7, R6  ; multiply the of odd positioned number by 3 and add it to the odd positioned number and store the result in r7
							; note that the odd positioned number contain the check digit
      
MINUS	SUBS R7, #10;       ; check if the sum is a multtiple of 10 by subtracting 10 from it
		BGT MINUS           ; loop if the result is greater than 10
		MOVEQ R0, #1        ; Load 1 into register 0 if the string is a UPC
		MOVNE R0, #2        ; Load 2 into register 0 if the string is NOT a UPC
loop    B loop	 

	    AREA question1, DATA, READONLY
UPC     DCB "013800150738" ;correct UPC string

UPC2    DCB "060383755577" ;correct UPC string
UPC3    DCB "065633454712" ;correct UPC string 
	    END
