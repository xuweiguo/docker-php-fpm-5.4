FROM registry.cn-hangzhou.aliyuncs.com/xuweiguo/5.4-fpm:0.0.9
RUN echo ' \
deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib  \
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib  \
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib  \
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib  \
deb http://deb.debian.org/debian jessie main  \
deb http://security.debian.org/debian-security jessie/updates main  \
deb http://deb.debian.org/debian jessie-updates main  \
' > /etc/apt/sources.list
RUN apt-get update