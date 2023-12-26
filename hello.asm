;
; LC3 Tutor - hello.asm
;
; Basic lc3 program that prints "Hello World!"
; to the console.
;
.ORIG x3000 ; Program begins at x3000.

    LEA R0, prompt1 ; Semi-colons are used to create comments.
    PUTS ; This prints the string prompt1. It is an OS call.

    HALT ; The program is done, all objectives met.
	
prompt1	.STRINGZ "Hello World!"	; String variable.
	
.END ; Indicates the end of the assembly file.