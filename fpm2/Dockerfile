FROM debian:jessie
RUN cp -v /etc/apt/sources.list /etc/apt/sources.list.bak &&  sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y ca-certificates curl librecode0 libsqlite3-0 libxml2 --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y autoconf file g++ gcc libc-dev make pkg-config re2c --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php

RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

ENV PHP_VERSION=5.4.45

ENV GPG_KEYS=F38252826ACD957EF380D39F2F7956BC5DA04B5D
RUN set -xe && for key in $GPG_KEYS; do gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; done


RUN buildDeps="$PHP_EXTRA_BUILD_DEPS bzip2 libcurl4-openssl-dev libreadline6-dev librecode-dev libsqlite3-dev libssl-dev libxml2-dev " && \
    set -x && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* && \
    curl -SL "http://php.net/get/php-$PHP_VERSION.tar.bz2/from/this/mirror" -o php.tar.bz2 && \
    curl -SL "http://php.net/get/php-$PHP_VERSION.tar.bz2.asc/from/this/mirror" -o php.tar.bz2.asc && \
    gpg --verify php.tar.bz2.asc && \
    mkdir -p /usr/src/php && \
    tar -xof php.tar.bz2 -C /usr/src/php --strip-components=1 && \
    rm php.tar.bz2* && cd /usr/src/php && \
    ./configure --with-config-file-path="$PHP_INI_DIR" \
    --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" $PHP_EXTRA_CONFIGURE_ARGS \
    --disable-cgi \
    --enable-mysqlnd \
    --enable-mbstring \
    --enable-ftp \
    --with-curl \
    --with-openssl \
    --with-mhash \
    --with-readline \
    --with-recode \
    --with-zlib && \
    make -j"$(nproc)" && make install && \
    { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps && \
    make clean

COPY docker-php-ext-*  /usr/local/bin/

RUN set -eux; \
    cd /usr/local/etc; \
    if [ -d php-fpm.d ]; then \
        # for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
        sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
        cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
    else \
        # PHP 5.x doesn't use "include=" by default, so we'll create our own simple config that mimics PHP 7+ for consistency
        mkdir php-fpm.d; \
        cp php-fpm.conf.default php-fpm.d/www.conf; \
        { \
            echo '[global]'; \
            echo 'include=etc/php-fpm.d/*.conf'; \
        } | tee php-fpm.conf; \
    fi; \
    { \
        echo '[global]'; \
        echo 'error_log = /proc/self/fd/2'; \
        echo; \
        echo '[www]'; \
        echo '; if we send this to /proc/self/fd/1, it never appears'; \
        echo 'access.log = /proc/self/fd/2'; \
        echo; \
        echo 'clear_env = no'; \
        echo; \
        echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
        echo 'catch_workers_output = yes'; \
    } | tee php-fpm.d/docker.conf; \
    { \
        echo '[global]'; \
        echo 'daemonize = no'; \
        echo; \
        echo '[www]'; \
        echo 'listen = 9000'; \
    } | tee php-fpm.d/zz-docker.conf

WORKDIR /var/www/html
EXPOSE 9000
CMD ["php-fpm"]