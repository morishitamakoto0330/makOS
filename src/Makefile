BATPATH			= C:\Users\moris\Desktop\makOS\bat
NASK			= $(BATPATH)\nask.exe 
PROGRAM			= makos.iso 

# �f�t�H���g����
default:		$(PROGRAM)

# �C���[�W�t�@�C������
$(PROGRAM): 	ipl.nas
				$(NASK) ipl.nas makos.iso ipl.lst

# �R�}���h

clean:
				del ipl.lst makos.iso 

