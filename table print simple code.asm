.MODEL SMALL
.STACK 100H
.DATA
    msg  DB "Enter number (1-9): $"
    newline DB 13,10,"$"
.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    ; Show prompt
    LEA DX, msg
    MOV AH, 09H
    INT 21H

    ; Take input
    MOV AH, 01H
    INT 21H
    SUB AL, 30H        ; Convert ASCII to number
    MOV BL, AL         ; Store number in BL

    ; Initialize counter
    MOV CL, 1          ; Counter from 1 to 10

TABLE_LOOP:
    MOV AL, BL         ; AL = input number
    MUL CL             ; AL * CL => AX

    PUSH AX            ; Save result for printing

    ; Print line (like: 5 * 2 = 10)

    ; Print input number (BL)
    MOV AL, BL
    CALL PRINT_NUM

    ; Print " * "
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '*'
    INT 21H
    MOV DL, ' '
    INT 21H

    ; Print counter (CL)
    MOV AH, 0     ; Clear high byte of AX
MOV AL, CL    ; Now AX = 00CL
CALL PRINT_NUM

    ; Print " = "
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV DL, '='
    INT 21H
    MOV DL, ' '
    INT 21H

    ; Print result from stack (AX)
    POP AX
    CALL PRINT_NUM

    ; Newline
    LEA DX, newline
    MOV AH, 09H
    INT 21H

    INC CL
    CMP CL, 11
    JNZ TABLE_LOOP

   
    MOV AH, 4CH
    INT 21H

; Print Number in AL or AX
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX
    MOV BX, 10

CONVERT_LOOP:
    XOR DX, DX
    DIV BX         ; AX / 10, remainder in DX
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

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

END MAIN
