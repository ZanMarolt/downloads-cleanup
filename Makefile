# Which target to run by default (when no target is passed to make)
.DEFAULT_GOAL := help

.PHONY: help folder/check folder/cleanup

help: ## Show help
	@echo "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:"
	@grep -E '^[a-zA-Z0-9_/%\-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-28s\033[0m %s\n", $$1, $$2}'


folder/check: ## Checks a folder for folders older than 1 month and prints them out, test before executing with this command
	@bash ./removal.sh -e

folder/cleanup: ## Checks a folder for folders older than 1 month and removes them
	@bash ./removal.sh -x	

