{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;  
  nixos_version = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).nixos_version;

in

{
  system.stateVersion = "${nixos_version}";
  nix.settings.experimental-features = [ "nix-command" "flakes" "impure-derivations" "ca-derivations" ]; 

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-12.2.3" "electron-21.4.0" "electron-24.8.6" "openssl-1.1.1w" "openssl-1.1.1v" "python-2.7.18.6" ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';



  imports = 
    (builtins.map (x: "${cfgpath}" + x)
      (import (builtins.toPath "${cfgpath}/auto/${machine}-modules.nix"))
    );

}
