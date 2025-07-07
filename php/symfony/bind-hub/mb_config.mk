
mb_project_name := symfony-php8
mb_project_prefix := sy


dc_files := $(mb_project_path)/docker/docker-compose.yml \
	$(mb_project_path)/docker/docker-compose.dev.yml

nginx_dc_service := app_nginx
php_dc_service := app