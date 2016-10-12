; Infinite loop (E9 FD FF)
loop:
	jmp loop

; Fill with 510 times 00 minus the prevoius code
times 510-($-$$) db 0

; Magic number
dw 0xAA55
