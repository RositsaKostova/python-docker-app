# Базов образ
FROM ubuntu:latest

# Инсталирай Python и pip
RUN apt-get update -y 
RUN apt-get install -y python3 python3-pip

# Създай работна директория
WORKDIR /src

# Копирай файла requirements.txt от папката src
COPY src/requirements.txt /src/requirements.txt

# Инсталирай Python зависимости
RUN pip3 install -r /src/requirements.txt

# Копирай всички файлове на приложението от папката src
COPY src/ /src

# Декларирай порта
EXPOSE 5000

# Стартирай приложението
CMD ["python3", "app.py"]
