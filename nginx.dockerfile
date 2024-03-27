FROM nginx:stable-alpine

ADD ./docker_config/nginx/default.conf /etc/nginx/default.conf

RUN mkdir -p /var/www/html