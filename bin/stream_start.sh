#!/bin/sh

file="/etc/nginx/running/stream_"$1".txt"
low_quality_pid="/etc/nginx/bin/stream_"$1"_low.pid"
medium_quality_pid="/etc/nginx/bin/stream_"$1"_medium.pid"
high_quality_pid="/etc/nginx/bin/stream_"$1"_high.pid"

end()
{
    pkill -TERM `cat $low_quality_pid | sed -n 1p`
    pkill -TERM `cat $medium_quality_pid | sed -n 1p`
    pkill -TERM `cat $high_quality_pid | sed -n 1p`
    rm $file
    exit
}

trap 'end' TERM

while true; do
    echo "running" > $file
    low=`cat $low_quality_pid | sed -n 2p`
    echo "low:"$low >> $file
    medium=`cat $medium_quality_pid | sed -n 2p`
    echo "medium:"$medium >> $file
    high=`cat $high_quality_pid | sed -n 2p`
    echo "high:"$high >> $file
    sleep 15
done
