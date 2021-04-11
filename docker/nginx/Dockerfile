FROM nginx:alpine

COPY . /var/www/app
COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/

VOLUME ./docker/nginx/log:/var/log/nginx

EXPOSE 80
