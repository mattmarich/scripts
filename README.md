M2Dev Tools
===========

The following scripts are a portion of my toolset that I use on a regular basis. 


GBConv
======

GBConv is a tool I created to make assigning cgroup memory settings quick, this lets you skip opening calculator on your workstation or doing manual computations from CLI

gbconv for 15GB conversion:


```bash
root@www:~# gbconv 15
MegaBytes:	15360
KiloBytes:	15728640
Bytes:		16106127360
```



MySQLStatus
============

MySQLStatus was created to give a quick look at MySQL on systems, pretty basic but helps shave some time on troubleshooting issues. Clears screen once the user enters the MySQL root user's password and refreshes once every two seconds


```bash
root@www:~# mysqlstatus
Please enter mysql root user password:
<User Entered Password>

+-------+------+-----------+----+---------+------+----------+------------------+
| Id    | User | Host      | db | Command | Time | State    | Info             |
+-------+------+-----------+----+---------+------+----------+------------------+
| 81187 | root | localhost |    | Query   | 0    | starting | show processlist |
+-------+------+-----------+----+---------+------+----------+------------------+
Uptime: 428087  Threads: 1  Questions: 4391153  Slow queries: 0  Opens: 7414  Flush tables: 11  Open tables: 1162  Queries per second avg: 10.257
```



Strongpass-Gen
==============

Strongpass-gen is another time saving tool, whenever setting a strong password I always found myself just googling 'strong password generator', going to the page, selecting my password requirement settings, and then I would get a password. This lets me get a couple passwords right from CLI


```bash
root@www:~# strongpass-gen
Five Strong Passwords:

vzEggB-IJIt18Yi7
0OW0y3ra2LAfigkb
WnHsV8J4-GdEDM5v
2d6Qt-b6NVwbnB3P
ZpXbv1rnpkfpr9gO
```
