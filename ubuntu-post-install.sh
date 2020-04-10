#!/bin/bash

VSCODE_SETTINGS=~/.config/Code/User/settings.json

wget https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y install git libsecret-1-0 libsecret-1-dev jq moreutils apt-transport-https virtualbox-6.0 vagrant
sudo apt update
sudo apt -y install dotnet-sdk-3.1
sudo snap install --classic code
jq -n '{}' > $VSCODE_SETTINGS
jq -r '. + {"telemetry.enableCrashReporter": false}' $VSCODE_SETTINGS | sponge $VSCODE_SETTINGS
jq -r '. + {"telemetry.enableTelemetry": false}' $VSCODE_SETTINGS | sponge $VSCODE_SETTINGS
echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" | sudo tee /etc/profile.d/dotnet-telemetry.sh
echo "export VAGRANT_DEFAULT_PROVIDER=virtualbox" | sudo tee /etc/profile.d/vagrant-default-provider.sh
mkdir ~/git
mkdir ~/vagrant
(cd /usr/share/doc/git/contrib/credential/libsecret && sudo make)
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
rm packages-microsoft-prod.deb
