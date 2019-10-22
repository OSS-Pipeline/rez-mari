#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
MARI_URL=$1
MARI_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "==============="
echo -e "=== INSTALL ==="
echo -e "==============="
echo -e "\n"

echo -e "[INSTALL][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[INSTALL][ARGS] MARI URL: ${MARI_URL}"
echo -e "[INSTALL][ARGS] MARI VERSION: ${MARI_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${INSTALL_PATH} || -z ${MARI_URL} || -z ${MARI_VERSION} ]]; then
    echo -e "\n"
    echo -e "[INSTALL][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We install Mari.
echo -e "\n"
echo -e "[INSTALL] Installing Mari-${MARI_VERSION}..."
echo -e "\n"

# We extract the content of the .run file in a manner that it does not ask for explicit user input.
${MARI_URL} \
    --prefix=${INSTALL_PATH} \
    --accept-eula

echo -e "\n"
echo -e "[INSTALL] Finished installing Mari-${MARI_VERSION}!"
echo -e "\n"
