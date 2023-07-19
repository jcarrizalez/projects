#FROM php:5.6.40-apache
FROM php:5.6.40-fpm

LABEL maintainer="Prezo App"

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN echo "memory_limit = -1" >> $PHP_INI_DIR/conf.d/memory_limit.ini
RUN echo "upload_max_filesize = 250M" >> /usr/local/etc/php/conf.d/upload_max_filesize.ini
RUN echo "post_max_size = 250M" >> /usr/local/etc/php/conf.d/post_max_size.ini
RUN echo "max_input_vars = 14000" >> /usr/local/etc/php/conf.d/max_input_vars.ini
RUN echo "short_open_tag = On" >> /usr/local/etc/php/conf.d/short_open_tag.ini

RUN echo "deb http://archive.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list

# Instala la extensión MySQL para PHP
RUN apt-get update && apt-get install -yq default-libmysqlclient-dev vim inetutils-ping mariadb-client net-tools cron nano sudo git

RUN apt install -yq apache2 libapache2-mod-fcgid


RUN git clone https://github.com/xdebug/xdebug.git \
&& cd xdebug \
&& git checkout tags/XDEBUG_2_5_5 \
&& phpize \
&& ./configure --enable-xdebug \
&& make \
&& make install

#RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_host = host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysql mysqli pdo pdo_mysql 

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user

RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

RUN adduser $user sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ADD ./addons/ /home/$user/addons

ADD ./ssh_keys/ /home/$user/.ssh

RUN cp /home/$user/addons/app/www.conf /usr/local/etc/php-fpm.d/www.conf
RUN cp /home/$user/addons/app/vhost.conf /etc/apache2/sites-enabled/000-default.conf
RUN cp /home/$user/addons/app/.htaccess /root/.htaccess
RUN cp /home/$user/addons/app/start.sh /start.sh

RUN a2enmod rewrite proxy_fcgi

EXPOSE 80

# Set working directory
WORKDIR /var/www/html

RUN chmod +x /start.sh


#COPY start.sh /
ENTRYPOINT [ "/start.sh" ]

#USER $user
#chmod +x protected/yiic;protected/yiic queue work --queue=ocr --load=1;

# echo "deb http://archive.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list
