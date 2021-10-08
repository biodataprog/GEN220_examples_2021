for year in $(seq 1990 1999)
do
  count=$(grep ",$year," fire_1990.txt | wc -l); 
  echo "year=$year count=$count"; 
done

