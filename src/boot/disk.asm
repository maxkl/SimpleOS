
; Read dh sectors to [es:bx] from disk dl
disk_load:
        pusha

        ; Store dx
        push dx

        ; Function = read
        mov ah, 0x02
        ; Number of sectors to read
        mov al, dh
        ; Start sector
        mov cl, 0x02
        ; Start cylinder
        mov ch, 0x00
        ; Drive number
        ; mov dl, dl
        ; Head number
        mov dh, 0x00

        ; read data an store it to [es:bx]
        int 0x13
        ; Carry is set if an error occured
        jc disk_error

        pop dx
        ; al contains the number of sectors read
        ; print an error message if we did not get the number of sectors we requested
        cmp al, dh
        jne sectors_error

        popa
        ret


disk_error:
        mov bx, DISK_ERROR
        call print
        call printnl
        ; ah = error code, dl = drive on which the error occured
        mov dh, ah
        ; Possible error codes: http://stanislavs.org/helppc/int_13-1.html
        call hexprint
        jmp disk_loop

sectors_error:
        mov bx, SECTORS_ERROR
        call print

disk_loop:
        jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
