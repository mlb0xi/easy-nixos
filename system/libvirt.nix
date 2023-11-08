{ config, lib, pkgs,  ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  
  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  username = config.username;
  
in

{
  environment.systemPackages = with pkgs; [
    virt-manager OVMF
    libvirt qemu
    libguestfs
    spice spice-gtk
    virtiofsd
  ];

  nixpkgs.config.permittedInsecurePackages = [
                "python3.10-certifi-2022.9.24"
              ];

  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];

  virtualisation.libvirtd = {
    enable = true;
  };

  users.users.${username}.extraGroups = [ "libvirt" "kvm" "libvirtd" "qemu-libvirtd" ];

  virtualisation.spiceUSBRedirection.enable = true;


  systemd.services.netstart = {
    enable = true;
    description = "start default virsh network";
    unitConfig.Type = "oneshot";
    script = "/run/current-system/sw/bin/virsh net-start default";
    wantedBy = [ "multi-user.target" ];
  };

}
