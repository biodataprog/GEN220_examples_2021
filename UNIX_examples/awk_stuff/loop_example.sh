
for odd in $(seq 1 2 15)
do
  echo "odd number is = $odd"
done


for odd in 1 3 5 7 9
do
  echo "odd numbers again = $odd"
done


for letter in a b c d
do
  echo "letter is $letter"
done

for filename in $(cat my_sequence_files.txt)
do
 echo "filename to process is $filename"
done

num=1
while [ "$num" -lt 10 ]
do
  echo "$num"
  num=$(expr $num + 1)
done
