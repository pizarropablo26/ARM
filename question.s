

            AREA question2,CODE, READONLY
            ENTRY

Capital_T     EQU     0x54        ; constant for capital 'T'
lower_t       EQU     0x74        ; constant for lower   't'
lower_h       EQU     0x68        ; constant for lower   'h'
lower_e       EQU     0x65        ; constant for lower   'e'
aspace        EQU     0x20        ; constant for a space ' '

	      ADR     r0, STRING1  ; load the thing to be manipulated in r1            
              ADR     r1, STRING2  ; load empty string to r2         
accum         LDRB    R2,[R0],#1   ; load the first character of the string
			  
	      CMP     R2,#0x00     ; compare if the string is empty
              BEQ     EXIT         ; if it is the exit the program


              CMP     R2,#lower_t  ; compare if the letter loaded is a 't'
store         STRBNE  R2,[R1],#1   ; store the first letter in memory if it is not equal
              BNE     accum        ; increase the pointer to the next letter
	      LDRBEQ  R3,[R0],#1   ; if it is load the next letter
	      CMPEQ   R3,#lower_h  ; compare if the letter loaded is 'h'
              BNE     wordwith_t   ; branch if the word only start with 't'
              LDRBEQ  R4,[R0],#1   ; if it is then load the next letter
              CMPEQ   R4,#lower_e  ; compare if the letter is 'e'
              BNE     wordwith_th  ; branch if the word only start with 'th'
              LDRBEQ  R5,[R0],#1   ; load the next letter/character if it is a 'e'
              CMPEQ   R5,#aspace   ; check if it is a space  
	      STRBEQ  R5,[R1],#1   ; store the space if the next character is a space
	      BEQ     accum        ; loop for the next character
	      CMPNE   R5,#0x00     ; if it is not a space, check if it is 
	      BEQ     loop         ; exit if the if the string has been fully transversed
              BNE     wordwith_the  ; if it is not a space, then it will branch out and store the previous letter in memory
			 
              


wordwith_the  STRB   R2,[R1],#1    ; store 't'
wordwith_th   STRB   R3,[R1],#1    ; store 'h'
wordwith_t    STRB   R4,[R1],#1    ; store 'e'
	      STRB   R5,[R1],#1    ; store whatever letter comes after 'e'
              B     accum          ; increase pointer


loop          B       loop

	      AREA question2, DATA, READONLY
STRING1       DCB "and the man said they must go";String1
EoS DCB       0x00 ;end of string1
              ALIGN
STRING2       space 0x7F ;just allocating 127 bytes 

              END
