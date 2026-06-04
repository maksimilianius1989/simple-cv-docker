DOCKER_COMPOSE=docker compose

init:
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "GEMINI_API_KEY=AQ.Ab8RN6IcvBdNZKLzo21JlOghD0dnVOwW5kTzwoTGqwBu8GC76Q" > src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "CHROME_PATH=/usr/bin/chromium" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} build
	cd src/simple-cv-api && yarn install
	${DOCKER_COMPOSE} up -d

init-prod:
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "GEMINI_API_KEY=AQ.Ab8RN6LLlgHt4qc0yW4-zuzFNzjAUErUnDzE8u7wdmx0-5UuFQ" > src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "CHROME_PATH=/usr/bin/chromium" >> src/simple-cv-api/.env
	${DOCKER_COMPOSE} - build
	${DOCKER_COMPOSE} -f docker-compose.prod.yaml up -d

api-logs:
	docker logs -f --tail 20 nestjs

rebuild:
	${DOCKER_COMPOSE} down
	rm -rf src/*
	make init

