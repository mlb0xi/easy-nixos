{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ntfs3g
    mtpfs
    exfatprogs
    
    # Outils de base
    vim
    bat
    git
    htop
    wget
    openssl
    nixos-icons
    neofetch
    tree
    ncdu
    p7zip
    
    # Nix-tools
    nix-prefetch-git    
    nix-prefetch-github
    nixpkgs-fmt
    
    # Automatisation
    cron
    rsync
    yq
    
    # Matériel
    lsof
    lm_sensors
    audit
    pciutils  
    lshw
    dmidecode
    smartmontools

    # Autres
    mediainfo
    glaxnimate
  ];

}
