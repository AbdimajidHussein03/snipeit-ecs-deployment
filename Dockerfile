# Stage 1: Base PHP + Apache image
FROM php:8.3-apache AS php-base


ENV APACHE_DOCUMENT_ROOT=/var/www/html/public


RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    default-mysql-client \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libldap2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install \
        pdo_mysql \
        bcmath \
        mbstring \
        zip \
        exif \
        gd \
        ldap \
    && a2enmod rewrite \
    && sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}/!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html



# Stage 2: Install PHP dependencies with Composer

FROM php-base AS vendor

COPY app/ /var/www/html/

RUN mkdir -p storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    bootstrap/cache \
    && composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader


# Stage 3: Build frontend assets with Node

FROM node:20-bookworm-slim AS assets

WORKDIR /app

COPY app/package*.json ./

RUN npm ci

COPY app/ ./

RUN npm run production


# Stage 4: Final runtime image
FROM php-base AS runtime

COPY app/ /var/www/html/

COPY --from=vendor /var/www/html/vendor /var/www/html/vendor
COPY --from=vendor /var/www/html/bootstrap/cache /var/www/html/bootstrap/cache
COPY --from=assets /app/public /var/www/html/public

RUN mkdir -p storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs \
    bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache public \
    && chmod -R ug+rwx storage bootstrap/cache

EXPOSE 80

CMD ["apache2-foreground"]
