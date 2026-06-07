DOCKER_COMPOSE=docker compose

init:
	make cloning
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "NODE_ENV=development" > src/simple-cv-api/.env
	echo "GEMINI_API_KEY=AQ.Ab8RN6LLlgHt4qc0yW4-zuzFNzjAUErUnDzE8u7wdmx0-5UuFQ" >> src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "TELEGRAM_MODE=polling" >> src/simple-cv-api/.env
	echo "DATABASE_URL=postgresql://simple_cv_user_test:123456_test@simple-cv-postgres:5432/simple_cv_test?schema=public" >> src/simple-cv-api/.env
	echo "JWT_SECRET=jwtsecrettest" >> src/simple-cv-api/.env
	echo "JWT_ACCESS_TOKEN_TTL=2h" >> src/simple-cv-api/.env
	echo "JWT_REFRESH_TOKEN_TTL=7d" >> src/simple-cv-api/.env
	echo "COOKIE_DOMAIN=.simple-cv.local" >> src/simple-cv-api/.env
	echo "APP_DOMAIN=http://simple-cv.local:1090" >> src/simple-cv-api/.env
	echo "API_DOMAIN=http://api.simple-cv.local:1090" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} build
	cd src/simple-cv-api && yarn install
	${DOCKER_COMPOSE} up -d

init-prod:
	make cloning
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "NODE_ENV=production" > src/simple-cv-api/.env
	echo "GEMINI_API_KEY=AQ.Ab8RN6LLlgHt4qc0yW4-zuzFNzjAUErUnDzE8u7wdmx0-5UuFQ" >> src/simple-cv-api/.env
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
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml build
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml up -d

cloning:
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend

update-prod-all:
	${DOCKER_COMPOSE} down
	git pull
	cd src/simple-cv-api && git pull
	cd src/simple-cv.life.frontend && git pull
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml up -d --build

prisma:
	${DOCKER_COMPOSE} exec simple-cv-nestjs sh -c "yarn prisma ${args}"

migrate:
	${DOCKER_COMPOSE} exec simple-cv-nestjs sh -c "yarn prisma migrate dev --name ${n}"