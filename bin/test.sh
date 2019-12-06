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

    UNITY_APPLICATION=$([ -n "${UNITY_INSTALL_VERSION_MATCH}" ] && echo "${UNITY_INSTALL_VERSION_MATCH}" || echo "${UNITY_INSTALL_LATEST}")

}

findunity

UNITY_VERSION=$(defaults read "${UNITY_APPLICATION}/Contents/Info.plist" CFBundleVersion)

echo "Testing with Unity ${UNITY_VERSION}"

if echo "${UNITY_VERSION}" | grep "2019" &> /dev/null; then

    "${UNITY_APPLICATION}/Contents/MacOS/Unity" \
        -batchmode \
        -nographics \
        -silent-crashes \
        -stackTraceLogType Full \
        -logFile - \
        -projectPath "$(pwd)/" \
        -runEditorTests \
        -editorTestsResultFile "$(pwd)/test.xml"

else

    "${UNITY_APPLICATION}/Contents/MacOS/Unity" \
        -batchmode \
        -nographics \
        -noUpm \
        -silent-crashes \
        -logFile "$(pwd)/unity.log" \
        -projectPath "$(pwd)/" \
        -runEditorTests \
        -editorTestsResultFile "$(pwd)/test.xml"

    cat "$(pwd)/unity.log"

fi

LOG_FILE="$(pwd)/test.xml"

printf '\n%s\n\n' "$(<"${LOG_FILE}")"

checktests() {

    local TOTAL
    local PASSED
    local FAILED

    TOTAL=$(grep -Eo 'total="([0-9]*)"' "${LOG_FILE}" | head -1 | grep -Eo '[0-9]+')
    PASSED=$(grep -Eo 'passed="([0-9]*)"' "${LOG_FILE}" | head -1 | grep -Eo '[0-9]+')
    FAILED=$(grep -Eo 'failed="([0-9]*)"' "${LOG_FILE}" | head -1 | grep -Eo '[0-9]+')

    printf "Test Results:\n - Total %s\n ✔ Passed %s\n 𐄂 Failed %s\n" "${TOTAL}" "${PASSED}" "${FAILED}"

    if [ "${TOTAL}" -ne "${PASSED}" ]; then

        return 1

    fi

    return 0

}

checktests "${LOG_FILE}"

CODE=$?

exit $CODE
