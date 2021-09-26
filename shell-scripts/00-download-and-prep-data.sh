format_time() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

clear

start=`date +%s`

sh shell-scripts/01-download-data.sh

sh shell-scripts/02-create-database.sh

sh shell-scripts/03-clean-data.sh

sh shell-scripts/04-populate-database.sh

end=`date +%s`
time_taken=$(( $end - $start ))
formatted_time_taken=$(format_time $time_taken)
echo "\nCOMPLETED IN $formatted_time_taken. DATABASE READY FOR USE"