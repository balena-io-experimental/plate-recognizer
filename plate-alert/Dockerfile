FROM balenalib/raspberrypi4-64-ubuntu-python:3.8-focal-build-20221014

WORKDIR /usr/src/app

RUN apt update && apt install -y sqlite3

RUN pip3 install flask twilio RPi.GPIO requests

COPY *.py ./

CMD [ "flask", "run", "--host=0.0.0.0" ]
