# Symfony 5 application docker skeleton
app_dir=${CURDIR}
docker_dir=.docker
console=php bin/console

# Including current environment files (.env, .env.local).
ifndef APP_ENV
	include .env
	# Determine if .env.local file exist
	ifneq ("$(wildcard .env.local)","")
		include .env.local
	endif
endif

# Get app name from environment file
app_name=${APP_NAME}

compose := docker-compose \
	-f '$(docker_dir)/docker-compose.yml' \
	-p '$(app_name)' \
	--env-file='.env'


#exec='docker exec'




build: up ps

up:
	$(compose) up -d --build

stop:
	$(compose) stop

down:
	$(compose) down

ps:
	$(compose) ps

logs:
	$(compose) logs -f



# Service commands:

danger-open='\033[31;49m'
danger-close='\033[39m'


delete_msg = "Do you really want to drop all containers from the system? [y/n] > "
CONFIRMATION ?= $(shell bash -c 'read -p ${delete_msg} result; echo $${result}')

drop-all:
	@printf "$(danger-open)\nATTENTION!\n"
	@printf "All containers will be removed from system.\n\n"
	@#printf "$(CONFIRMATION)"
	@docker stop $$(docker ps -a -q) && docker rm $$(docker ps -a -q)
	@printf $(danger-close)

ddt:
	@printf "\033[31;49m\nATTENTION!\n\033[39m\n"


# ---------------------------------------------------------------------------------------------------------------------

#	USERNAME ?= $(shell bash -c 'read -p "Username: " username; echo $$username')
#	PASSWORD ?= $(shell bash -c 'read -s -p "Password: " pwd; echo $$pwd')
#	talk:
#		@clear
#		@echo 'Username › $(USERNAME)'
#		@echo 'Password › $(PASSWORD)'


#	build:
#	  @read -p "tag? : " TAG \
#	  && echo "tag : $${TAG}"
