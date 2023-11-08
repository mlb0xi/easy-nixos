{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  username = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).username;

  secrets = import (builtins.toPath "${cfgpath}/.secrets/wireguard.nix"); 
  address = secrets.address;
  aliases = secrets.aliases;
  
in

{
  environment.systemPackages = with pkgs; [
   thunderbird
   protonmail-bridge
  ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [ thunderbird ];
    
    accounts.email = {

      accounts.default = {
        primary = true;
        inherit address;          
        inherit aliases;
        };
      };
    
    };



}
