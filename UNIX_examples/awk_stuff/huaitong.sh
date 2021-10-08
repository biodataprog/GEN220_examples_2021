
for i in $(seq 1990 1 2019);
do 
    a=$(awk -F, "{ if (\$2=="$i") { s+= \$11 } } END {print s}" 1990s-2010sfire)
    echo "total acerage burned in $i: $a"
    #| awk -F, '{s+=$11}END{print s}')"" 
done

for i in $(seq 1990 1 2019);
do
  echo -n "Year is: "
  grep ",$i," 1990s-2010sfire | awk -F, '{s+=$11} END {print s}' 
done