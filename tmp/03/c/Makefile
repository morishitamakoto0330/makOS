TOOLPATH		= C:\Users\moris\Desktop\makOS\tools
INCPATH			= C:\Users\moris\Desktop\makOS\tools\haribote

NASK			= $(TOOLPATH)\nask.exe 
CC1				= $(TOOLPATH)\cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK		= $(TOOLPATH)\gas2nask.exe -a
OBJ2BIM			= $(TOOLPATH)\obj2bim.exe
BIM2HRB			= $(TOOLPATH)\bim2hrb.exe
RULEFILE		= $(INCPATH)\haribote.rul
EDIMG			= $(TOOLPATH)\edimg.exe 

# デフォルト動作 ####################################
default:		makos.iso


# ファイル生成規則 ##################################

ipl10.bin:		ipl10.nas
	$(NASK) ipl10.nas ipl10.bin ipl10.lst

asmhead.bin:	asmhead.nas
	$(NASK) asmhead.nas asmhead.bin asmhead.lst

bootpack.gas:	bootpack.c
	$(CC1) -o bootpack.gas bootpack.c

bootpack.nas:	bootpack.gas 
	$(GAS2NASK) bootpack.gas bootpack.nas

bootpack.obj:	bootpack.nas
	$(NASK) bootpack.nas bootpack.obj bootpack.lst

naskfunc.obj:	naskfunc.nas
	$(NASK) naskfunc.nas naskfunc.obj naskfunc.lst

bootpack.bim:	bootpack.obj naskfunc.obj
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map \
		bootpack.obj naskfunc.obj
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

makos.iso:		haribote.img 
	$(EDIMG) binin:ipl10.bin \
		wbinimg src:haribote.img len:1474560 from:0 to:65536 \
		binout:makos.iso


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





