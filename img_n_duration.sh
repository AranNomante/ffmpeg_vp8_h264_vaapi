#$1 inp
#$2 secs
ffmpeg -i $1 -ss $2 -vframes 1 -f image2 -s 1920x1080 thumbnail

