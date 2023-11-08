#!/bin/bash

set -uxo

# Nixos config places
CFGPATH=$(sed "s/\"//g" /etc/nixos/cfgpath.nix)
MACHINE=$(sed "s/\"//g" /etc/nixos/machine.nix)

# Modules list
MODULES=$(awk -F '"' '{ for (i=2 ; i<=NF ; i+=2) print $i }' ${CFGPATH}config/${MACHINE}-modules.nix)
MODULES_PATH=$(for i in $MODULES ; do find $CFGPATH -type f -name "*$i.nix" -not -path "*.secrets*" ; done)
MODULES_GIT=$(for element in $MODULES_PATH ; do echo $element | grep 'git.nix' ; done)


for element in $MODULES_GIT
do
  OWNER=$(cat $element | grep owner | head -n 1 | awk -F '"' '{print $2}')
  REPO=$(cat $element | grep pname | head -n 1 | awk -F '"' '{print $2}')

  SHA256=$(nix-prefetch-github-latest-release $OWNER $REPO | grep sha256 | awk -F '"' '{print $4}')
  REV=$(nix-prefetch-github-latest-release $OWNER $REPO | grep rev | awk -F '"' '{print $4}')
  VERSION=$(curl -sL https://api.github.com/repos/$OWNER/$REPO/releases | grep tag_name | head -n 1 | awk -F '"' '{print $4}')


  # Retraitement du element
  cp ${element} ${element}.BAK

  sed -i "/  version = \"/s/\".*\"/\"$VERSION\"/" ${element}
  sed -i "/  rev = \"/s/\".*\"/\"$REV\"/" ${element}
  sed -i "/  sha256 = \"/s/\".*\"/\"$SHA256\"/" ${element}

done





