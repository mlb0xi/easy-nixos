{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  secrets = import (builtins.toPath "${cfgpath}/.secrets/firewall.nix");
  allowedTCPPorts = secrets.allowedTCPPorts;
  allowedUDPPorts = secrets.allowedUDPPorts;

in 

{

  #----- Activation du pare-feu
  networking.firewall.enable = true;
  networking.nftables.enable = true;

  #----- Gestion des règles
  networking.firewall = {
    trustedInterfaces = [ "virbr0" ];
    inherit allowedTCPPorts;
    inherit allowedUDPPorts;
  };

  
}
