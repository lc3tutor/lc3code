;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; LC3 Tutor – logicalOR.asm
;
; Takes two inputs in registers R1 and R2 and returns the bitwise
; OR of the two inputs in R2.
;
; Use:
;   To use the subroutine in your code, copy the subroutine
;   code into your program. Ensure there are no label conflicts.
;   Ensure the subroutine start is within reach of the JSR. Also,
;   ensure that you properly setup input registers before the JSR.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.ORIG x3000

    LD  R1, testVal1
	LD  R2, testVal2
	JSR bwOR
	ADD R1, R2, #0
	JSR binStr
    HALT            ; Stop the program
    
testVal1    .FILL    0x1234
testVal2    .FILL    0xF00F

;
; bwOR
;
; Description:
; Using DeMorgan inverter inputs and outputs of AND.
;
; Dependencies:
;    – None
;
; Parameters:
;    – R1, first operand.
;    - R2, second operand.
;
; Returns:
;    – R2, result of OR.
;
; End Addr. – Start Addr. = # Words used
; <0xENNN>    – <0xSNNN>      = #WN
;
bwOR
    ST  R1, bwORR1  ; Save R1 and R7
    ST  R7, bwORR7  ; Don't save R2, its returned
    
    NOT R1, R1
	NOT R2, R2
	AND R2, R2, R1
	NOT R2, R2

    LD  R1, bwORR1
    LD  R7, bwORR7  ; Restore saved registers
    RET  ; Return from subroutine

bwORR1    .FILL    0x0000
bwORR2    .FILL    0x0000
bwORR7    .FILL    0x0000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Ignore code below. Used to show the result.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; binStr
;
; Dependencies:
;    - None
;
; Parameters:
;    - R1, value to be displayed in binary.
;
; Returns:
;    - None
;
; End Addr. - Start Addr. = # Words used
; 0x3025    - 0x3004      = 33
;
binStr
    ST  R0, binStrR0    ; Save registers
    ST  R1, binStrR1    ; Make R1 read-only
    ST  R2, binStrR2
    ST  R3, binStrR3
    ST  R7, binStrR7
    
    LD  R2, MSbMask     ; Set up MSb masking
    AND R3, R3, #0
    ADD R3, R3, #-16    ; Loop counter (16 bits)
    
    binStrL1
        ADD R3, R3, #1       ; Decrement loop count
        BRp binStrS2         ; When zero, counter done
        AND R0, R2, R1       ; Checks MSb of R1
        BRz binStrS1         ; If MSb zero
        LD  R0, binStr1Ascii ; Else MSb one
        OUT                  ; Output ascii one
        ADD R1, R1, R1       ; Shift R1 left
        BR  binStrL1         ; Next iteration
    binStrS1                 ; MSb is zero
        LD  R0, binStr0Ascii ; Load zero ascii
        OUT                  ; Output ascii zero
        ADD R1, R1, R1       ; Shift R1 left
        BR  binStrL1         ; Next iteration
    binStrS2  ; Done with loop
        
    LD    R0, binStrR0    ; Restore saved registers
    LD    R1, binStrR1
    LD    R2, binStrR2
    LD    R3, binStrR3
    LD    R7, binStrR7        
    RET  ; Return from subroutine

binStrR0        .FILL    0x0000    ; Space for saved registers
binStrR1        .FILL    0x0000
binStrR2        .FILL    0x0000
binStrR3        .FILL    0x0000
binStrR7        .FILL    0x0000
MSbMask         .FILL    0x8000    ; Grabs the most sig. bit
binStr0Ascii    .FILL    #48       ; Ascii zero
binStr1Ascii    .FILL    #49       ; Ascii one

.END