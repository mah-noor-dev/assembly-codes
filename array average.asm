.MODEL SMALL
.STACK 100H

.DATA
    msg1 db "Enter 5 numbers (0-9): $"
    msg2 db 13,10,"Average = $"
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
    XOR BL, BL

InputLoop:
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV [DI], AL
    ADD BL, AL
    INC DI
    LOOP InputLoop

    ; Newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    ; Display Average
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV AX, 0
    MOV AL, BL
    MOV BL, 5
    DIV BL          ; AL = sum / 5

    AAM
    ADD AH, 30H
    MOV DL, AH
    MOV AH, 02H
    INT 21H

    ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
