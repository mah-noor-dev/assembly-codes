.MODEL SMALL
.STACK 100H

.DATA
msg1 db "Enter a number: $"
msg2 db 13,10, "The number is even.$"
msg3 db 13,10, "The number is odd.$"

.CODE
MOV AX, @DATA
MOV DS, AX

LEA DX, msg1
MOV AH, 09H
INT 21H


ReadLoop:
MOV AH, 01H
INT 21H        

CMP AL, 0DH
JE CheckLastDigit

SUB AL, '0'    
PUSH AX        

JMP ReadLoop

CheckLastDigit:
POP AX        

MOV DX, 0
MOV CX, 2
DIV CX         

CMP DX, 0
JE Even

LEA DX, msg3
MOV AH, 09H
INT 21H
MOV AH, 4CH
INT 21H

Even:
LEA DX, msg2
MOV AH, 09H
INT 21H

MOV AH, 4CH
INT 21H
