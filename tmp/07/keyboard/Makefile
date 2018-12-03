OBJS_BOOTPACK	= bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
				  int.obj

TOOLPATH		= C:\Users\moris\Desktop\makOS\tools
INCPATH			= C:\Users\moris\Desktop\makOS\tools\haribote

NASK			= $(TOOLPATH)\nask.exe 
CC				= cl /I$(INCPATH)
CC1				= $(TOOLPATH)\cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK		= $(TOOLPATH)\gas2nask.exe -a
OBJ2BIM			= $(TOOLPATH)\obj2bim.exe
MAKEFONT		= $(TOOLPATH)\makefont.exe
BIN2OBJ			= $(TOOLPATH)\bin2obj.exe
BIM2HRB			= $(TOOLPATH)\bim2hrb.exe
RULEFILE		= $(INCPATH)\haribote.rul
EDIMG			= $(TOOLPATH)\edimg.exe 



# デフォルト動作
all:			makos.iso 


# ファイル生成規則 ##################################
#
# IPL
#
ipl10.bin:		ipl10.nas
	$(NASK) ipl10.nas ipl10.bin ipl10.lst
asmhead.bin:	asmhead.nas
	$(NASK) asmhead.nas asmhead.bin asmhead.lst
#
# 文字データ
#
hankaku.bin:	hankaku.txt
	$(MAKEFONT) hankaku.txt hankaku.bin
hankaku.obj:	hankaku.bin 
	$(BIN2OBJ) hankaku.bin hankaku.obj _hankaku

#
# C
#
bootpack.gas:	bootpack.c
		$(CC1) -o bootpack.gas bootpack.c
bootpack.nas:	bootpack.gas 
		$(GAS2NASK) bootpack.gas bootpack.nas
bootpack.obj:	bootpack.nas
		$(NASK) bootpack.nas bootpack.obj bootpack.lst
dsctbl.gas:	dsctbl.c
		$(CC1) -o dsctbl.gas dsctbl.c
dsctbl.nas:	dsctbl.gas 
		$(GAS2NASK) dsctbl.gas dsctbl.nas
dsctbl.obj:	dsctbl.nas
		$(NASK) dsctbl.nas dsctbl.obj dsctbl.lst
graphic.gas:	graphic.c
		$(CC1) -o graphic.gas graphic.c
graphic.nas:	graphic.gas 
		$(GAS2NASK) graphic.gas graphic.nas
graphic.obj:	graphic.nas
		$(NASK) graphic.nas graphic.obj graphic.lst
int.gas:	int.c
		$(CC1) -o int.gas int.c
int.nas:	int.gas 
		$(GAS2NASK) int.gas int.nas
int.obj:	int.nas
		$(NASK) int.nas int.obj int.lst



#
# NASK(システムコール関数定義)
#

naskfunc.obj:	naskfunc.nas
	$(NASK) naskfunc.nas naskfunc.obj naskfunc.lst

#
# OS本体
# 
bootpack.bim:	$(OBJS_BOOTPACK) 
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map \
		$(OBJS_BOOTPACK)
# 3MB+64KB=3136KB

bootpack.hrb:	bootpack.bim
	$(BIM2HRB) bootpack.bim bootpack.hrb 0

haribote.sys:	asmhead.bin bootpack.hrb
	type asmhead.bin bootpack.hrb > haribote.sys

haribote.img: 	ipl10.bin haribote.sys 	
	$(EDIMG) imgin:$(TOOLPATH)\fdimg0at.tek \
		wbinimg src:ipl10.bin len:512 from:65536 to:0 \
		copy from:haribote.sys to:@: \
		imgout:haribote.img 


makos.iso:		ipl10.bin haribote.img 
	$(EDIMG) create file:_ipl10.bin size:1847296

	$(EDIMG) binin:_ipl10.bin \
		wbinimg src:ipl10.bin len:65536 from:0 to:0 \
		binout:_ipl10.bin 

	$(EDIMG) binin:_ipl10.bin \
		wbinimg src:haribote.img len:1474560 from:0 to:65536 \
		binout:_ipl10.bin 

	ren _ipl10.bin makos.iso 



# コマンド ##############################################

clean:
				del *.bin
				del *.lst
				del *.gas
				del *.obj
				del bootpack.nas
				del bootpack.map
				del bootpack.bim
				del bootpack.hrb
				del haribote.sys
				del haribote.img
				del makos.iso





