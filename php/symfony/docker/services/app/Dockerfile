ARG PHP_IMAGE_APP_VERSION="8.3.2-fpm-alpine3.19"
ARG LOCAL_BIN_PATH=/usr/local/bin

FROM php:${PHP_IMAGE_APP_VERSION} AS base
WORKDIR /app
RUN apk update && \
 	apk add --no-cache \
		gcc \
		autoconf \
        postgresql-dev \
        # mariadb-dev \ # for MySQL
        && \
 	apk add --no-cache \
    	--virtual .phpize-deps ${PHPIZE_DEPS}
RUN docker-php-ext-install \
        pcntl \
        posix \
        bcmath \
        pdo \
        pdo_pgsql \
        # pdo_mysql \   # Uncomment if you plan to use MySQL/MariaDB
        && \
 	docker-php-ext-enable \
    	opcache

FROM base AS build_vendor
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV APP_ENV=prod
ENV APP_DEBUG=0
COPY --from=composer:latest /usr/bin/composer /usr/bin/
COPY ./%_PROJECT_NAME_%/composer.json ./project/composer.lock ./
## Prevent symfony script from running with --no-scripts
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts

FROM base AS app_prod
COPY --from=build_vendor /app/vendor /app/vendor
COPY ./%_PROJECT_NAME_%/ .
RUN php bin/console cache:clear --env=prod --no-debug && \
    php bin/console cache:warmup --env=prod --no-debug

FROM app_prod AS app_ci
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer:latest /usr/bin/composer /usr/bin/
RUN composer install --no-interaction
# Optional: copy phpunit config if you don’t commit it
#COPY ./project/phpunit.xml.dist ./


FROM app_prod AS app_dev
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=appuser
ARG XDEBUG_VERSION=3.3.1
COPY --from=composer:latest /usr/bin/composer /usr/bin/

RUN apk add --update \
    linux-headers \
    git

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN pecl install xdebug-$XDEBUG_VERSION && \
    docker-php-ext-enable xdebug

RUN echo "Creating user and group with UID=${USER_ID}, GID=${GROUP_ID}, and name=${USER_NAME}" && \
    addgroup -g ${GROUP_ID} ${USER_NAME} && \
    adduser -D -u ${USER_ID} -G ${USER_NAME} ${USER_NAME}

USER ${USER_NAME}
