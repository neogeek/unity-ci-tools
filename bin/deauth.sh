#!/bin/bash

# https://github.com/tmux/tmux/issues/475#issuecomment-231527324
export EVENT_NOKQUEUE=1

findunity() {

    local UNITY_INSTALLS
    local PROJECT_VERSION
    local UNITY_INSTALL_VERSION_MATCH
    local UNITY_INSTALL_LATEST

    UNITY_INSTALLS=$(find /Applications/Unity -name "Unity.app" | sort -r)

    if [ -f "ProjectSettings/ProjectVersion.txt" ]; then

        PROJECT_VERSION=$(grep -o -E "[0-9]+\.[0-9]+\.[0-9]+[a-z][0-9]+" "ProjectSettings/ProjectVersion.txt" | head -1)

        UNITY_INSTALL_VERSION_MATCH=$(grep "${PROJECT_VERSION}" <<< "${UNITY_INSTALLS}")

    fi

    UNITY_INSTALL_LATEST=$(head -1 <<< "${UNITY_INSTALLS}")

    UNITY_APPLICATION=${UNITY_INSTALL_VERSION_MATCH:-$UNITY_INSTALL_LATEST}

}

findunity

"${UNITY_APPLICATION}/Contents/MacOS/Unity" \
    -quit \
    -batchmode \
    -returnlicense || true
