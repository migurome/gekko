#!/bin/bash

DIR_CFG="cfg"
DIR_DATA="data"

DIR_TMP="tmp"
FILE_TMP="file_mediapro"
FILE_TMP_2="file_mediapro_2"
FILE_TMP_LISTA="file_gkk_mediapro"

NUMER=5

SQBBDD="Kakaroto.db"

INICIO=$(date --date='-50 day' +"%Y-%m-%d")
sqlite3 $DIR_DATA/$SQBBDD "select cau_001 from day_st order by cau_001 " | uniq > $DIR_TMP/$FILE_TMP_LISTA

while IFS= read -r line; do
    sqlite3 $DIR_DATA/$SQBBDD "SELECT * FROM day_st WHERE cau_001 = '$line' AND cau_002 > '$INICIO'" > $DIR_TMP/$FILE_TMP
    LOW=$(head -$NUMER tmp/file_mediapro | awk -F\| 'BEGIN{sum=0}{sum+=$4}END{print $4/'$NUMER'};')
    TOP=$(tail -$NUMER tmp/file_mediapro | awk -F\| 'BEGIN{sum=0}{sum+=$4}END{print $4/'$NUMER'};')
    RESULT=$(awk "BEGIN {printf \"%.3f\",${TOP}/${LOW}}" 2> /dev/null)
    sqlite3 $DIR_DATA/$SQBBDD "update day_st set cau_008 = '$RESULT' where cau_001='$line';"
done < $DIR_TMP/$FILE_TMP_LISTA

#rm $DIR_TMP/$FILE_TMP
#rm $DIR_TMP/$FILE_TMP_2
