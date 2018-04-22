#!/usr/local/bin/bash

RRD_DIR="/var/db/rrd/health"
RRDTOOL="/usr/local/bin/rrdtool"

### change to the script directory
cd $RRD_DIR

## Graph for last 24 hours 
$RRDTOOL graph health_of_system.png \
-w 785 -h 151 -a PNG \
--slope-mode \
--logarithmic --units=si \
--start end-86400 --end now \
--font DEFAULT:7: \
--title "system health" \
--watermark "`date`" \
--vertical-label "hw.sensors" \
--right-axis-label "speeds" \
--right-axis 100:0 \
--x-grid MINUTE:10:HOUR:1:MINUTE:120:0:%R \
--alt-y-grid --rigid \
DEF:CpuTemp=health_db.rrd:CpuTemp:MAX \
DEF:CpuSpeed=health_db.rrd:CpuSpeed:MAX \
DEF:LoadAvg=health_db.rrd:LoadAvg:MAX \
CDEF:scaled_CpuSpeed=CpuSpeed,0.01,* \
LINE1:CpuTemp#00D600:"CPU temp" \
GPRINT:CpuTemp:LAST:"Cur\: %5.2lf" \
GPRINT:CpuTemp:AVERAGE:"Avg\: %5.2lf" \
GPRINT:CpuTemp:MAX:"Max\: %5.2lf" \
GPRINT:CpuTemp:MIN:"Min\: %5.2lf\t\t" \
LINE1:scaled_CpuSpeed#FF0066:"CPU Freq" \
GPRINT:CpuSpeed:LAST:"Cur\: %5.2lf" \
GPRINT:CpuSpeed:AVERAGE:"Avg\: %5.2lf" \
GPRINT:CpuSpeed:MAX:"Max\: %5.2lf" \
GPRINT:CpuSpeed:MIN:"Min\: %5.2lf\n" \
LINE1:LoadAvg#0000FF:"Load Avg" \
GPRINT:LoadAvg:LAST:"Cur\: %5.2lf" \
GPRINT:LoadAvg:AVERAGE:"Avg\: %5.2lf" \
GPRINT:LoadAvg:MAX:"Max\: %5.2lf" \
GPRINT:LoadAvg:MIN:"Min\: %5.2lf\n" \

## copy to the web directory
cp health_*.png /var/www/htdocs/internal/graphs/

