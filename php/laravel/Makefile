mb_project_path := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
mb_clone_mb_if_not_found ?= 1
mb_mb_default_path ?= $(abspath $(mb_project_path)/../../../make/MakeBind)
mb_git_clone_path ?= $(dir $(mb_mb_default_path))
mb_main_mk ?= $(mb_mb_default_path)/main.mk
mb_default_repo_ssh ?= git@github.com:AntonioCS/MakeBind.git
mb_silent_mode ?= 0

#ifeq ($(if $(value mb_debug),$(mb_debug),0),1)
#$(info mb_silent_mode: $(mb_silent_mode))
#$(info mb_project_current_dir: $(mb_project_path))
#$(info mb_default_location_path: $(mb_default_location_path))
#$(info mb_main_mk: $(mb_main_mk))
#endif


## The MakeBind project exists and there is a symlink
ifneq ($(wildcard $(mb_main_mk)),)
include $(mb_main_mk)
else
#### make was called with a target that doesn't exist probably because there is no MakeBind in the project
%:
	$(info @$(MAKE) -s mb_clone_and_rerun mb_invoked_with_target=$*)

##### MakeBind is not present in the project, clone it and rerun the make command
mb_clone_and_rerun:
ifndef mb_silent_mode
	$(info MakeBind being cloned from $(mb_repo_ssh) to $(mb_dir))
endif
	$(info @git clone $(mb_default_repo_ssh) $(mb_git_clone_path))
	$(info @$(MAKE) -s $(if $(value mb_invoked_with_target),$(mb_invoked_with_target)))
endif # if check if exists
