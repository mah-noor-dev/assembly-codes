.MODEL SMALL
.STACK 100h

.DATA
    binary DB 8 DUP(0)     ; Reserve 8 bytes for binary digits (max for a byte)

.CODE
MAIN:
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, 25             ; Number to convert
    MOV BL, 2              ; Dividing by 2 for binary conversion
    MOV SI, 0              ; Index for binary array

binaryconversion_loop:
    XOR AH, AH             ; Clear AH before DIV to avoid division errors
    DIV BL                 ; AL / BL ? AL = Quotient, AH = Remainder
    MOV binary[SI], AH     ; Store remainder (0 or 1) in array
    INC SI
    CMP AL, 0              ; Continue if quotient ? 0
    JNE binaryconversion_loop

exit:
    MOV AH, 4Ch            ; Exit program
    INT 21h
END MAIN
