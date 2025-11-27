#!/bin/bash

# Enter server directory
cd paper

# Accept EULA
echo "eula=true" > eula.txt

MC_VERSION=${MC_VERSION:-latest}
PAPER_BUILD=${PAPER_BUILD:-latest}
MIN_RAM=${MIN_RAM:-256M}
MAX_RAM=${MAX_RAM:-1G}
JAVA_OPTS=${JAVA_OPTS:-"-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"}


# Perform initial setup
URL_PREFIX=https://fill.papermc.io/v3/projects/paper
if [ ${MC_VERSION} = latest ]
  then
    # Get the latest MC version
	MC_VERSION=$(wget -qO - $URL_PREFIX | jq -r '.versions[ (.versions | keys_unsorted | first) ] | first')
	echo "Latest MC version detected: ${MC_VERSION}"
fi
URL_PREFIX=${URL_PREFIX}/versions/${MC_VERSION}
if [ ${PAPER_BUILD} = latest ]
  then
    # Get the latest build
    PAPER_BUILD=$(wget -qO - $URL_PREFIX/builds/latest | jq -r '.id')
	echo "Latest Paper build detected: ${PAPER_BUILD}"
fi

JAR_NAME=paper-${MC_VERSION}-${PAPER_BUILD}.jar

if [ ! -e ${JAR_NAME} ]
  then
    rm -f *.jar
	DOWNLOAD_URL=$(wget -qO - $URL_PREFIX/builds/${PAPER_BUILD} | jq -r '.downloads."server:default".url')
    wget ${DOWNLOAD_URL} -O ${JAR_NAME}
fi

if [ $# -gt 0 ]; then
	sh -c "$1" _ "$@"
	if [ $? -ne 0 ]; then
		exit $?
	fi
fi

# Start server
exec java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_OPTS} -jar ${JAR_NAME} nogui
