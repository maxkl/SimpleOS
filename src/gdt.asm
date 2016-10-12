
gdt_start:
        ; NULL descriptor
        dd 0
        dd 0

gdt_code:
        ; Segment length (bits 0-15)
        dw 0xffff
        ; Segment base (bits 0-15)
        dw 0x0000
        ; Segment base (bits 16-23)
        db 0x00
        ; Flags (8 bits): Code, Read+Exec
        db 10011010b
        ; Flags (4 bits) & segment length (bits 16-19)
        db 11001111b
        ; Segment base (bits 24-31)
        db 0x00

gdt_data:
        ; Segment length (bits 0-15)
        dw 0xffff
        ; Segment base (bits 0-15)
        dw 0x0000
        ; Segment base (bits 16-23)
        db 0x00
        ; Flags (8 bits): Data, RW
        db 10010010b
        ; Flags (4 bits) & segment length (bits 16-19)
        db 11001111b
        ; Segment base (bits 24-31)
        db 0x00

gdt_end:

gdt_descriptor:
        ; GDT size - 1 (16 bits)
        dw gdt_end - gdt_start - 1
        ; GDT address
        dd gdt_start

; Segment numbers
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
