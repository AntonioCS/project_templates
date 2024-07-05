
mb_project_name := symfony-php8
mb_project_prefix := sy

### List of modules to include in the project
### This can be MakeBind modules or custom modules located in the modules folder in <your_project>/BindHub/modules
mb_project_modules := docker/docker_compose.mk \
	docker/php/symfony.mk \
	docker/nginx.mk

dc_files := $(mb_project_path)/docker/docker-compose.yml \
	$(mb_project_path)/docker/docker-compose.dev.yml

dc_service_nginx := app_nginx
dc_service_php := app