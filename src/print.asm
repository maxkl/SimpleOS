
; Prints the string at address bx
print:
        ; Push all registers to the stack
        pusha
        start:
                ; Load the next character
                mov al, [bx]
                ; Check for '\0'
                cmp al, 0
                je done

                ; Print the character (using the BIOS)
                mov ah, 0x0e
                int 0x10

                ; Advance to next character
                inc bx
                jmp start
        done:
        ; Pop all registers
        popa
        ret

; Print \n\r
printnl:
        pusha

        mov ah, 0x0e
        ; '\n'
        mov al, 0x0a
        int 0x10
        ; '\r'
        mov al, 0x0d
        int 0x10

        popa
        ret
