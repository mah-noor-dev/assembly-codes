.model small
.stack 100h

.data
    array  db 10, 15, 6, 15, 7, 15, 8, 9, 15, 10
           db 12, 13, 14, 15, 15, 5, 4, 3, 15, 0
    target db 10   
    count db 0

.code
main:
    mov ax, @data
    mov ds, ax

    call COUNT_OCCURRENCES     

    mov al, cl  
     mov bx, 4000h
    mov [bx], al

    add al, '0'                
    mov dl, al
    mov ah, 02h
    int 21h                    

    mov ah, 4Ch
    int 21h

COUNT_OCCURRENCES proc
    xor cx, cx
    mov si, 0

next_item:
    cmp si, 20
    jge done

    mov al, array[si]
    cmp al, target
    jne skip

    inc cx

skip:
    inc si
    jmp next_item

done:
    mov cl, cl                 
    ret
COUNT_OCCURRENCES endp

end main
