## 0.0.0 docker官方拉取 扩展
# FROM php:5.4-fpm
## 自带扩展
## Core,ctype,curl,date,dom,ereg,fileinfo,filter,ftp,hash,iconv,json,libxml,mbstring,mhash,mysqlnd,openssl,pcre,PDO,
## pdo_sqlite,Phar,posix,readline,Reflection,session,SimpleXML,SPL,sqlite3,standard,tokenizer,xml,xmlreader,xmlwriter,zlib
## nabla系统
## Core,ctype,curl,date,dom,ereg,fileinfo,filter,ftp,hash,iconv,json,libxml,mbstring,mhash,mysqlnd,openssl,pcre,PDO,pdo_sqlite,
## posix,Reflection,session,SimpleXML,SPL,sqlite3,standard,tokenizer,xml,xmlreader,xmlwriter,zlib
## 0.0.1 bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop sysvsem 
## 未添加
## bcmath,bz2,calendar,dba,exif,gd,imagick,
## mcrypt,mysql,mysqli,pcntl,pdo_mysql,redis,
## shmop,soap,sockets,ssh2,sysvsem,xmlrpc,zip

# 0.0.1 添加 bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop  sysvsem 
FROM registry.cn-hangzhou.aliyuncs.com/xuweiguo/5.4-fpm:0.0.0
RUN docker-php-ext-install bcmath calendar exif sockets dba mysqli pcntl pdo_mysql shmop sysvsem 


EXPOSE 9000
CMD ["php-fpm"]