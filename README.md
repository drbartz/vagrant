vagrant
=======
Some vagrant examples if you wanna start a Centos machine to monitoring something

# prereq 
* [vagrant](https://www.vagrantup.com/) up and running;
* The Puppet machine (CentOS-Puppet/) up
	cd CentOS-Puppet
	vagrant up

# CentOS-Puppet
puppet server with all the config to deploy another server

the source configurations used are at [git:drbartz/puppet](https://github.com/drbartz/puppet)
Internal IP: 10.10.10.2

# CentOS-Graphite
Deploy a graphite server from the [git:graphite-project]

You can access at:
	http://127.0.0.1:8083

Internal IP: 10.10.10.3


# CentOS-Zabbix
Deploy a zabbix server from zabbix repo (http://repo.zabbix.com)

You can access at:
	http://127.0.0.1:8085/zabbix
	user: admin
	pass: zabbix

Internal IP: 10.10.10.5

# CentOS-Skyline
Deploy a skyline server from github repo (https://github.com/drbartz/skyline)

You can access at:
	http://127.0.0.1:8086/

Internal IP: 10.10.10.6

