#!/bin/bash

cat > /etc/sysconfig/network <<__END__
NETWORKING=yes
HOSTNAME=puppet.home
__END__

cat > /etc/yum.repos.d/puppet.repo <<__END__
[puppetlabs]
name=Puppet Labs Packages
baseurl=http://yum.puppetlabs.com/el/6/products/x86_64/
enabled=1
gpgcheck=0
[puppetlabs2]
name=Puppet Labs Packages Deps
baseurl=http://yum.puppetlabs.com/el/6/dependencies/x86_64/
enabled=1
gpgcheck=0
__END__

yum -y install puppet-server git
chkconfig --level 3 puppetmaster on

cat > /etc/sysconfig/iptables <<__END__
# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8140 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
__END__
service iptables restart

install -d /etc/puppet/git
cd /etc/puppet/git
git clone https://github.com/drbartz/puppet/
rm -rf /etc/puppet/modules /etc/puppet/manifests
ln -s /etc/puppet/git/puppet/manifests /etc/puppet/manifests
ln -s /etc/puppet/git/puppet/modules /etc/puppet/modules

service puppetmaster start
puppet agent --test --verbose
