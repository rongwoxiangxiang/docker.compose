FROM php:7.2-fpm

#ADD composer.phar /usr/local/bin/composer
#RUN chmod 755 /usr/local/bin/composer

RUN apk update && apk upgrade

#时区配置
ENV TIMEZONE Asia/Shanghai
RUN apk update && apk add tzdata
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
RUN echo $TIMEZONE > /etc/timezone

RUN docker-php-ext-install mbstring opcache pdo pdo_mysql mysqli
RUN apk update && apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev && \
    docker-php-ext-configure gd \
      --with-gd \
      --with-freetype-dir=/usr/include/ \
      --with-png-dir=/usr/include/ \
      --with-jpeg-dir=/usr/include/ \
      --with-zlib-dir=/usr && \
        NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
        docker-php-ext-install -j${NPROC} gd zip && \

       apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

WORKDIR /data1/www
