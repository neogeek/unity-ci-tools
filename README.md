# Unity CI Tools

[![Build Status](https://travis-ci.org/neogeek/unity-ci-tools.svg?branch=master)](https://travis-ci.org/neogeek/unity-ci-tools)
[![Join the chat at https://discord.gg/nNtFsfd](https://img.shields.io/badge/discord-join%20chat-7289DA.svg)](https://discord.gg/nNtFsfd)
[![](https://img.shields.io/badge/Trello-Board-blue.svg)](hhttps://trello.com/b/b4Tpw4Bw/unity-ci-tools)

## Setup

### Create a `.travis.yml` File

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

### Setup Environment Variables on Travis

Add the following variables in the settings panel of your project on <https://travis-ci.org/>:

| Key | Description |
| --- | ----------- |
| UNITY_SERIAL | The serial key found at <https://id.unity.com/en/subscriptions>. Keys are only avalible with a Plus or Pro Subscription |
| UNITY_USERNAME | Your email address used to log into <https://unity.com/>. |
| UNITY_PASSWORD | Your password used to log into <https://unity.com/>. |

![](screenshots/travis-env-variables-empty.png)

![](screenshots/travis-env-variables-filled-out.png)
