ARG PHP_IMAGE_APP_VERSION="8.3.2-fpm-alpine3.19"
ARG LOCAL_BIN_PATH=/usr/local/bin

FROM php:${PHP_IMAGE_APP_VERSION} AS base
WORKDIR /app
RUN apk update && \
 	apk add --no-cache \
		gcc \
        openssh-client \
		autoconf && \
 	apk add --no-cache \
    	--virtual .phpize-deps ${PHPIZE_DEPS}
RUN	pecl channel-update pecl.php.net && \
#    pecl install -o -f  \
#    	ds && \
    docker-php-ext-install \
    	pcntl \
    	posix \
    	bcmath && \
 	docker-php-ext-enable \
    	opcache
#ds

FROM base AS app_dev
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=appuser
ARG LOCAL_BIN_PATH
ARG XDEBUG_VERSION=3.3.1
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer:latest /usr/bin/composer /usr/bin/
RUN apk add --update \
      linux-headers \
      bash \
      git
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN pecl install \
      xdebug-$XDEBUG_VERSION && \
    docker-php-ext-enable \
      xdebug
## Files created in the container will no longer be owned by root
RUN echo "Creating user and group with UID=${USER_ID}, GID=${GROUP_ID}, and name=${USER_NAME}" && \
    addgroup -g ${GROUP_ID} ${USER_NAME} && \
    adduser -D -u ${USER_ID} -G ${USER_NAME} ${USER_NAME}
USER ${USER_NAME}
