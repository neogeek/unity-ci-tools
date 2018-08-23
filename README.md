# Unity CI Tools

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
