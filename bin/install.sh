#!/bin/bash

if [ ! -d "${HOME}/cache" ]; then

    mkdir -m 777 "${HOME}/cache"

fi

if [ -z "${UNITY_INSTALLER_HASH}" ]; then

    UNITY_INSTALLER_HASH="59ff3e03856d"

fi

if [ -z "${UNITY_INSTALLER_VERSION}" ]; then

    UNITY_INSTALLER_VERSION="2019.3.15f1"

fi

if [ -z "${UNITY_INSTALLER_URL}" ]; then

    UNITY_INSTALLER_URL="https://download.unity3d.com/download_unity/${UNITY_INSTALLER_HASH}/MacEditorInstaller/Unity-${UNITY_INSTALLER_VERSION}.pkg"

fi

FILENAME=$(basename "${UNITY_INSTALLER_URL}")

if [ ! -f "${HOME}/cache/${FILENAME}" ]; then

    echo "Downloading Unity ${UNITY_INSTALLER_VERSION} from ${UNITY_INSTALLER_URL}"
    curl --retry 5 -o "${HOME}/cache/${FILENAME}" "${UNITY_INSTALLER_URL}"

fi

echo "Installing Unity ${UNITY_INSTALLER_VERSION}"
sudo installer -dumplog -package "${HOME}/cache/${FILENAME}" -target /
