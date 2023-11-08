{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grub2_efi
  ];


  boot.loader = {

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      #version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
      useOSProber = false;
    };

  };

}
