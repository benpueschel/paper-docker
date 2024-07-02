# Paper Docker

PaperMC in a docker container.
PaperMC is a fork of the Minecraft Server API Spigot which aims to improve performance, 
reduce memory usage and to simplify aswell as to improve the API usage.

To find out more about Paper visit https://papermc.io/ or https://github.com/PaperMC/Paper

## Quick Start

The package is available on GitHub Container Registry as `ghcr.io/benpueschel/paper-docker:main`.
To automatically pull the image and run a container, use:
```sh
docker run -p 25565:25565 -d --rm --name my-paper-server \
-v my-paper-volume:/home/minecraft/paper \
ghcr.io/benpueschel/paper-docker:main
```

Container uses the following environment variables:
- `MC_VERSION`: target minecraft version. defaults to `latest`
- `PAPER_BUILD`: target build. defaults to `latest`
- `MIN_RAM`: jvm min heap size (-Xms). Defaults to `256M`
- `MAX_RAM`: jvm max heap size (-Xmx). Defaults to `1G`
- `JAVA_OPTS`: extra options to be passed to the jvm. optional

## Manual Build

First, clone the repository:
```sh
git clone https://github.com/benpueschel/paper-docker.git && cd paper-docker
```

Then build the image with:
```sh
docker build -t my-paper-image .
```

Finally, run the container with the custom image using:
```sh
docker run -p 25565:25565 -d --rm --name my-paper-server \
-v my-paper-volume:/home/minecraft/paper \
my-paper-image
```

