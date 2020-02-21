DIR_CSV="CSV"
DIR_DONE="CSV/done"

for GO in "$DIR_DONE"/*.xxx
    do
        FILE=$(ls $GO| awk -F\/ '{print $3}' | awk -F "." '{print $1}' ) #2>> $DIR_LOG/Log_CSV.err
        mv $DIR_DONE/$FILE.xxx $DIR_CSV/$FILE.csv
    done
