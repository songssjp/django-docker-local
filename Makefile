.PHONY: init copy_ssh build init_db migrate createsuperuser up down run bash logs supervisor-restart supervisor-status

DOCKER_COMPOSE = docker-compose -p myapp

init: copy_ssh build init_db migrate

copy_ssh:
	cp -r ~/.ssh ./django_sample

build:
	$(DOCKER_COMPOSE) build

init_db:
	$(DOCKER_COMPOSE) run --rm myapp mysql -h172.18.0.2 -uroot -e'DROP DATABASE IF EXISTS mysite;CREATE DATABASE mysite'

migrate:
	$(DOCKER_COMPOSE) run --rm myapp python manage.py migrate

createsuperuser:
	$(DOCKER_COMPOSE) run --rm myapp python manage.py createsuperuser

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

run:
	$(DOCKER_COMPOSE) exec myapp python manage.py runserver 0:8000

bash:
	$(DOCKER_COMPOSE) exec myapp /bin/bash

logs:
	$(DOCKER_COMPOSE) logs

supervisor-restart:
	$(DOCKER_COMPOSE) exec myapp supervisorctl restart runserver

supervisor-status:
	$(DOCKER_COMPOSE) exec myapp supervisorctl status
