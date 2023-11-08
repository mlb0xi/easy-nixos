{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  username = config.username;  

in

{
  environment.systemPackages = with pkgs; [
    nmap                            # port scanning
    wireshark junkie                # network sniffing
    sqlmap                          # injection sql
    hashcat hashcat-utils hcxtools  # password cracking
    ettercap bettercap              # man in the middle
    aircrack-ng                     # vulnerabilites wifi
    ghidra                          # reverse engineering
  ];

  users.users.${username} = {
    extraGroups = [ "wireshark" ]; 
  };

}
