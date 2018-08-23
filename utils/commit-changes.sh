#!/bin/bash

git add data/editor-installers.json
git commit -m "Updated editor-installers.json [skip ci]"
git push "https://$GITHUB_TOKEN@github.com/neogeek/unity-ci-tools"
