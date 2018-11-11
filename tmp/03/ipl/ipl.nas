; mak-os
; TAB=4
; フロッピーディスクをエミュレートするための記述

	RESB	0x8000												; 先頭はとりあえず0で埋める

;  Primary Volume Descriptor

	DB		1													; このディスクリプターのType Code 必ず1
	DB		"CD001"												; 文字列"CD001"
	DB		1													; このディスクリプターのVersion 必ず1
	DB		0													; 使わない部分 必ず0
	DB		"Win32               "								; SystemID(32byte) "Win32"　残りはスペースで埋める
	DB		"            "										; 
	DB		"                    "								; VolumeID(32byte) "" よくわからんがスペースで埋める
	DB		"            "										;
	RESB 	8													; 使わない領域 0で埋める
	DD		0x00000386											; Volume Space Size(8byte)
	DD		0x86030000											;
	RESB 	32													; 使わない領域 0で埋める
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
;	DD		0x0b760008											; IPL追加でこの辺が変わるっぽい
	DD		0x1e210010											;
;	DD		0x1b35170b											;
	DD		0x00000224											;
	DD		0x01000001											;
	DW		0x0001												;

	; 以下特に記述しない場合は空白文字(0x20)で埋める
	; Volume Set ID(128byte) 空白文字 上から順に100文字，20文字，8文字
	DB		"                                                                                                    "
	DB		"                    "
	DB		"        "				
	; Publisher ID(128byte) 空白文字 上から順に100文字，20文字，8文字
	DB		"                                                                                                    "
	DB		"                    "
	DB		"        "
	; Data Preparer ID(128byte) 空白文字 上から順に100文字，20文字，8文字
	DB		"                                                                                                    "
	DB		"                    "
	DB		"        "
	; Application ID(128byte) 119文字 空白文字 9文字
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
	DB		1													; File Structure Version 必ず1
	DB		0													; 使わない部分 必ず0
	
	; Contents not defined by ISO 9660 (512byte)
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"                                                                                                    "
	DB		"            "

	RESB	653													; 予約:0


; Boot Record Volume Descriptor

	DB		0													; ボリューム記述子タイプ:0
	DB		"CD001"												; 文字列"CD001"
	DB		1													; このディスクリプターのVersion 必ず1
	DB		"EL TORITO SPECIFICATION"							; 文字列"EL TORITO SPECIFICATION" 残りは0で埋める
	RESB	0x8827-$											;
	RESB	0x8847-$											; 予約:0
	DB		0x012												; Boot catalogのセクタ
	RESB	0x9000-$											; 予約:0

; Boot catalog

	DB		1													; ヘッダID:1
	DB		0													; 0:80x86, 1:powerPC, 2:Mac
	RESB	0x9004-$											; 予約:0
	RESB	0x901c-$											;
	DB		0xaa, 0x55											; チェックサム
	DB		0x55												; シグネチャ:0x55
	DB		0xaa												; シグネチャ:0xaa
	DB		0x88												; 0x88:Bootable, 0x00:Not Bootable
	DB		0x02												; エミュレーション
	DB		0x00, 0x00											; 読み込み先セグメント
	DB		0x00												; ?
	DB		0x00												; 予約:0
	DB		0x01, 0x00											; 読み込みセクタ数
	DB		0x20, 0x00, 0x00, 0x00								; ブートセクタの読み込み元セクタ:0x10000byte目
	RESB 	0x9800-$											; 予約:0
	RESB	0x10000-$											; ブートセクタの記述まで0で埋める




	ORG		0x7c00												; このプログラムがどこに読み込まれるのか

; 標準的なFAT12フォーマットフロッピーディスクのための記述

	JMP		entry 
	DB		0x90
	DB		"HARIBOTE"											; ブートセクタの名前(8byte)
	DW		512													; 1セクタの大きさ:512byte
	DB		1													; クラスタの大きさ:1セクタ
	DW		1													; FATがどこから始まるか:1セクタ目
	DB		2													; FATの個数:2個
	DW		224													; ルートディレクトリ領域の大きさ:224エントリ
	DW		2880												; このドライブの大きさ:2880セクタ
	DB		0xf0												; メディアのタイプ:0xf0
	DW		9													; FAT領域の長さ:9セクタ
	DW		18													; 1トラックにいくつのセクタがあるか:18セクタ
	DW		2													; ヘッドの数:2個
	DD		0													; パーティションを使ってないのでここは必ず0
	DD		2880												; このドライブの大きさをもう一度書く
	DB		0, 0, 0x29											; よく分からないけどこの値にしておくといいらしい
	DD		0xffffffff											; たぶんボリュームシリアル番号
	DB		"MAK-OS     "										; ディスクの名前(11byte)
	DB		"FAT12   "											; フォーマットの名前
	RESB	18													; とりあえず18バイト空けておく

; プログラム本体

entry:
	MOV		AX,0					; レジスタ初期化
	MOV		SS,AX
	MOV		SP,0x7c00 
	MOV		DS,AX

; ディスクを読む
	MOV		AX,0x0820
	MOV		ES,AX
	MOV		CH,0					; シリンダ0
	MOV		DH,0					; ヘッダ0
	MOV		CL,2					; セクタ2

	MOV		AH,0x02 				; AH=0x02:ディスク読み込み
	MOV		AL,1					; 1セクタ
	MOV		BX,0
	MOV		DL,0x00 				; Aドライブ
	INT		0x13					; ディスクBIOS呼び出し
	JC		error

; 読み終わった

fin:
	HLT								; 何かあるまでCPUを停止させる
	JMP		fin						; 無限ループ
	
error:
	MOV		SI,msg
putloop:
	MOV		AL,[SI]
	ADD		SI,1					; SIに1を足す
	CMP		AL,0
	JE		fin
	MOV		AH,0x0e 				; 一文字表示ファンクション
	MOV		BX,15					; カラーコード
	INT		0x10					; ビデオBIOS呼び出し
	JMP		putloop
msg:
	DB		0x0a, 0x0a				; 改行を2つ
	DB		"load error"
	DB		0x0a					; 改行
	DB		0

;	RESB	0x7dfe-$				; 0x7dfeまでを0x00で埋める命令
	RESB	0x17dfe-$				; 0x17dfeまでを0x00で埋める命令

	DB		0x55, 0xaa

















































