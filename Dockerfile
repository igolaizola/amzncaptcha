FROM --platform=linux/arm/v7 python:3.7.10-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY amzncaptcha.py amzncaptcha.py

EXPOSE 8080

CMD [ "python3", "amzncaptcha.py" , "8080"]
