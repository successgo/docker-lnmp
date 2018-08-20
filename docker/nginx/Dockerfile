FROM nginx:1.13

RUN set -ex; \
    echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf; \
    rm /etc/nginx/nginx.conf; \
    usermod -u 1000 nginx; \
    groupmod -g 1000 nginx

COPY ./etc/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
