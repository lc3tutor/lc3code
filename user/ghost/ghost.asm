;
; LC3 Tutor - ghost.asm
;
; The LC3 image redghost.asm is loaded into memory at 0x5000.
; This program copies the image data from the location at 0x5000
; into the graphics display memory between 0xC000 and 0xFFEE.
;
; This code is not optimized. Feel free to edit and use this
; code in your program.
;
.ORIG x3000

    LD R0, disLoc
    LD R1, picAdr
    LD R4, hei

Loop1 ; Loop for each row.
    LD R2, wid ; Reload counter each loop.
    Loop2 ; Loop for each pixel.
    	LDR R3, R1, #0 ; This code loads the color from memory,
        STR R3, R0, #0 ; Then stores that in the graphics display
        ADD R1, R1, #1 ; memory.
        ADD R0, R0, #1
        ADD R2, R2, #-1
        BRp Loop2
    LD R2, nxtLine
    ADD R0, R0, R2
    ADD R4, R4, #-1
    BRp Loop1

    HALT
	
disLoc  .FILL   xC555   ; Where the top left of image is on display.
picAdr  .FILL   x5000   ; Where the image exist in the LC3 memory.
wid     .FILL   #14     ; Width of the image.
hei     .FILL   #14     ; Height of the image.
nxtLine .FILL   #114    ; Used to calculate the beginning of the next row of image.

.END