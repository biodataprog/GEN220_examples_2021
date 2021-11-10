# print out the files that end in '.fq' in the folder and their size (du -h)
for file in $(ls *.fq); do echo $file; du -h $file; done
