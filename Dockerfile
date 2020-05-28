FROM php:7.3-fpm

LABEL maintainer="Nico Lance Medina <nico@nlmedina.com>"

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libicu-dev \
        libzip-dev \
        libc-client-dev \
        libkrb5-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) gd intl zip pdo_mysql imap \
    && pecl install xdebug-2.7.2 \
    && docker-php-ext-enable xdebug \
    && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/docker.conf
