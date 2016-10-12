; Base address of the boot sector
[org 0x7c00]

; TTY mode
mov ah, 0x0e

; Print what resides at the label
mov al, [the_secret]
int 0x10

jmp $ ; infinite loop

the_secret:
    db 'X'

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55
