
NAME="GeneA"
NAME2="GeneB"
echo "$NAME $NAME2"

NAME="GeneC"
NAME3=$NAME.$NAME2
echo "$NAME $NAME2 $NAME3"

echo $NAME
if [ $NAME == "GeneC" ]
then
   echo "Name is C"
fi

echo $NAME
if [ $NAME != "GeneA" ]
then
   echo "Name is not GeneA"
fi

NAME="GeneA"
if [ $NAME == "GeneA" ]; then
  echo "A"
elif [ $NAME == "GeneB" ]; then
  echo "B"
else
  echo "had another class for NAME: $NAME"
fi

NAME="genea"
if [ $NAME == "GeneA" ]; then
  echo "A"
elif [ $NAME == "GeneB" ]; then
  echo "B"
else
  echo "had another class for NAME: $NAME"
fi
