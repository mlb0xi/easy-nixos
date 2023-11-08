{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix; 
  machine = import /etc/nixos/machine.nix; 

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  root_label = config.root_label;
  resume_offset = config.resume_offset;

in
{
  boot.kernelParams = [ "resume_offset=${resume_offset}" ];
  boot.resumeDevice = "/dev/disk/by-label/${root_label}";

  systemd.services = {
    create-swapfile = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "swap-swapfile.swap" ];
      script = ''
        swapfile="/swap/swapfile"
        if [[ -f "$swapfile" ]]; then
          echo "Swap file $swapfile already exists, taking no action"
        else
          echo "Setting up swap file $swapfile"
          ${pkgs.coreutils}/bin/truncate -s 0 "$swapfile"
          ${pkgs.e2fsprogs}/bin/chattr +C "$swapfile"
        fi
      '';
    };
  };
}
