import os

direct = {"coast/testing/","coast/training/","forest/testing/","forest/training/","insidecity/testing/","insidecity/training/"}
for dir1 in direct:
	fp = open(dir1+"concat.dt","w")
	for fileName in os.listdir(dir1):
		if(".txt" in fileName and fileName!='concat.txt'):
			f = open(dir1+fileName, "r")
			matter = f.read()
			f.close()
			matter = matter.replace("\n"," ")
			fp.write(matter.strip()+"\n")
	

	fp.close()
