FROM richarvey/nginx-php-fpm:1.10.3

LABEL maintainer="Boyan Balkanski <boyan.balkanski@gmail.com>"

WORKDIR /var/www/app
ENV WEBROOT /var/www/app

RUN docker-php-ext-configure pcntl \
    && docker-php-ext-install pcntl bcmath sockets tokenizer \
    && docker-php-ext-enable xdebug

# RUN apk add --no-cache nodejs-current  --repository="http://dl-cdn.alpinelinux.org/alpine/edge/community"

RUN apk --update add python3 \
    curl \
    nodejs-current \
    nodejs-npm

RUN node -v \
    npm -v

RUN npm install -g yarn

RUN rm -r /etc/nginx/sites-enabled/*
COPY ssl/bagisto.dev /etc/nginx/sites-enabled/bagisto.dev
COPY ssl/certs/bagisto.dev.key /etc/ssl/private/bagisto.dev.key
COPY ssl/certs/STAR.bagisto.dev.crt /etc/ssl/certs/bagisto.dev.crt
COPY ssl/certs/dhparam.pem /etc/nginx/dhparam.pem
