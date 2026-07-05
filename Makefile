DC = docker compose -f docker-compose.yml -f docker-compose.dev.yml

.PHONY: up down clear logs sh cert

up:
	$(DC) up --build

down:
	$(DC) down
	
clear:
	$(DC) down -v

logs:
	$(DC) logs -f

sh:
	$(DC) exec backend sh

cert:
	mkcert -cert-file nginx/certs/localhost.pem -key-file nginx/certs/localhost-key.pem localhost 127.0.0.1 ::1
