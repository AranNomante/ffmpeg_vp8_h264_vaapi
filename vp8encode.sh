#Bufsize and minrate are added but not tested 

#$1 input filename
#$2 good realtime best
#$3 --cpu-used for best and good deadline valid values are from 0 to 5 for realtime 0 to 15
#$4 tile columns allow multi threading use powers of 2 eg 2=4
#$5 no threads to use
#$6 minrate around 2k is good for 1080p60
#$7 out filename
# -b:v bitrate 512k maybe too low for 720p30 try 1500k to 2000k 
#for fast/quality use realtime 6-7 
#for very good quality use good 2
start=$(date +%s.%N)
ffmpeg -i $1 -r 30 -g 90 -s 1280x720 -aspect 16:9 -c:v libvpx -deadline $2 -row-mt 1 -b:v 2500k -threads $5 -tile-columns $4 -cpu-used $3 -minrate $6 -bufsize 3000k -maxrate 3000k -crf 30 -frame-parallel 1 $7.webm
duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time"
mv $7.webm $7.mp4
