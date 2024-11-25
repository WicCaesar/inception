FROM alpine:3.20.2

ARG PHP_VERSION=83 \
    DB_NAME \
    DB_USER \
    DB_PASS \ 
    DB_HOST \
    ADM_WP_NAME \
    ADM_WP_PASS \
    ADM_WP_EMAIL \
    WP_USERNAME \
    WP_USERPASS \
    WP_USEREMAIL \
    WP_TITLE \
    WP_HOST

#Downloading and installing all required PHP modules to avoid issues.
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    php-tokenizer \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*
#Another sed substitution in the www.conf setup, to allow fastcgi to listen to all connections on port 9000. After the setup, clears the cache of installed modules.

#Changes the current working directory to /var/www, so I don't have to type that all the time.
WORKDIR /var/www

#WordPress installation.
RUN wget https://wordpress.org/wordpress-6.7.1.zip && \
    unzip wordpress-6.7.1.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress wordpress-6.7.1.zip

RUN wget https://github.com/wp-cli/wp-cli/releases/download/v2.11.0/wp-cli-2.11.0.phar && \
    mv wp-cli-2.11.0.phar wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./requirements/wordpress/conf/create_wpconfig.sh .

RUN chmod +x create_wpconfig.sh && chmod -R 777 wp-content/

CMD ["/bin/sh", "-c", "/var/www/create_wpconfig.sh && /usr/sbin/php-fpm83 -F"]
