{ config, lib, pkgs, ... }:

## WORK IN PROGRESS

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

  programs.hyprland = {
    enable = true;
    xwayland.hidpi = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND= "1";
    MOZ_DBUS_REMOTE = "1";
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs.dconf.enable = true;

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
  
  
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];


  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    wf-recorder
    swaybg
    playerctl
    brightnessctl    

    wofi        # wayland app launcher
    waybar
    hyprpaper
    hyprpicker  # color chooser
    wlsunset    # night mode
  
    dunst
    cliphist    # wayland clipboard manager

    kitty       # light terminal

    xfce.thunar
    xfce.thunar-archive-plugin
    
    cinnamon.nemo-with-extensions

    gnome.gedit
    xed-editor
    cinnamon.pix

    ranger        
    evince    
    qpdfview

    gnome.gnome-weather
    
    polkit_gnome
    gnome.gnome-keyring
    gnome.seahorse

    gnome.file-roller
  ];



}
