#!/bin/bash

UNITY_APPLICATION=$(find /Applications/Unity -name Unity.app | head -1)

"${UNITY_APPLICATION}/Contents/MacOS/Unity" \
    -quit \
    -batchmode \
    -serial "$UNITY_SERIAL" \
    -username "$UNITY_USERNAME" \
    -password "$UNITY_PASSWORD" || true
