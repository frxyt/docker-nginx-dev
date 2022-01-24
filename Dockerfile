# Copyright (c) 2019,2022 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019,2022 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-nginx-dev> for details.

ARG FRX_DOCKER_FROM=nginx:latest
FROM ${FRX_DOCKER_FROM}

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

ENV NGINX_CONF_TPL="php" \
    NGINX_SERVER_NAME="_" \
    NGINX_ROOT="/var/www/html" \
    NGINX_PHP_FPM="php:9000" \
    NGINX_CONF_SERVER=

COPY ./build ./Dockerfile ./LICENSE ./README.md  /frx/

RUN /frx/build

EXPOSE 80

VOLUME [ "/var/log/nginx", "/var/www/html" ]

CMD [ "/frx/start" ]