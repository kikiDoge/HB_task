DATA SEGMENT
	FILEP DB '1.txt', 0
	ERRS DB 'File Error', '$'
	SUSS DB 'HAHAH', '$'
	READBUF DB 256 DUP('0')
	HANDLE DW ?
DATA ENDS

STACK SEGMENT
	BUF DW 20h DUP(?)
	STTOP LABEL WORD
STACK ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK
START:
	MOV AX, DATA
	MOV DS, AX
	
	MOV AX, STACK
	MOV SS, AX
	LEA SP, STTOP
	
	MOV AH, 3DH
	MOV AL, 0
	LEA DX, FILEP
	INT 21H
	
	JC ERR
	
	MOV BX, AX
	MOV HANDLE, BX
	MOV AH, 3FH
	LEA DX, READBUF
	MOV CX, 256
	INT 21H
	
	MOV BX, AX
	MOV CH, '$'
	MOV READBUF[BX], CH
	MOV BX, HANDLE
	
	MOV AH, 3EH
	INT 21H
	
	MOV AH, 09H
	LEA DX, READBUF
	INT 21H
	MOV AH, 09H
	INT 21H
	JMP EXIT
	
ERR:
	MOV AH, 09H
	LEA DX, ERRS
	INT 21H
	
EXIT:
	MOV AH,1
	INT 21H
	MOV AX, 4C00H
	INT 21H
CODE ENDS
	END START

	
