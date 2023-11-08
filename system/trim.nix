{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    util-linux
  ];

  services.fstrim.enable = lib.mkDefault true;
}
