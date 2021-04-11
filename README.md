# Prepared Dockerized Symfony

## Used Images

We considered adding all of the services into separated dockerfiles, even though these files only contains the images with no customization, just for flexability purposes.

- `ngnix:alpine`
- `mysql:8.0`
- `php:7.3-fpm` with PDO, ZIP and GD extensions, and xdebug 3.x for `development` enviroment.

## Usage

You can simply run the `make` or `make help` commands, which will provide you with the propper imformation on how to config, build and run the application.

```bash
make config             Make some pre-install configuration

make run                Prepare app's configurations, Installing dependencies and Starting containers
make up                 Starting containers
make down               Stoping containers

make php                Enter php-fpm container
make nginx              Enter nginx container
make composer           Installing dependencies

make tests              Run tests

make vars               Some debugging env vars to be exported into your local, to make xdebug work proparly
````
