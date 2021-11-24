       AREA question2,CODE, READONLY
       ENTRY
	   ADR r0, STRING1
	   














		AREA question2, DATA, READONLY
STRING1 DCB “and the man said they must go”;String1
EoS DCB 0x00 ;end of string1
STRING2 space 0x7F ;just allocating 127 bytes 