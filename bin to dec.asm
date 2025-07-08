.stack 100h
.model small

.data
msg1 db "Enter binary number : $"      
msg2 db 13,10,"Decimal is: $"

.code
main:
    mov ax, @data
    mov ds, ax

    ; Print prompt
    lea dx, msg1
    mov ah, 9
    int 21h

    xor bx, bx      ; Result = 0

read_binary:
    mov ah, 1       ; Read char
    int 21h

    cmp al, 13      ; Enter pressed
    je show_result

    cmp al, '0'
    jl invalid
    cmp al, '1'
    jg invalid      ; Only accept 0 or 1

    sub al, '0'     ; Convert ASCII to number (0 or 1)
    
    shl bx, 1       ; Multiply BX by 2
    xor ah, ah      ; Clear AH to prevent garbage in AX
    add bx, ax      ; Add bit to result (use AX safely)
    jmp read_binary

invalid:
    ; Exit on invalid input
    mov ah, 4ch
    int 21h

show_result:
    lea dx, msg2
    mov ah, 9
    int 21h

    mov ax, bx
    xor cx, cx
    mov si, 10

decimal_loop:
    xor dx, dx
    div si          ; AX ÷ 10, quotient in AX, remainder in DX
    push dx
    inc cx
    cmp ax, 0
    jne decimal_loop

print_decimal:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_decimal

    ; Exit
    mov ah, 4ch
    int 21h
