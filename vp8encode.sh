#$1 input filename
#$2 good realtime best
#$3 --cpu-used for best and good deadline valid values are from 0 to 5 for realtime 0 to 15
#$4 tile columns allow multi threading use powers of 2 eg 2=4
#$5 no threads to use
#$6 out filename
# -b:v bitrate 512k maybe too low for 720p30 try 1500k to 2000k 
#for fast/quality use realtime 6-7 
#for very good quality use good 2
start=$(date +%s.%N)
ffmpeg -i $1 -r 30 -g 90 -s 1280x720 -aspect 16:9 -c:v libvpx -deadline $2 -row-mt 1 -b:v 2500k -threads $5 -tile-columns $4 -cpu-used $3 -maxrate 3000k -crf 30 -frame-parallel 1 $6.webm

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time"
mv $6.webm $6.mp4
