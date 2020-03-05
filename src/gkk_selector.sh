#!/bin/bash

MAX_VOL=100000

DIR_CFG="cfg"
DIR_DATA="data"
DIR_TMP="tmp"
DIR_LOG="log"

FILE_TMP="file_merge"
FILE_TMP_2="file_merge_2"

SQBBDD="MajinBuu"
SQBBDD_2="Kakaroto.db"

for LETTER in A B C D E F G H I J
do
    sqlite3 $DIR_DATA/$SQBBDD$LETTER.db "select cau_001 from day_st where cau_004 > '$MAX_VOL'" >> $DIR_TMP/$FILE_TMP
done

cat $DIR_TMP/$FILE_TMP | uniq -c | sort -n | awk '{if( int($1) > 30){print $2}}' | sort > $DIR_TMP/$FILE_TMP_2

rm $DIR_TMP/$FILE_TMP

while IFS= read -r line; do
    LETTER=$(echo $line | cut -c -1)
    sqlite3 $DIR_DATA/$SQBBDD$LETTER.db "select * from day_st where cau_001='$line'" >> $DIR_TMP/$FILE_TMP
done < $DIR_TMP/$FILE_TMP_2

while IFS= read -r line; do
    QUERY=$(echo $line | awk -F\| '{ print "insert into day_st(cau_000, cau_001, cau_002, cau_003, cau_004)VALUES( \"" $1 "\"," "\""$2 "\"," "\""$3 "\"," "\""$4 "\"," "\""$5 "\");" }')
    sqlite3 "$DIR_DATA/$SQBBDD_2" "$QUERY" 2>> $DIR_LOG/Log.BBDD
done < $DIR_TMP/$FILE_TMP

rm $DIR_TMP/$FILE_TMP
rm $DIR_TMP/$FILE_TMP_2
