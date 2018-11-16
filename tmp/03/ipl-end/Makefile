TOOLPATH		= C:\Users\moris\Desktop\makOS\tools
NASK			= $(TOOLPATH)\nask.exe 
EDIMG			= $(TOOLPATH)\edimg.exe 

# デフォルト動作
default:		makos.iso


# ファイル生成規則

ipl.bin:		ipl.nas
	$(NASK) ipl.nas ipl.bin ipl.lst

haribote.sys:	haribote.nas
	$(NASK) haribote.nas haribote.sys haribote.lst

haribote.img: 	ipl.bin haribote.sys 
	$(EDIMG) imgin:$(TOOLPATH)\fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:65536 to:0 \
		copy from:haribote.sys to:@: \
		imgout:haribote.img

makos.iso:		haribote.img 
	$(EDIMG) binin:ipl.bin \
		wbinimg src:haribote.img len:1474560 from:0 to:65536 \
		binout:makos.iso

# コマンド

clean:
				del ipl.bin ipl.lst
				del haribote.sys haribote.lst
				del haribote.img
				del makos.iso


