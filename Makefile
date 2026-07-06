.PHONY: up dev down clear logs sh art cert

# PRODUCTION
up:
	docker compose -f docker-compose.yml up --build

# DEVELOPMENT
dev:
	docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build

# CORE
down:
	docker compose down

clear:
	docker compose down -v

logs:
	docker compose logs -f $(s)

sh:
	@test -n "$(s)" || { echo "Usage: make sh s=<service>"; exit 1; }
	docker compose exec $(s) sh

art:
	@test -n "$(a)" || { echo "Usage: make art a=<artisan command>"; exit 1; }
	docker compose exec -u $(shell id -u):$(shell id -g) backend php artisan $(a)

# UTILS
cert:
	mkcert -cert-file nginx/certs/localhost.pem -key-file nginx/certs/localhost-key.pem localhost 127.0.0.1 ::1