# Use the official Ubuntu 20.04 image as the base image

FROM ubuntu:20.04

# Set environment variable to suppress interactive prompts from apt

ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory in the container to /Minecraft

WORKDIR /Minecraft

# Update package lists and install Java Development Kit 17 and wget, then clean up temporary files

RUN apt-get update && apt-get install -y \
 openjdk-17-jdk \
 wget \
 && rm -rf /var/lib/apt/lists/\*

# Copy files from the host machine to the container

COPY ./paper-1.20.4-496.jar /Minecraft/paper.jar
COPY ./server.properties /Minecraft/server.properties
COPY ./plugins /Minecraft/plugins

# Accept the Minecraft EULA by writing "eula=true" to eula.txt

RUN echo "eula=true" > eula.txt

# Expose port 25565 on the host machine

EXPOSE 25565

# Set the command to run when the container starts

ENTRYPOINT ["java"]

# Provide default arguments to the ENTRYPOINT command

CMD ["-Xms10G", "-Xmx20G", "-jar", "paper.jar", "nogui"]
