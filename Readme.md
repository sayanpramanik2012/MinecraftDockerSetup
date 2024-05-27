FROM ubuntu:20.04

## This line uses the official Ubuntu 20.04 image as the base image for our Dockerfile

## The "FROM" instruction specifies the base image for our application and sets the context for any subsequent instructions

- ENV DEBIAN_FRONTEND=noninteractive
- WORKDIR /Minecraft

  ## The "WORKDIR" instruction sets the working directory in the container to /Minecraft

  ## This is where all files will be located within the container

- RUN apt-get update && apt-get install -y \
  openjdk-17-jdk \
  wget \
  && rm -rf /var/lib/apt/lists/\*

  ## The "RUN" instruction executes a command in the container

  ## In this case, the command is to install the Java Development Kit 17 and wget

  ## The && symbol is a logical operator that runs the second command only if the first command is successful

  ## The rm -rf /var/lib/apt/lists/\* command is used to clean up any temporary files created during the installation process

- COPY ./paper-1.20.4-496.jar /Minecraft/paper.jar
- COPY ./server.properties /Minecraft/server.properties
- COPY ./plugins /Minecraft/plugins

  ## The "COPY" instruction copies files from the current directory on the host machine into the container

  ## In this case, the files paper-1.20.4-496.jar, server.properties, and plugins are copied into the /Minecraft directory in the container

- RUN echo "eula=true" > eula.txt
- EXPOSE 25565

  ## The "EXPOSE" instruction tells which port to expose on the host machine when running the container

  ## In this case, port 25565 is exposed

- ENTRYPOINT [ "java" ]

  ## The "ENTRYPOINT" instruction specifies the command to run when the container starts

  ## In this case, the command is java -Xms10G -Xmx20G -jar paper.jar nogui

  ## The "-Xms10G" and "-Xmx20G" options set the minimum and maximum Java heap sizes, respectively

  ## The "-jar" option tells Java to run the specified JAR file, which is paper.jar in this case

  ## The "nogui" option tells Java to run the server in headless mode, without a graphical user interface

- CMD [ "-Xms10G", "-Xmx20G", "-jar", "paper.jar", "nogui" ]
  ## The "CMD" instruction specifies additional arguments to pass to the ENTRYPOINT command
  ## In this case, the command is java -Xms10G -Xmx20G -jar paper.jar nogui
  ## The CMD instruction is optional and can be overridden when running the container with the -e flag
  ## For example, to set a different JVM heap size when running the container, you could use the following command:
  ## docker run -e JAVA_OPTS="-Xms4G -Xmx8G" image-name
