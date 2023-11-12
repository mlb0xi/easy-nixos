{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix; 
  machine = import /etc/nixos/machine.nix; 

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  efi_partlabel = config.efi_partlabel;
  root_label = config.root_label;
  ext4_options = config.ext4_options;

in

{
  environment.systemPackages = with pkgs; [
    e2fsprogs
    dosfstools
  ];


  fileSystems = {

    "/" =
        { device = "/dev/disk/by-label/${root_label}";
          fsType = "ext4";
          options = ext4_options;
        };


    "/boot/efi" =
        { device = "/dev/disk/by-partlabel/${efi_partlabel}";
          fsType = "vfat";
        };

  };




  # Swapfile
  systemd.services = {
    create-swapfile = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "swap-swapfile.swap" ];
      script = ''
        ${pkgs.coreutils}/bin/truncate -s 0 /swap/swapfile
        ${pkgs.e2fsprogs}/bin/chattr +C /swap/swapfile
      '';
    };
  };

  swapDevices = [ {
    device = "/swap/swapfile";
    size = 32768;
  } ];


  boot.initrd.availableKernelModules = [ 
    "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"
  ];
    
}
