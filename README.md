# zabbix_ipvsadm
Thanks for shota https://www.zabbix.com/forum/showthread.php?t=12086

This program based on above.
For monitoring Linux Virtual Server statistics.

## Usage
* Put ipvsadm_discover.sh and ipvsadm.py into /etc/zabbix/ as executable.
* Add UserParameter written in below to /etc/zabbix/zabbix_agentd.conf
```
UserParameter=ipvsadm.activeconn[*],/etc/zabbix/ipvsadm.py active $1 $2 $3
UserParameter=ipvsadm.inactconn[*],/etc/zabbix/ipvsadm.py inactive $1 $2 $3
UserParameter=ipvsadm.weight[*],/etc/zabbix/ipvsadm.py weight $1 $2 $3
UserParameter=ipvsadm.discovery,/etc/zabbix/ipvsadm_discover.sh
```
* Allow sudo for zabbix user
```
Defaults:zabbix !requiretty
zabbix	ALL=(ALL)	NOPASSWD: /sbin/ipvsadm
```
* Then test "zabbix_get -s IPADDRESS -k ipvsadm.discovery"
* If above is OK, import the template "Template_LVS_connections.xml" to zabbix server.
