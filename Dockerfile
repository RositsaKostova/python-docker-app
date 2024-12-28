# Базов образ
FROM ubuntu:latest

# Инсталирай системни пакети
RUN apt-get update -y && apt-get install -y \
    python3 python3-pip python3-dev build-essential libffi-dev

# Създай работна директория
WORKDIR /src

# Копирай requirements.txt в контейнера
COPY src/requirements.txt /src/requirements.txt

# Инсталирай Python зависимости
RUN pip3 install -r /src/requirements.txt

# Копирай всички файлове от src в контейнера
COPY src/ /src

# Декларирай порта, който приложението ще използва
EXPOSE 5000

# Стартирай приложението
CMD ["python3", "app.py"]
