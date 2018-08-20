FROM php:7.2-fpm-stretch

COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/

RUN set -ex; \
    # 换源
    echo "deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free" > /etc/apt/sources.list; \
    echo "deb-src http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    # 更新源
    apt-get update; \
    apt-get install -y \
        # 安装 php-gd 的依赖
        libfreetype6-dev \
        libpng-dev \
        libjpeg-dev \
        # 安装 php-zip 的依赖
        libzip-dev \
        ; \
    # 安装 gd.so
    docker-php-ext-configure gd \
        --with-gd \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
        --with-freetype-dir=/usr/include; \
    docker-php-ext-install -j $(nproc) gd; \
    # 安装 pdo_mysql.so
    docker-php-ext-configure pdo_mysql --with-pdo-mysql; \
    docker-php-ext-install -j $(nproc) pdo_mysql; \
    # 安装 zip.so
    docker-php-ext-configure zip --with-zip-dir=/usr/include; \
    docker-php-ext-install -j $(nproc) zip; \
    # 安装 mysqli.so
    docker-php-ext-configure mysqli; \
    docker-php-ext-install -j $(nproc) mysqli; \
    pecl install xdebug; \
    docker-php-ext-enable xdebug; \
    # 修改 php-fpm 的运行者 www-data 的 uid 和 gid 为1000
    usermod -u 1000 www-data; \
    groupmod -g 1000 www-data; \
    chown -Rc www-data:www-data /var/www/html

CMD ["php-fpm"]

