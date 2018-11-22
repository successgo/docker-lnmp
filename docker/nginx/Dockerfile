FROM nginx:1.15-alpine

RUN set -ex; \
    echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf; \
    rm /etc/nginx/nginx.conf;

COPY ./etc/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
