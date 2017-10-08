FROM php:7.1-fpm-alpine

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && docker-php-ext-install \
        mbstring \
        pdo_mysql \
    && apk add --update --no-cache \
        bash \
        nginx \
    && mkdir -p /run/nginx \
    && echo -e "#!/bin/sh\nphp-fpm -D\nnginx -g 'daemon off;'" \
        > /usr/local/bin/php-nginx \
    && chmod +x /usr/local/bin/php-nginx

EXPOSE 80

CMD ["php-nginx"]
