#!/bin/bash

VSCODE_SETTINGS=~/.config/Code/User/settings.json

sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y install git libsecret-1-0 libsecret-1-dev jq moreutils
sudo snap install --classic code
jq -n '{}' > $VSCODE_SETTINGS
jq -r '. + {"telemetry.enableCrashReporter": false}' $VSCODE_SETTINGS | sponge $VSCODE_SETTINGS
jq -r '. + {"telemetry.enableTelemetry": false}' $VSCODE_SETTINGS | sponge $VSCODE_SETTINGS
mkdir ~/git
(cd /usr/share/doc/git/contrib/credential/libsecret && sudo make)
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
