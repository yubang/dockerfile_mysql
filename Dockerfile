#mysql环境

FROM centos:6

#yubang打包的镜像，为了开发mysql
MAINTAINER yubang cybzxc@163.com

#安装常用软件
RUN yum -y install vim
RUN yum -y install openssh-server
RUN yum -y install tar
RUN yum -y install wget
RUN yum -y install unzip

#安装mysql5.1
RUN yum -y install mysql mysql-server

#修改mysql密码为root
RUN service mysqld start && mysqladmin -u root password root && service mysqld restart  && service mysqld stop

#修改容器root密码为root
#echo '密码'| passwd --stdin 用户名
RUN echo 'root'| passwd --stdin root

ADD init.sh /var/script/init.sh
ADD my.cnf /var/script/my.cnf
RUN chmod -v +x /var/script/init.sh

#共享文件夹
VOLUME ["/var/data"]

#转发端口
EXPOSE 3306 22

#容器启动执行脚本
ENTRYPOINT ["/var/script/init.sh"]



