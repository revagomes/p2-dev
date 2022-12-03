include docker.mk

.PHONY: test build build-dev distro-install

DRUPAL_VER ?= 9
PHP_VER ?= 8.1
FILE_MATCH ?=

BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh

install:
	@echo "Install $(PROJECT_NAME) dependencies..."
ifeq ($(ENVIRONMENT), prod)
	docker exec -t $(shell docker ps --filter name='^/$(PROJECT_NAME)_web' --format "{{ .ID }}") composer install --no-dev
else
	docker exec -t $(shell docker ps --filter name='^/$(PROJECT_NAME)_web' --format "{{ .ID }}") composer install
endif

build:
	@echo "Build $(PROJECT_NAME)..."
	@make install
# TODO: Add drush config:import -y when there are settings files 
	docker exec -t $(shell docker ps --filter name='^/$(PROJECT_NAME)_web' --format "{{ .ID }}") bash -c 'vendor/bin/drush updb -y'
	@echo "Finish build $(PROJECT_NAME)"

build-dev:
	@echo "Build $(PROJECT_NAME) Development environment..."
	@make install
	docker exec -t $(shell docker ps --filter name='^/$(PROJECT_NAME)_web' --format "{{ .ID }}") bash -c 'vendor/bin/run toolkit:build-dev'
# TODO: Add drush config:import -y when there are settings files 
	docker exec -t $(shell docker ps --filter name='^/$(PROJECT_NAME)_web' --format "{{ .ID }}") bash -c 'vendor/bin/drush updb -y'
	@echo "Finish build $(PROJECT_NAME)"

distro-install:
	docker-compose -f services-drupal.yml run --rm install