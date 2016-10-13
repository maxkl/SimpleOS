[bits 32]

; Call kernel main routine
[extern kernel_main]
call kernel_main

jmp $
