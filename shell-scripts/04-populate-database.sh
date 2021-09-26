format_time() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

populate_database_start=`date +%s`

echo "\nPOPULATING DATABASE big-data-bowl-2022.db WITH DATA IN db-data/\n"
sqlite3 big-data-bowl-2022.db < sql-queries/populate-database.sql

echo "REMOVING TEMPORARY DIRECTORY FOR DATABASE DATA LOADING\n"
rm -r db-data

populate_database_end=`date +%s`
populate_database_time=$(( $populate_database_end - $populate_database_start ))
echo "DATABASE POPULATED IN $(format_time $populate_database_time)\n"