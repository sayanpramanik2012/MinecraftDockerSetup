FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /Minecraft

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    && rm -rf /var/lib/apt/lists/*

# RUN wget -o paper.jar https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/496/downloads/paper-1.20.4-496.jar
COPY ./paper-1.20.4-496.jar /Minecraft/paper.jar
COPY ./server.properties /Minecraft/server.properties
COPY ./plugins /Minecraft/plugins

RUN echo "eula=true" > eula.txt

EXPOSE 25565

ENTRYPOINT [ "java" ]

CMD [ "-Xms10G", "-Xmx20G", "-jar", "paper.jar", "nogui" ]
