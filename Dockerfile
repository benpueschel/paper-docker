FROM openjdk:11.0-jre-slim

RUN apt-get update \
	&& apt-get install -y wget \
	&& apt-get install -y jq \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir /paper

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp

COPY start.sh /

ENTRYPOINT [ "/start.sh" ]