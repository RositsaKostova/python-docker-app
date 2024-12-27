# The base image
FROM ubuntu:latest

# Install python and pip
RUN apt-get update -y
RUN apt-get install -y python3 python3-pip

COPY . . 

# Install Python modules needed by the Python app
RUN pip3 install -r /src/requirements.txt

# Declare the port number the container should expose
EXPOSE 5000

# Run the application
CMD ["python3", "/src/app.py"]

