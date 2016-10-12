[bits 32]

VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print:
        pusha

        ; Load address of video memory
        mov edx, VIDEO_MEM
        print_loop:
                ; Load the next character
                mov al, [ebx]

                ; Check for '\0'
                cmp al, 0
                je print_end

                ; Set color for character
                mov ah, WHITE_ON_BLACK
                ; Store character to video memory
                mov [edx], ax

                ; advance to next character
                inc ebx
                ; increment video memory address
                ; each character in video memory is 2 bytes
                add edx, 2

                jmp print_loop

        print_end:
        popa
        ret
