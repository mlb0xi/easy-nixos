# 1. Objectif de nixos-facile

Le projet nixos-facile a pour but de fournir une aide - en français pour le moment - à un utilisateur débutant sur NixOS.

L'objectif est donc de mettre à disposition une documentation simple, composée de modules nix / schémas / explications de quelques concepts permettant d'être efficace dans la mise en place d'une NixOS répondant à des besoins courants : bureautique, gaming, etc.

Ce projet n'a pas vocation à essayer de couvrir l'ensemble des possibilités de NixOS.


# 2. Mise en place de nixos-facile

Avant tout, il est recommandé de lire la partie documentation : https://github.com/mlb0xi/easy-nixos/blob/main/DOCUMENTATION.md

Afin de mettre en place les modules Nixos "sans réfléchir", il faudra mettre en place la configuration suivante :
```  
NAME         SIZE FSTYPE      LABEL   PARTLABEL
sda                 
├─sda1  256M vfat        UEFI1   uefi1        
└─sda2  300G crypto_LUKS         nixos1
  └─rootfs   300G ext4        nixos1  
  
```

Pourquoi cette configuration ? Il s'agit de ma configuration, qui pourra être évidemment adaptée selon les besoins de chacun :

- système de fichiers `ext4` : on n'a pas besoin de `btrfs`, le principal intérêt de `btrfs` étant ses snapshots (inutile ici). Autant rester simple, si on n'a pas besoin de sous-volumes particuliers,
- taille de 300G : pas besoin de 300G en soit, c'est pour voir venir, car il est vrai que NixOS prend de la place, dû au fait que la distribution conserve par défaut tous les anciens builds du système - cf la documentation pour voir comment faire du ménage,
- chiffrement complet, boot inclus (full disk encryption) : la distro étant installée sur un PC portable, autant renforcer la sécurité,
- fonctionnement par `LABEL` : c'est aussi un choix arbitraire, rien n'empêche de fonctionner par `UUID` ou simplement par `/dev/...`.


Voici les lignes de commande pour paramétrer ainsi depuis un disque vierge :
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
  --change-name=2:linux \
  $target_device

partprobe -s "$target_device"


# Luks
cryptsetup luksFormat --type luks1 $target_device"2"
cryptsetup luksOpen $target_device rootfs

# Systèmes de fichiers
mkfs.vfat -F32 $target_device"1"
mkfs.ext4 /dev/mapper/rootfs

```
