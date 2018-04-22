### change to the script directory
cd /var/db/rrd/pfstats/

######
######## pf bandwidth and states graph
/usr/local/bin/rrdtool graph pf_stats_bytes_states.png \
-w 785 -h 151 -a PNG \
--slope-mode \
--start end-86400 --end now \
--font DEFAULT:7: \
--title "pf bandwidth and states" \
--watermark "`date`" \
--vertical-label "bytes/sec" \
--right-axis-label "states" \
--right-axis 0.001:0 \
--x-grid MINUTE:10:HOUR:1:MINUTE:120:0:%R \
--alt-y-grid --rigid \
DEF:BytesIn=pf_stats_db.rrd:BytesIn:MAX \
DEF:BytesOut=pf_stats_db.rrd:BytesOut:MAX \
DEF:States=pf_stats_db.rrd:States:MAX \
CDEF:scaled_States=States,1000,* \
AREA:BytesIn#33CC33:"bytes in " \
GPRINT:BytesIn:LAST:"Cur\:  %5.2lf" \
GPRINT:BytesIn:AVERAGE:"Avg\: %5.2lf" \
GPRINT:BytesIn:MAX:"Max\: %5.2lf" \
GPRINT:BytesIn:MIN:"Min\: %5.2lf\t\t" \
LINE1:scaled_States#FF0000:"states" \
GPRINT:States:LAST:"Cur\: %5.2lf" \
GPRINT:States:AVERAGE:"Avg\: %5.2lf" \
GPRINT:States:MAX:"Max\: %5.2lf" \
GPRINT:States:MIN:"Min\: %5.2lf\n" \
LINE1:BytesOut#0000CC:"bytes out" \
GPRINT:BytesOut:LAST:"Cur\: %5.2lf" \
GPRINT:BytesOut:AVERAGE:"Avg\: %5.2lf" \
GPRINT:BytesOut:MAX:"Max\: %5.2lf" \
GPRINT:BytesOut:MIN:"Min\: %5.2lf" 

#####
######## pf packet rate graph
/usr/local/bin/rrdtool graph pf_stats_packets.png \
-w 785 -h 151 -a PNG \
--slope-mode \
--start -86400 --end now \
--font DEFAULT:7: \
--title "pf packet rate" \
--watermark "`date`" \
--vertical-label "pass packets/sec" \
--right-axis-label "block packets/sec" \
--right-axis 0.01:0 \
--right-axis-format %1.1lf \
--x-grid MINUTE:10:HOUR:1:MINUTE:120:0:%R \
--alt-y-grid --rigid \
DEF:PktsInPass=pf_stats_db.rrd:PktsInPass:MAX \
DEF:PktsOutPass=pf_stats_db.rrd:PktsOutPass:MAX \
DEF:PktsInBlock=pf_stats_db.rrd:PktsInBlock:MAX \
DEF:PktsOutBlock=pf_stats_db.rrd:PktsOutBlock:MAX \
CDEF:scaled_PktsInBlock=PktsInBlock,100,* \
CDEF:scaled_PktsOutBlock=PktsOutBlock,100,* \
AREA:PktsInPass#33CC33:"pass in " \
GPRINT:PktsInPass:LAST:"Cur\: %5.2lf" \
GPRINT:PktsInPass:AVERAGE:"Avg\: %5.2lf" \
GPRINT:PktsInPass:MAX:"Max\: %5.2lf" \
GPRINT:PktsInPass:MIN:"Min\: %5.2lf\t\t" \
LINE1:scaled_PktsInBlock#FF0000:"block in " \
GPRINT:PktsInBlock:LAST:"Cur\: %5.2lf" \
GPRINT:PktsInBlock:AVERAGE:"Avg\: %5.2lf" \
GPRINT:PktsInBlock:MAX:"Max\: %5.2lf" \
GPRINT:PktsInBlock:MIN:"Min\: %5.2lf\n" \
LINE1:PktsOutPass#0000CC:"pass out" \
GPRINT:PktsOutPass:LAST:"Cur\: %5.2lf" \
GPRINT:PktsOutPass:AVERAGE:"Avg\: %5.2lf" \
GPRINT:PktsOutPass:MAX:"Max\:  %5.2lf" \
GPRINT:PktsOutPass:MIN:"Min\: %5.2lf\t\t" \
LINE1:scaled_PktsOutBlock#FF8000:"block out" \
GPRINT:PktsOutBlock:LAST:"Cur\: %5.2lf" \
GPRINT:PktsOutBlock:AVERAGE:"Avg\: %5.2lf" \
GPRINT:PktsOutBlock:MAX:"Max\: %5.2lf" \
GPRINT:PktsOutBlock:MIN:"Min\: %5.2lf\t\t"

#####
######## pf state rate graph
/usr/local/bin/rrdtool graph pf_stats_states.png \
-w 785 -h 151 -a PNG \
--slope-mode \
--start -86400 --end now \
--font DEFAULT:7: \
--title "pf state rate" \
--watermark "`date`" \
--vertical-label "states/sec" \
--right-axis-label "searches/sec" \
--right-axis 100:0 \
--x-grid MINUTE:10:HOUR:1:MINUTE:120:0:%R \
--alt-y-grid --rigid \
DEF:StateInserts=pf_stats_db.rrd:StateInserts:MAX \
DEF:StateRemovals=pf_stats_db.rrd:StateRemovals:MAX \
DEF:StateSearchs=pf_stats_db.rrd:StateSearchs:MAX \
CDEF:scaled_StateSearchs=StateSearchs,0.01,* \
AREA:StateInserts#33CC33:"inserts" \
GPRINT:StateInserts:LAST:"Cur\: %5.2lf" \
GPRINT:StateInserts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:StateInserts:MAX:"Max\: %5.2lf" \
GPRINT:StateInserts:MIN:"Min\: %5.2lf\t\t" \
LINE1:scaled_StateSearchs#FF0000:"searches" \
GPRINT:StateSearchs:LAST:"Cur\: %5.2lf" \
GPRINT:StateSearchs:AVERAGE:"Avg\: %5.2lf" \
GPRINT:StateSearchs:MAX:"Max\: %5.2lf" \
GPRINT:StateSearchs:MIN:"Min\: %5.2lf\n" \
LINE1:StateRemovals#0000CC:"removal" \
GPRINT:StateRemovals:LAST:"Cur\: %5.2lf" \
GPRINT:StateRemovals:AVERAGE:"Avg\: %5.2lf" \
GPRINT:StateRemovals:MAX:"Max\: %5.2lf" \
GPRINT:StateRemovals:MIN:"Min\: %5.2lf" 

####### copy to the web directory
cp pf_stats_*.png /var/www/htdocs/internal/graphs

cd -
