FROM ubuntu:latest

RUN apt update \
	&& apt install -y openjdk-21-jdk \
	&& apt install -y wget \
	&& apt install -y jq \
	&& rm -rf /var/lib/apt/lists/*

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp

# Create a non-priviliged user and set the working directory to their home
RUN useradd -ms /bin/bash minecraft
WORKDIR /home/minecraft
RUN mkdir paper
RUN chown minecraft paper

# Copy the start script and make it executable
COPY start.sh ./
RUN chmod +x start.sh

# Switch to the non-priviliged user
USER minecraft

ENTRYPOINT [ "./start.sh" ]
