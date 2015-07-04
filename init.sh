#!/bin/bash

#复制数据库文件
if [ ! -e "/var/data/db" ]
then
    cp -Rv /var/lib/mysql /var/data/db
    cp -vf /var/script/my.cnf /etc/my.cnf
    chmod -Rv 777 /var/data/db
    service mysqld start
    mysql -u root -proot -e 'use mysql;GRANT ALL PRIVILEGES ON *.* TO "root"@"%" WITH GRANT OPTION ; UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root' AND Host='%';FLUSH PRIVILEGES;'
    mysqladmin -u root password root
    service mysqld stop
fi

setenforce 0
service mysqld start
service sshd start


while true ; do
     sleep 100
done
