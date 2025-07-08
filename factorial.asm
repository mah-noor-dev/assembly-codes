.MODEL SMALL
.STACK 100H
.DATA
    msg DB "Enter number (1-9): $"
    msg2 DB 13,10,"Factorial is: $"
.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Input prompt
    LEA DX, msg
    MOV AH, 09H
    INT 21H

    ; Input
    MOV AH, 01H
    INT 21H
    SUB AL, 30H       ; Convert ASCII to number
    MOV BL, AL
    MOV AX, 1         ; Result = 1

    ; Multiply loop
FACTORIAL_LOOP:
    MUL BL            ; AX = AX * BL
    PUSH AX           ; Store result (intermediate)
    DEC BL
    CMP BL, 0
    JNZ FACTORIAL_LOOP

    ; Output label
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    ; Final result is on top of stack
    POP AX

    ; Convert to digits & print
    MOV CX, 0
    MOV BX, 10

CONVERT_LOOP:
    XOR DX, DX
    DIV BX           ; AX / 10, remainder in DX
    PUSH DX
    INC CX
    CMP AX, 0
    JNZ CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    LOOP PRINT_LOOP

    MOV AH, 4CH
    INT 21H
