## php:5.4-fpm 自带扩展
## Core ctype curl date dom ereg fileinfo filter hash iconv json libxml mysqlnd openssl pcre PDO 
## pdo_sqlite Phar posix readline recode Reflection session SimpleXML SPL sqlite3 standard tokenizer 
## xml xmlreader xmlwriter zlib
## 
## nabla系统
## bcmath bz2 calendar Core ctype curl date dba dom ereg exif fileinfo filter ftp gd hash iconv 
## imagick json libxml mbstring mcrypt mhash mysql mysqli mysqlnd openssl pcntl pcre PDO pdo_mysql 
## pdo_sqlite posix redis Reflection session shmop SimpleXML soap sockets SPL sqlite3 ssh2 standard 
## sysvsem tokenizer xml xmlreader xmlrpc xmlwriter zip zlib
# netselect-apt -s testing -o /etc/apt/sources.list.2

FROM php:5.4-fpm 

## 附带软件安装
RUN apt-get update && \
	apt-get install -y --no-install-recommends libbz2-dev \
	libmcrypt-dev \
	libssl-dev \
	libmcrypt-dev \
	&&  rm -r /var/lib/apt/lists/*

## 扩展安装自带
RUN docker-php-ext-install bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop sysvsem bz2 ftp soap  mysql  mcrypt

## redis
RUN pecl install redis-4.3.0 && docker-php-ext-enable redis

# 增加 GD 扩展. 图像处理
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


## imagick 
#RUN export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
#	apt-get update && \
#	apt-get install -y --no-install-recommends libmagickwand-dev && \
#	rm -rf /var/lib/apt/lists/* && \
#	pecl install imagick-3.4.3 && \
#	docker-php-ext-enable imagick

## mhash
#RUN wget https://nchc.dl.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz \
&& mkdir -p /tmp/mhash \
&& tar -xf mhash-0.9.9.9.tar.gz -C /tmp/mhash --strip-components=1 \
&& rm mhash-0.9.9.9.tar.gz \
&& ( \
    cd /tmp/mhash \
    && ./configure \
    && make \
    && make install \
) \
#&& rm -r /tmp/mhash \
#&& docker-php-ext-configure -with-mhash=/tmp/mhash \
#    && docker-php-ext-install /tmp/xcache \
#    && rm -r /tmp/xcache
#

EXPOSE 9000
CMD ["php-fpm"]