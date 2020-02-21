DIR_DATA="data"

for LETTER in A B C D E F G H I J
do
    sqlite3 $DIR_DATA/MajinBuu$LETTER.db < $DIR_DATA/create.sql 
done
