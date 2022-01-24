# Copyright (c) 2019,2022 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019,2022 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-nginx-dev> for details.

server {
    listen 80 default;
    listen [::]:80 ipv6only=on default;

    server_name ${NGINX_SERVER_NAME};
    root ${NGINX_ROOT};

    error_log  /var/log/nginx/${NGINX_SERVER_NAME}-http-error.log;
    access_log /var/log/nginx/${NGINX_SERVER_NAME}-http-access.log;

    ${NGINX_CONF_SERVER}

    location / {
        try_files $uri $uri/ =404;
    }
}