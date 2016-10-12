; TTY mode
mov ah, 0x0e
; Character to print
mov al, 'A'
; General interrupt for video services
int 0x10
mov al, 's'
int 0x10
mov al, 'd'
int 0x10
mov al, 'f'
int 0x10

; Jump to the current address (infinite loop)
jmp $

; Fill with 510 times 00 minus the prevoius code
times 510 - ($-$$) db 0

; Magic number
dw 0xaa55
