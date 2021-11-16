# Unity CI Tools

> Bash scripts for running Unity tests on continuous integration services

[![Join the chat at https://discord.gg/nNtFsfd](https://img.shields.io/badge/discord-join%20chat-7289DA.svg)](https://discord.gg/nNtFsfd)

## Setup

### Create a `bitrise.yml` File

```yaml
---
format_version: "8"
default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git
project_type: other
trigger_map:
  - push_branch: main
    workflow: primary
  - pull_request_source_branch: "*"
    workflow: primary
    pull_request_target_branch: main
workflows:
  primary:
    steps:
      - git-clone@6: {}
      - cache-pull@2: {}
      - script@1:
          title: Install and Test with Unity
          inputs:
            - content: |-
                #!/usr/bin/env bash
                # fail if any commands fails
                set -e
                # debug log
                set -x

                bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/v1.1.0/bin/install.sh)
                bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/v1.1.0/bin/auth.sh)
                bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/v1.1.0/bin/test.sh)
                bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/v1.1.0/bin/deauth.sh)
      - cache-push@2:
          inputs:
            - cache_paths: "$HOME/cache"
          is_always_run: true
meta:
  bitrise.io:
    machine_type: standard
    stack: osx-xcode-13.1.x
```

### Create a `Makefile` File

```yaml
test: SHELL:=/bin/bash
test:
  bash <(curl -fsSL https://raw.githubusercontent.com/neogeek/unity-ci-tools/v1.1.0/bin/test.sh)

clean:
  git clean -xdf
```

### Setup Environment Variables on Bitrise

Add the following variables in the Secrets tab in the Workflow Editor section of your project on <https://bitrise.io/>:

| Key                     | Description                                                                                                                                               | Required |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| UNITY_SERIAL            | The serial key found at <https://id.unity.com/en/subscriptions>. Keys are only avalible with a Plus or Pro Subscription                                   | Yes      |
| UNITY_USERNAME          | Your email address used to log into <https://unity.com/>.                                                                                                 | Yes      |
| UNITY_PASSWORD          | Your password used to log into <https://unity.com/>.                                                                                                      | Yes      |
| UNITY_INSTALLER_URL     | Full URL of editor installer. See [editor installers](https://github.com/neogeek/get-unity/blob/master/data/editor-installers.json).                      | No       |
| UNITY_INSTALLER_VERSION | Version of editor installer. To be used with hash. See [editor installers](https://github.com/neogeek/get-unity/blob/master/data/editor-installers.json). | No       |
| UNITY_INSTALLER_HASH    | Hash of editor installer. To be used to version. See [editor installers](https://github.com/neogeek/get-unity/blob/master/data/editor-installers.json).   | No       |
