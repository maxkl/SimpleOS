
[bits 16]
enter_pm:
        ; Disable interrupts
        cli
        ; Load GDT
        lgdt [gdt_descriptor]
        ; Set pe bit (protected mode enable) in cr0
        mov eax, cr0
        or eax, 0x1
        mov cr0, eax
        ; Far jump (by explicitely mentioning the segment)
        ; this is done to flush the CPU pipeline
        jmp CODE_SEG:init_pm

[bits 32]
init_pm:
        ; Update the segment registers
        mov ax, DATA_SEG
        mov ds, ax
        mov ss, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        ; Update stack
        mov ebp, 0x90000
        mov esp, ebp
        ; Jump to well-known label
        jmp BEGIN_PM
