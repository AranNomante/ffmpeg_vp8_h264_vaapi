#$1 input filename
#$2 no threads to use
#$3 preset ultrafast superfast veryfast faster fast medium slow slower veryslow
#$4 min bitrate specify around 1k when using slower encoding else put 0-500
#$5 crf 0 means lossless don't go over 30 - 22-25 is a good range
#$6 out filename
# -b:v bitrate 512k maybe too low for 720p30 try 1500k to 2000k 
#for fast/quality use realtime 6-7 
#for very good quality use good 2
start=$(date +%s.%N)
ffmpeg -i $1 -r 30 -g 90 -s 1920x1080 -aspect 16:9 -c:v libx264 -preset $3  -b:v 2500k -threads $2 -minrate $4  -maxrate 3000k -bufsize 3000k -crf $5  $6.mp4

duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time"
