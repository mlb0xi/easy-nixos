{ config, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  luks_partlabel = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).luks_partlabel;

in

{
  environment.systemPackages = with pkgs; [
    cryptsetup
  ];


  boot.initrd = {
    luks.devices = {
      rootfs = {
        device = "/dev/disk/by-partlabel/${luks_partlabel}";
        allowDiscards = true;
        preLVM = true;
#        keyFile = "/data/.secrets/keyfile.key";
      };
    };
  };

}
