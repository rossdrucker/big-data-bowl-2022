format_time() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

download_start=`date +%s`

echo "SETTING UP DIRECTORY data-raw\n"
mkdir data-raw

cd data-raw
touch .gitkeep

kaggle competitions download -c nfl-big-data-bowl-2022

echo "\nEXTRACTING FILES FROM KAGGLE .zip DOWNLOAD\n"
unzip nfl-big-data-bowl-2022.zip

echo "\nDELETING .zip FILE\n"
rm nfl-big-data-bowl-2022.zip

download_end=`date +%s`

download_time=$(( $download_end - $download_start ))
echo "FILES DOWNLOADED IN $(format_time $download_time)\n"