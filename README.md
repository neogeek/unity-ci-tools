# Unity CI Tools

[![Build Status](https://travis-ci.org/neogeek/unity-ci-tools.svg?branch=master)](https://travis-ci.org/neogeek/unity-ci-tools)
[![Join the chat at https://discord.gg/nNtFsfd](https://img.shields.io/badge/discord-join%20chat-7289DA.svg)](https://discord.gg/nNtFsfd)
[![](https://img.shields.io/badge/Trello-Board-blue.svg)](hhttps://trello.com/b/b4Tpw4Bw/unity-ci-tools)

## Usage

**.travis.yml**

```yaml
sudo: required
language: objective-c
osx_image: xcode9.4.1
rvm:
  - 2.5.1
install:
  - bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/master/bin/install.sh)
script:
  - bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/master/bin/auth.sh)
  - bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/master/bin/test.sh)
  - bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/master/bin/deauth.sh)
```
