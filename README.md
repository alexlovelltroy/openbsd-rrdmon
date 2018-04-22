Monitor OpenBSD Router

I install this in /var/rrdmon and add this to root's crontab

```
*       *       *       *       *       /var/rrdmon/pfstats/update_database.sh
*       *       *       *       *       /var/rrdmon/health/update_database.sh
*       *       *       *       *       /var/rrdmon/pfstats/create_graphs.sh
*       *       *       *       *       /var/rrdmon/health/create_graphs.sh
```
