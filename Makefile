DOCKER_COMPOSE=docker compose

init:
	${DOCKER_COMPOSE} build
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv-api.git src/simple-cv-api
	git clone ssh://git@gitlab.it-vimax.com.ua:2022/it-vimax/simple-cv.life.frontend.git src/simple-cv.life.frontend
	cp src/simple-cv-api/.env.example src/simple-cv-api/.env
	echo "GEMINI_API_KEY=gen-lang-client-0695045766" > src/simple-cv-api/.env
	echo "TELEGRAM_BOT_TOKEN=8828034118:AAEIR_aRQbdhWbmTz6WtYJH8Az4_1B78fL0" >> src/simple-cv-api/.env
	echo "CHROME_PATH=/usr/bin/chromium" >> src/simple-cv-api/.env
	cd src/simple-cv-api && yarn install
	${DOCKER_COMPOSE} up -d

api-log:
	docker logs -f --tail 10 nestjs