[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_boxfill8
	EXTERN	_putfonts8_asc
	EXTERN	_sheet_refresh
[FILE "window.c"]
[SECTION .text]
	GLOBAL	_make_window8
_make_window8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,24
	MOV	EAX,DWORD [16+EBP]
	MOV	EBX,DWORD [12+EBP]
	MOV	DWORD [-16+EBP],EAX
	MOV	ESI,DWORD [8+EBP]
	MOV	EAX,DWORD [20+EBP]
	MOV	DWORD [-20+EBP],EAX
	MOVSX	EAX,BYTE [24+EBP]
	MOV	DWORD [-24+EBP],EAX
	LEA	EAX,DWORD [-1+EBX]
	PUSH	0
	MOV	DWORD [-28+EBP],EAX
	PUSH	EAX
	PUSH	0
	PUSH	0
	PUSH	8
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	LEA	EAX,DWORD [-2+EBX]
	PUSH	1
	MOV	DWORD [-32+EBP],EAX
	PUSH	EAX
	PUSH	1
	PUSH	1
	PUSH	7
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	MOV	EAX,DWORD [-16+EBP]
	ADD	ESP,56
	DEC	EAX
	MOV	DWORD [-36+EBP],EAX
	PUSH	EAX
	PUSH	0
	PUSH	0
	PUSH	0
	PUSH	8
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	MOV	EDI,DWORD [-16+EBP]
	SUB	EDI,2
	PUSH	EDI
	PUSH	1
	PUSH	1
	PUSH	1
	PUSH	7
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	EDI
	PUSH	DWORD [-32+EBP]
	PUSH	1
	PUSH	DWORD [-32+EBP]
	PUSH	15
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	PUSH	DWORD [-36+EBP]
	PUSH	DWORD [-28+EBP]
	PUSH	0
	PUSH	DWORD [-28+EBP]
	PUSH	0
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	MOV	EAX,DWORD [-16+EBP]
	ADD	ESP,56
	SUB	EAX,3
	PUSH	EAX
	LEA	EAX,DWORD [-3+EBX]
	PUSH	EAX
	PUSH	2
	PUSH	2
	PUSH	8
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	PUSH	EDI
	PUSH	DWORD [-32+EBP]
	PUSH	EDI
	PUSH	1
	PUSH	15
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	DWORD [-36+EBP]
	PUSH	DWORD [-28+EBP]
	PUSH	DWORD [-36+EBP]
	PUSH	0
	PUSH	0
	PUSH	EBX
	PUSH	ESI
	CALL	_boxfill8
	MOV	DWORD [8+EBP],ESI
	MOV	EAX,DWORD [-24+EBP]
	MOV	DWORD [12+EBP],EBX
	MOV	DWORD [20+EBP],EAX
	ADD	ESP,28
	MOV	EAX,DWORD [-20+EBP]
	MOV	DWORD [16+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_make_wtitle8
[SECTION .data]
_closebtn.0:
	DB	"OOOOOOOOOOOOOOO@"
	DB	"OQQQQQQQQQQQQQ$@"
	DB	"OQQQQQQQQQQQQQ$@"
	DB	"OQQQ@@QQQQ@@QQ$@"
	DB	"OQQQQ@@QQ@@QQQ$@"
	DB	"OQQQQQ@@@@QQQQ$@"
	DB	"OQQQQQQ@@QQQQQ$@"
	DB	"OQQQQQ@@@@QQQQ$@"
	DB	"OQQQQ@@QQ@@QQQ$@"
	DB	"OQQQ@@QQQQ@@QQ$@"
	DB	"OQQQQQQQQQQQQQ$@"
	DB	"OQQQQQQQQQQQQQ$@"
	DB	"O$$$$$$$$$$$$$$@"
	DB	"@@@@@@@@@@@@@@@@"
[SECTION .text]
	GLOBAL	_make_wtitle8
_make_wtitle8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	EAX
	CMP	BYTE [20+EBP],0
	JE	L3
	MOV	BL,7
	MOV	DL,12
L4:
	MOV	EAX,DWORD [12+EBP]
	PUSH	20
	SUB	EAX,4
	XOR	EDI,EDI
	PUSH	EAX
	PUSH	3
	PUSH	3
	MOVZX	EAX,DL
	PUSH	EAX
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	PUSH	DWORD [16+EBP]
	MOVSX	EAX,BL
	PUSH	EAX
	PUSH	4
	PUSH	24
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_putfonts8_asc
	ADD	ESP,52
	IMUL	EBX,DWORD [12+EBP],5
	MOV	DWORD [-16+EBP],0
L20:
	MOV	EAX,DWORD [12+EBP]
	MOV	EDX,DWORD [8+EBP]
	ADD	EAX,EBX
	XOR	ESI,ESI
	LEA	ECX,DWORD [-21+EDX+EAX*1]
L19:
	MOV	DL,BYTE [_closebtn.0+ESI+EDI*1]
	CMP	DL,64
	JE	L25
	CMP	DL,36
	JE	L26
	CMP	DL,81
	MOV	DL,8
	SETNE	AL
	SUB	DL,AL
L14:
	INC	ESI
	MOV	BYTE [ECX],DL
	INC	ECX
	CMP	ESI,15
	JLE	L19
	INC	DWORD [-16+EBP]
	ADD	EDI,16
	ADD	EBX,DWORD [12+EBP]
	CMP	DWORD [-16+EBP],13
	JLE	L20
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L26:
	MOV	DL,15
	JMP	L14
L25:
	XOR	EDX,EDX
	JMP	L14
L3:
	MOV	BL,8
	MOV	DL,15
	JMP	L4
	GLOBAL	_putfonts8_asc_sht
_putfonts8_asc_sht:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,12
	MOV	EAX,DWORD [8+EBP]
	MOV	EDI,DWORD [16+EBP]
	MOV	DWORD [-16+EBP],EAX
	MOV	EBX,DWORD [20+EBP]
	MOV	EAX,DWORD [12+EBP]
	MOV	DWORD [-20+EBP],EAX
	MOV	EAX,DWORD [28+EBP]
	MOV	DWORD [-24+EBP],EAX
	LEA	EAX,DWORD [15+EDI]
	PUSH	EAX
	MOV	EAX,DWORD [-20+EBP]
	MOV	ESI,DWORD [32+EBP]
	MOVSX	EBX,BL
	LEA	ESI,DWORD [EAX+ESI*8]
	LEA	EAX,DWORD [-1+ESI]
	PUSH	EAX
	PUSH	EDI
	PUSH	DWORD [-20+EBP]
	MOVZX	EAX,BYTE [24+EBP]
	PUSH	EAX
	MOV	EAX,DWORD [-16+EBP]
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	PUSH	DWORD [-24+EBP]
	PUSH	EBX
	PUSH	EDI
	PUSH	DWORD [-20+EBP]
	MOV	EAX,DWORD [-16+EBP]
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_putfonts8_asc
	MOV	DWORD [16+EBP],EDI
	LEA	EAX,DWORD [16+EDI]
	MOV	DWORD [20+EBP],ESI
	MOV	DWORD [24+EBP],EAX
	ADD	ESP,52
	MOV	EAX,DWORD [-20+EBP]
	MOV	DWORD [12+EBP],EAX
	MOV	EAX,DWORD [-16+EBP]
	MOV	DWORD [8+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_sheet_refresh
	GLOBAL	_make_textbox8
_make_textbox8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,20
	MOV	EAX,DWORD [12+EBP]
	MOV	ESI,DWORD [16+EBP]
	ADD	EAX,DWORD [20+EBP]
	SUB	ESI,3
	PUSH	ESI
	MOV	DWORD [-16+EBP],EAX
	MOV	EAX,DWORD [16+EBP]
	ADD	EAX,DWORD [24+EBP]
	MOV	DWORD [-20+EBP],EAX
	MOV	EAX,DWORD [-16+EBP]
	INC	EAX
	PUSH	EAX
	MOV	DWORD [-24+EBP],EAX
	MOV	EAX,DWORD [12+EBP]
	PUSH	ESI
	SUB	EAX,2
	PUSH	EAX
	MOV	DWORD [-28+EBP],EAX
	MOV	EAX,DWORD [8+EBP]
	PUSH	15
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EDI,DWORD [12+EBP]
	MOV	EAX,DWORD [-20+EBP]
	SUB	EDI,3
	INC	EAX
	PUSH	EAX
	MOV	DWORD [-32+EBP],EAX
	PUSH	EDI
	MOV	EAX,DWORD [8+EBP]
	PUSH	ESI
	PUSH	EDI
	PUSH	15
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [8+EBP]
	ADD	ESP,56
	MOV	EBX,DWORD [-20+EBP]
	ADD	EBX,2
	PUSH	EBX
	PUSH	DWORD [-24+EBP]
	PUSH	EBX
	PUSH	EDI
	PUSH	7
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [-16+EBP]
	PUSH	EBX
	ADD	EAX,2
	PUSH	EAX
	PUSH	ESI
	PUSH	EAX
	MOV	EAX,DWORD [8+EBP]
	PUSH	7
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [8+EBP]
	ADD	ESP,56
	MOV	EBX,DWORD [16+EBP]
	SUB	EBX,2
	MOV	EDI,DWORD [12+EBP]
	PUSH	EBX
	DEC	EDI
	PUSH	DWORD [-16+EBP]
	PUSH	EBX
	PUSH	EDI
	PUSH	0
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [8+EBP]
	PUSH	DWORD [-20+EBP]
	PUSH	DWORD [-28+EBP]
	PUSH	EBX
	PUSH	DWORD [-28+EBP]
	PUSH	0
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [8+EBP]
	ADD	ESP,56
	PUSH	DWORD [-32+EBP]
	PUSH	DWORD [-16+EBP]
	PUSH	DWORD [-32+EBP]
	PUSH	DWORD [-28+EBP]
	PUSH	8
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [8+EBP]
	PUSH	DWORD [-32+EBP]
	PUSH	DWORD [-24+EBP]
	PUSH	EBX
	PUSH	DWORD [-24+EBP]
	PUSH	8
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	DEC	EAX
	PUSH	DWORD [-20+EBP]
	PUSH	DWORD [-16+EBP]
	PUSH	EAX
	PUSH	EDI
	MOVZX	EAX,BYTE [28+EBP]
	PUSH	EAX
	MOV	EAX,DWORD [8+EBP]
	PUSH	DWORD [4+EAX]
	PUSH	DWORD [EAX]
	CALL	_boxfill8
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET