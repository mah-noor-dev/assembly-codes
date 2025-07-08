.model small
.stack 100h

.data
    msg1 db "Enter string: $"
    msg2 db 13,10,"Total vowels: $"
    newline db 13,10,"$"

.code
main:
    mov ax, @data
    mov ds, ax

    
    lea dx, msg1
    mov ah, 09h
    int 21h

   
    mov cx, 0          
    xor bx, bx          

read_loop:
    mov ah, 01h        
    int 21h
    cmp al, 0Dh         
    je check_vowels

    push ax           
    inc cx              
    jmp read_loop

check_vowels:
    
    lea dx, newline
    mov ah, 09h
    int 21h

next_char:
    pop ax
    cmp al, 'a'
    je is_vowel
    cmp al, 'e'
    je is_vowel
    cmp al, 'i'
    je is_vowel
    cmp al, 'o'
    je is_vowel
    cmp al, 'u'
    je is_vowel
    cmp al, 'A'
    je is_vowel
    cmp al, 'E'
    je is_vowel
    cmp al, 'I'
    je is_vowel
    cmp al, 'O'
    je is_vowel
    cmp al, 'U'
    je is_vowel
    jmp skip

is_vowel:
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
