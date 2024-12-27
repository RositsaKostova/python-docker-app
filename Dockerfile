# Използваме Ubuntu като базов образ
FROM ubuntu:latest

# Инсталираме нужните зависимости
RUN apt-get update && apt-get install -y python3 python3-pip

# Задаваме работната директория
WORKDIR /app

# Копираме всички файлове от директорията src в контейнера
COPY src/ .

# Инсталираме Python зависимостите
RUN pip3 install --no-cache-dir -r requirements.txt

# Указваме командата за стартиране на приложението
CMD ["python3", "app.py"]
