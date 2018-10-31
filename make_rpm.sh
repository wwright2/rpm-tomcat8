#!/bin/bash

#MAJORVERSION=$(echo $VERSION |cut -d"." -f1 |tr -d "[:space:]")
MAJORVERSION="8"
URL="http://archive.apache.org/dist/tomcat"
# find the latest version 8.xx.xx

[ ! -f "release.txt" ] && echo "release.txt is missing" && exit 1

# GET a listing of 8.x.x tomcat packages.
[ ! -f "tomcat-$MAJORVERSION.list" ] &&  curl $URL/tomcat-$MAJORVERSION/ > tomcat-$MAJORVERSION.list

LATEST=$(egrep -o "[0-9]{1,2}[.][0-9]{1,3}[.][0-9]{1,3}*" tomcat-$MAJORVERSION.list | sort -u | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -n1 )
RELEASE=$( cat release.txt )

[ -z "$LATEST" ] && echo "Error LATEST is null exiting" &&  exit 2
[ -z "$RELEASE" ]  && echo "Error RELEASE is null exiting" && exit 3

cat tomcat8.spec.t | sed -e "/Version:/c\Version:    $LATEST" -e "/Release:/c\Release:    $RELEASE" > tomcat8.spec
cat tomcat8-manager.spec.t | sed -e "/Version:/c\Version:    $LATEST" -e "/Release:/c\Release:    $RELEASE" > tomcat8-manager.spec

VERSION=$LATEST
ARCH=$(grep "BuildArch:" tomcat8.spec |cut -d ":" -f2 |tr -d "[:space:]")

echo "Version: $VERSION-$RELEASE BuildArch: $ARCH "

rm -rf rpmbuild
mkdir rpmbuild
mkdir rpmbuild/BUILD
mkdir rpmbuild/RPMS
mkdir rpmbuild/SOURCES
mkdir rpmbuild/SPECS
mkdir rpmbuild/SRPMS

# Dont download if it already exists.
[ ! -f "apache-tomcat-$VERSION.tar.gz" ] && `wget http://archive.apache.org/dist/tomcat/tomcat-$MAJORVERSION/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz -O apache-tomcat-$VERSION.tar.gz`


##########################
# Add custom tomfoolery
# POC- Nick
##########################
#ww tar -xzpf apache-tomcat-$VERSION.tar.gz
#cp java-libs apache-tomcat-$VERSION/conf
#mv apache-tomcat-$VERSION.tar.gz apache-tomcat-$VERSION.tar.gz.old
#cd apache-tomcat-$VERSION/webapps/manager/
#jar -cvf manager.war *
#cd -
#tar -czpf apache-tomcat-$VERSION.tar.gz apache-tomcat-$VERSION
#ww-end


ln -v -s "$(pwd)/apache-tomcat-$VERSION.tar.gz" "rpmbuild/SOURCES/"
ln -v -s "$(pwd)/tomcat8."{init,logrotate,sysconfig,bin,conf} "rpmbuild/SOURCES/"
ln -v -s "$(pwd)/tomcat8.spec" "rpmbuild/SPECS/"

pushd rpmbuild

#ww hostname build.nice.com

rpmbuild --buildroot "`pwd`/BUILDROOT" ../tomcat8.spec -bb --define "_topdir `pwd`"
rpmbuild --buildroot "`pwd`/BUILDROOT" ../tomcat8-manager.spec -bb --define "_topdir `pwd`"

popd
find rpmbuild | grep rpm$


#publish-rpm $VERSION $RELEASE $ARCH suite-tomcat8 "RPMS/$ARCH/tomcat8-$VERSION-$RELEASE.$ARCH.rpm"
