FROM php:7.1.23-fpm-stretch

RUN set -ex; \
    # 换源
    echo "deb http://mirrors.aliyun.com/debian/ stretch main contrib non-free" > /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    # 更新源
    apt-get update; \
    apt-get install -y \
        git \
        # php-gd 的依赖
        libfreetype6-dev \
        libpng-dev \
        libjpeg-dev \
        libweb-dev \
        libxpm-dev \
        # php-zip 的依赖
        libzip-dev \
        # php-memcached 的依赖
        libmemcached-dev \
        ; \
    docker-php-ext-configure bcmath; \
    docker-php-ext-configure gd \
        --with-gd \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
        --with-freetype-dir=/usr/include \
        ; \
    docker-php-ext-configure opcache --enable-opcache; \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql; \
    docker-php-ext-configure zip --with-zip-dir=/usr/include; \
    docker-php-ext-configure mysqli; \
    docker-php-ext-install -j $(nproc) \
        bcmath \
        gd \
        pdo_mysql \
        zip \
        mysqli \
        opcache \
        ; \
    pecl install xdebug; \
    docker-php-ext-enable xdebug; \
    pecl install mongodb; \
    docker-php-ext-enable mongodb; \
    pecl install redis; \
    docker-php-ext-enable redis; \
    pecl install memcached; \
    docker-php-ext-enable memcached; \
    # 修改 php-fpm 的运行者 www-data 的 uid 和 gid 为1000
    usermod -u 1000 www-data; \
    groupmod -g 1000 www-data; \
    chown -Rc www-data:www-data /var/www/html;

WORKDIR /app

USER www-data

CMD ["php-fpm"]

