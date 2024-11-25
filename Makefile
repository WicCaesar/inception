name = Devaneio
include srcs/.env
.DEFAULT_GOAL = all

data:
	@bash ./srcs/requirements/wordpress/tools/create_dbdirs.sh
	echo "Considere executar: ~$ sudo chmod 777 data"

env:
	@bash ./create_env.sh

certificate:
	@bash ./create_certificate.sh

initial: data certificate env
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env up --detach --build
#--build images before starting containers.
#--detach mode runs containers in the background.

all:
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env up --detach --build

build:
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env build

down:
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env down

clean: down
	@docker-compose --file ./srcs/docker-compose.yml down --volumes --rmi local
	@docker container prune --force
	@sudo rm -rf ~/data/

fclean: down
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env down --volumes
	@docker image prune --all --force
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm srcs/.env srcs/requirements/tools/*
	@sudo rm -rf ~/data

re: fclean initial
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env up --detach --build

restore:
	@sudo cp -r ../Downloads/data ../
	@docker exec -i ${DB_HOST} mysql -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < ../Downloads/wordpress-database.sql
	#@wp import ../Downloads/onlydans.WordPress.2024-11-24.xml --authors=create
	#@sudo docker cp ../Downloads/wordpress-files wordpress>:/var/www
	@docker-compose --file ./srcs/docker-compose.yml --env-file srcs/.env up --detach --build
	
.PHONY: all down data certificate env initial build clean fclean re restore info

