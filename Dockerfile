## 0.0.0 docker官方拉取 扩展
FROM php:5.4-fpm
## 自带扩展
## Core,ctype,curl,date,dom,ereg,fileinfo,filter,ftp,hash,iconv,json,libxml,mbstring,mhash,mysqlnd,openssl,pcre,PDO,
## pdo_sqlite,Phar,posix,readline,Reflection,session,SimpleXML,SPL,sqlite3,standard,tokenizer,xml,xmlreader,xmlwriter,zlib
## nabla系统
## Core,ctype,curl,date,dom,ereg,fileinfo,filter,ftp,hash,iconv,json,libxml,mbstring,mhash,mysqlnd,openssl,pcre,PDO,pdo_sqlite,
## posix,Reflection,session,SimpleXML,SPL,sqlite3,standard,tokenizer,xml,xmlreader,xmlwriter,zlib
## 0.0.1 bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop sysvsem 
## 0.0.2 bz2
## 未添加
## bz2,gd,imagick,mcrypt,mysql,redis,soap,ssh2,xmlrpc,zip

## 0.0.1 添加 bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop  sysvsem 
#RUN docker-php-ext-install bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop sysvsem 

## 0.0.2 添加 bz2
#RUN apt-get update && \
#apt-get install -y --no-install-recommends libbz2-dev && \
#rm -r /var/lib/apt/lists/* && \
#docker-php-ext-install bz2

## full
RUN apt-get update && \
apt-get install -y --no-install-recommends libbz2-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop sysvsem bz2

EXPOSE 9000
CMD ["php-fpm"]