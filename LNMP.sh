#!/bin/bash

yum -y install gcc make pcre-devel zlib-devel mariadb-server  mariadb-devel mariadb php  php-mysql php-fpm-5.4.16-42.el7.x86_64.rpm
useradd -s /sbin/nologin nginx

###部署nginx
tar -zxf nginx-1.12.2.tar.gz  -C /root/
cd /root/nginx-1.12.2/
./configure --prefix=/usr/local/nginx --user=nginx  --group=nginx
make && make install

###修改配置信息,开启支持php页面服务
sed -i  '65,71s/#//'  /usr/local/nginx/conf/nginx.conf
sed -i  '69s/^/#/'  /usr/local/nginx/conf/nginx.conf
sed -i  '70s/fastcgi_params/fastcgi.conf/'  /usr/local/nginx/conf/nginx.conf

###启动服务
systemctl start php-fpm.service
systemctl enable php-fpm.service
systemctl start mariadb
systemctl enable mariadb

netstat -untpl | grep 9000
netstat -untpl | grep 3306
netstat -untpl | grep 80




