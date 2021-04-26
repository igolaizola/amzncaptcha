FROM python:3.7 AS build

COPY . /
RUN pip3 install -r requirements.txt
RUN pip3 install pyinstaller
RUN pyinstaller --onefile /amzncaptcha.py

FROM debian
COPY --from=build /dist/amzncaptcha /
EXPOSE 8080
ENTRYPOINT ["/amzncaptcha"]
CMD ["8080"]
