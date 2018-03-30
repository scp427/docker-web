FROM ubuntu:16.04
RUN apt-get update

RUN apt-get install -y php-dev pkg-config
RUN apt-get install -y php-fpm
RUN apt-get install -y php-curl php-mcrypt php-mysql 
RUN apt-get install -y php-mbstring php-gd php-imagick php-imap php-intl
RUN apt-get install -y mysql-client sphinxsearch libcurl4-gnutls-dev

RUN mkdir /software
RUN apt-get install -y wget && wget -P /software http://pecl.php.net/get/redis-3.1.6.tgz && wget -P /software http://pecl.php.net/get/yar-2.0.4.tgz && wget -P /software http://pecl.php.net/get/memcached-3.0.4.tgz
RUN wget -P /software https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz 
RUN cd /software && tar zxvf redis-3.1.6.tgz && tar zxvf yar-2.0.4.tgz && tar zxvf memcached-3.0.4.tgz && tar zxvf libmemcached-1.0.18.tar.gz 
RUN cd /software/libmemcached-1.0.18 && ./configure -prefix=/usr/lib/libmemcached && make && make install 
RUN cd /software/memcached-3.0.4 && phpize && ./configure --with-php-config=php-config --with-libmemcached-dir=/usr/lib/libmemcached --disable-memcached-sasl && make && make install 
RUN cd /software/redis-3.1.6 && phpize && ./configure --with-php-config=php-config && make && make install 
RUN cd /software/yar-2.0.4 && phpize && ./configure --with-php-config=php-config && make && make install 

ENV PHP_EXT_DIR /etc/php/7.0/mods-available

RUN cd $PHP_EXT_DIR && echo 'extension=redis.so' > redis.ini && echo 'extension=memcached.so' > memcached.ini && echo 'extension=yar.so' > yar.ini
RUN ln -s $PHP_EXT_DIR/redis.ini $PHP_EXT_DIR/../fpm/conf.d/20-redis.ini && ln -s $PHP_EXT_DIR/memcached.ini $PHP_EXT_DIR/../fpm/conf.d/20-memcached.ini && ln -s $PHP_EXT_DIR/yar.ini $PHP_EXT_DIR/../fpm/conf.d/20-yar.ini
RUN ln -s $PHP_EXT_DIR/redis.ini $PHP_EXT_DIR/../cli/conf.d/20-redis.ini && ln -s $PHP_EXT_DIR/memcached.ini $PHP_EXT_DIR/../cli/conf.d/20-memcached.ini && ln -s $PHP_EXT_DIR/yar.ini $PHP_EXT_DIR/../cli/conf.d/20-yar.ini
RUN cd 

RUN echo "\n* soft nofile 65535\n* hard nofile 65535\n" >> /etc/security/limits.conf

ADD sysctl.conf /etc/sysctl.conf
RUN echo '\ndaemonize=no\n' >> $PHP_EXT_DIR/../fpm/php-fpm.conf

RUN mkdir /run/php

RUN rm -rf /software
RUN apt-get remove -y wget php-dev
RUN apt-get clean -y && apt-get autoremove -y

EXPOSE 9000

CMD ["php-fpm7.0"]