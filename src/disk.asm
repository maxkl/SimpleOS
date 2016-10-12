
disk_load:
        pusha

        push dx

        ; read
        mov ah, 0x02
        ; number of sectors to read
        mov al, dh
        ; Sector to read from (0x01 is boot sector)
        mov cl, 0x02
        ; Cylinder
        mov ch, 0x00
        ; Drive number
        ; mov dl, 0x00
        ; Head number
        mov dh, 0x00

        ; Read from disk
        ; result is written to es:bx
        int 0x13
        ; Jump on error (carry bit set = error)
        jc disk_error

        pop dx
        ; al contains number of read sectors
        cmp al, dh
        jne sectors_error

        popa
        ret

disk_error:
        mov bx, DISK_ERROR
        call print
        call printnl

        mov dh, ah
        ; Print error
        ; dl still contains the number of the drive the error occured on
        ; for description see http://stanislavs.org/helppc/int_13-1.html
        call hexprint

        jmp disk_loop

sectors_error:
        mov bx, SECTORS_ERROR
        call print
        call printnl

disk_loop:
        jmp $

DISK_ERROR: db 'Disk read error', 0
SECTORS_ERROR: db 'Incorrect number of sectors read', 0
