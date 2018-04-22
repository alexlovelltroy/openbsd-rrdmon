#!/usr/local/bin/bash

gawk="/usr/local/bin/gawk"
pfctl="/sbin/pfctl"
rrdtool="/usr/local/bin/rrdtool"

pfctl_info() {
    local output=$($pfctl -si 2>&1)
    local temp=$(echo "$output" | $gawk '
        BEGIN {BytesIn=0; BytesOut=0; PktsInPass=0; PktsInBlock=0; \
               PktsOutPass=0; PktsOutBlock=0; States=0; StateSearchs=0; \
               StateInserts=0; StateRemovals=0}
        /Bytes In/ { BytesIn = $3 }
        /Bytes Out/ { BytesOut = $3 }
        /Packets In/ { getline;PktsInPass = $2 }
        /Passed/ { getline;PktsInBlock = $2 }
        /Packets Out/ { getline;PktsOutPass = $2 }
        /Passed/ { getline;PktsOutBlock = $2 }
        /current entries/ { States = $3 }
        /searches/ { StateSearchs = $2 }
        /inserts/ { StateInserts = $2 }
        /removals/ { StateRemovals = $2 }
        END {print BytesIn ":" BytesOut ":" PktsInPass ":" \
             PktsInBlock ":" PktsOutPass ":" PktsOutBlock ":" \
             States ":" StateSearchs ":" StateInserts ":" StateRemovals}
        ')
    RETURN_VALUE=$temp
}

### change to the script directory
cd /var/db/rrd/pfstats/

### collect the data
pfctl_info

### update the database
$rrdtool update pf_stats_db.rrd --template BytesIn:BytesOut:PktsInPass:PktsInBlock:PktsOutPass:PktsOutBlock:States:StateSearchs:StateInserts:StateRemovals N:$RETURN_VALUE

cd -
