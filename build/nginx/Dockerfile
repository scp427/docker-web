FROM ubuntu:16.04
MAINTAINER yuhari
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update

RUN apt-get -y install build-essential libpcre3 libpcre3-dev openssl libssl-dev libxml2 libxml2-dev libxslt1-dev libgd-dev libgd2-xpm-dev libgeoip-dev

RUN mkdir /software
RUN mkdir /software/temp
RUN mkdir /var/lib/nginx && mkdir /var/lib/nginx/body

RUN apt-get install -y wget unzip 
RUN wget http://nginx.org/download/nginx-1.12.1.tar.gz && tar -zxvf nginx-1.12.1.tar.gz -C /software/temp

ADD nginx-upstream-fair-master/* /software/temp/nginx-upstream-fair-master/

RUN cd /software/temp/nginx-1.12.1 && ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-log-path=/var/log/nginx/access.log --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --with-debug --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-sha1=/usr/include/openssl --with-mail --with-mail_ssl_module --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads --add-module=/software/temp/nginx-upstream-fair-master && make && make install

RUN apt-get remove -y wget unzip
RUN apt-get clean -y && apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /software

RUN echo "\ndaemon off;\n" >> /etc/nginx/nginx.conf
RUN echo "\n* soft nofile 65535\n* hard nofile 65535\n" >> /etc/security/limits.conf

ADD sysctl.conf /etc/sysctl.conf

EXPOSE 80 443

CMD ["nginx"]

