[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
[FILE "fifo.c"]
[SECTION .text]
	GLOBAL	_fifo32_init
_fifo32_init:
	PUSH	EBP
	MOV	EBP,ESP
	MOV	EAX,DWORD [8+EBP]
	MOV	ECX,DWORD [12+EBP]
	MOV	EDX,DWORD [16+EBP]
	MOV	DWORD [12+EAX],ECX
	MOV	DWORD [EAX],EDX
	MOV	DWORD [16+EAX],ECX
	MOV	DWORD [20+EAX],0
	MOV	DWORD [4+EAX],0
	MOV	DWORD [8+EAX],0
	POP	EBP
	RET
	GLOBAL	_fifo32_put
_fifo32_put:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	MOV	EBX,DWORD [8+EBP]
	CMP	DWORD [16+EBX],0
	JNE	L3
	OR	DWORD [20+EBX],1
	OR	EAX,-1
L2:
	POP	EBX
	POP	EBP
	RET
L3:
	MOV	ECX,DWORD [4+EBX]
	MOV	EDX,DWORD [EBX]
	MOV	EAX,DWORD [12+EBP]
	MOV	DWORD [EDX+ECX*4],EAX
	MOV	EAX,DWORD [4+EBX]
	INC	EAX
	MOV	DWORD [4+EBX],EAX
	CMP	EAX,DWORD [12+EBX]
	JE	L5
L4:
	DEC	DWORD [16+EBX]
	XOR	EAX,EAX
	JMP	L2
L5:
	MOV	DWORD [4+EBX],0
	JMP	L4
	GLOBAL	_fifo32_get
_fifo32_get:
	PUSH	EBP
	OR	EAX,-1
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	ECX,DWORD [8+EBP]
	MOV	ESI,DWORD [16+ECX]
	MOV	EBX,DWORD [12+ECX]
	CMP	ESI,EBX
	JE	L6
	MOV	EAX,DWORD [8+ECX]
	MOV	EDX,DWORD [ECX]
	MOV	EDX,DWORD [EDX+EAX*4]
	INC	EAX
	MOV	DWORD [8+ECX],EAX
	CMP	EAX,EBX
	JE	L9
L8:
	LEA	EAX,DWORD [1+ESI]
	MOV	DWORD [16+ECX],EAX
	MOV	EAX,EDX
L6:
	POP	EBX
	POP	ESI
	POP	EBP
	RET
L9:
	MOV	DWORD [8+ECX],0
	JMP	L8
	GLOBAL	_fifo32_status
_fifo32_status:
	PUSH	EBP
	MOV	EBP,ESP
	MOV	EDX,DWORD [8+EBP]
	POP	EBP
	MOV	EAX,DWORD [12+EDX]
	SUB	EAX,DWORD [16+EDX]
	RET
