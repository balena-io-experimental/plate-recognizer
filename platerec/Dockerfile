FROM platerecognizer/alpr-stream:raspberry-1.38.0

RUN apt update && apt install -y nano

WORKDIR /user-data

WORKDIR /app

COPY *.var ./
COPY *.sh ./
RUN chmod +x entry.sh


CMD ["bash", "entry.sh"]
