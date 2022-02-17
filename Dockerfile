FROM fooz79/alpine-openrc:latest

RUN apk add --no-cache \
    bind-tools \
    busybox-extras \
    busybox-initscripts \
    git \
    git-bash-completion \
    htop \
    logrotate \
    mariadb-connector-c \
    mongodb-tools \
    mysql-client \
    nginx \
    procps \
    redis \
    screen \
    subversion \
    supervisor \
    tini \
    tree \
    vim \
    wget \
    # crond
    && rc-update add crond \
    # supervisor
    && mkdir /var/log/supervisor \
    && mkdir /etc/supervisor.d \
    && rc-update add supervisord \
    # nginx
    && mkdir -p /etc/nginx/default.d \
    && rm -f /etc/nginx/conf.d/default.conf \
    && rc-update add nginx \
    # redis
    && rc-update add redis \
    # workdir
    && mkdir -p /data/nginx/wwwlogs /data/nginx/wwwroot \
    && chown nobody. /data/nginx/wwwlogs

# nginx.conf
COPY nginx.conf /etc/nginx/
# php-fpm proxy
COPY php-fpm.conf /etc/nginx/default.d/
# redis.conf
COPY redis.conf /etc/

EXPOSE 80 6379

VOLUME [ "/data" ]
