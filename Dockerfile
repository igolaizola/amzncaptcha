FROM python:3.7 AS build

COPY . /
RUN pip3 install -r requirements.txt
RUN pip3 install pyinstaller
RUN pyinstaller --onefile --collect-data amazoncaptcha /amzncaptcha.py 
FROM debian
COPY --from=build /dist/amzncaptcha /
RUN apt update && apt install -y libxcb1
RUN /amzncaptcha version
EXPOSE 8080
ENTRYPOINT ["/amzncaptcha"]
CMD ["8080"]

FROM python:3.7 AS build
