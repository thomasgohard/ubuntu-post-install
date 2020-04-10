#!/bin/bash

VSCODE_SETTINGS=~/.config/Code/User/settings.json

wget https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y install git libsecret-1-0 libsecret-1-dev jq moreutils apt-transport-https ruby ruby-dev
sudo apt update
sudo apt -y install dotnet-sdk-3.1
sudo snap install --classic code
jq -n '{}' > $VSCODE_SETTINGS
jq -r '. + {"telemetry.enableCrashReporter": false}' $VSCODE_SETTINGS | sponge $VSCODE_SETTINGS
jq -r '. + {"telemetry.enableTelemetry": false}' $VSCODE_SETTINGS | sponge $VSCODE_SETTINGS
echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" | sudo tee /etc/profile.d/dotnet-telemetry.sh
mkdir ~/git
(cd /usr/share/doc/git/contrib/credential/libsecret && sudo make)
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
rm packages-microsoft-prod.deb
gem install --user-install github-pages
echo $'if which ruby >/dev/null && which gem >/dev/null; then\n\tPATH="$(ruby -r rubygems -e \'puts Gem.user_dir\')/bin:$PATH"\nfi' | tee -a ~/.bashrc
