# 1. Objectif de nixos-facile

Le projet nixos-facile a pour but de fournir une aide - en français pour le moment - à un utilisateur débutant sur NixOS.

L'objectif est donc de mettre à disposition une documentation simple, composée de modules nix / schémas / explications de quelques concepts permettant d'être efficace dans la mise en place d'une NixOS répondant à des besoins courants : bureautique, gaming, etc.

Ce projet n'a pas vocation à essayer de couvrir l'ensemble des possibilités de NixOS.

-- EN CONSTRUCTION --


# 2. Principes généraux sur le gestionnaire de paquets Nix et NixOS

Il est recommandé de lire la documentation officielle pour aller plus loin : https://nixos.org/guides/how-nix-works

Seront ici abordés très rapidement les avantages et principes de NixOS.

Les grands principes à comprendre, pour un utilisateur venant d'une autre distribution Linux, sont les suivants (on y reviendra plus tard en détail si besoin) :
- tout est déclaratif : ici, pas de apt install ou pacman -S, quand on veut un paquet, on le met dans un fichier de config,
- tout est conservé : quand on fait une mise à jour (un `rebuild` pour avoir les termes nix), rien n'est écrasé par la mise à jour, l'ancien système - avant mise à jour - est toujours là,
- tout est conteneurisé : pas au sens de Flatpak ou docker, mais à sa manière ; tout est dans `/nix/store` et rien n'est modifiable à la main par l'utilisateur (système en lecture seule).

Les principaux avantages de NixOS sont donc :
- la reproductibilité : comme tout est déclaré dans quelques fichiers de configuration, il suffit de copier ces fichiers sur une autre machine, faire un `rebuild`, et on retrouve une copie conforme de la première,
- la stabilité : comme tout est conservé, si la machine ne redémarre pas après une mise à jour, il suffit de choisir un autre `build` lors du démarrage et on redémarre sur une version plus ancienne du système,
- la sécurité : comme tout est conteneurisé et en lecture seule, sauf si un programme malveillant parvient à arriver dans les dépôts de NixOS, la sécurité est renforcée.


# 3. Installation et chemins importants sur NixOS

Pour aller plus loin : https://nixos.org/manual/nixos/stable/

On peut facilement récupérer l'ISO de la dernière version de NixOS ici (attention de bien récupérer NixOS - la distribution-, en bas de la page, et non pas le gestionnaire de paquets Nix, qui s'installe sur Linux/MacOS/Windows) : https://nixos.org/download

Pour une première installation, il est conseillé de ne pas prendre l'ISO minimale, mais de prendre l'image recommandée avec GNOME.

L'installation se fait assez facilement avec un installateur (Calamares) plutôt classique. Mais c'est trompeur, car l'installateur cache en réalité ce qui est fait dans l'arrière-boutique : la création des fichiers de configuration, puis le build (la première installation). Après le reboot, on a donc notre système NixOS en fonctionnement.

Par défaut, voici les chemins importants qui divergent d'autres distributions Linux :
```
├── etc
│   └── nixos            => fichiers de configuration

├── nix
│   └── store            => paquets, logiciels, etc.

├── run
│   └── current-system   => système actuellement en fonctionnement
```

A partir de ces trois emplacements, la distribution fonctionne de la manière suivante :
- On modifie ce que l'on souhaite dans nos fichiers de configuration dans `/etc/nixos` (ajout/suppression de logiciel, paramétrage d'un disque supplémentaire au démarrage, etc.)
- On `rebuild` le système avec la commande `nixos-rebuild switch`, ce qui va modifier le `/nix/store`, par exemple en téléchargeant le paquet,
- Tout est automatiquement "monté" sur `/run/current-system`, et on bénéficie de notre modification.

Il faut bien comprendre ce que ce fonctionnement implique : sur la documentation anglaise, ils appellent ça "reliability" et/ou "reproducibility". En fait, comme on ne va faire que **décrire** ce que l'on veut dans notre fichier de configuration, on ne va en théorie jamais pouvoir casser notre distribution ou lui faire avoir un comportement inattendu.

Si on fait mal quelque chose, le système refusera purement et simplement de `rebuild`, avec un message d'erreur. Et si on décrit correctement, le système fonctionnera **exactement** comme il fonctionne chez quelqu'un avec le même matériel et la même configuration.


# 4. Structure d'un fichier de configuration

Le sujet le plus important est donc celui des fichiers de configuration.

Par défaut, l'installateur crée deux fichiers :
- `/etc/nixos/configuration.nix`
- `/etc/nixos/hardware-configuration.nix`

En réalité, ce nommage est totalement **arbitraire** et rien ne nous empêche de fonctionner totalement autrement. C'est même plutôt recommandé, sous peine d'avoir rapidement des fichiers de configuration très longs et peu logiques dans leur organisation.

Le fichier à conserver, par commodité, est `/etc/nixos/configuration.nix`, car c'est le premier fichier consulté par le système lors d'un `rebuild`.

Mais l'objectif est d'avoir un fonctionnement **modulaire** (un fichier pour une application ou un usage particulier), donc le fichier `/etc/nixos/configuration.nix` va être épuré au maximum, ne gardant que les éléments les plus basiques :
- la version de NixOS (la version stable - qui monte en version tous les 6 mois - est conseillée sauf besoins particuliers),
- l'import de nos modules,
- quelques éléments supplémentaires comme l'autorisation des paquets non-free, etc.

Voici à quoi ressemble un fichier `configuration.nix` épuré :

```nix
{ config, lib, pkgs, ... }:

let
  cfgpath = "/etc/nixos/";
  machine = "tuxedo"; # j'ai une machine Tuxedo  
  nixos_version = "23.05";

in

{
  system.stateVersion = "${nixos_version}";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  imports = 
    (builtins.map (x: "${cfgpath}" + x)
      (import (builtins.toPath "${cfgpath}/auto/${machine}-modules.nix"))
    );

}
```

Un fichier de configuration aura généralement cette structure en trois blocs :
- le bloc entre crochets, qui donne le contexte (pour simplifier, disons qu'en laissant toujours config, lib et pkgs cela fonctionnera),
- le bloc `let`, qui définit les variables qui seront utilisées par la suite,
- le bloc `in`, qui définit ce qu'on souhaite faire en langage `nix`.

A titre d'exemple, voici ce que fait le fichier ci-dessus :
- il déclare la version de nixos à installer (23.05 ici),
- il déclare que l'on veut disposer du dernier noyau linux stable disponible (sans cela on reste sur une même version jusqu'à la prochaine montée en version de nixos),
- il déclare que l'on veut autoriser les paquets `Unfree`, et également les firmware `nonfree` (plus spécifiquement `Redistributable` qui est intermédiaire entre libre et propriétaire, mais ne rentrons pas trop dans les détails),
- il importe les modules (tout le reste de la configuration nixos) par une commande `imports` suivi d'une syntaxe "effrayante".

Il n'y a pas besoin de connaître par coeur cette syntaxe, car elle est directement fonctionnelle sans modification, il faut juste en comprendre le fonctionnement. En langage `nix`, le terme `builtins.quelquechose` fait référence à une fonction incluse de base dans le langage. Donc, ici, ce que l'on fait, c'est :
- ligne 2 : **importer** le fichier `/etc/nixos/auto/tuxedo-modules.nix`, fichier qui contient la liste des modules que l'on souhaite pour notre machine (détail ci-dessous),
- ligne 1 : **mapper** chaque élément de la liste avec `/etc/nixos/` afin d'avoir un chemin du type `/etc/nixos/system/firewall.nix` par exemple.

Voici un aperçu du fichier `auto/tuxedo-modules.nix` :
```nix
[
"./hardware/intelcpu.nix"
"./hardware/intelgpu.nix"
"./hardware/bluetooth.nix"
"./hardware/printer.nix"
"./hardware/soundcard.nix"
...
"./system/firewall.nix"
"./system/network.nix"
"./system/homemanager.nix"
"./system/locale.nix"
"./system/libvirt.nix"
...
"./server/fish.nix"
"./server/nano.nix"
"./server/openssh.nix"
"./server/gocryptfs.nix"
"./server/python.nix"
...
"./desktop/codecs.nix"
"./desktop/fonts.nix"
"./desktop/gnome.nix"
"./desktop/gsettings.nix"
...
"./apps/chromium.nix"
"./apps/firefox.nix"
"./apps/thunderbird.nix"
"./apps/video-downloader-git.nix"
"./apps/logitech.nix"
...
"./apps/vscode.nix"
]

```

Encore une fois, ce nommage est arbitraire, et libre à chaque utilisateur de nommer ses fichiers de configuration à sa guise.


# 5. Organisation des fichiers de configuration

L'objectif est d'être organisé dans la structure des fichiers, afin de toujours s'y retrouver facilement.

```
/etc
├── nixos
│   ├── auto
│   ├── bash
│   ├── config
----------
│   ├── apps
│   ├── desktop
│   ├── hardware
│   ├── server
│   ├── system
----------
│   ├── cfgpath.nix
│   ├── configuration.nix
│   └── machine.nix

```
Il y a ici 8 dossiers et 3 fichiers sous `/etc/nixos`.

Les fichiers `cfgpath.nix` et `machine.nix` sont facultatifs, mais permettront plus tard de déplacer la configuration facilement d'une machine à une autre **ayant une configuration matérielle ou logicielle différente**.

Le fichier `cfgpath.nix` contient simplement "/etc/nixos/", et `machine.nix` le nom de la machine ("tuxedo").

Les dossiers sont plus intéressants car scindés en 2 catégories :
- les dossiers contenant les modules proprement dits, rangés par "niveau" : hardware, system, server, desktop et apps,
- les dossiers contenant des outils d'automatisation : auto, bash et config.

Pour le dossier contenant les modules hardware par exemple, voici ce qui est disponible actuellement :
```
./hardware/
├── amdcpu.nix
├── amdgpu.nix
├── bluetooth.nix
├── intelcpu.nix
├── intelgpu.nix
├── nvidia.nix
├── printer.nix
├── soundbook2.nix
├── soundcard.nix
└── wifi.nix
```

Tous ne seront évidemment pas utilisés en même temps : avec une carte graphique AMD, on utilisera le module `amdgpu.nix`, mais on laissera de côté le module `nvidia.nix`.

C'est l'avantage de la configuration par modules : avoir tout de disponible, mais n'utiliser que ce qui est nécessaire, sans que ce soit contraignant ou difficile à modifier.

Toujours dans le cadre d'une carte graphique AMD, voici le module qui sera ainsi activé :

```nix
{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    
    driSupport = lib.mkDefault true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];

    driSupport32Bit = lib.mkDefault true;
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];

  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Force RADV (vulkan-radeon) over amdvlk - via environment variable
  environment.variables.AMD_VULKAN_ICD = lib.mkDefault "RADV";

}

```

Les modules "hardware" sont souvent les plus complexes au niveau syntaxe, mais voici ce que fait ce module en résumé :
- il active `opengl`, et notamment les paquets liés à AMD que sont `amdvlk` et les `rocm`
- il active également le 32 bits, sans quoi adieu Steam, Lutris, etc.,
- il indique au kernel de démarrer `amdgpu` au boot et en tant que xserver,
- il force l'utilisation de `vulkan-radeon` au lieu de `amdvlk`, car il est plus performant.

Sur une autre distribution Linux, pour faire ces opérations, on aurait modifié les fichiers d'initramfs, puis le grub, le tout en ayant auparavant installé les paquets, et avant cela modifié le gestionnaire de paquets pour activer le 32 bits, etc. Et le fichier grub qu'on modifie, c'est le même qu'on modifie pour tout autre chose (du chiffrement, etc.).

Ici, on écrit dans un seul module tout ce qui concerne la carte graphique AMD, et cela ne nous empêchera pas de remodifier l'initramfs ou le grub dans d'autres modules, que celui-ci soit utilisé ou non.


# 6. Paramétrage déclaratif

En autre exemple, on peut prendre le module `./server/nano.nix`. Le terme "server" regroupe ici les modules concernant des applications en ligne de commande, qui peuvent être indifféremment utilisées sur un NixOS sans interface graphique (en mode serveur) ou sur un NixOS graphique dans un émulateur de terminal.

```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano nanorc
  ];


  programs.nano = {
    syntaxHighlight = true;

    # https://www.nano-editor.org/dist/v2.1/nanorc.5.html
    nanorc = ''
      set tabsize 2      
      set tabstospaces   
      set autoindent  
    '';

  };

}

```

Ce module est très intéressant, car il inclut deux fonctions primordiales que tout utilisateur de Nix utilisera au quotidien pour installer une nouvelle application :
- `environment.systemPackages` : permet d'ajouter un paquet/logiciel au système : l'équivalent du `apt install`,
- `programs.monProgramme` : permet de configurer son programme de manière déclarative.

Le second point est unique à NixOS : le **paramétrage déclaratif** des applications. Ici, par exemple, on n'a pas seulement installé nano, on a paramétré l'application pour avoir une indentation de 2 au lieu de 4 par défaut, qu'au retour à la ligne il nous décale le curseur si besoin, etc.

Un parfait exemple d'application extrêmement configurée de cette manière est `./apps/firefox.nix`, qui contient une soixantaine de paramètres pour le respect de la vie privée, etc.

A ce sujet, la bible du nixosien se situe ici : https://search.nixos.org/packages (pour rechercher un paquet),
Et ici : https://search.nixos.org/options (pour rechercher un paramétrage).
Essayez d'y aller et de rechercher `nano`, c'est très intéressant.

