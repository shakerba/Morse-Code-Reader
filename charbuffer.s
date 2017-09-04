.equ ADDR_CHAR, 0x09000000

.section .text
.global char

 movi  r5, 0x41   /* ASCII for 'A' */
 
 stbio r5,132(r3) /* character (4,1) is x + y*128 so (4 + 128 = 132) 

 