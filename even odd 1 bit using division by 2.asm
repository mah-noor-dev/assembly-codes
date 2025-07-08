.model small
.stack 100h
.data
    msg1 db "enter a one digit number : $"
    msg2 db 10,13,"your number was even !$"
    msg3 db 10,13,"your number was odd ! $"
.code
main: 
    mov ax,@data
    mov ds,ax
    
    
    mov dx,offset msg1
    mov ah,09h
    int 21h
                  
    mov ah,01h
    int 21h
    mov bl,2
    div bl
    cmp ah,0
    je even
    mov dx,offset msg3 
    mov ah,09h
    int 21h
    mov ah,4ch 
    int 21h
    
    
even: 
    mov dx,offset msg2
    mov ah ,09h
    int 21h   
    mov ah,4ch
    int 21h
    
    
    
