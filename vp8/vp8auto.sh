# $1 ifilename $2 outfilename $3 orientation 0: default 1:horizontal
echo $0;
starttime=$(date +%s);
eval $(ffprobe -v quiet -show_format -of flat=s=_ -show_entries stream=r_frame_rate,height,nb_frames,duration,codec_name $1);
rfps=${streams_stream_0_r_frame_rate};
height=${streams_stream_0_height};
bitrate=$((${format_bit_rate}/1000));
codec=${streams_stream_0_codec_name};
duration=${streams_stream_0_duration};
duration=${duration%.*};
echo "INPUT SPECIFICS:";
echo "----------------";
echo $rfps,$height,$bitrate,$codec,$duration;
echo "----------------";
cores=$(cat /proc/cpuinfo 2>&1 | grep cores | awk 'NR == 1');
IFS=':'
read -ra SPLCR <<< "$cores"
numcores="$(echo -e "${SPLCR[1]}" | sed -e 's/^[[:space:]]*//')";
tilecols=$(echo $numcores | awk '{printf "%d",(log($1)/log(2))}');
IFS='/' # hyphen (-) is set as delimiter
read -ra ADDR <<< "$rfps" # str is read into an array as tokens separated by IFS
frames=${ADDR[0]};
divisor=${ADDR[1]};
fps=$(expr $frames / $divisor);
fps=${fps%.*};
gop=$(( $fps * 2 ));
bufsize=4500k;
bvrate=512k;
filename=$1;
outfile=$2;
resolution=1920x1080;
aspect=16:9
IFS=' ' # reset to default value after usage
if [ $fps -gt 60 ]
then
	fps=60;
	gop=120;
fi
if [ $duration -gt 60 ]
then
	bufsize=3000k;
fi
if [ $bitrate -gt 4500 ]
then
	bvrate=2500k;
elif [ $bitrate -gt 3000 ]
then
	bvrate=2000k;
elif [ $bitrate -gt 2000 ]
then
	bvrate=1000k;
fi
if [  $height -ge 1080 ]
then
	resolution=1920x1080;
elif [ $height -ge 720 ]
then
	resolution=1280x720;
elif [ $height -ge 480 ]
then
	resolution=720x480;
else
	resolution=640x360;
fi
if [ $3 -eq 1 ]
then
	IFS='x'
	read -ra ORIENT <<< "$resolution"
	resolution=${ORIENT[1]}x${ORIENT[0]};
	IFS=' '
	aspect=9:16;
fi
#invert resolution if passed as command
#inputs in order filename,tilecols,numcores,outfile,bvrate,bufsize,fps,resolution
echo "OUTPUT SPECIFICS:";
echo "-----------------";
echo $filename,$tilecols,$numcores,$gop,$outfile,$bvrate,$bufsize,$fps,$resolution;
echo "-----------------";
ffmpeg -i $filename -r $fps -g $gop -s $resolution -aspect $aspect -c:v libvpx -deadline good -row-mt 1 -b:v $bvrate -threads $numcores -tile-columns $tilecols -cpu-used 2 -bufsize $bufsize  -crf 5 -frame-parallel 1 $outfile.webm
endtime=$(date +%s);
dif=$(( $endtime - $starttime ));
echo "It takes $dif seconds to complete this task...";

