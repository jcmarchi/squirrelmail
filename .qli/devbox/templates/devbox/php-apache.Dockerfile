FROM php:8.2-apache

ARG DEVBOX_UID=1000
ARG DEVBOX_GID=1000

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${DEVBOX_GID} devbox \
    && useradd -m -u ${DEVBOX_UID} -g ${DEVBOX_GID} -s /bin/bash devbox

RUN git config --system --add safe.directory /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
ENV APACHE_RUN_USER=devbox
ENV APACHE_RUN_GROUP=devbox
ENV COMPOSER_HOME=/tmp/composer

RUN mkdir -p /tmp/composer \
    && chmod -R 777 /tmp/composer

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf \
    /etc/apache2/apache2.conf \
    /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html

CMD ["apache2-foreground"]
