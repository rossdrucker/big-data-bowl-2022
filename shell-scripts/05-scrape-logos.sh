format_time() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

start=`date +%s`

echo "SCRAPING ESPN FOR TEAM LOGOS\n"

mkdir -p img/team-logos

cd img/team-logos
touch .gitkeep

cd ../..

mkdir -p img/team-wordmarks
cd img/team-wordmarks
touch .gitkeep

cd ../..

cd img/

touch .gitkeep

cd ..

python helpers/scrape-logos.py

echo "\nSCRAPING WIKIPEDIA FOR TEAM WORDMARKS\n"

python helpers/scrape-wordmarks.py

cd img/team-wordmarks

sed -e 's/#FFFFFF/#ffb612/g' wft.svg > washington-football-team.svg

rm wft.svg

cd ../..

end=`date +%s`
time_taken=$(( $end - $start ))
download_time=$(format_time $time_taken)
echo "LOGOS AND WORDMARKS SCRAPED IN $download_time\n"