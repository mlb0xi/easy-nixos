#!/bin/bash

set -exo

# Nixos config places
CFGPATH=$(sed "s/\"//g" /etc/nixos/cfgpath.nix)
MACHINE=$(sed "s/\"//g" /etc/nixos/machine.nix)

# Modules list
MODULES=$(awk -F '"' '{ for (i=2 ; i<=NF ; i+=2) print $i }' ${CFGPATH}config/${MACHINE}-modules.nix)


# Find modules everywhere BUT in .secrets
MODULES_PATH=$(for i in $MODULES ; do find . -type f -name "*$i.nix" -not -path "*.secrets*" ; done)
echo ${MODULES_PATH} > ${CFGPATH}auto/${MACHINE}-modules.nix


# Retraitement du fichier auto
sed -i "s/ /\n/g" ${CFGPATH}auto/${MACHINE}-modules.nix
sed -i "s/^/\"/g" ${CFGPATH}auto/${MACHINE}-modules.nix
sed -i "s/\$/\"/g" ${CFGPATH}auto/${MACHINE}-modules.nix

sed -i "1i [" ${CFGPATH}auto/${MACHINE}-modules.nix
sed -i -e '$a	]' ${CFGPATH}auto/${MACHINE}-modules.nix

cat ${CFGPATH}auto/${MACHINE}-modules.nix
