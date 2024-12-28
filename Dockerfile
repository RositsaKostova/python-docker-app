# Базов образ
FROM ubuntu:latest

# Инсталирай системни пакети
RUN apt-get update -y && apt-get install -y \
    python3 python3-pip python3-dev build-essential libffi-dev

# Създай работна директория
WORKDIR /src

# Копирай всички файлове от проектната директория в контейнера
COPY . /src/

# Инсталирай Python зависимости
RUN pip3 --version 

# Декларирай порта, който приложението ще използва
EXPOSE 5000

# Стартирай приложението
CMD ["python3", "app.py"]
