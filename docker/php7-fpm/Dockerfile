FROM php:7.1.23-fpm-alpine3.8

ENV DEV_TOOLS \
    git

RUN set -ex; \
    # 换源
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories; \
    # 更新源
    apk update; \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        # gd
        libpng-dev \
        jpeg-dev \
        libwebp-dev \
        libxpm-dev \
        freetype-dev \
        # memcached
        libmemcached-dev \
        ; \
    # php-ext: bcmath
    docker-php-ext-configure bcmath; \
    docker-php-ext-install -j $(nproc) bcmath; \
    # php-ext: gd
    docker-php-ext-configure gd \
        --with-gd \
        --with-png-dir \
        --with-zlib-dir \
        --with-xpm-dir \
        --with-freetype-dir \
        ; \
    docker-php-ext-install -j $(nproc) gd; \
    # php-ext: opcache
    # php-ext: pdo_mysql
    docker-php-ext-configure pdo_mysql --with-pdo-mysql; \
    docker-php-ext-install -j $(nproc) pdo_mysql; \
    # php-ext: mysqli
    docker-php-ext-configure mysqli --with-mysqli; \
    docker-php-ext-install -j $(nproc) mysqli; \
    # update pecl
    pecl channel-update pecl.php.net; \
    # php-ext: xdebug
    pecl install xdebug-2.6.1; \
    docker-php-ext-enable xdebug; \
    # php-ext: mongodb
    pecl install mongodb-1.5.3; \
    docker-php-ext-enable mongodb; \
    # php-ext: redis
    pecl install redis-4.1.1; \
    docker-php-ext-enable redis; \
    # php-ext: memcached
    pecl install memcached-3.0.4; \
    docker-php-ext-enable memcached; \
    apk del .build-deps; \
    apk add --no-cache ${DEV_TOOLS}; \
    echo -e "\033[42;37m Build Completed :).\033[0m\n"

WORKDIR /app

USER www-data

CMD ["php-fpm"]
