# Използваме Ubuntu като базов образ
FROM ubuntu:latest

# Инсталираме нужните зависимости
RUN apt-get update -y && apt-get install -y python3 python3-pip

