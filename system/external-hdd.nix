{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix; 
  machine = import /etc/nixos/machine.nix; 

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  external_hdd_label = config.external_hdd_label;  
  ext4_options = config.ext4_options;

in
{

    # Indiquer ici le point de montage
    system.activationScripts.externalHddDir =
    ''
      mkdir -p /media/data
    '';


  # Indiquer ici le système de fichiers, par défaut ici ext4
  fileSystems = {

    "/media/data" =
        { device = "/dev/disk/by-label/${external_hdd_label}";
          fsType = "ext4";
          options = [ "nofail" ] ++ ext4_options;
        };        

  };

}

