[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_timer_alloc
	EXTERN	_timer_settime
	EXTERN	_farjmp
[FILE "mtask.c"]
[SECTION .text]
	GLOBAL	_mt_init
_mt_init:
	PUSH	EBP
	MOV	EBP,ESP
	CALL	_timer_alloc
	PUSH	2
	MOV	DWORD [_mt_timer],EAX
	PUSH	EAX
	CALL	_timer_settime
	MOV	DWORD [_mt_tr],24
	LEAVE
	RET
	GLOBAL	_mt_taskswitch
_mt_taskswitch:
	PUSH	EBP
	XOR	EAX,EAX
	CMP	DWORD [_mt_tr],24
	SETE	AL
	MOV	EBP,ESP
	PUSH	2
	PUSH	DWORD [_mt_timer]
	LEA	EAX,DWORD [24+EAX*8]
	MOV	DWORD [_mt_tr],EAX
	CALL	_timer_settime
	PUSH	DWORD [_mt_tr]
	PUSH	0
	CALL	_farjmp
	LEAVE
	RET
	GLOBAL	_mt_timer
[SECTION .data]
	ALIGNB	4
_mt_timer:
	RESB	4
	GLOBAL	_mt_tr
[SECTION .data]
	ALIGNB	4
_mt_tr:
	RESB	4
