FROM h3xsh/image:base

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get install -y \
    lsb-release

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
    php8.4-cli \
    php8.4-common \
    php8.4-curl \
    php8.4-fpm \
    php8.4-mbstring \
    php8.4-mysql \
    php8.4-xml \
    php8.4-zip \
    php8.4-bcmath \
    php8.4-gd

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN php -v && composer -V

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER dev
WORKDIR /home/dev

CMD ["zsh"]