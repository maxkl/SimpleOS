; boot sector offset
[org 0x7c00]

mov bx, str_hello
call print
call printnl

mov bx, str_bye
call print
call printnl

mov dx, 0x12fe
call hexprint

; Infinite loop
jmp $

%include "print.asm"
%include "hexprint.asm"

; Data
str_hello: db 'Hello, World!', 0
str_bye: db 'See you soon.', 0

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55
