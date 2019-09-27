# PHP 容器配置

# 从官方基础版本构建
FROM registry.cn-hangzhou.aliyuncs.com/xuweiguo/docker-git-php-5.4-fpm:0.0.7

# 0.0.7 php_mbstring 扩展
#RUN apt-get update && \
#apt-get install -y apt-transport-https

#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

#RUN echo ' \
#deb https://mirrors.tuna.tsinghua.edu.cn/debian/ jessie main contrib non-free  \
#deb https://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-updates main contrib non-free \
#deb https://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-backports main contrib non-free \
#deb https://mirrors.tuna.tsinghua.edu.cn/debian-security jessie/updates main contrib non-free \
#' > /etc/apt/sources.list

# RUN apt-get update && \
#RUN docker-php-ext-configure mbstring && \
#docker-php-ext-install mbstring

# 0.0.8 增加 mcrypt 扩展 
RUN apt-get update && \ 
apt-get install -y --no-install-recommends libmcrypt-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure mcrypt && \
docker-php-ext-install mcrypt


EXPOSE 9000
CMD ["php-fpm"]
