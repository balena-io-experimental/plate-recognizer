FROM platerecognizer/alpr-stream:raspberry-1.38.0

RUN apt update && apt install -y nano

WORKDIR /user-data

WORKDIR /app

COPY *.sh ./
RUN chmod +x entry.sh
COPY *.var ./

CMD ["bash", "entry.sh"]
