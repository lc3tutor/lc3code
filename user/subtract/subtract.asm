;
; LC3 Tutor - subtract.asm
;
; Creates two numerical values and subtracts them.
; This program doesn't do anything useful. The purpose
; of this program is to show case ADD, AND, and NOT.
;
.ORIG x3000 ; Program begins at x3000.

    AND R0, R0, #0 ; Clear R0, R0 -> zero.
	AND R1, R1, R0 ; Use R0 to clear R1.
	
	ADD R0, R0, #9 ; Put #9 in R0.
	ADD R1, R1, #10
	ADD R1, R1, #11 ; Put #21 in R1. Need two ADDs.

	NOT R1, R1
	ADD R1, R1, #1 ; Put #-21 in R1.
	
	ADD R0, R0, R1 ; R0 = #-12 = #9 + #-21
	; You can check that R0 is xFFEB.

    HALT

.END