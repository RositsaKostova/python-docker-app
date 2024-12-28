# Базов образ
FROM ubuntu:latest

# Инсталирай Python и pip
RUN apt-get update -y && apt-get install -y python3 python3-pip

# Създай работна директория
WORKDIR /src

# Копирай само нужните файлове
COPY requirements.txt /src/requirements.txt

# Инсталирай Python зависимости
RUN pip3 install -r requirements.txt

# Копирай останалите файлове на приложението
COPY . /src

# Декларирай порта, който контейнерът ще използва
EXPOSE 5000

# Стартирай приложението
CMD ["python3", "app.py"]

