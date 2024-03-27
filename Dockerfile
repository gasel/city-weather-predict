# Utilizar la imagen oficial de PHP
FROM php:8.1-fpm-alpine

ADD ./docker_config/php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

# Instalar las dependencias necesarias
RUN apt-get update && \
    apt-get install -y libpq-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev zip unzip git

# Instalar las extensiones de PHP necesarias
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo pdo_mysql gd mbstring xml

RUN chown -R laravel:laravel /var/www/html

# Instalar Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar los archivos del proyecto al contenedor
COPY . /var/www/html

# Instalar las dependencias del proyecto
# RUN composer install

# CMD ["php-fpm"]
# CMD ["nginx", "-g", "daemon off;"]