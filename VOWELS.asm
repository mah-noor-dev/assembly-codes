.MODEL SMALL
.STACK 100H
.DATA
    msg1 db "Enter a string: $"
    msg2 db 0dh,0ah,"Vowels: $"
    newline db 0dh,0ah,"$"
    count db 0
    num dw 0

.CODE
main:
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, msg1
    int 21h

    mov si, 0

L:
    mov ah, 01h
    int 21h
    cmp al, 0dh
    je l2
    push ax
    inc num
    jmp L

l2:
    mov ah, 09h
    lea dx, msg2
    int 21h

    mov cx, num

L3:
    pop ax
    mov bl, al
    cmp bl, 'A'
    je countv
    cmp bl, 'E'
    je countv
    cmp bl, 'I'
    je countv
    cmp bl, 'O'
    je countv
    cmp bl, 'U'
    je countv
    cmp bl, 'a'
    je countv
    cmp bl, 'e'
    je countv
    cmp bl, 'i'
    je countv
    cmp bl, 'o'
    je countv
    cmp bl, 'u'
    je countv
    jmp skip

countv:
    mov dl, bl
    mov ah, 02h
    int 21h
    inc count
    jmp skip

skip:
    loop L3

    mov dl, count
    add dl, 30h
    mov ah, 02h
    int 21h

    mov ah, 4ch
    int 21h
