
.equ ADDR_JP2_EDGE, 0xFF20007C #address of Edge Capture register GPIO JP2
.equ ADDR_JP2_IRQ, 0x1000
.equ ADDR_JP2, 0xFF200070 #adress of JP2
.equ ADDR_LED, 0xFF200000

.section .exceptions, "ax" #ensures ISR is at 0x20

.global ISR

ISR: 

/*SAVE REGISTERS ON THE STACK*/

	movia r2, ADDR_JP2_EDGE
	ldw r2, 0(r2)
	
	rdctl et, ctl4                    /* check the interrupt pending register (ctl4) */
	beq et, r0, exit_handler
	
	movia r2, ADDR_JP2_IRQ    
	and	r2, r2, et                  /* check if the pending interrupt is from GPIO JP2 */
	beq   r2, r0, exit_handler    

	movia r2, ADDR_JP2_EDGE           /* check edge capture register from GPIO JP2 */
	ldwio et, 0(r2)
	andhi  r2, et, 0x0800        /* mask bit  (sensor 0) */ 
	beq   r2, r0, exit_handler        /* exit if sensor 0 did not interrupt */
	
sensor_0_interupt_handler:

	/*acklowledge interupt*/
	movia r2, 0xffffffff 
	movia r3, ADDR_JP2_EDGE
	stwio r2, (r3)

	/*turn on the led to test if working*/
	movia r2, ADDR_LED
	movi r3, 0xf
	stwio r3, 0(r2)
	
exit_handler:

/*POP OFF REGISTERS FROM THE STACK*/

	subi ea, ea, 4
	eret