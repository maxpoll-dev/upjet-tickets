FROM dunglas/frankenphp:1-php8.5-alpine AS base
WORKDIR /app
RUN install-php-extensions \
    pdo_pgsql \
    redis \
    pcntl \
    opcache \
    intl \
    zip \
    bcmath \
    gd
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
ENV SERVER_NAME=:80

FROM base AS dev

FROM base AS production
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist --no-scripts
COPY . .
RUN composer dump-autoload --optimize \
    && chmod -R 775 storage bootstrap/cache
