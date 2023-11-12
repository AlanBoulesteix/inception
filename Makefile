all:	build up

up:
	sudo docker compose -f srcs/docker-compose.yml up -d

down:
	sudo docker compose -f srcs/docker-compose.yml down

build:
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress
	sudo docker compose -f srcs/docker-compose.yml build

logs:
	docker compose -f ./srcs/docker-compose.yml logs

clean: 	down
	sudo docker system prune -af

fclean:	clean
	sudo rm -rf $(HOME)/data/mariadb
	sudo rm -rf $(HOME)/data/wordpress
	-sudo docker volume rm srcs_mariadb
	-sudo docker volume rm srcs_wordpress

re:	clean
	make all

.PHONY: all build up down run clean fclean re
