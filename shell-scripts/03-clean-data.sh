format_time() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

data_cleaning_start=`date +%s`

echo "\nCREATING TEMPORARY DIRECTORY FOR DATABASE DATA LOADING\n"
mkdir db-data

echo "CLEANING DATA FILES\n"
sed '1d' data-raw/games.csv > db-data/games-cleaned.csv
sed '1d' data-raw/PFFScoutingData.csv > db-data/PFFScoutingData-cleaned.csv
sed '1d' data-raw/players.csv > db-data/players-cleaned.csv
sed '1d' data-raw/plays.csv > db-data/plays-cleaned.csv
sed '1d' data-raw/tracking2018.csv > db-data/tracking2018-cleaned.csv
sed '1d' data-raw/tracking2019.csv > db-data/tracking2019-cleaned.csv
sed '1d' data-raw/tracking2020.csv > db-data/tracking2020-cleaned.csv
cat db-data/tracking*-cleaned.csv >> db-data/tracking-cleaned.csv

data_cleaning_end=`date +%s`
data_cleaning_time=$(( $data_cleaning_end - $data_cleaning_start ))
echo "DATA CLEANED IN $(format_time $data_cleaning_time)\n"