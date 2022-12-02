include docker.mk

.PHONY: test build

DRUPAL_VER ?= 9
PHP_VER ?= 8.1
FILE_MATCH ?=

BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

test:
	cd ./tests/$(DRUPAL_VER) && PHP_VER=$(PHP_VER) ./run.sh

build:
	@echo "Build $(PROJECT_NAME)..."
ifeq ($(ENVIRONMENT), prod)
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_web_1' --format "{{ .ID }}") composer install --no-dev
else
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_web_1' --format "{{ .ID }}") composer install
endif
# TODO: Need drush cim -y when have settings files
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_web_1' --format "{{ .ID }}") bash -c 'cd $(DRUPAL_ROOT) && drush updb -y'
	@echo "Finish build $(PROJECT_NAME)"

distro-install:
	docker-compose -f services-drupal.yml run --rm install

nuxt-install:
	cd $(FRONT_DIR) && make install

nuxt-build:
	cd $(FRONT_DIR) && make build

nuxt-lint:
	cd $(FRONT_DIR) && make lint

nuxt-run:
	cd $(FRONT_DIR) && make run

start-automation:
	docker exec $(shell docker ps --filter name='^/$(PROJECT_NAME)_n8n' --format "{{ .ID }}") python /root/.pece/startWorkflows.py
