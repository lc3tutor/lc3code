;
; LC3 Tutor - redbox.asm
;
; Basic lc3 program that prints a red box to the
; graphics display.
;
.ORIG x3000

	LD	R0, GD_START
	LD  R1, COLOR_RED
	STR R1, R0, #0
	LD  R2, HEIGHT
OUTER_LOOP
	LD  R3, WIDTH
	INNER_LOOP
		STR R1, R0, #0
		ADD R0, R0, #1
		ADD R3, R3, #-1
		BRp INNER_LOOP
	ADD R2, R2, #-1
	BRnz LOOP_BREAK
	LD  R3, ROW_OFFSET
	ADD R0, R0, R3
	BR  OUTER_LOOP
LOOP_BREAK

    HALT
	
GD_START	.FILL xDDB0
COLOR_RED	.FILL x7C00
HEIGHT		.FILL #15
WIDTH		.FILL #25
ROW_OFFSET  .FILL #103

.END