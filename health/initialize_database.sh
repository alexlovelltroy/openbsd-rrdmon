#!/usr/local/bin/bash

RRD_DIR="/var/db/rrd/health"
RRDTOOL="/usr/local/bin/rrdtool"

cd $RRD_DIR

$RRDTOOL create health_db.rrd \
    --step 60 \
    DS:CpuTemp:GAUGE:120:0:10000000000000 \
    DS:CpuSpeed:GAUGE:120:0:10000000000000 \
    DS:LoadAvg:GAUGE:120:0:10000000000000 \
    RRA:MAX:0.5:1:1500 

cd -
