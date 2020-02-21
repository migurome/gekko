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
FILE_T="tickers.txt"
SQBBDD="MajinBuu"

for LETTER in A B C D E F G H I J
do
    sqlite3 $DIR_DATA/$SQBBDD$LETTER.db "select cau_001 from day_st order by cau_001 " | uniq > $DIR_TMP/$FILE_TMP$LETTER
done

for LETTER in A B C D E F G H I J
do
    echo "Creando max y min de $LETTER"	
    while IFS= read -r line; do
        MAX=$(sqlite3 $DIR_DATA/$SQBBDD$LETTER.db "select cau_003 from day_st where cau_001='$line' order by cau_003" | tail -1)
        MIN=$(sqlite3 $DIR_DATA/$SQBBDD$LETTER.db "select cau_003 from day_st where cau_001='$line' order by cau_003" | head -1)
        sqlite3 $DIR_DATA/$SQBBDD$LETTER.db "update day_st set cau_005 = '$MAX', cau_006 ='$MIN' where cau_001='$line';"
    done < $DIR_TMP/$FILE_TMP$LETTER
done

rm $DIR_TMP/$FILE_TMP*
