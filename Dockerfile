FROM python:3.7 AS build

COPY . /
WORKDIR /
RUN pip3 install -r requirements.txt
RUN pip3 install pyinstaller
RUN pyinstaller /amzncaptcha.py --onefile

FROM alpine
COPY --from=build /dist/amzncaptcha /amzncaptcha
EXPOSE 8080
ENTRYPOINT ["/amzncaptcha"]
CMD ["8080"]
