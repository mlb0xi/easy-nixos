{ config, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  username = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).username;

in

{
  environment.systemPackages = with pkgs; [
    cups brlaser
  ];

  hardware.sane = {
    enable = true;
    brscan4 = {
      enable = true;
      netDevices = { home = { model = "DCP-L2530DW"; ip = "192.168.0.4"; }; };
    };
  };

  services = {

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
    };

    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;    
    };
    
  };

  programs.system-config-printer.enable = true;
  
  users.users.${username}.extraGroups = [ "scanner" "lp" "cups" "printer" ];

}
