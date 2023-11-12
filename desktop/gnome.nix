{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  layout = config.keyMap; 
  xkbVariant = config.xkbVariant;
  xkbOptions = config.xkbOptions;
  ext4_options = config.ext4_options;

in

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    inherit layout;
    inherit xkbVariant;
    inherit xkbOptions;

    displayManager = {
      gdm.enable = true;
      defaultSession = "gnome";
    };
    desktopManager.gnome.enable = true;
  };

  services.packagekit.enable = false;
  services.flatpak.enable = true;
  services.blueman.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music gnome-tour gnome-photos gnome.gnome-characters
    gnome.totem gnome.tali gnome.iagno gnome.hitori gnome.atomix
    gnome.gnome-maps gnome.gnome-clocks gnome-connections
    gnome.gnome-font-viewer gnome.gnome-software gnome.geary xterm
    gnome.gnome-packagekit packagekit system-config-printer gnome-tour
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnome.dconf-editor
    dconf2nix
  ];

}
