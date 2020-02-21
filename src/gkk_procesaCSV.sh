#!/bin/bash

#        _    _                                             ____  _             _
#   __ _| | _| | __     _ __  _ __ ___   ___ ___  ___  __ _| __ )(_) __ _   ___| |__
#  / _` | |/ / |/ /    | '_ \| '__/ _ \ / __/ _ \/ __|/ _` |  _ \| |/ _` | / __| '_ \
# | (_| |   <|   <     | |_) | | | (_) | (_|  __/\__ \ (_| | |_) | | (_| |_\__ \ | | |
#  \__, |_|\_\_|\_\____| .__/|_|  \___/ \___\___||___/\__,_|____/|_|\__, (_)___/_| |_|
#  |___/         |_____|_|                                          |___/


DIR_DONE="CSV/done/"
DIR_CSV="CSV"
DIR_SRC="src"
DIR_DATA="data"
DIR_TMP="tmp"
DIR_LOG="log"

SQBBDD="MajinBuu.db"

FILE_IN_4="file4.tmp"
FILE_IN_5="file5.tmp"

#PWD_FILE=$(ls $DIR_CSV/*.csv) 2>> $DIR_LOG/Log_CSV.err
#
#FILE=$(ls $DIR_CSV/*.csv | awk -F\/ '{print $2}' | awk -F "." '{print $1}' ) 2>> $DIR_LOG/Log_CSV.err

#if [ $FILE != "" ]
#then
    for GO in "$DIR_CSV"/*.csv
    do
        echo "InF|Procesando fichero $GO" >> $DIR_LOG/Log_CSV.err
        while IFS= read -r line; do
            FILE=$(ls $GO| awk -F\/ '{print $2}' | awk -F "." '{print $1}' ) 2>> $DIR_LOG/Log_CSV.err
            echo $line | sed 's/,/|/g' | sed 's/-//g' | awk -F \| 'BEGIN{OFS="|"}{print $1"'$FILE'","'$FILE'",$1,$6,$7}' >> $DIR_TMP/$FILE_IN_4  2>> $DIR_LOG/Log_CSV.err
            cat $DIR_TMP/$FILE_IN_4 | grep -v Date > $DIR_TMP/$FILE_IN_5
        done < $GO

        echo "InF|Insertando en BBDD $FILE" >> $DIR_LOG/Log_CSV.err
        while IFS= read -r line; do
            QUERY=$(echo "$line" | awk -F\| '{ print "insert into day_st(cau_000, cau_001, cau_002, cau_003, cau_004)VALUES( \"" $1 "\"," "\""$2 "\"," "\""$3 "\"," "\""$4 "\"," "\""$5 "\");" }')
            sqlite3 "$DIR_DATA/$SQBBDD" "$QUERY" 2>> $DIR_LOG/Log_CSV.err
        done < $DIR_TMP/$FILE_IN_5

        echo "InF|Moviendo fichero $FILE" >> $DIR_LOG/Log_CSV.err
        mv  $GO $DIR_DONE/$FILE.xxx 2>> $DIR_LOG/Log_CSV.err
        rm  $DIR_TMP/$FILE_IN_4 2>> $DIR_LOG/Log_CSV.err
        rm  $DIR_TMP/$FILE_IN_5 2>> $DIR_LOG/Log_CSV.err
    done
#else
#    echo "ER|file not found" >>  $DIR_LOG/Log_CSV.err
#fi
