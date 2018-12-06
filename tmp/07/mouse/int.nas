[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_io_out8
	EXTERN	_io_in8
	EXTERN	_fifo8_put
[FILE "int.c"]
[SECTION .text]
	GLOBAL	_init_pic
_init_pic:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	255
	PUSH	33
	CALL	_io_out8
	PUSH	255
	PUSH	161
	CALL	_io_out8
	PUSH	17
	PUSH	32
	CALL	_io_out8
	PUSH	32
	PUSH	33
	CALL	_io_out8
	ADD	ESP,32
	PUSH	4
	PUSH	33
	CALL	_io_out8
	PUSH	1
	PUSH	33
	CALL	_io_out8
	PUSH	17
	PUSH	160
	CALL	_io_out8
	PUSH	40
	PUSH	161
	CALL	_io_out8
	ADD	ESP,32
	PUSH	2
	PUSH	161
	CALL	_io_out8
	PUSH	1
	PUSH	161
	CALL	_io_out8
	PUSH	251
	PUSH	33
	CALL	_io_out8
	PUSH	255
	PUSH	161
	CALL	_io_out8
	LEAVE
	RET
	GLOBAL	_inthandler21
_inthandler21:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	97
	PUSH	32
	CALL	_io_out8
	PUSH	96
	CALL	_io_in8
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	_keyinfo
	CALL	_fifo8_put
	LEAVE
	RET
	GLOBAL	_inthandler2c
_inthandler2c:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	100
	PUSH	160
	CALL	_io_out8
	PUSH	98
	PUSH	32
	CALL	_io_out8
	PUSH	96
	CALL	_io_in8
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	_mouseinfo
	CALL	_fifo8_put
	LEAVE
	RET
	GLOBAL	_inthandler27
_inthandler27:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	103
	PUSH	32
	CALL	_io_out8
	LEAVE
	RET
	GLOBAL	_keyinfo
[SECTION .data]
	ALIGNB	16
_keyinfo:
	RESB	24
	GLOBAL	_mouseinfo
[SECTION .data]
	ALIGNB	16
_mouseinfo:
	RESB	24
