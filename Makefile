.SILENT:
.DEFAULT_GOAL := help
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	export REMOTE_HOST := $(shell ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
endif
ifeq ($(UNAME_S),Darwin)
	export REMOTE_HOST := $(shell ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | sed -n '1p')
endif

export USRID := $(shell id -u)
export GRPID := $(shell id -g)

.PHONY: help
help: ; $(info Usage:)
	echo "\033[0;32mmake config\033[0;0m             Make some pre-install configuration"
	echo ""

	echo "\033[0;32mmake run\033[0;0m                Prepare app's configurations, Installing dependencies and Starting containers"
	echo "\033[0;32mmake up\033[0;0m                 Starting containers"
	echo "\033[0;32mmake down\033[0;0m             	Stoping containers"
	echo ""
	
	echo "\033[0;32mmake php\033[0;0m              	Enter php-fpm container"
	echo "\033[0;32mmake nginx\033[0;0m            	Enter nginx container"
	echo "\033[0;32mmake composer\033[0;0m           Installing dependencies"
	echo ""

	echo "\033[0;32mmake tests\033[0;0m              Run tests"
	echo ""

	echo "\033[0;32mmake vars\033[0;0m               Some debugging env vars to be exported into your local, to make xdebug work proparly"

.PHONY: up
up: ; $(info Starting containers:)
	docker-compose up -d
	echo "\033[0;32mOpen http://localhost:8080\033[0;0m"

.PHONY: down
down: ; $(info Stoping containers:)
	docker-compose down

.PHONY: composer
composer: ; $(info Installing dependencies:)
	docker-compose run -T --rm php-fpm composer install --ansi --no-interaction

.PHONY: run
run: config composer up ; $(info Server is running...)

.PHONY: php
php: ; $(info Entering php-fpm container)
	docker-compose exec php-fpm bash

.PHONY: nginx
nginx: ; $(info Entering nginx container)
	docker-compose exec nginx sh

.PHONY: tests
tests: ; $(info Running tests using PHPUnit)
	docker-compose run -T --rm php-fpm ./vendor/bin/phpunit

.PHONY: config
config: ; $(info Preparingcp -i .env.dist .envcp -i .env.dist .env configuration...)
	cp -i .env.dist .env
	cp -i .env.dist .env.local

.PHONY: vars
vars: ; $(info Now excute the following commands:)
	@echo "export REMOTE_HOST=${REMOTE_HOST}"
	@echo "export XDEBUG_PORT=9001"
	@echo "export USRID=${USRID}"
	@echo "export GRPID=${GRPID}"
