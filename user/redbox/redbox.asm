;
; LC3 Tutor - redbox.asm
;
; Basic lc3 program that prints a red box to the
; graphics display.
;
.ORIG x3000

	LD	R0, GD_START	; Starting pixel to draw.
	LD  R1, COLOR_RED	
	LD  R2, HEIGHT		; The height is our row counter.

; Outer loop is one row of pixels. Inner loop is a pixel.
OUTER_LOOP
	LD  R3, WIDTH		; The width is our column counter.
	INNER_LOOP
		STR R1, R0, #0	; Change pixel to red.
		ADD R0, R0, #1	; Move pointer to next pixel in row.
		ADD R3, R3, #-1	; Decrement column counter.
		BRp INNER_LOOP	; Loop if not end of column.
	ADD R2, R2, #-1		; Decrement row counter.
	BRnz LOOP_BREAK		; Break if last row.
	LD  R3, ROW_OFFSET	; Add row offset to pointer.
	ADD R0, R0, R3
	BR  OUTER_LOOP		; Start on next row.
LOOP_BREAK

    HALT
	
GD_START	.FILL xDDB0	; The top left of the rectangle.
COLOR_RED	.FILL x7C00 ; Color of the rectangle.
HEIGHT		.FILL #15	; Height of the rectangle.
WIDTH		.FILL #25	; Width of the rectangle.
ROW_OFFSET  .FILL #103	; Needed to move down a row.

.END