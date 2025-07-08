                                   .model small
.stack 100h

.data
    msg1 db "Enter string: $"
    msg2 db 13,10,"Total a's: $"
    newline db 13,10,"$"

.code
main:
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    mov ah, 09h
    int 21h

    mov cx, 0
    xor bx, bx    ; count of 'a'

read_loop:
    mov ah, 01h
    int 21h
    cmp al, 0Dh
    je check_a

    push ax
    inc cx
    jmp read_loop

check_a:
    lea dx, newline
    mov ah, 09h
    int 21h

next_char:
    pop ax
    cmp al, 'a'
    je is_a
    jmp skip

is_a:
    inc bx

skip:
    loop next_char

    lea dx, msg2
    mov ah, 09h
    int 21h

    mov ax, bx
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    mov ah, 4Ch
    int 21h
end main
