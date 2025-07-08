.MODEL SMALL
.STACK 100H

.DATA
    msg1 db 'Enter 4-bit binary: $'
    msg2 db 13,10, 'Decimal = $'
    newline db 13,10,'$'

.CODE
MAIN:
    mov ax, @data
    mov ds, ax

    ; Show message
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Initialize
    xor bx, bx     ; will store final result
    mov cx, 4      ; we will take 4 bits

READ_LOOP:
    mov ah, 01h
    int 21h        ; get input char
    sub al, 30h    ; '0' ? 0, '1' ? 1

    shl bx, 1      ; multiply result by 2
    add bl, al     ; add new bit

    loop READ_LOOP

    ; Print newline and message
    lea dx, newline
    mov ah, 09h
    int 21h

    lea dx, msg2
    mov ah, 09h
    int 21h

    ; Now print decimal value (in BX)
    mov ax, bx
    call PRINT_DECIMAL

    ; Exit
    mov ah, 4ch
    int 21h

; ----- Decimal Print Procedure (Just Prints 0-99 max) -----
PRINT_DECIMAL PROC
    xor cx, cx

    divide_loop:
        xor dx, dx
        mov bx, 10
        div bx         ; AX / 10
        push dx        ; remainder
        inc cx
        cmp ax, 0
        jne divide_loop

    print_loop:
        pop dx
        add dl, 30h
        mov ah, 02h
        int 21h
        loop print_loop

    ret
PRINT_DECIMAL ENDP

END MAIN
