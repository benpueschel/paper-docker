# Paper Docker

PaperMC in a docker container.
PaperMC is a fork of the Minecraft Server API Spigot which aims to improve performance, reduce memory usage and to simplify aswell as to improve the API usage.

To find out more about Paper visit https://papermc.io/ or https://github.com/PaperMC/Paper

## Usage

Build with:
```
docker build -t my-paper-image .
```

Run with:
```
docker run -p 25565:25565 -d --rm --name my-paper-server \
-v /paper/install/dir:/paper \
my-paper-image \
<version> <build>
```

- Version: Set to the Minecraft-Version you want to use. defaults to "latest"
- Build: Set to the specific build you want to use. defaults to "latest"