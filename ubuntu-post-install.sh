#!/bin/bash
sudo apt update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y install git libsecret-1-0 libsecret-1-dev
sudo snap install --classic code
mkdir ~/git
(cd /usr/share/doc/git/contrib/credential/libsecret && sudo make)
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
