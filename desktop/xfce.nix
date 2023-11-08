{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  layout = config.keyMap; 
  xkbVariant = config.xkbVariant;
  xkbOptions = config.xkbOptions;
  

in

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    inherit layout;
    inherit xkbVariant;
    inherit xkbOptions;

#    displayManager.sddm.enable = true;
    displayManager.defaultSession = "xfce";

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  services.packagekit.enable = false;

  services.blueman.enable = true;
  programs.dconf.enable = true;  

}
