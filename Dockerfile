FROM php:7.1-fpm

MAINTAINER Nico Lance Medina <nico@nlmedina.com>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libicu-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd intl zip pdo_mysql \
    && pecl install xdebug-2.6.1 \
    && docker-php-ext-enable xdebug \
    && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/docker.conf
