#!/bin/bash

# Директория для хранения временных файлов Certbot
mkdir -p /var/www/certbot

# Запуск certbot для генерации сертификатов
certbot certonly --webroot --webroot-path=/var/www/certbot -d simple-cv.life --non-interactive --agree-tos --email it.vimax@gmail.com

# Настроить cron для обновления сертификатов
echo "0 0 * * * /usr/bin/certbot renew --quiet" >> /etc/crontabs/root

# Запуск cron в фоновом режиме
crond -f &