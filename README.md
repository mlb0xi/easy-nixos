# 1. Objectif de nixos-facile

Le projet nixos-facile a pour but de fournir une aide - en français pour le moment - à un utilisateur débutant sur NixOS.

L'objectif est donc de mettre à disposition une documentation simple, composée de modules nix / schémas / explications de quelques concepts permettant d'être efficace dans la mise en place d'une NixOS répondant à des besoins courants : bureautique, gaming, etc.

Ce projet n'a pas vocation à essayer de couvrir l'ensemble des possibilités de NixOS.


# 2. Mise en place de nixos-facile

Avant tout, il est recommandé de lire la partie documentation : https://github.com/mlb0xi/easy-nixos/blob/main/DOCUMENTATION.md

Afin de mettre en place les modules Nixos "sans réfléchir", il faudra mettre en place la configuration suivante :
```  
NAME         	SIZE 	FSTYPE      	LABEL   	PARTLABEL
sda                 
├─sda1  	256M 	vfat        	UEFI1   	uefi1        
└─sda2  	300G 	ext4         	nixos1		nixos1	  
```

Les points importants sont :

- système de fichiers `ext4` : simple et efficace,
- taille de 300G : pas besoin de 300G en soit, c'est pour voir venir, car il est vrai que NixOS prend de la place, dû au fait que la distribution conserve par défaut tous les anciens builds du système - cf la documentation pour voir comment faire du ménage,
- fonctionnement par `LABEL` : c'est le choix de la souplesse, rien n'empêche de fonctionner par `UUID` par exemple.

## A. Depuis une installation fraiche de NixOS


Il faut s'assurer d'avoir :
- correctement formaté les partitions lors de l'installation : `ext4`,
- un paramétrage correct pour les `label` des partitions, via la commande suivante.

```bash
target_device=/dev/sda

sgdisk --change-name=1:uefi1 $target_device
tune2fs -L nixos1 $target_device"2"
```

Copier ensuite ce dépôt github sur `/etc/nixos/`, via la commande suivante :

```bash

# Préparation
sudo chown -R $USER /etc/nixos
cp -r /etc/nixos /etc/nixos.BAK

# Installation du dépôt git
git clone https://github.com/mlb0xi/easy-nixos /etc/nixos
```

Vérifier que la configuration des modules correspond à votre config (notamment matérielle), dans `/etc/nixos/config/maMachine-modules.nix`


## B. Depuis un disque vierge

Voici les lignes de commande pour paramétrer ainsi depuis un disque vierge, en commençant par le formatage du disque :

```bash
target_device=/dev/sda

# Table de partitionnement et partitions
sgdisk -Z "$target_device"

sgdisk \
  --new=1:0:+256M \
  --typecode=1:ef00 \
  --change-name=1:uefi1 \
  $target_device

sgdisk \
  --new=2:0:+300G \
  --typecode=2:8304 \
  --change-name=2:nixos1 \
  $target_device

partprobe -s "$target_device"

# Systèmes de fichiers
mkfs.vfat -F32 $target_device"1"
fatlabel $target_device"1" UEFI1

mkfs.ext4 $target_device"2"
tune2fs -L nixos1 $target_device"2"

```

A ce niveau, on a un disque bien configuré, il faut ensuite :
- monter les partitions sur `/mnt`
- copier les fichiers de configuration sur `/mnt/etc/nixos`
- modifier le fichier `cfgpath` pour l'installation uniquement,
- lancer la commande magique d'installation `nixos-install`

```bash
# Montage des disques
mount $target_device"2" /mnt

mkdir -p /mnt/boot/efi
mount $target_device"1" /mnt/boot/efi

###
# Copier ensuite le contenu du dépôt github sur /mnt/etc/nixos
###

# Puis entrer les commandes suivantes

echo "/mnt/etc/nixos" > /mnt/etc/nixos/cfgpath.nix
cp /mnt/etc/nixos/machine.nix /etc/nixos/
cp /mnt/etc/nixos/cfgpath.nix /etc/nixos/

nixos-install
```

