#!/bin/bash
#
# le.sh
# Copyright (C) 2017 Lynx ltd. <anton@algotradinghub.com>
# Created by Anton Kundenko.
#

pids=""
export QINIT=$PWD/king.q
export Q=q64

trap ctrl_c INT

function ctrl_c() {
    killall -9 $Q >/dev/null 2>&1;
}


for i in `seq 1 3`;
do
    $Q -p "500$i" &
    pids="$pids $!"
    echo "instance 500${i} is running."
done

wait $pids >/dev/null 2>&1;

echo end

exit 0;



