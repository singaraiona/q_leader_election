#!/bin/bash
#
# le.sh
# Copyright (C) 2017 Lynx ltd. <anton@algotradinghub.com>
# Created by Anton Kundenko.
#

pids=""
export QINIT=$PWD/king.q
export Q=${HOME}/q/m32/q

trap ctrl_c INT

function ctrl_c() {
    for p in $pids;
    do
        kill -9 $p
    done
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



