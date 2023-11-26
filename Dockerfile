FROM ubuntu:latest

RUN apt update \
	&& apt install -y openjdk-17-jdk \
	&& apt install -y wget \
	&& apt install -y jq \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir /paper

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp

COPY start.sh /
RUN chmod +x start.sh

ENTRYPOINT [ "/start.sh" ]
