#!/bin/bash

#        _    _                                   _
#   __ _| | _| | __    _ __ ___   __ ___  __  ___| |__
#  / _` | |/ / |/ /   | '_ ` _ \ / _` \ \/ / / __| '_ \
# | (_| |   <|   <    | | | | | | (_| |>  < _\__ \ | | |
#  \__, |_|\_\_|\_\___|_| |_| |_|\__,_/_/\_(_)___/_| |_|
#  |___/         |_____|

# Calcula el valor maximo y minimo del stock y los inserta en base de datos

DIR_CFG="cfg"
DIR_DATA="data"

DIR_TMP="tmp"
FILE_TMP="file_gkk_max"
FILE_TMP_2="file2_gkk_max"
FILE_T="tickers.txt"

SQBBDD="MajinBuu.db"

sqlite3 $DIR_DATA/$SQBBDD "select cau_001 from day_st order by cau_001 " | uniq > $DIR_TMP/$FILE_TMP

while IFS= read -r line; do
    MAX=$(sqlite3 $DIR_DATA/$SQBBDD "select cau_003 from day_st where cau_001='$line' order by cau_003" | tail -1)
    MIN=$(sqlite3 $DIR_DATA/$SQBBDD "select cau_003 from day_st where cau_001='$line' order by cau_003" | head -1)
    sqlite3 $DIR_DATA/$SQBBDD "update day_st set cau_005 = '$MAX', cau_006 ='$MIN' where cau_001='$line';"
done < $DIR_TMP/$FILE_TMP

rm $DIR_TMP/$FILE_TMP
