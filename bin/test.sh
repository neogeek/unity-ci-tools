#!/bin/bash

# https://github.com/tmux/tmux/issues/475#issuecomment-231527324
export EVENT_NOKQUEUE=1

UNITY_APPLICATION=$(find /Applications/Unity -name Unity.app | head -1)

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

    TOTAL=$(grep -Eo 'total="([0-9]*)"' "${LOG_FILE}" | head -1 | grep -Eo '[0-9]+')
    PASSED=$(grep -Eo 'passed="([0-9]*)"' "${LOG_FILE}" | head -1 | grep -Eo '[0-9]+')
    FAILED=$(grep -Eo 'failed="([0-9]*)"' "${LOG_FILE}" | head -1 | grep -Eo '[0-9]+')

    printf "Test Results \nTotal: ${TOTAL} Passed: ${PASSED} Failed: ${FAILED}\n"

    if [ "${TOTAL}" -ne "${PASSED}" ]; then

        return 1

    fi

    return 0

}

checktests "${LOG_FILE}"

CODE=$?

exit $CODE
