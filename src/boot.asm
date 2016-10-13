
; Boot sector offset
[org 0x7c00]

; Offset of the kernel main routine
KERNEL_OFFSET equ 0x1000

; Save the boot drive number for later use
mov [BOOT_DRIVE], dl

; Set up stack
mov bp, 0x9000
mov sp, bp

; Load the kernel from the hard drive
call load_kernel

; Enter protected mode (this never returns)
call enter_pm

%include "print.asm"
%include "disk.asm"
%include "gdt.asm"
%include "protected-mode.asm"

[bits 16]
load_kernel:
        ; Print a message to inform the user
        mov bx, MSG_LOAD_KERNEL
        call print
        call printnl
        ; Read the kernel from disk
        mov bx, KERNEL_OFFSET
        mov dh, 2
        mov dl, [BOOT_DRIVE]
        call disk_load
        ret

[bits 32]
; We are now in protected mode
BEGIN_PM:
        call KERNEL_OFFSET
        ; Infinite loop in case the kernel ever returns
        jmp $

; Data
BOOT_DRIVE db 0
MSG_LOAD_KERNEL db 'Loading kernel...', 0

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55
