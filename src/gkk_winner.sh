#!/bin/bash

DIR_CFG="cfg"
DIR_DATA="data"

DIR_TMP="tmp"
FILE_TMP="file_winner"
FILE_TMP_2="file_winner_2"
FILE_TMP_LISTA="file_gkk_winner"

SQBBDD="Kakaroto.db"

YESTERDAY=$(date --date='-1 day' +"%Y-%m-%d")

sqlite3 $DIR_DATA/$SQBBDD "select cau_001 from day_st order by cau_001 " | uniq > $DIR_TMP/$FILE_TMP_LISTA

while IFS= read -r line; do
    sqlite3 $DIR_DATA/$SQBBDD "SELECT cau_001, cau_003, cau_005 FROM day_st WHERE cau_001='$line' AND cau_002='$YESTERDAY'" > $DIR_TMP/$FILE_TMP
    cat $DIR_TMP/$FILE_TMP | awk -F\| 'BEGIN{OFS="|"}{if($2 >= $3){val="true"}else{val="false"}; print $1,$2,val}' > $DIR_TMP/$FILE_TMP_2
    VAL=$(cat $DIR_TMP/$FILE_TMP_2 | awk -F\| '{print $3}')
    sqlite3 $DIR_DATA/$SQBBDD "update day_st set cau_007 = '$VAL' where cau_001='$line';"
done < $DIR_TMP/$FILE_TMP_LISTA

#rm $DIR_TMP/$FILE_TMP
#rm $DIR_TMP/$FILE_TMP_2
