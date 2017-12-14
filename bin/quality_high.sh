#!/bin/sh

file="stream_"$1"_high.pid"

test()
{
    pkill -KILL -$PGID
    rm $file
    exit
}

trap 'test' TERM

echo ${$} > $file
sleep 5
line=`ffprobe 'rtmp://127.0.0.1:'$2'/live/'$1  -analyzeduration 10M -probesize 10M -show_entries stream=width,height -v quiet -of compact=nokey=1 | sed -n 2p`
height=`echo $line | cut -d '|' -f 2`
width=`echo $line | cut -d '|' -f 3`
if [ $height -ge 1920 ]
then
    if [ $width -ge 1080 ] #le && ne marche pas alors yolo
    then
       echo "running" >> $file
       ffmpeg -analyzeduration 10M -probesize 10M -i 'rtmp://127.0.0.1:'$2'/live/'$1 -preset superfast -max_muxing_queue_size 10240 -c:v libx264 -vf scale=1920:1080 -level:v 30 -f flv 'rtmp://127.0.0.1:'$2'/show/'$1'_high'
    fi
fi
