FROM registry.cn-hangzhou.aliyuncs.com/xuweiguo/5.4-fpm:0.0.9
RUN apt-get update && apt-get install -y apt-transport-https

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak_20200806

RUN echo ' \
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ jessie main contrib non-free  \
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-updates main contrib non-free \
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ jessie-backports main contrib non-free \
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security jessie/updates main contrib non-free \
' > /etc/apt/sources.list


RUN apt-get update