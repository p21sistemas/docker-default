FROM php:7.4-cli-alpine3.12

RUN apk add --update --no-cache --virtual .build-deps libxml2-dev

RUN docker-php-ext-install opcache xml tokenizer simplexml xmlwriter

WORKDIR /usr/share/apache2/www