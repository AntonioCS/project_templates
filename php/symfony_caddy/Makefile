
docker_compose_file := docker/docker-compose.yml
docker_compose_file_dev := docker/docker-compose.dev.yml
dfiles := --file $(docker_compose_file) --file $(docker_compose_file_dev)

dc-start:
	docker compose $(dfiles) up -d
#	MY_UID=$$(id -u) MY_GID=$$(id -g)

dc-stop:
	docker compose $(dfiles) stop

dc-down:
	docker compose $(dfiles) down

php-shell:
	docker compose $(dfiles) exec app sh

dc-restart: dc-stop
dc-restart: dc-start

dc-build:
	docker compose $(dfiles) build --parallel --no-cache \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg USER_NAME=$(shell whoami) \
		--build-arg GROUP_ID=$(shell id -g)

dc-rebuild: dc-stop
dc-rebuild: dc-build
dc-rebuild: dc-start

dc-status:
	docker compose $(dfiles) ps

dc-logs:
	docker compose $(dfiles) logs -f

## By default in the caddy container /var/log/caddy/error.log and /var/log/caddy/access.log
## are symlinks to /dev/stderr and /dev/stdout respectively, so this won't output anything, use this if you
## have changed the default configuration.
caddy_error_log := /var/log/caddy/error.log
caddy_access_log := /var/log/caddy/access.log
service_caddy := app_caddy

caddy-tail-error-log:
	docker compose $(dfiles) exec $(service_caddy) tail -f $(caddy_error_log) || true

caddy-tail-access-log:
	docker compose $(dfiles) exec $(service_caddy) tail -f $(caddy_access_log) || true

caddy-tail-dc-logs:
	docker compose $(dfiles) logs -f $(service_caddy)

caddy-shell:
	docker compose $(dfiles) exec $(service_caddy) sh


php-composer-install:
	docker compose $(dfiles) run --rm app composer install

setup: dc-rebuild
setup: php-composer-install
