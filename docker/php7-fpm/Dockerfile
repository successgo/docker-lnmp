FROM php:7.1.23-fpm-stretch

RUN set -ex; \
    # change /etc/apt/sources.list according to your need
    echo "deb http://mirrors.aliyun.com/debian/ stretch main contrib non-free" > /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-backports main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb http://mirrors.aliyun.com/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    echo "deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list; \
    # update and install
    apt-get update; \
    apt-get install -y \
        # run composer may need git to be installed
        git \
        cmake \
        # php gd extension need libfreetype6, libpng, libjpeg
        libfreetype6-dev \
        libpng-dev \
        libjpeg-dev \
        # php zip extention need libzip
        libzip-dev \
        # php mongodb extension need libcurl, libssl, libsasl2
        libcurl4-openssl-dev \
        libssl-dev \
        libsasl2-dev \
        ; \
    # run ./configure script to configure php bcmath extension
    docker-php-ext-configure bcmath; \
    # run ./configure script to configure php gd extension
    docker-php-ext-configure gd \
        --with-gd \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
        --with-freetype-dir=/usr/include \
        ; \
    # run ./configure script to configure php opcache extension
    docker-php-ext-configure opcache --enable-opcache; \
    # run ./configure script to configure php pdo_mysql extension
    docker-php-ext-configure pdo_mysql --with-pdo-mysql; \
    # run ./configure script to configure php zip extension
    docker-php-ext-configure zip; \
    # run ./configure script to configure php mysqli extension
    docker-php-ext-configure mysqli; \
    # install php extension: bcmath, gd, pdo_mysql, zip, mysqli, opcache
    docker-php-ext-install -j $(nproc) \
        bcmath \
        gd \
        pdo_mysql \
        zip \
        mysqli \
        opcache \
        ; \
    # extract php source for later php extention installation
    docker-php-source extract; \
    # install php redis extension from source
    curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/4.2.0.tar.gz; \
    tar xf /tmp/redis.tar.gz; \
    mv phpredis-4.2.0 /usr/src/php/ext/redis; \
    rm /tmp/redis.tar.gz; \
    docker-php-ext-install -j $(nproc) redis; \
    # install php xdebug extension from source
    curl -L -o /tmp/xdebug.tar.gz https://github.com/xdebug/xdebug/archive/2.6.1.tar.gz; \
    tar xf /tmp/xdebug.tar.gz; \
    mv xdebug-2.6.1 /usr/src/php/ext/xdebug; \
    rm /tmp/xdebug.tar.gz; \
    docker-php-ext-install -j $(nproc) xdebug; \
    # install php mongodb extension from source
    OLD_PWD=$(pwd); \
    curl -L -o /tmp/mongo-c-driver.tar.gz https://github.com/mongodb/mongo-c-driver/archive/1.13.0.tar.gz; \
    cd /tmp; \
    tar xf mongo-c-driver.tar.gz; \
    cd mongo-c-driver-1.13.0; \
    mkdir cmake-build; \
    cd cmake-build; \
    cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=off -DCMAKE_BUILD_TYPE=Release ..; \
    make -j $(nproc); \
    make install; \
    cd $OLD_PWD; \
    rm -rf /tmp/mongo-c-driver.tar.gz; \
    rm -rf /tmp/mongo-c-driver-1.13.0; \
    curl -L -o /tmp/mongo-php-driver.tar.gz https://github.com/mongodb/mongo-php-driver/archive/1.5.0.tar.gz; \
    tar xf /tmp/mongo-php-driver.tar.gz; \
    mv mongo-php-driver* /usr/src/php/ext/mongodb; \
    rm /tmp/mongo-php-driver.tar.gz; \
    docker-php-ext-configure mongodb --with-libbson=yes --with-libmongoc=yes; \
    docker-php-ext-install -j $(nproc) mongodb; \
    # delete php source
    docker-php-source delete; \
    # do other stuff
    chown -Rc www-data:www-data /var/www; \
    chmod 664 -Rc /var/www; \
    echo 'build OK!'

WORKDIR /app

CMD ["php-fpm"]
