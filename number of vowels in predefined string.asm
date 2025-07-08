.MODEL SMALL
.STACK 100h

.DATA
    str     db "HELLO WORLD$", 0
    msg1    db 10,13, "Original string: HELLO WORLD$", 0
    msg2    db 10,13, "Total vowels in string: $"
    newline db 10,13, "$"

.CODE
main:
    mov ax, @data
    mov ds, ax

    ; Print original string message
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Push string chars to stack (until '$')
    lea si, str
    mov cx, 0             ; char count

push_loop:
    mov al, [si]
    cmp al, '$'
    je start_counting
    push ax
    inc si
    inc cx
    jmp push_loop

start_counting:
    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    xor bx, bx            ; vowel count = 0

count_loop:
    pop ax
    cmp al, 'a'
    je vowel_inc
    cmp al, 'e'
    je vowel_inc
    cmp al, 'i'
    je vowel_inc
    cmp al, 'o'
    je vowel_inc
    cmp al, 'u'
    je vowel_inc
    cmp al, 'A'
    je vowel_inc
    cmp al, 'E'
    je vowel_inc
    cmp al, 'I'
    je vowel_inc
    cmp al, 'O'
    je vowel_inc
    cmp al, 'U'
    je vowel_inc
    jmp skip_vowel

vowel_inc:
    inc bx

skip_vowel:
    loop count_loop

    ; Print total vowels message
    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Convert vowel count (bx) to ASCII and print
    mov ax, bx
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h

END main
