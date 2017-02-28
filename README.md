#install required tools
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev

#nginx source code
wget http://nginx.org/download/nginx-1.9.15.tar.gz

#RTMP module
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip

#Then execute
tar -zxvf nginx-1.9.15.tar.gz
unzip master.zip

cd nginx-1.9.15
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
sudo make install

##Move nginx.conf to /usr/local/nginx/conf/nginx.conf

#then execute nginx
sudo /usr/local/nginx/sbin/nginx

#stopped with
sudo /usr/local/nginx/sbin/nginx -s stop

##OBS settings##
# Stream Service : Custom
# Server	 : rtmp://<server ip>/live
