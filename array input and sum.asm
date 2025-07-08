.MODEL SMALL
.STACK 100H

.DATA
    msg1    db "Enter 5 numbers (0-9): $"
    msg2    db 13,10, "Sum = $"
    newline db 13,10,'$'
    array   db 5 dup(?)

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

    
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV AL, BL
    AAM
    ADD AH, 30H
    MOV DL, AH
    MOV AH, 02H
    INT 21h  
    ADD Al, 30H
    MOV DL, Al
    MOV ah, 02H
    INT 21h
