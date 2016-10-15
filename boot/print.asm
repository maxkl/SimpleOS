
; Print a string at bx in 16-bit real mode using BIOS
print:
        pusha
        ; print to TTY
        mov ah, 0x0e
        ; Loop until the whole string has been printed
        print_loop:
                mov al, [bx]
                ; Check if we reached '\0'
                cmp al, 0
                je print_end
                ; Print the character
                int 0x10
                ; Advance to next character
                inc bx
                jmp print_loop
        print_end:
        popa
        ret

; Print '\r\n'
printnl:
        pusha
        mov ah, 0x0e
        ; '\r'
        mov al, 0x0d
        int 0x10
        ; '\n'
        mov al, 0x0a
        int 0x10
        popa
        ret

; Print dx in hex format
hexprint:
        pusha
        ; Index variable
        mov cx, 0
        hex_loop:
                ; Loop 4 times
                cmp cx, 4
                je end

                ; Convert last char of dx to ASCII
                ; ax as working register
                mov ax, dx
                ; Mask
                and ax, 0x000f
                ; To ASCII
                add al, 0x30
                ; Add 7 extra if al is greater than '9' to get 'A' to 'F'
                cmp al, 0x39
                jle step2
                add al, 7
                step2:
                ; Get correct position of the string to place our ASCII char
                mov bx, HEX_OUT + 5
                sub bx, cx
                ; Copy to the string
                mov [bx], al
                ; Rotate right so that the current 2nd char is now the first
                ror dx, 4
                ; Increment index and loop
                inc cx
                jmp hex_loop
        end:
        mov bx, HEX_OUT
        call print
        popa
        ret

HEX_OUT: db '0x0000', 0
