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

CODE=$?

cat "$(pwd)/test.xml" && exit $CODE
