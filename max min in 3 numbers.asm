.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB "Enter First Number: $"
    MSG2 DB 10,13,"Enter Second Number: $"
    MSG3 DB 10,13,"Enter Third Number: $"
    MSG4 DB 10,13,"Maximum: $"
    MSG5 DB 10,13,"Minimum: $"

.CODE
MAIN:
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for first number                                               
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Read first character (as input number)
    MOV AH, 01H
    INT 21H
    MOV BH, AL           ; Store in BH

    ; Prompt for second number
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H

    ; Read second character
    MOV AH, 01H
    INT 21H
    MOV BL, AL           ; Store in BL

    ; Prompt for third number
    LEA DX, MSG3
    MOV AH, 09H
    INT 21H

    ; Read third character
    MOV AH, 01H
    INT 21H
    MOV CH, AL           ; Store in CH

    ; Display "Maximum: "
    LEA DX, MSG4
    MOV AH, 09H
    INT 21H

    ; Compare to find maximum
    CMP BH, BL
    JA BH_GREATER        ; If BH > BL, check BH vs CH
    CMP BL, CH
    JA PRINT_BL          ; If BL > CH, BL is max
    MOV DL, CH           ; Else CH is max
    JMP PRINT_MAX

BH_GREATER:
    CMP BH, CH
    JA PRINT_BH          ; If BH > CH, BH is max
    MOV DL, CH           ; Else CH is max
    JMP PRINT_MAX

PRINT_BH:
    MOV DL, BH
    JMP PRINT_MAX

PRINT_BL:
    MOV DL, BL
    JMP PRINT_MAX

PRINT_MAX:
    ; Print max character
    MOV AH, 02H
    INT 21H

    ; Display "Minimum: "
    LEA DX, MSG5
    MOV AH, 09H
    INT 21H

    ; Compare to find minimum
    CMP BH, BL
    JB BH_SMALLER        ; If BH < BL, check BH vs CH
    CMP BL, CH
    JB PRINT_BL_MIN      ; If BL < CH, BL is min
    MOV DL, CH           ; Else CH is min
    JMP PRINT_MIN

BH_SMALLER:
    CMP BH, CH
    JB PRINT_BH_MIN      ; If BH < CH, BH is min
    MOV DL, CH           ; Else CH is min
    JMP PRINT_MIN

PRINT_BH_MIN:
    MOV DL, BH
    JMP PRINT_MIN

PRINT_BL_MIN:
    MOV DL, BL
    JMP PRINT_MIN

PRINT_MIN:
    ; Print min character
    MOV AH, 02H
    INT 21H

    ; Terminate program
    MOV AH, 4CH
    INT 21H
