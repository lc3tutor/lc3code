;
; LC3 Tutor - bin2str.asm
;
; Value to binary string. Program bin2str shows the proper use
; of the binStr assembly subroutine. First R1 is loaded with
; a test value called testVal. Then the binStr subroutine is
; called that will display the value as a binary string in the
; console without changing R1.
;
; This code is not optimized. Feel free to edit and use this
; code in your program.
;
; To use the subroutine in your code, copy the binStr subroutine
; code into your program. There should not be any label conflicts.
; Ensure the subroutine start is within reach of the JSR. Also,
; ensure that you properly setup R1 before the JSR.
;
.ORIG x3000

    LD  R1, testVal ; Setup R1 with value
    JSR binStr      ; Call the subroutine
    HALT            ; Stop the program
    
testVal .FILL    0x5A4D        ; Value to print to display

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