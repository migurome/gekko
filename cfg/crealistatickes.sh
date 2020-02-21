DIR_CFG="cfg"

FILE_TIK="all_tickers.txt"
FILE_OUT="tickers"

for LETTER in A B C D E F G H I J
do
    cat $DIR_CFG/$FILE_TIK | grep ^$LETTER >> $DIR_CFG/$FILE_OUT$LETTER
done

