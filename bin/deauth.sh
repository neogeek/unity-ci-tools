#!/bin/bash

UNITY_APPLICATION=$(find /Applications/Unity -name Unity.app | head -1)

"${UNITY_APPLICATION}/Contents/MacOS/Unity" \
    -quit \
    -batchmode \
    -returnlicense || true
