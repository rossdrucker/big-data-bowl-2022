start=`date +%s`
echo "SETTING UP DIRECTORY data-raw\n"
mkdir data-raw
cd data-raw
echo "DOWNLOADING DATA FROM KAGGLE\n"
kaggle competitions download -c nfl-big-data-bowl-2022
echo "\nEXTRACTING FILES FROM KAGGLE .zip DOWNLOAD\n"
unzip nfl-big-data-bowl-2022.zip
echo "\nDELETING .zip FILE\n"
rm nfl-big-data-bowl-2022.zip
end=`date +%s`
timetaken=$(( $end - $start ))
echo "COMPLETED IN $timetaken SECONDS. DATA READY FOR USE"