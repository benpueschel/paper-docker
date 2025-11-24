#!/bin/bash

# Enter server directory
cd paper

# Accept EULA
echo "eula=true" > eula.txt

MC_VERSION=${MC_VERSION:-latest}
PAPER_BUILD=${PAPER_BUILD:-latest}
MIN_RAM=${MIN_RAM:-256M}
MAX_RAM=${MAX_RAM:-1G}


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

# Run user-defined command
exec "$@"

# Start server
exec java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_OPTS} -jar ${JAR_NAME} nogui
