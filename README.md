rpm-tomcat8
===========

An RPM spec file to install Tomcat 8.0.

To Build:

`sudo yum -y install rpmdevtools && rpmdev-setuptree`

`wget https://raw.github.com/gdelprete/rpm-tomcat8/master/tomcat8.spec -O ~/rpmbuild/SPECS/tomcat8.spec`

`wget https://raw.github.com/gdelprete/rpm-tomcat8/master/tomcat8.init -O ~/rpmbuild/SOURCES/tomcat8.init`

`wget https://raw.github.com/gdelprete/rpm-tomcat8/master/tomcat8.sysconfig -O ~/rpmbuild/SOURCES/tomcat8.sysconfig`

`wget https://raw.github.com/gdelprete/rpm-tomcat8/master/tomcat8.logrotate -O ~/rpmbuild/SOURCES/tomcat8.logrotate`

`wget http://www.motorlogy.com/apache/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz -O ~/rpmbuild/SOURCES/apache-tomcat-7.0.55.tar.gz`

`rpmbuild -bb ~/rpmbuild/SPECS/tomcat8.spec`

