#!/bin/bash
set -uxo

#-----
#----- Prefetch version, rev, and sha256 from github compiled apps
#-----

# Emplacements NixOS
CFGPATH=$(sed "s/\"//g" /etc/nixos/cfgpath.nix)
MACHINE=$(sed "s/\"//g" /etc/nixos/machine.nix)

# Liste des modules "from git"
MODULES_GIT=$(sed "s/\"//g" ${CFGPATH}auto/${MACHINE}-modules.nix | grep '\-git.nix')

# Prefetch
for element in $MODULES_GIT
do
  OWNER=$(cat $element | grep owner | head -n 1 | awk -F '"' '{print $2}')
  REPO=$(cat $element | grep pname | head -n 1 | awk -F '"' '{print $2}')

  SHA256=$(nix-prefetch-github-latest-release $OWNER $REPO | grep sha256 | awk -F '"' '{print $4}')
  REV=$(nix-prefetch-github-latest-release $OWNER $REPO | grep rev | awk -F '"' '{print $4}')
  VERSION=$(curl -sL https://api.github.com/repos/$OWNER/$REPO/releases | grep tag_name | head -n 1 | awk -F '"' '{print $4}')

  sed -i "\|  version = \"|s|\".*\"|\"${VERSION}\"|" ${element}
  sed -i "\|  rev = \"|s|\".*\"|\"${REV}\"|" ${element}
  sed -i "\|  sha256 = \"|s|\".*\"|\"${SHA256}\"|" ${element}

done





