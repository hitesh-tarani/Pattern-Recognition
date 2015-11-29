import os
direct = {"coast/testing/","coast/training/","forest/testing/","forest/training/","insidecity/testing/","insidecity/training/"}
for dir1 in direct:
	os.remove(dir1+"concat.txt")
	