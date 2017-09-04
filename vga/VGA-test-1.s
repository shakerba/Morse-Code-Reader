
.data

A: .incbin "Untitled1.raw"


.global main
main:

 .equ ADDR_VGA, 0x08000000


  movia r2,ADDR_VGA
 
  movui r3,0x0140 #320 to the address value of the VGA
  movui r6, 0x00f0 #240 
  mov r7,r0
  mov r8,r0
  mov r9,r2
  movia r10,1024
  movia r11,2
  
 # movui r4,0xffff  /* White pixel */
  movia r5, A 
  mov r4, r2
 # call printImage
  
  

  Loop2:
  Loop1: #going upto 0 0 to 320 0
  
  ldh r4,(r5)
  
  sthio r4,(r9)

 
  addi r7,r7,1
  addi r5,r5,16
  mul r11,r11,r7
  mul r10,r10,r8 
  mov r9,r2
  add r9,r9,r11
  add r9,r9,r10

  blt r7,r3,Loop1
  
  mov r7,r0
  addi r8,r8,1
  
  blt r8,r6,Loop2
  
  #sthio r4,1032(r2) /* pixel (4,1) is x*2 + y*1024 so (8 + 1024 = 1032) 
  
  LOOP1:
  
	


  
LOOP:


br LOOP

