.model small
.stack 100h
.data
    string db 'assembly is fun5$'  ; '$' used to terminate the string

.code
main:
    mov ax, @data
    mov ds, ax

    lea si, string          ; SI points to start of string

    call TO_UPPER           ; Call the procedure

    mov ah, 09h             ; DOS function to print string
    lea dx, string
    int 21h

    mov ah, 4ch             ; Exit to DOS
    int 21h


TO_UPPER proc
    start_loop:
        mov al, [si]        ; Load current character
        cmp al, '$'         ; Check for end of string
        je end_proc

        cmp al, 'a'         ; Check if character >= 'a'
        jb not_lower
        cmp al, 'z'         ; Check if character <= 'z'
        ja not_lower

        sub al, 20h         ; Convert to uppercase (ASCII logic)
        mov [si], al        ; Replace character in string

    not_lower:
        inc si              ; Move to next character
        jmp start_loop

    end_proc:
        ret
TO_UPPER endp

end main