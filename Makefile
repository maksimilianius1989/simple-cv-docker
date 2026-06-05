DOCKER_COMPOSE=docker compose

init:
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "NODE_ENV=development" >> src/simple-cv-api/.env
	echo "GEMINI_API_KEY=AQ.Ab8RN6LLlgHt4qc0yW4-zuzFNzjAUErUnDzE8u7wdmx0-5UuFQ" >> src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "TELEGRAM_MODE=polling" >> src/simple-cv-api/.env
	echo "TELEGRAM_WEBHOOK_DOMAIN=" >> src/simple-cv-api/.env
	echo "TELEGRAM_WEBHOOK_PATH=" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} build
	cd src/simple-cv-api && yarn install
	${DOCKER_COMPOSE} up -d

init-prod:
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "NODE_ENV=production" >> src/simple-cv-api/.env
	echo "GEMINI_API_KEY=AQ.Ab8RN6LLlgHt4qc0yW4-zuzFNzjAUErUnDzE8u7wdmx0-5UuFQ" >> src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "TELEGRAM_MODE=webhook" >> src/simple-cv-api/.env
	echo "TELEGRAM_WEBHOOK_DOMAIN=https://api.simple-cv.life" >> src/simple-cv-api/.env
	echo "TELEGRAM_WEBHOOK_PATH=/telegram/webhook" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml build --no-cache
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml up -d

api-logs:
	docker logs -f --tail 20 nestjs
