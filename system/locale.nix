{ config, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");

  timeZone = config.timeZone;    
  locales = config.locales;
  font = config.font;
  keyMap = config.keyMap;
    
in

{
  time = { inherit timeZone; };

  i18n = {
    defaultLocale = "${locales}";
    extraLocaleSettings = {
      LC_ADDRESS = "${locales}";
      LC_IDENTIFICATION = "${locales}";
      LC_MEASUREMENT = "${locales}";
      LC_MONETARY = "${locales}";
      LC_NAME = "${locales}";
      LC_NUMERIC = "${locales}";
      LC_PAPER = "${locales}";
      LC_TELEPHONE = "${locales}";
      LC_TIME = "${locales}";
    };
  };

  console = {
    inherit font;
    inherit keyMap;
  };

}
