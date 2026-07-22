DOCKER_COMPOSE=docker compose

init:
	make cloning
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "NODE_ENV=development" > src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "TELEGRAM_MODE=polling" >> src/simple-cv-api/.env
	echo "DATABASE_URL=postgresql://simple_cv_user_test:123456_test@simple-cv-postgres:5432/simple_cv_test?schema=public" >> src/simple-cv-api/.env
	echo "JWT_SECRET=jwtsecrettest" >> src/simple-cv-api/.env
	echo "JWT_ACCESS_TOKEN_TTL=2h" >> src/simple-cv-api/.env
	echo "JWT_REFRESH_TOKEN_TTL=7d" >> src/simple-cv-api/.env
	echo "COOKIE_DOMAIN=.simple-cv.pet" >> src/simple-cv-api/.env
	echo "APP_DOMAIN=http://simple-cv.pet:1090" >> src/simple-cv-api/.env
	echo "API_DOMAIN=http://api.simple-cv.pet:1090" >> src/simple-cv-api/.env
	echo "UPLOADS_PATH=/app/src/uploads" >> src/simple-cv-api/.env
	echo "ANALYTICS_SALT=test" >> src/simple-cv-api/.env
	echo "OLLAMA_MODEL=llama3.2:3b" >> src/simple-cv-api/.env
	echo "OLLAMA_HOST=https://ai.simple-cv.life" >> src/simple-cv-api/.env
	echo "OLLAMA_USER=admin" >> src/simple-cv-api/.env
	echo "OLLAMA_PASS=fjDFFdsf87F6fFDDD" >> src/simple-cv-api/.env
	echo "OLLAMA_TIMEOUT=600000" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} build
	cd src/simple-cv-api && yarn install
	${DOCKER_COMPOSE} up -d

init-prod:
	make cloning
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "NODE_ENV=production" > src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "TELEGRAM_MODE=webhook" >> src/simple-cv-api/.env
	echo "TELEGRAM_WEBHOOK_DOMAIN=https://api.simple-cv.life" >> src/simple-cv-api/.env
	echo "TELEGRAM_WEBHOOK_PATH=/telegram/webhook" >> src/siple-cv-api/.env
	echo "DATABASE_URL=postgresql://simple_cv_user:SoeeKKDs432_4pod446@simple-cv-postgres:5432/simple_cv?schema=public" >> src/simple-cv-api/.env
	echo "JWT_SECRET=JWT_fds876DE" >> src/simple-cv-api/.env
	echo "JWT_ACCESS_TOKEN_TTL=2h" >> src/simple-cv-api/.env
	echo "JWT_REFRESH_TOKEN_TTL=7d" >> src/simple-cv-api/.env
	echo "COOKIE_DOMAIN=.simple-cv.life" >> src/simple-cv-api/.env
	echo "APP_DOMAIN=https://simple-cv.life" >> src/simple-cv-api/.env
	echo "API_DOMAIN=https://api.simple-cv.life" >> src/simple-cv-api/.env
	echo "UPLOADS_PATH=/app/src/uploads" >> src/simple-cv-api/.env
	echo "ANALYTICS_SALT=rrwwref543543fd" >> src/simple-cv-api/.env
	echo "OLLAMA_MODEL=llama3.2:3b" >> src/simple-cv-api/.env
	echo "OLLAMA_HOST=https://ai.simple-cv.life" >> src/simple-cv-api/.env
	echo "OLLAMA_USER=admin" >> src/simple-cv-api/.env
	echo "OLLAMA_PASS=fjDFFdsf87F6fFDDD" >> src/simple-cv-api/.env
	echo "OLLAMA_TIMEOUT=600000" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml build
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml up -d

cloning:
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend

prod-update:
	${DOCKER_COMPOSE} down
	git pull
	cd src/simple-cv-api && git checkout -- . && git pull
	cd src/simple-cv.life.frontend && git checkout -- . && git pull
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml up -d --build
	${DOCKER_COMPOSE} ps

yarn:
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api sh -c "yarn ${p}"

prisma:
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api sh -c "yarn prisma ${p}"

lint-fix:
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api sh -c "yarn lint --fix"

migrate-create:
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api sh -c "yarn prisma migrate dev --create-only --name ${n}"

migrate-applay:
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api sh -c "yarn prisma migrate dev"
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api sh -c "yarn prisma generate"

dev-restart:
	${DOCKER_COMPOSE} down
	${DOCKER_COMPOSE} up -d
	${DOCKER_COMPOSE} logs -f simple-cv-nestjs-api simple-cv-nestjs-worker

node-restart:
	${DOCKER_COMPOSE} down simple-cv-nestjs-api simple-cv-nestjs-worker simple-cv-nginx
	${DOCKER_COMPOSE} up -d simple-cv-nestjs-api simple-cv-nestjs-worker simple-cv-nginx
	${DOCKER_COMPOSE} logs -f  simple-cv-nestjs-api simple-cv-nestjs-worker

nginx-restart:
	${DOCKER_COMPOSE} down simple-cv-nginx
	${DOCKER_COMPOSE} up -d simple-cv-nginx

sh:
	${DOCKER_COMPOSE} exec simple-cv-nestjs-api bash