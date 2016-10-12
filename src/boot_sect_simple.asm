; TTY mode
mov ah, 0x0e

; Init stack at 0x8000
mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

mov al, [0x7ffe] ; 0x8000 - 2 = 0x7ffe
int 0x10

mov al, [0x8000]
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x8000]
int 0x10

jmp $ ; infinite loop

the_secret:
    db 'X'

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55
