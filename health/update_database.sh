#!/usr/local/bin/bash

RRD_DIR="/var/db/rrd/health"
gawk="/usr/local/bin/gawk"
sysctl="/sbin/sysctl"
rrdtool="/usr/local/bin/rrdtool"

health_info() {
    local output=$($sysctl 2>&1)
    local temp=$(echo "$output" | $gawk '
        BEGIN {MbTemp=0; CpuTemp=0; CpuFan=0; PSFan=0; \
               VCore=0; Plus12V=0; Plus3V=0; Plus5V=0; \
               Neg12V=0; CpuSpeed=0}
        {FS = "[= ]"}
        /hw.sensors.cpu0.temp0/ { CpuTemp = $2 }
        /hw.cpuspeed/ { CpuSpeed = $2 }
        /vm.loadavg/ { LoadAvg = $3 }
        END {print CpuTemp ":" CpuSpeed ":" LoadAvg }
        ')
    RETURN_VALUE=$temp
}

### change to the script directory
cd $RRD_DIR

### collect the data
health_info

### update the database
$rrdtool update health_db.rrd --template CpuTemp:CpuSpeed:LoadAvg N:$RETURN_VALUE

cd -
