ARG APPLICATION_ENV=production
FROM php:7.4-fpm
ARG APPLICATION_ENV

# install some base extensions
RUN apt-get update && apt-get install -y \
	curl \
  git \
  zip unzip \
  libzip-dev \
  libpng-dev \
  && apt-get clean
COPY docker/php-fpm/php.ini /usr/local/etc/php/php.ini

RUN docker-php-ext-install zip pdo pdo_mysql gd

# Install xDebug (if development environment)
RUN if [ "$APPLICATION_ENV" = "development" ]; then pecl install xdebug \
  && docker-php-ext-enable xdebug \
  ; fi

# Copy xdebug configration for remote debugging
RUN mkdir -p /tmp_configs
COPY docker/php-fpm/xdebug.ini /tmp_configs
RUN if [ "$APPLICATION_ENV" = "development" ]; then cp /tmp_configs/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini \
	&& touch /tmp/xdebug.log \
	&& chmod 0666 /tmp/xdebug.log \
  ; fi
RUN rm -rf /tmp_configs

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www
RUN mkdir app && chown www-data:www-data app

COPY --chown=www-data:www-data ./ /var/www/app

USER www-data
WORKDIR /var/www/app
