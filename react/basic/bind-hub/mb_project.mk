### Custom Project targets

setup: mb_info_msg := Running setup
setup: dc/rebuild
setup: mb/info-setup
setup: ## Setup project
	$(call mb_printf_info,Finished setup)

dc_service_react := app_react
dc_react_default_shell ?= $(dc_default_shell_bin)

dc/react/shell: ## Start a shell in the react container
	$(call dc_invoke,exec,,$(dc_service_react),$(dc_react_default_shell))

dc/react/shell-run: ## Start a shell in the react container (using run instead of exec)
	$(call dc_invoke,run,,$(dc_service_react),$(dc_react_default_shell))

dc/react/run-dev: ## Run the node server in the react container
	$(call dc_invoke,run,,$(dc_service_react),npm run dev --host)

dc/react/logs: ## Logs of the react container (follow mode)
dc/react/logs: dc_cmd_options_logs := -f --no-log-prefix --tail=10
dc/react/logs: dc_cmd_services_logs := $(dc_service_react)
dc/react/logs: dc/logs


dc/start:
	$(MAKE) dc/react/logs GNUMAKEFLAGS=""