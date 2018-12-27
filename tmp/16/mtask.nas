[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_memman_alloc_4k
	EXTERN	_set_segmdesc
	EXTERN	_load_tr
	EXTERN	_timer_alloc
	EXTERN	_timer_settime
	EXTERN	_farjmp
[FILE "mtask.c"]
[SECTION .text]
	GLOBAL	_task_now
_task_now:
	MOV	EAX,DWORD [_taskctl]
	PUSH	EBP
	MOV	EBP,ESP
	POP	EBP
	MOV	EDX,DWORD [EAX]
	IMUL	EDX,EDX,408
	LEA	EAX,DWORD [8+EDX+EAX*1]
	MOV	EDX,DWORD [4+EAX]
	MOV	EAX,DWORD [8+EAX+EDX*4]
	RET
	GLOBAL	_task_add
_task_add:
	PUSH	EBP
	MOV	EBP,ESP
	MOV	ECX,DWORD [8+EBP]
	MOV	EDX,DWORD [8+ECX]
	IMUL	EDX,EDX,408
	ADD	EDX,DWORD [_taskctl]
	MOV	EAX,DWORD [8+EDX]
	MOV	DWORD [16+EDX+EAX*4],ECX
	INC	EAX
	MOV	DWORD [8+EDX],EAX
	MOV	DWORD [4+ECX],2
	POP	EBP
	RET
	GLOBAL	_task_remove
_task_remove:
	PUSH	EBP
	XOR	ECX,ECX
	MOV	EBP,ESP
	PUSH	EBX
	MOV	EBX,DWORD [8+EBP]
	MOV	EAX,DWORD [8+EBX]
	IMUL	EAX,EAX,408
	ADD	EAX,DWORD [_taskctl]
	LEA	EDX,DWORD [8+EAX]
	CMP	ECX,DWORD [8+EAX]
	JGE	L5
L9:
	CMP	DWORD [8+EDX+ECX*4],EBX
	JE	L5
	INC	ECX
	CMP	ECX,DWORD [EDX]
	JL	L9
L5:
	MOV	EAX,DWORD [4+EDX]
	DEC	DWORD [EDX]
	CMP	ECX,EAX
	JGE	L10
	DEC	EAX
	MOV	DWORD [4+EDX],EAX
L10:
	MOV	EAX,DWORD [EDX]
	CMP	DWORD [4+EDX],EAX
	JL	L11
	MOV	DWORD [4+EDX],0
L11:
	MOV	DWORD [4+EBX],1
	MOV	EBX,DWORD [EDX]
	CMP	ECX,EBX
	JGE	L19
L16:
	MOV	EAX,DWORD [12+EDX+ECX*4]
	MOV	DWORD [8+EDX+ECX*4],EAX
	INC	ECX
	CMP	ECX,EBX
	JL	L16
L19:
	POP	EBX
	POP	EBP
	RET
	GLOBAL	_task_switchsub
_task_switchsub:
	PUSH	EBP
	XOR	ECX,ECX
	MOV	EBP,ESP
	MOV	EAX,DWORD [_taskctl]
	XOR	EDX,EDX
L26:
	CMP	DWORD [8+EAX+EDX*1],0
	JG	L22
	INC	ECX
	ADD	EDX,408
	CMP	ECX,9
	JLE	L26
L22:
	MOV	DWORD [EAX],ECX
	MOV	BYTE [4+EAX],0
	POP	EBP
	RET
	GLOBAL	_task_init
_task_init:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	EDI,EDI
	PUSH	EBX
	XOR	ESI,ESI
	PUSH	124088
	MOV	EBX,999
	PUSH	DWORD [8+EBP]
	CALL	_memman_alloc_4k
	MOV	DWORD [_taskctl],EAX
	POP	EAX
	POP	EDX
L33:
	MOV	EAX,EDI
	LEA	EDX,DWORD [24+ESI]
	ADD	EAX,DWORD [_taskctl]
	ADD	EDI,120
	MOV	DWORD [4092+EAX],0
	MOV	DWORD [4088+EAX],EDX
	ADD	EAX,4104
	PUSH	137
	PUSH	EAX
	LEA	EAX,DWORD [2555928+ESI]
	PUSH	103
	ADD	ESI,8
	PUSH	EAX
	CALL	_set_segmdesc
	ADD	ESP,16
	DEC	EBX
	JNS	L33
	MOV	ECX,DWORD [_taskctl]
	XOR	EDX,EDX
	MOV	EBX,9
L38:
	LEA	EAX,DWORD [ECX+EDX*1]
	ADD	EDX,408
	DEC	EBX
	MOV	DWORD [8+EAX],0
	MOV	DWORD [12+EAX],0
	JNS	L38
	CALL	_task_alloc
	MOV	EBX,EAX
	MOV	DWORD [4+EAX],2
	MOV	DWORD [12+EAX],2
	MOV	DWORD [8+EAX],0
	PUSH	EAX
	CALL	_task_add
	CALL	_task_switchsub
	PUSH	DWORD [EBX]
	CALL	_load_tr
	CALL	_timer_alloc
	PUSH	DWORD [12+EBX]
	PUSH	EAX
	MOV	DWORD [_task_timer],EAX
	CALL	_timer_settime
	LEA	ESP,DWORD [-12+EBP]
	MOV	EAX,EBX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_task_alloc
_task_alloc:
	PUSH	EBP
	XOR	ECX,ECX
	MOV	EBP,ESP
	XOR	EDX,EDX
L49:
	MOV	EAX,EDX
	ADD	EAX,DWORD [_taskctl]
	CMP	DWORD [4092+EAX],0
	JE	L52
	INC	ECX
	ADD	EDX,120
	CMP	ECX,999
	JLE	L49
	XOR	EAX,EAX
L43:
	POP	EBP
	RET
L52:
	ADD	EAX,4088
	MOV	DWORD [4+EAX],1
	MOV	DWORD [52+EAX],514
	MOV	DWORD [56+EAX],0
	MOV	DWORD [60+EAX],0
	MOV	DWORD [64+EAX],0
	MOV	DWORD [68+EAX],0
	MOV	DWORD [76+EAX],0
	MOV	DWORD [80+EAX],0
	MOV	DWORD [84+EAX],0
	MOV	DWORD [88+EAX],0
	MOV	DWORD [100+EAX],0
	MOV	DWORD [104+EAX],0
	MOV	DWORD [108+EAX],0
	MOV	DWORD [112+EAX],0
	MOV	DWORD [116+EAX],1073741824
	JMP	L43
	GLOBAL	_task_run
_task_run:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	ESI,DWORD [12+EBP]
	MOV	EAX,DWORD [16+EBP]
	MOV	EBX,DWORD [8+EBP]
	TEST	ESI,ESI
	JS	L58
L54:
	TEST	EAX,EAX
	JLE	L55
	MOV	DWORD [12+EBX],EAX
L55:
	CMP	DWORD [4+EBX],2
	JE	L59
L56:
	CMP	DWORD [4+EBX],2
	JE	L57
	MOV	DWORD [8+EBX],ESI
	PUSH	EBX
	CALL	_task_add
	POP	ECX
L57:
	MOV	EAX,DWORD [_taskctl]
	MOV	BYTE [4+EAX],1
	LEA	ESP,DWORD [-8+EBP]
	POP	EBX
	POP	ESI
	POP	EBP
	RET
L59:
	CMP	DWORD [8+EBX],ESI
	JE	L56
	PUSH	EBX
	CALL	_task_remove
	POP	EAX
	JMP	L56
L58:
	MOV	ESI,DWORD [8+EBX]
	JMP	L54
	GLOBAL	_task_switch
_task_switch:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	EBX,DWORD [_taskctl]
	MOV	EDX,DWORD [EBX]
	IMUL	EDX,EDX,408
	LEA	EDX,DWORD [EDX+EBX*1]
	LEA	ECX,DWORD [8+EDX]
	MOV	EAX,DWORD [4+ECX]
	MOV	ESI,DWORD [8+ECX+EAX*4]
	INC	EAX
	MOV	DWORD [4+ECX],EAX
	CMP	EAX,DWORD [8+EDX]
	JE	L64
L61:
	CMP	BYTE [4+EBX],0
	JNE	L65
L62:
	MOV	EAX,DWORD [4+ECX]
	MOV	EBX,DWORD [8+ECX+EAX*4]
	PUSH	DWORD [12+EBX]
	PUSH	DWORD [_task_timer]
	CALL	_timer_settime
	CMP	EBX,ESI
	POP	ECX
	POP	EAX
	JE	L60
	PUSH	DWORD [EBX]
	PUSH	0
	CALL	_farjmp
	POP	EAX
	POP	EDX
L60:
	LEA	ESP,DWORD [-8+EBP]
	POP	EBX
	POP	ESI
	POP	EBP
	RET
L65:
	CALL	_task_switchsub
	MOV	EDX,DWORD [_taskctl]
	MOV	EAX,DWORD [EDX]
	IMUL	EAX,EAX,408
	LEA	ECX,DWORD [8+EAX+EDX*1]
	JMP	L62
L64:
	MOV	DWORD [4+ECX],0
	JMP	L61
	GLOBAL	_task_sleep
_task_sleep:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	ESI,DWORD [8+EBP]
	CMP	DWORD [4+ESI],2
	JE	L69
L66:
	LEA	ESP,DWORD [-8+EBP]
	POP	EBX
	POP	ESI
	POP	EBP
	RET
L69:
	CALL	_task_now
	PUSH	ESI
	MOV	EBX,EAX
	CALL	_task_remove
	POP	ECX
	CMP	ESI,EBX
	JNE	L66
	CALL	_task_switchsub
	CALL	_task_now
	PUSH	DWORD [EAX]
	PUSH	0
	CALL	_farjmp
	POP	EAX
	POP	EDX
	JMP	L66
	GLOBAL	_task_timer
[SECTION .data]
	ALIGNB	4
_task_timer:
	RESB	4
	GLOBAL	_taskctl
[SECTION .data]
	ALIGNB	4
_taskctl:
	RESB	4