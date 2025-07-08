.MODEL SMALL
.STACK 100H

.DATA
    msg1    db "Enter a string  :$"
    msg2    db 13,10, "The reverse string is :$"
    newline db 13,10, '$'

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Print "Enter a string"
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    MOV CX, 0  ; Counter for characters

Input:
    MOV AH, 01H
    INT 21H       ; Read a character from user

    CMP AL, 0DH   ; Check for Enter key (carriage return)
    JE PRINT

    PUSH AX       ; Push the character onto the stack
    INC CX        ; Count the character
    JMP Input

PRINT:
    ; New line using variable
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Print "The reverse string is :"
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    ; New line again using variable
    LEA DX, newline
    MOV AH, 09H
    INT 21H

Reverse:
    POP DX
    MOV AH, 02H
    INT 21H
    LOOP Reverse

    MOV AH, 4CH
    INT 21H
