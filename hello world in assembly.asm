.data
 string1 db "HELLO WORLD$"
.code
main:
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    mov dx,offset string1
    int 21h
end main