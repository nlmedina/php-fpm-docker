FROM php:7.3-fpm-alpine

LABEL maintainer="Nico Lance Medina <nico@nlmedina.com>"

RUN apk update && apk add --no-cache \
        $PHPIZE_DEPS \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        icu-dev \
        libzip-dev\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd intl zip pdo_mysql \
    && pecl install xdebug-2.7.2 \
    && docker-php-ext-enable xdebug \
    && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/docker.conf
