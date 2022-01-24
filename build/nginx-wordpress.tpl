# Copyright (c) 2019,2022 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019,2022 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-nginx-dev> for details.

# https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/

server {
    listen 80 default;
    listen [::]:80 ipv6only=on default;

    server_name ${NGINX_SERVER_NAME};
    root ${NGINX_ROOT};

    error_log  /var/log/nginx/${NGINX_SERVER_NAME}-http-error.log;
    access_log /var/log/nginx/${NGINX_SERVER_NAME}-http-access.log;

    index index.php index.htm index.html;

    ${NGINX_CONF_SERVER}

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location ~* \.(txt|log)$ {
        allow 192.168.0.0/16;
        deny all;
    }

    location ~ /\.ht {
		deny all;
	}

    location ~* /app/uploads/.*.php$ {
        deny all;
    }

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_intercept_errors on;
        fastcgi_pass ${NGINX_PHP_FPM};
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires max;
        log_not_found off;
    }
}