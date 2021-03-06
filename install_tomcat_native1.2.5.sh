#!/bin/bash
mkdir temp
cd temp
wget --no-check-certificate https://raw.githubusercontent.com/JeffXue/common-packages/master/apr-1.4.5.tar.gz
wget --no-check-certificate https://raw.githubusercontent.com/JeffXue/common-packages/master/openssl-1.0.2g.tar.gz
wget --no-check-certificate https://raw.githubusercontent.com/JeffXue/common-packages/master/tomcat-native-1.2.5-src.tar.gz
wget --no-check-certificate https://raw.githubusercontent.com/JeffXue/common-packages/master/apache-tomcat-7.0.68.tar.gz

tar xzf apr-1.4.5.tar.gz -C /usr/local/
tar xzf openssl-1.0.2g.tar.gz -C /usr/local/
tar xzf tomcat-native-1.2.5-src.tar.gz -C /usr/local/
tar xzf apache-tomcat-7.0.68.tar.gz -C /usr/local/

cd ..
rm -rf temp

apt-get install libapr1-dev libssl-dev -y

cd /usr/local/apr-1.4.5
./configure --prefix=/usr/local/apr145
make && make install

cd /usr/local/openssl-1.0.2g
./config --prefix=/usr/local/openssl102g  -fPIC no-gost
make depend
make && make install

cd /usr/local/tomcat-native-1.2.5-src/native
./configure --with-apr=/usr/local/apr145 --with-ssl=/usr/local/openssl102g --with-java-home=/usr/local/jdk1.7.0_79 --prefix=/usr/local/apache-tomcat-7.0.68
make && make install

cp /usr/local/apache-tomcat-7.0.68/lib/libtcnative-1.so.0.2.5 /usr/lib/
ln -s /usr/lib/libtcnative-1.so.0.2.5 /usr/lib/libtcnative-1.so
ln -s /usr/lib/libtcnative-1.so.0.2.5 /usr/lib/libtcnative-1.so.0

