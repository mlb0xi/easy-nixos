{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fwupd fwupd-efi
  ];

  services.fwupd.enable = true;
  #utilisation : "fwupdmgr update"

}
