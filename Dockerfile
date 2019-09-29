## registry.cn-hangzhou.aliyuncs.com/xuweiguo/5.4-fpm:0.0.6 自带扩展
## Core ctype curl date dom ereg fileinfo filter ftp hash iconv json libxml mbstring mhash mysqlnd 
## openssl pcre PDO pdo_sqlite Phar posix readline Reflection session SimpleXML SPL sqlite3 standard 
## tokenizer xml xmlreader xmlwriter zlib


## nabla系统
## bcmath bz2 calendar Core ctype curl date dba dom ereg exif fileinfo filter ftp gd hash iconv 
## imagick json libxml mbstring mcrypt mhash mysql mysqli mysqlnd openssl pcntl pcre PDO pdo_mysql 
## pdo_sqlite posix redis Reflection session shmop SimpleXML soap sockets SPL sqlite3 ssh2 standard 
## sysvsem tokenizer xml xmlreader xmlrpc xmlwriter zip zlib

## 1.0.0  bcmath calendar exif sockets dba mysql mysqli pcntl pdo_mysql shmop  sysvsem 
## 1.0.1  soap  xmlrpc
## 1.0.2  bz2
## 1.0.3  mcrypt
## 1.0.4  zip
## 1.0.4  redis     
##  zip   imagick 
#  sed -i 's/httpredir.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 1.0.0 
FROM registry.cn-hangzhou.aliyuncs.com/xuweiguo/5.4-fpm:0.0.6
RUN docker-php-ext-install  bcmath calendar exif sockets dba mysql mysqli pcntl pdo_mysql shmop  sysvsem 

RUN apt-get update
  	apt-get install -y --no-install-recommends libxml2-dev \
  	rm -r /var/lib/apt/lists/* && \
  	docker-php-ext-install  soap  xmlrpc

RUN apt-get update && \
	apt-get install -y --no-install-recommends libbz2-dev libzip-dev libmcrypt-dev && \
	rm -r /var/lib/apt/lists/* && \
	docker-php-ext-install  bz2 zip && \
	pecl install mcrypt-1.0.1 && \
	docker-php-ext-enable mcrypt


RUN apt-get update && \
	apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
	rm -r /var/lib/apt/lists/* && \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
	docker-php-ext-install  gd

## ssh2
RUN wget http://www.libssh2.org/download/libssh2-1.2.9.tar.gz \
    && mkdir -p /tmp/libssh2 \
    && tar -xf libssh2.tar.gz -C /tmp/libssh2 --strip-components=1 \
    && rm libssh2.tar.gz \
    && ( \
        cd /tmp/libssh2 \
        && ./configure \
        && make \
        && make install \
    ) \
    && rm -r /tmp/libssh2 \
    && pecl install ssh2-0.13 && docker-php-ext-enable ssh2

RUN pecl install redis-4.3.0 && docker-php-ext-enable redis

RUN export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
	apt-get update && \
	apt-get install -y --no-install-recommends libmagickwand-dev && \
	rm -rf /var/lib/apt/lists/* && \
	pecl install imagick-3.4.3 && \
	docker-php-ext-enable imagick

EXPOSE 9000
CMD ["php-fpm"]