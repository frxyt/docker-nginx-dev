# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-nginx-dev> for details.

server{
    listen 80 default;
    listen [::]:80 ipv6only=on default;

    server_name ${NGINX_SERVER_NAME};
    root ${NGINX_ROOT};

    error_log  /var/log/nginx/${NGINX_SERVER_NAME}-http-error.log;
    access_log /var/log/nginx/${NGINX_SERVER_NAME}-http-access.log;

    index index.php index.html;

    ${NGINX_CONF_SERVER}

    location / {
        try_files $uri $uri/ /index.php?$query_string;
        sendfile off;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass ${NGINX_PHP_FPM};
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}