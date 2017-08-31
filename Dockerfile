FROM php:7.1-fpm-alpine

RUN docker-php-ext-install \
        mbstring \
        pdo_mysql \
    && apk add --update --no-cache \
        nginx \
    && mkdir -p /run/nginx \
    && echo -e "#!/bin/sh\nphp-fpm -D\nnginx -g 'daemon off;'" \
        > /usr/local/bin/php-nginx \
    && chmod +x /usr/local/bin/php-nginx

EXPOSE 80

CMD ["php-nginx"]
