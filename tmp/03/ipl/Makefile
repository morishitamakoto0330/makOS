BATPATH			= C:\Users\moris\Desktop\makOS\bat
NASK			= $(BATPATH)\nask.exe 
PROGRAM			= makos.iso 

# デフォルト動作
default:		$(PROGRAM)

# イメージファイル生成
$(PROGRAM): 	ipl.nas
				$(NASK) ipl.nas makos.iso ipl.lst

# コマンド

clean:
				del ipl.lst makos.iso 


