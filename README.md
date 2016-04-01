# Oracle database 12c server container #

Big thanks to Frits Hoogland for [sharing Dockerfile and knowledge](https://fritshoogland.wordpress.com/2015/08/11/installing-the-oracle-database-in-docker/)!

## Pre-requisites ##

First download the required software files : 

[Oracle Database 12c Release 1 - file 1](http://download.oracle.com/otn/linux/oracle12c/121020/linuxamd64_12102_database_1of2.zip)

[Oracle Database 12c Release 1 - file 2](http://download.oracle.com/otn/linux/oracle12c/121020/linuxamd64_12102_database_2of2.zip)

[Oracle Database 12c Release 1 Examples](http://download.oracle.com/otn/linux/oracle12c/121020/linuxamd64_12102_examples.zip)

[utPLSQL source files](http://jaist.dl.sourceforge.net/project/utplsql/utPLSQL/2.3.0/utplsql-2-3-0.zip)

## Install ##

The script `deploy_ora12_container.sh` may be used to build the image and start a container.


The database listens on default port 1521.  
Password of users SYS and SYSTEM is oracle. 



