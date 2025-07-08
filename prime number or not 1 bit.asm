.MODEL SMALL
.STACK 100H
.DATA
    msg1 DB "Enter a number (2-9): $"
    primeMsg DB 13,10,"It's a Prime Number.$"
    notPrimeMsg DB 13,10,"It's NOT a Prime Number.$"
.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Show prompt
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    ; Take input
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; Convert ASCII to number
    MOV BL, AL       ; Store number in BL

    CMP BL, 2        ; Special case for 2
    JE IS_PRIME

    MOV CL, 2        ; Start divisor from 2

CHECK_LOOP:
    MOV AL, BL
    MOV AH, 0
    DIV CL           ; Divide number by divisor

    CMP AH, 0        ; If divisible
    JE NOT_PRIME

    INC CL
    MOV AL, BL
    DEC AL           ; AL = number - 1
    CMP CL, AL       ; While CL <= number - 1
    JLE CHECK_LOOP

IS_PRIME:
    LEA DX, primeMsg
    MOV AH, 09H
    INT 21H
    JMP EXIT

NOT_PRIME:
    LEA DX, notPrimeMsg
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H
