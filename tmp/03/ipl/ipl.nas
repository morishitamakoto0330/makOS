; mak-os
; TAB=4
; �t���b�s�[�f�B�X�N���G�~�����[�g���邽�߂̋L�q

	RESB	0x8000												; �擪�͂Ƃ肠����0�Ŗ��߂�

;  Primary Volume Descriptor

	DB		1													; ���̃f�B�X�N���v�^�[��Type Code �K��1
	DB		"CD001"												; ������"CD001"
	DB		1													; ���̃f�B�X�N���v�^�[��Version �K��1
	DB		0													; �g��Ȃ����� �K��0
	DB		"Win32               "								; SystemID(32byte) "Win32"�@�c��̓X�y�[�X�Ŗ��߂�
	DB		"            "										; 
	DB		"                    "								; VolumeID(32byte) "" �悭�킩��񂪃X�y�[�X�Ŗ��߂�
	DB		"            "										;
	RESB 	8													; �g��Ȃ��̈� 0�Ŗ��߂�
	DD		0x00000386											; Volume Space Size(8byte)
	DD		0x86030000											;
	RESB 	32													; �g��Ȃ��̈� 0�Ŗ��߂�
	DD		0x01000001											; Volume Set Size(4byte)
	DD		0x01000001											; Volume Sequence Number(4byte)
	DD		0x00080800											; Logical Block Size(4byte)
	DD		0x0000000a											; Path Table Size(8byte)
	DD		0x0a000000											;
	DD		0x00000015											; Location of Type-L Path Table(4byte)
	DD		0x00000000											; Location of the Optional Type-L Path Table(4byte)
	DD		0x17000000											; Location of Type-M Path Table(4byte)
	DD		0x00000000											; Location of the Optional Type-M Path Table(4byte)
	DD		0x001d0022											; Directory entry for the root directory(34byte)
	DD		0x00000000											;
	DD		0x08001d00											;
	DD		0x00000000											;
	DD		0x0a760008											;
;	DD		0x0b760008											; IPL�ǉ��ł��̕ӂ��ς����ۂ�
	DD		0x1e210010											;
;	DD		0x1b35170b											;
	DD		0x00000224											;
	DD		0x01000001											;
	DW		0x0001												;

	; �ȉ����ɋL�q���Ȃ��ꍇ�͋󔒕���(0x20)�Ŗ��߂�
	; Volume Set ID(128byte) �󔒕��� �ォ�珇��100�����C20�����C8����
	DB		"                                                                                                    "
	DB		"                    "
	DB		"        "				
	; Publisher ID(128byte) �󔒕��� �ォ�珇��100�����C20�����C8����
	DB		"                                                                                                    "
	DB		"                    "
	DB		"        "
	; Data Preparer ID(128byte) �󔒕��� �ォ�珇��100�����C20�����C8����
	DB		"                                                                                                    "
	DB		"                    "
	DB		"        "
	; Application ID(128byte) 119���� �󔒕��� 9����
	DB		"MKISOFS ISO 9660/HFS FILESYSTEM BUILDER & CDRECORD CD-R/DVD CREATOR (C) 1993 E.YOUNGDALE (C) 1997 J."
	DB		"PEARSON/J.SCHILLING "
	DB		"        "

	DB		"                    "								; Copyright File ID(38byte) 
	DB		"                  "								;
	DB		"                    "								; Abstract File ID(36byte) 
	DB		"                "									;
	DB		"                    "								; Bibliographic File ID(37byte) 
	DB		"                 "									;
	DB		"2018101600333000$"									; Volume Creation Date and Time(17byte)
	DB		"2018101600333000$"									; Volume Modification Date and Time(17byte)
	DB		"0000000000000000", 0								; Volume Expiration Date and Time(17byte)
	DB		"2018101600333000$"									; Volume Effective Date and Time(17byte)
	DB		1													; File Structure Version �K��1
	DB		0													; �g��Ȃ����� �K��0
	
	; Contents not defined by ISO 9660 (512byte)
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"            "

	RESB	653													; �\��:0


; Boot Record Volume Descriptor

	DB		0													; �{�����[���L�q�q�^�C�v:0
	DB		"CD001"												; ������"CD001"
	DB		1													; ���̃f�B�X�N���v�^�[��Version �K��1
	DB		"EL TORITO SPECIFICATION"							; ������"EL TORITO SPECIFICATION" �c���0�Ŗ��߂�
	RESB	0x8827-$											;
	RESB	0x8847-$											; �\��:0
	DB		0x012												; Boot catalog�̃Z�N�^
	RESB	0x9000-$											; �\��:0

; Boot catalog

	DB		1													; �w�b�_ID:1
	DB		0													; 0:80x86, 1:powerPC, 2:Mac
	RESB	0x9004-$											; �\��:0
	RESB	0x901c-$											;
	DB		0xaa, 0x55											; �`�F�b�N�T��
	DB		0x55												; �V�O�l�`��:0x55
	DB		0xaa												; �V�O�l�`��:0xaa
	DB		0x88												; 0x88:Bootable, 0x00:Not Bootable
	DB		0x02												; �G�~�����[�V����
	DB		0x00, 0x00											; �ǂݍ��ݐ�Z�O�����g
	DB		0x00												; ?
	DB		0x00												; �\��:0
	DB		0x01, 0x00											; �ǂݍ��݃Z�N�^��
	DB		0x20, 0x00, 0x00, 0x00								; �u�[�g�Z�N�^�̓ǂݍ��݌��Z�N�^:0x10000byte��
	RESB 	0x9800-$											; �\��:0
	RESB	0x10000-$											; �u�[�g�Z�N�^�̋L�q�܂�0�Ŗ��߂�




	ORG		0x7c00												; ���̃v���O�������ǂ��ɓǂݍ��܂��̂�

; �W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q

	JMP		entry 
	DB		0x90
	DB		"HARIBOTE"											; �u�[�g�Z�N�^�̖��O(8byte)
	DW		512													; 1�Z�N�^�̑傫��:512byte
	DB		1													; �N���X�^�̑傫��:1�Z�N�^
	DW		1													; FAT���ǂ�����n�܂邩:1�Z�N�^��
	DB		2													; FAT�̌�:2��
	DW		224													; ���[�g�f�B���N�g���̈�̑傫��:224�G���g��
	DW		2880												; ���̃h���C�u�̑傫��:2880�Z�N�^
	DB		0xf0												; ���f�B�A�̃^�C�v:0xf0
	DW		9													; FAT�̈�̒���:9�Z�N�^
	DW		18													; 1�g���b�N�ɂ����̃Z�N�^�����邩:18�Z�N�^
	DW		2													; �w�b�h�̐�:2��
	DD		0													; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
	DD		2880												; ���̃h���C�u�̑傫����������x����
	DB		0, 0, 0x29											; �悭������Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
	DD		0xffffffff											; ���Ԃ�{�����[���V���A���ԍ�
	DB		"MAK-OS     "										; �f�B�X�N�̖��O(11byte)
	DB		"FAT12   "											; �t�H�[�}�b�g�̖��O
	RESB	18													; �Ƃ肠����18�o�C�g�󂯂Ă���

; �v���O�����{��

entry:
	MOV		AX,0					; ���W�X�^������
	MOV		SS,AX
	MOV		SP,0x7c00 
	MOV		DS,AX

; �f�B�X�N��ǂ�
	MOV		AX,0x0820
	MOV		ES,AX
	MOV		CH,0					; �V�����_0
	MOV		DH,0					; �w�b�_0
	MOV		CL,2					; �Z�N�^2

	MOV		AH,0x02 				; AH=0x02:�f�B�X�N�ǂݍ���
	MOV		AL,1					; 1�Z�N�^
	MOV		BX,0
	MOV		DL,0x00 				; A�h���C�u
	INT		0x13					; �f�B�X�NBIOS�Ăяo��
	JC		error

; �ǂݏI�����

fin:
	HLT								; ��������܂�CPU���~������
	JMP		fin						; �������[�v
	
error:
	MOV		SI,msg
putloop:
	MOV		AL,[SI]
	ADD		SI,1					; SI��1�𑫂�
	CMP		AL,0
	JE		fin
	MOV		AH,0x0e 				; �ꕶ���\���t�@���N�V����
	MOV		BX,15					; �J���[�R�[�h
	INT		0x10					; �r�f�IBIOS�Ăяo��
	JMP		putloop
msg:
	DB		0x0a, 0x0a				; ���s��2��
	DB		"load error"
	DB		0x0a					; ���s
	DB		0

;	RESB	0x7dfe-$				; 0x7dfe�܂ł�0x00�Ŗ��߂閽��
	RESB	0x17dfe-$				; 0x17dfe�܂ł�0x00�Ŗ��߂閽��

	DB		0x55, 0xaa

















































