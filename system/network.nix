{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");

  hostName = config.hostName;

in
{
  environment.systemPackages = with pkgs; [
    networkmanager
  ];

  networking = {
    inherit hostName;
    useDHCP = false;
    networkmanager.enable = true;  
  };
}
