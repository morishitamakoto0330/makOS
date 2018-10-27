; mak-os
; TAB=4

; Boot Record Volume Descriptor

	RESB	0x8800
	DB		"CD001"
	DB		1
	DB		"EL TORITO SPECIFICATION"
	RESB	0x8846-$
	DB		0x012														; Boot catalog sector
	RESB	0x8fff-$

; Boot catalog

	DB		1
	DB		0
	RESB	2
	DB		"MakotoMorishita"
	RESB	0x901b-$




