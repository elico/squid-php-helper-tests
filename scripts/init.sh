#!/usr/bin/env bash

dnf update -y

dnf module enable mariadb:10.5 -y
dnf module enable php:7.4 -y
#dnf module enable ruby:2.6 -y 

dnf install oracle-epel-release-el8 -y

dnf config-manager --set-enabled ol8_codeready_builder

dnf install -y bash-completion htop fish vim wget git rsync ruby ruby-devel unzip tree make \
	httpd php-fpm php-json php-xml php-mysqlnd php-cli php-common php-zip php-opcache php-readline php-curl php-gd mariadb-server mariadb-server-utils python3-pip \
	redis memcached php-pear php-devel

systemctl enable --now httpd redis

mkdir /opt/src

tar xvf /vagrant/archive/oracle-install-ngtech-cert.tar.gz -C /opt/src/

cd /opt/src/oracle-install-ngtech-cert/ && make install-cert

pecl channel-update pecl.php.net
printf "\n" |pecl install redis
echo  "extension=redis.so" > /etc/php.d/90-redis.ini
php -m | grep redis

cat > /etc/yum.repos.d/squid.repo <<EOF
[ngtech_squid]
name=NgTech Squid
baseurl=https://www.ngtech.co.il/repo/oracle/8/\$basearch/
gpgcheck=0
enabled=1
EOF

dnf module -y disable squid

dnf install -y squid squid-helpers
cp /vagrant/archive/php-helpers/session-helper.php /usr/local/bin/session-helper.php
chmod +x /usr/local/bin/session-helper.php

cat /vagrant/archive/php-helpers/session_helper.conf /etc/squid/squid.conf > /etc/squid/squid.conf.in && mv /etc/squid/squid.conf.in /etc/squid/squid.conf

systemctl enable squid
systemctl restart squid redis
