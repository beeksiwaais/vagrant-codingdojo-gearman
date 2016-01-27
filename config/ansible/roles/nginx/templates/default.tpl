server {
    listen  80;

    root {{ nginx.docroot }}/web;

    server_name {{ nginx.servername }};

    if (!-f $request_filename) {
        rewrite ^/(.*)$ /app_dev.php last;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
