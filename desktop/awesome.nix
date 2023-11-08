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
  services.xserver = {
    enable = true;
    libinput.enable = true;
    inherit layout;
    inherit xkbVariant;
    inherit xkbOptions;

    displayManager.startx.enable = true;
    dpi = 180;

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };


#  services.packagekit.enable = false;
#  services.flatpak.enable = true;
#  services.blueman.enable = true;
#  programs.dconf.enable = true;  

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };


  environment.systemPackages = with pkgs; [
    awesome
  ];

  fileSystems = {
    "/home" =
        { device = "/dev/vg/homeAwesome";
          fsType = "ext4";
          options = ext4_options;
        };
  };

}
