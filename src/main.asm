
; Boot sector offset
[org 0x7c00]

; Set up stack at 0x8000
mov bp, 0x8000
mov sp, bp

mov bx, 0x9000
mov dh, 2
call disk_load

; Print first loaded word
mov dx, [0x9000]
call hexprint
call printnl

; Print first loaded word of second sector
mov dx, [0x9000 + 512]
call hexprint
call printnl

; Infinite loop
jmp $

%include "print.asm"
%include "hexprint.asm"
%include "disk.asm"

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55

; Some data so that we have something to read
; Sector 2
times 256 dw 0xdada
; Sector 3
times 256 dw 0xface
