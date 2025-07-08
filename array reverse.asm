.MODEL SMALL
.STACK 100H

.DATA
    msg1 db "Enter 5 numbers (0-9): $"
    msg2 db 13,10,"Reverse = $"
    newline db 13,10,'$'
    array db 5 dup(?)

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    LEA DI, array
    MOV CX, 5

InputLoop:
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV [DI], AL
    INC DI
    LOOP InputLoop

    ; Print reverse
    LEA DX, newline
    MOV AH, 09H
    INT 21H
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    LEA SI, array
    ADD SI, 4
    MOV CX, 5

PrintReverse:
    MOV DL, [SI]
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    DEC SI
    LOOP PrintReverse

    MOV AH, 4CH
    INT 21H
