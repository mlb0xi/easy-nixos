{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  
    # Maintenance
    gparted
    pika-backup
    android-tools
    
    # Gestion des fichiers
    fsearch
    krename
    meld
    pdfarranger
    
    # Documents
    endeavour
    obsidian
    drawio
    
    discord
#   nextcloud-client
#   synology-drive-client
    wireguard-tools
    vncdo
   
    # Outils BDD
    sqlitebrowser
    sqlite
      
  ];
}
