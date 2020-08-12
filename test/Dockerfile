FROM registry.cn-hangzhou.aliyuncs.com/xuweiguo/5.4-fpm:0.0.9
RUN rm /etc/apt/sources.list && mv /etc/apt/sources.list.bak /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends zip ftp