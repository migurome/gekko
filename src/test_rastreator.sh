#!/bin/bash

#          _    _                      _                  _
#     __ _| | _| | __    _ __ __ _ ___| |_ _ __ ___  __ _| |_ ___  _ __
#    / _` | |/ / |/ /   | '__/ _` / __| __| '__/ _ \/ _` | __/ _ \| '__|
#   | (_| |   <|   <    | | | (_| \__ \ |_| | |  __/ (_| | || (_) | |
#    \__, |_|\_\_|\_\___|_|  \__,_|___/\__|_|  \___|\__,_|\__\___/|_|
#    |___/         |_____|

# Rastrea y genera una lista de tickers activos, es decir, que reciben respuesta desde el servicio de yahoo

DIR_CFG="cfg"
DIR_SRC="src"

FILE_ALL="all_tickets.txt"

while IFS= read -r line; do
    NUM=$(python $DIR_SRC/gkk_alive.py $line | wc -l)
    if [ $NUM == '4' ]
    then
	echo $line >> $DIR_CFG/theFINAL
    fi
done < $DIR_CFG/$FILE_ALL
