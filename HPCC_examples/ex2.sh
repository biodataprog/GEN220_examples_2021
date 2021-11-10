#!/usr/bin/bash
# lets print out the unique names of all the samples/file sets

testfile="/home/Long/Name/Here.png"
basename $testfile
basename $testfile .png

for file in $(ls *_R1.fq)
do
  sample=$(basename $file _R1.fq)
  echo "sample is $sample"
  R1=$sample"_R1.fq"
  R2=$sample"_R2.fq"
  echo "analysisprogram $R1 $R2"
done


perl -e 'print("hello"),"\n"'


