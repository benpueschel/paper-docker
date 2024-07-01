FROM alpine:latest

RUN apk update && \
	apk add jq bash openjdk21-jre wget

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp

# Create a non-priviliged user and set the working directory to their home
RUN adduser -D -S -h /home/minecraft minecraft
WORKDIR /home/minecraft
RUN mkdir paper
RUN chown minecraft paper

# Copy the start script and make it executable
COPY start.sh ./
RUN chown minecraft start.sh
RUN chmod +x start.sh

# Switch to the non-priviliged user
USER minecraft

ENTRYPOINT [ "./start.sh" ]
