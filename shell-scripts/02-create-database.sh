format_time() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

database_creation_start=`date +%s`

echo "\nCREATING DATABASE big-data-bowl-2022.db IN ROOT DIRECTORY\n"
sqlite3 big-data-bowl-2022.db < sql-queries/create-tables.sql

database_creation_end=`date +%s`
database_creation_time=$(( $database_creation_end - $database_creation_start ))
echo "DATABASE CREATED IN $(format_time $database_creation_time)\n"