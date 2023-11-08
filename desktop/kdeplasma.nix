{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  layout = config.keyMap; 
  xkbVariant = config.xkbVariant;
  xkbOptions = config.xkbOptions;
  ext4_options = config.ext4_options;  

  kdeNative = with pkgs.libsForQt5; [
    qtstyleplugin-kvantum
    kaccounts-providers
    kaccounts-integration
    kate
    kitinerary
    knotes
    audiotube
    kwave
    juk
  ];

in

{
  services.xserver = {
    enable = true;
    libinput.enable = true;
    inherit layout;
    inherit xkbVariant;
    inherit xkbOptions;

    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasmawayland";
    desktopManager.plasma5.enable = true;
  };

  services.packagekit.enable = false;
  services.flatpak.enable = true;
  services.blueman.enable = true;
  programs.dconf.enable = true;  

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  ];

  environment.systemPackages = with pkgs; [
    krita
    media-downloader
    partition-manager
    vorta
  ] ++ kdeNative;


}
