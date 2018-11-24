TOOLPATH		= C:\Users\moris\Desktop\makOS\tools
NASK			= $(TOOLPATH)\nask.exe 
EDIMG			= $(TOOLPATH)\edimg.exe 

# デフォルト動作
default:		makos.iso


# ファイル生成規則

ipl10.bin:		ipl10.nas
	$(NASK) ipl10.nas ipl10.bin ipl10.lst

haribote.sys:	haribote.nas
	$(NASK) haribote.nas haribote.sys haribote.lst

haribote.img: 	ipl10.bin haribote.sys 
	$(EDIMG) imgin:$(TOOLPATH)\fdimg0at.tek \
		wbinimg src:ipl10.bin len:512 from:65536 to:0 \
		copy from:haribote.sys to:@: \
		imgout:haribote.img

makos.iso:		haribote.img 
	$(EDIMG) binin:ipl10.bin \
		wbinimg src:haribote.img len:1474560 from:0 to:65536 \
		binout:makos.iso

# コマンド

clean:
				del ipl10.bin ipl10.lst
				del haribote.sys haribote.lst
				del haribote.img
				del makos.iso


