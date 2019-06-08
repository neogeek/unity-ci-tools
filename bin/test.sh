#!/bin/bash

UNITY_APPLICATION=$(find /Applications/Unity -name Unity.app | head -1)

"${UNITY_APPLICATION}/Contents/MacOS/Unity" \
    -batchmode \
    -nographics \
    -noUpm \
    -silent-crashes \
    -logFile "$(pwd)/unity.log" \
    -projectPath "$(pwd)/" \
    -runEditorTests \
    -editorTestsResultFile "$(pwd)/test.xml"

CODE=$?

echo $CODE
cat "$(pwd)/unity.log"

cat "$(pwd)/test.xml" && exit $CODE
