FROM --platform=linux/amd64 eclipse-temurin:17-jdk-jammy

LABEL   author="Torsten Widmann" maintainer="info@goover.de"
LABEL   org.opencontainers.image.source="https://github.com/gOOvER/own-pterodactyl-images"
LABEL   org.opencontainers.image.licenses=MIT

RUN  apt update -y && apt -y upgrade
RUN  apt install -y tesseract-ocr ca-certificates curl ffmpeg git iproute2 ipset openssl sqlite3 tar tzdata libfreetype6
RUN  update-locale lang=en_US.UTF-8 && dpkg-reconfigure --frontend noninteractive locales && ldconfig
RUN  useradd -m -d /home/container -s /bin/bash container
RUN  tesseract -v

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
# ENTRYPOINT  ["sh", "/entrypoint.sh"]
CMD ["/bin/bash", "/entrypoint.sh"]
