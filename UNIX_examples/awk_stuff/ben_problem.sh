for file in $(ls *.csv) 
do
  echo -e -n "$file\t"
  awk -F',' '{sum+=$11;} END{printf "%d\n", sum;}' $file
done
