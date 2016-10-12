; TTY mode
mov ah, 0x0e

; cs -> Code Segment
; ds -> Data Segment
; ss -> Stack Segment
; es -> Extra Segment
; fs, gs -> General Purpose Segments

; This implicitly uses ds as the segment (ds:the_secret)
; ds is 0x0000 initially so we are accessing 0x0000:the_secret
mov al, [the_secret]
int 0x10

; Set ds to the right value
; the segment address is left-shifted 4 bits, so the segment really starts at 0x7c00
; also, the segment registers can not be mov'ed to so we have to use an intermediate register
mov bx, 0x7c0
mov ds, bx

; Now try again, this should work
mov al, [the_secret]
int 0x10

; Explicitly select es as the segment
; es is 0x0000, so we are essentially accessing 0x0000:the_secret
mov al, [es:the_secret]
int 0x10

; Set es to the correct value so that es:the_secret really points to the_secret
mov bx, 0x7c0
mov es, bx

; Print the_secret using es as the segment
; this should work, too
mov al, [es:the_secret]
int 0x10

; Infinite loop
jmp $

; Data
the_secret: db 'X'

; Zero padding
times 510 - ($-$$) db 0
; Magic bios number
dw 0xaa55
