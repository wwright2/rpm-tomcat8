
# rpm-tomcat8

An RPM spec file to install Tomcat 8.x.x


Tools for rpm build :

`sudo yum install rpm-build`

To clean the RPM build dir

```
rm -rf rpmbuild
```

edit make_rpm.sh
- set MAJORVERSION="8"
- edit URL="http://archive.apache.org/dist/tomcat"
- test curl $URL/tomcat-$MAJORVERSION/
	- test in a browser
	
SAVE. RUN. ?Look for error messages.
```
./make_rpm.sh
```


Example Output: 
```
find | grep rpm$
```
```
rpmbuild/RPMS/noarch/nicesystems-tomcat8-8.5.34-2.noarch.rpm
rpmbuild/RPMS/noarch/nicesystems-tomcat8-manager-8.5.34-2.noarch.rpm

```