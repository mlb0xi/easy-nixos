# 1. Objectif de nixos-facile

Le projet nixos-facile a pour but de fournir une aide - en français pour le moment - à un utilisateur débutant sur NixOS.

L'objectif est donc de mettre à disposition une documentation simple, composée de modules nix / schémas / explications de quelques concepts permettant d'être efficace dans la mise en place d'une NixOS répondant à des besoins courants : bureautique, gaming, etc.

Ce projet n'a pas vocation à essayer de couvrir l'ensemble des possibilités de NixOS.


# 2. Mise en place de nixos-facile

Avant tout, il est recommandé de lire la partie documentation : https://github.com/mlb0xi/easy-nixos/blob/main/DOCUMENTATION.md

Afin de mettre en place les modules Nixos "sans réfléchir", il faudra avoir la configuration suivante (commande un peu plus bas pour s'occuper des `LABEL`) :
```  
NAME         	SIZE 	FSTYPE      	LABEL   	PARTLABEL
sda                 
├─sda1  	256M 	vfat        	UEFI1   	uefi1        
└─sda2  	150G 	ext4         	nixos1		nixos1	  
```

Les points importants sont :

- système de fichiers `ext4` : simple et efficace,
- taille de 150G : pas besoin de 150G en soit, c'est pour voir venir, car il est vrai que NixOS prend de la place, dû au fait que la distribution conserve par défaut tous les anciens builds du système - cf la documentation pour voir comment faire du ménage,
- fonctionnement par `LABEL` : c'est le choix de la souplesse, rien n'empêche de fonctionner par `UUID` par exemple.


## A. Depuis une installation fraiche de NixOS

Il faut s'assurer d'avoir :
- correctement formaté les partitions lors de l'installation : `ext4` pour la partition système, et une partition uefi,
- un paramétrage correct pour les `label` des partitions, via la commande suivante.

```bash
target_device=/dev/sda

nix-shell -p gptfdisk --run "sgdisk --change-name=1:uefi1 $target_device"
tune2fs -L nixos1 $target_device"2"

partprobe -s "$target_device"
```

Copier ensuite ce dépôt github sur `/etc/nixos/`, via la commande suivante :

```bash

# Préparation
# A fait en tant qu'utilisateur, pas en tant que root ici
sudo chown -R $USER /etc/nixos
sudo cp -r /etc/nixos /etc/nixos.BAK

# Installation du dépôt
# (pas besoin d'installer git de manière permanente grâce à nix-shell)
nix-shell -p git --run "git clone https://github.com/mlb0xi/easy-nixos /etc/nixos"
```

Vérifier que la configuration des modules correspond à votre config (notamment matérielle), dans `/etc/nixos/config/maMachine-modules.nix`

Voici en détail ce qu'il faut regarder :
- dans `hardware`, avez-vous un full intel (`intelcpu` et `intelgpu`). Sinon, modifier pour AMD ou Nvidia,
- dans `system`, est-ce que vous voulez un pare-feu (par défaut oui), un `swap` sous forme de swapfile, etc.
- dans `desktop`, par défaut c'est GNOME,
- dans `apps`, quelles applications souhaitez-vous installer (plusieurs packs sont proposés pour le multimedia, gaming, etc.).

Ensuite, il faut aller personnaliser son nom d'utilisateur dans `/etc/nixos/config/maMachine-conf.nix`.

Et voilà.

Il reste une commande à lancer pour un remplissage automatique du fichier contenant les modules `/etc/nixos/auto/maMachine-modules.nix`, puis on pourra lancer le rebuild.

```bash

# Remplissage automatique du fichier de modules
cd /etc/nixos && bash bash/nixos-autoModules.sh

# Rebuild du système
sudo nixos-rebuild boot
```

Au reboot, tout sera en place.



## B. Depuis un disque vierge

Voici les lignes de commande pour paramétrer ainsi depuis un disque vierge, en commençant par le formatage du disque :

```bash
# Modifier ici avec le nom du disque où installer NixOS
# target_device=/dev/nvme0n1
target_device=/dev/sda

# Table de partitionnement et partitions
sgdisk -Z "$target_device"

sgdisk \
  --new=1:0:256M \
  --typecode=1:ef00 \
  --change-name=1:uefi1 \
  $target_device

sgdisk \
  --largest-new=2 \
  --typecode=2:8304 \
  --change-name=2:nixos1 \
  $target_device

partprobe -s "$target_device"

# Systèmes de fichiers
mkfs.vfat -n UEFI1 -F32 /dev/disk/by-partlabel/uefi1
mkfs.ext4 -L nixos1 -F /dev/disk/by-partlabel/nixos1

# Vérifions nos partitions
lsblk -o NAME,SIZE,LABEL,PARTLABEL

```

A ce niveau, on a un disque bien configuré, il faut ensuite :
- monter les partitions sur `/mnt`
- copier les fichiers de configuration sur `/mnt/etc/nixos`
- modifier le fichier `cfgpath` pour l'installation uniquement,
- lancer la commande magique d'installation `nixos-install`

```bash
# Montage des disques
mount /dev/disk/by-label/nixos1 /mnt

mkdir -p /mnt/boot/efi
mount /dev/disk/by-partlabel/uefi1 /mnt/boot/efi

# Installation du dépôt
# (pas besoin d'installer git de manière permanente grâce à nix-shell)
nix-shell -p git --run "git clone https://github.com/mlb0xi/easy-nixos /mnt/etc/nixos"
```

De même que pour l'installation depuis une fresh install de Nixos, vérifier que la configuration des modules correspond à votre config (notamment matérielle), dans `/etc/nixos/config/maMachine-modules.nix`

Voici en détail ce qu'il faut regarder :
- dans `hardware`, avez-vous un full intel (`intelcpu` et `intelgpu`). Sinon, modifier pour AMD ou Nvidia,
- dans `system`, est-ce que vous voulez un pare-feu (par défaut oui), un `swap` sous forme de swapfile, etc.
- dans `desktop`, par défaut c'est GNOME,
- dans `apps`, quelles applications souhaitez-vous installer (plusieurs packs sont proposés pour le multimedia, gaming, etc.).

Ensuite, il faut aller personnaliser son nom d'utilisateur dans `/etc/nixos/config/maMachine-conf.nix`.

Et voilà. On va pouvoir lancer l'installation.

```
# Préparation de l'installation
echo '"/mnt/etc/nixos/"' > /mnt/etc/nixos/cfgpath.nix
cp /mnt/etc/nixos/machine.nix /etc/nixos/
cp /mnt/etc/nixos/cfgpath.nix /etc/nixos/

# Installation en tant que telle
nixos-install
```
