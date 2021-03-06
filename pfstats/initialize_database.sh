## change directory to the rrdtool script dir
cd /var/db/rrd/pfstats/

rrdtool create pf_stats_db.rrd \
--step 60 \
DS:BytesIn:COUNTER:120:0:10000000000000 \
DS:BytesOut:COUNTER:120:0:10000000000000 \
DS:PktsInPass:COUNTER:120:0:10000000000000 \
DS:PktsInBlock:COUNTER:120:0:10000000000000 \
DS:PktsOutPass:COUNTER:120:0:10000000000000 \
DS:PktsOutBlock:COUNTER:120:0:10000000000000 \
DS:States:GAUGE:120:0:10000000000000 \
DS:StateSearchs:COUNTER:120:0:10000000000000 \
DS:StateInserts:COUNTER:120:0:10000000000000 \
DS:StateRemovals:COUNTER:120:0:10000000000000 \
RRA:MAX:0.5:1:1500 

cd -
