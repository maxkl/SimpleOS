
; Boot sector offset
[org 0x7c00]

; Set up stack at 0x8000
mov bp, 0x9000
mov sp, bp

; Enter protected mode
call enter_pm

; Infinite loop
jmp $

%include "print.asm"
%include "gdt.asm"
%include "protected-mode.asm"

[bits 32]
; This will be called after entering protected mode
BEGIN_PM:
        mov ebx, MSG
        call print
        ; Infinite loop
        jmp $

; Test message
MSG: db 'Hi from protected mode!', 0

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55
